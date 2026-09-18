# Journeywar 148.0: Recoil maintenance TODO

Reviewed 2026-09-18 against develop commit `cee3368bde4f058d4749c4a6cc0b4b3be1f7926c` (commit message `VERSION{148.0}`).

Scope: source review of definitions, startup, the bundled unit-script framework, event scheduler, custom rendering, UI, music and selected gameplay gadgets. This is not an exhaustive audit or an engine playtest. No Spring/Recoil executable or Lua interpreter was available. The hub implementation was not inspected; its rejection is user-reported.

## Immediate metadata fix

- [x] Set `units/gaia/ginfmachine.lua` display `name` to `Infernal Machine`.
- [x] Set `units/gaia/gProceduralFeature.lua` display `name` to `Procedural Feature`: the same whitespace-only defect was found there.
- Internal keys `ginfernalmachine` and `gproceduralfeature` remain unchanged, preserving scripted spawns and references. Descriptions and gameplay fields are unchanged.
- [ ] Rebuild the game archive under a new version, rescan with unitsync/the hub, and confirm both full names are populated. Editing source does not repair the already-published 148.0 archive.
- [ ] Validate every loaded UnitDef for a non-whitespace display name before release, including generated/inherited definitions. The two fixes are confirmed findings, not proof that every definition is valid.

## P0: Establish a reproducible launch

### 1. Pin the engine and release inputs
- [ ] Record an exact Recoil release, platform, map and game commit. Keep a known-working old Spring installation as a comparison.
- [ ] Verify `modinfo.lua` dependencies `cursors.sdz` and `Spring content v1` resolve in the portable installation; inspect resulting unitsync metadata.
- [ ] Document how `version = '$VERSION'` is substituted. No release workflow was found in the reviewed repository tree.
- [ ] Replace the README's generic Spring installation directions with tested Recoil launch instructions after validation.
Acceptance: a clean installation discovers the archive and launches without missing-dependency errors.

### 2. Audit the bundled Lua unit-script framework
Evidence: `LuaRules/Gadgets/unit_script.lua` contains its own coroutine scheduler and API wrappers, rather than simply including the engine version. It uses `math.bit_and`, wraps weapon and transport callins, and includes basecontent `gamedata/VFSUtils.lua`.
- [ ] Diff it against the pinned engine's framework; preserve Journeywar-specific thread behavior explicitly.
- [ ] Check API availability and include resolution before replacing anything.
- [ ] Exercise creation, aiming/firing, animation waits, signals, transport, death, and gadget-started script calls.
Acceptance: both factions' starter units and a representative combat/transport unit work without coroutine errors or stuck waits.

### 3. Replace obsolete synced-table iteration
Evidence: `LuaRules/Utilities/tablefunctions.lua:MakeRealTable` calls `spairs`; `LuaRules/system.lua` and `LuaUI/system.lua` export legacy iterator globals.
- [ ] Replace executable legacy iterator uses with normal iteration and remove obsolete exports where appropriate.
Acceptance: nested synced data reaches unsynced consumers on the pinned engine without nil-function errors. This is a confirmed API incompatibility when the affected function runs on Recoil versions that removed those globals.

### 4. Make the interface recoverable
Evidence: `gui_BuildAndAbilityWindow.lua:Initialize` immediately dereferences `WG.Chili`; `gui_hideDefaultGui.lua` independently hides the console, resource bar and tooltips, and auto-readies in `GameSetup`.
- [ ] Guard Chili availability and preserve usable default controls until the replacement UI initializes.
- [ ] Verify build commands, abilities, upgrades, resource display, team selection and start positions.
Acceptance: a Chili failure leaves a playable interface and visible diagnostic output.

## P1: Confirmed source defects to repair

### 5. Repair event cancellation and scheduling
Evidence: `LuaRules/Gadgets/jw_eventstream.lua` iterates frame-indexed sparse buckets using `ipairs(Events)`; cancellation removes `evtID` as an array index instead of loop index `i`. It also leaves the event record allocated. Scheduling permits the current/past frame, which can strand events after that bucket has run. Documented finalization/deactivation behavior is not implemented by the shown frame handler.
- [ ] Implement deterministic cancellation, record cleanup and future-frame scheduling; localize event variables.
- [ ] Decide and implement finalization semantics before exposing them to callers.
Acceptance: cancel an event in a distant sparse bucket, cancel a non-first entry, reschedule during dispatch, and destroy a unit with pending events without later callbacks or leaked records.
These are existing game defects, not evidence that Recoil caused them.

### 6. Repair build/upgrade GUI behavior
Evidence: `showComEndUpgradeMenue` assigns `boolShowUpgrade = not true`, permanently resetting the toggle. `UnitButton` constructs `unitDef.name .. ".png" or "placeholder.png"`, so its fallback cannot handle a missing image. Build parsing relies on command names instead of checking negative build-command IDs.
- [ ] Fix the toggle, use the actual build picture with an existence-checked fallback, and identify build commands by ID.
Acceptance: upgrades open and close; all buildable units have correct icons and buttons.

### 7. Validate GUI-to-simulation messages
Evidence: `jw_guiReciver.lua` reads spectator status without rejecting spectators, passes coordinate strings through without numeric/range validation, and its zone deletion path does not check ownership. Upgrades directly call a script environment function.
- [ ] Validate sender, team, command, coordinates and target ownership; confirm script calls use the required unit context.
Acceptance: valid owner actions work; spectators, malformed messages and another team's zone deletion requests cannot modify game state.

## P1: Rendering and gameplay migration risks

### 8. Resolve custom material loading before shader modernization
Evidence: the enabled newer-engine path in `api_custom_unit_shaders.lua` loads `ModelMaterials/` or `ModelMaterials_103/`; neither directory appears in the reviewed repository tree. Existing material definitions instead live beneath `LuaRules/Gadgets/CustomUnitShadders/`. That older implementation is gated to older engines.
- [ ] Determine whether intended material configurations are loaded at all; select one supported rendering path.
- [ ] Check each required UnitRendering/FeatureRendering function against the pinned engine, including material setup, LuaDraw and cleanup.
- [ ] Test normal maps, flags, shark effects, features, cloaking, transparency and shadows; use ordinary engine rendering as a fallback on shader failure.
- [ ] Then test LUPS and screen-space effects independently. Keep `jw_HeatDeathShader.lua` disabled until its documented all-units shader bug is repaired.
Acceptance: units remain visible through construction, cloak, destruction and UI/rules reload; no shader failure can leave LuaDraw permanently hiding them.
Do not infer that the guide's removal of distant billboards means every similarly named material LOD API was removed.

### 9. Preserve movement, collisions and faction mechanics
Evidence: `gamedata/modrules.lua` selects pathfinder 0/1 from a modoption; `gamedata/movedefs.lua` contains hover, amphibious, train and submarine movement classes. Unit definitions still use legacy acceleration/braking names.
- [ ] Validate pathfinder settings, collision volumes, water transitions and intended upright behavior; migrate acceleration/braking fields with verified units.
- [ ] Test walking/unrooted buildings, moving factories, transport and tractor capture/release, resurrection, terrain deformation and projectile-driven abilities.
- [ ] Check start-unit selection, AI startup and victory. In `game_spawn.lua`, the wildhorses branch treats a GetPlayerList entry as a table, and the fallback calls bare `echo`; reproduce these paths before repairing.
Acceptance: both factions can start, build an economy/army, move, fight and win on land/water terrain without stuck units or disabled abilities.

### 10. Audit remaining API and asset changes
- [ ] Scan executable call sites for changed config defaults, selection counts, marker boolean arguments and text color state.
- [ ] Scan image formats for paletted files and convert affected assets without altering alpha.
- [ ] Review camera bindings, shared-unit orders and resurrection outcomes only where Journeywar depends on the old behavior.
Acceptance: no migration warning is treated as a confirmed game failure without a matching code path or reproduction.

## P2: Stability, performance and distribution

- [ ] Test `snd_music.lua` at startup and across track/loop changes: it supplies `WG.music_volume or 0.5` at each stream start; verify the UI updates the same setting.
- [ ] Exercise `jw_SlowMo.lua` with multiple clients: speed commands and Lua messages must behave consistently with host speed limits.
- [ ] Profile ecology, forest fires, missions, projectile effects and common unit threads at realistic unit counts before optimizing.
- [ ] Add definition/reference checks and a repeatable engine smoke scenario, then a two-client desync test and sustained full match.
- [ ] Build and test portable Windows and Linux installs; publish a new version only after hub metadata and download/startup checks pass.

## Suggested execution order and release gate

First: metadata rescan and pinned-engine launch. Next: framework/API blockers and UI fallback. Then: scheduler/UI defects and core faction mechanics. Finally: rendering restoration, performance and packaging.

Release gate: clean logs through launch and a full match; both factions build and win; key unique mechanics work; no multiplayer desync; hub accepts every unit name; clean portable install needs no undocumented files.

Migration reference: [Recoil's official Spring migration guide](https://recoilengine.org/docs/guides/migrating-from-spring/). Its listed changes are version-sensitive; verify against the chosen target rather than assuming every Recoil build has identical behavior.

