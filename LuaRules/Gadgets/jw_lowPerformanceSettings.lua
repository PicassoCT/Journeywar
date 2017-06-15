function widget:GetInfo()
	return {
		name      = "Framerate increase",
		desc      = "Turns off shading and more.",
		author    = "[KING]Antarac",
		version   = "0.2",
		date      = "May 26, 2017",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true,
	}
end

local SendCommands = Spring.SendCommands
local CommandList = {

"Fps = 0",										-- Shows Frames per second in the upper right corner of screen.
"Clock = 0",									-- Shows how long game is played already in the upper right corner of screen.
"HardwareCursor 1",								-- ?

"AdvMapShading 0",								-- Shading for maps.
"AdvModelShading 0",							-- Shading for models.
"AdvSky 0",										-- ?
"AllowDeferredMapRendering 0",					-- ?
"AllowDeferredModelRendering 0",				-- ?
"BumpWaterBlurReflection 0",					-- ?
"BumpWaterRefraction 0",						-- ?
"DynamicClouds 0",								-- ?
"DynamicSky 0",									-- ?
"DynamicSun 0",									-- ?
"FSAALevel 0",									-- ?
"GrassDetail 0",								-- ?
"GroundDecals 0",								-- Draws black paths after vehicle move or black smoky ground after explosion.
"GroundDecalsParallaxMapping 0",				-- ?
"GroundDetail 40", 								-- Map gets to flat on 0.
"HeightMapTexture 0",							-- ?
"HighResLos 0",									-- ?
-- "MapBorder 1",								-- Set or toggle map border rendering
"MaxDynamicMapLights 0",						-- ?
"MaxDynamicModelLights 0",						-- ?
"MaxNanoParticles 1",							-- The amount of Particles you can see from Construction units and Nanos.
"MaxParticles 1",								-- ?
"Shadows 0",									-- Shadows for all objects. 0 = turned off.
"Water 0",										-- Basic water, no performance hit.
												-- Reflective, Pretty, not a too large performance hit.
												-- Dynamic, Very pretty, MASSIVE performance hit and buggy on some hardware.
												-- Reflective + Refractive, Prettier than reflective and pretty much the same performance hit, slightly buggy on some hardware.
												-- Bump-mapped water, very low impact like basic water, very pretty and realistic at average ranges. Has shore waves and some basic effects for impacts/movement through the water. 




-- Turn off Show path can save lots of power. Figure out which ones to use.
-- ShowPathCost									-- Enable rendering of the path cost-map overlay
-- ShowPathFlow									-- Enable/Disable rendering of the path flow-map overlay
-- ShowPathHeat									-- Enable/Disable rendering of the path heat-map overlay
-- ShowPathTraversability						-- Enable rendering of the path traversability-map overlay
-- ShowPathType									-- Shows path traversability for a given MoveDefName, MoveDefID or UnitDefName


-- advshading [0|1]	Disables/enables advanced shading (reflective units, more?).
-- AirMesh										-- Show/Hide the smooth air-mesh map overlay
-- AllMapMarks									-- Show/Hide all map marks drawn so far
-- ClearMapMarks								-- Remove all map marks drawn so far
-- Cross										-- Allows one to exchange and modify the appearance of the cross/mouse-pointer in first-person-control view
-- CtrlPanel									-- Reloads GUI config
-- Debug										-- Enable/Disable debug info rendering mode
-- DebugColVol									-- Enable/Disable drawing of collision volumes
-- DebugDrawAI									-- Enables/Disables debug drawing for AIs
-- DecGUIOpacity								-- Decreases the the opacity(see-through-ness) of GUI elements
-- DecreaseViewRadius							-- Decrease the view radius (higher performance, uglier view)
--"DrawTrees = 0",
-- Font											-- Reloads the fonts
-- FPSHud										-- Enables/Disables HUD (GUI interface) shown in first-person-control mode
-- Fullscreen									-- Switches fullscreen mode
-- GameInfo										-- Enables/Disables game-info panel rendering
-- IncGUIOpacity								-- Increases the the opacity(see-through-ness) of GUI elements
-- IncreaseViewRadius							-- Increase the view radius (lower performance, nicer view)
-- Info											-- Shows/Hides the player roster
-- LODScale										-- Set the scale for either of: LOD (level-of-detail), shadow-LOD, reflection-LOD, refraction-LOD
-- LessClouds									-- Decreases the density of clouds (higher performance)
-- LessTrees									-- Decreases the distance to the camera, in which trees are still shown (higher performance)
-- MoreClouds									-- Increases the density of clouds (lower performance)
-- MoreTrees									-- Increases the distance to the camera, in which trees are still shown (lower performance)
-- Resync										-- Redirects command /Resync to its synced processor
-- roam											-- Disables/Enables ROAM mesh rendering: 0=off, 1=on
-- SafeGL										-- Enables/Disables OpenGL safe-mode
--"ShadowMapSize = 8192
-- ShowElevation								-- Enable rendering of the auxiliary height-map overlay
-- ShowMetalMap									-- Enable rendering of the auxiliary metal-map overlay
--"ShowStandard									-- Disable rendering of all auxiliary map overlays
--"SmoothLines = 0
--"SmoothPoints = 0
--"Speed										-- Shows/Hides the simulation speed indicator
--"TeamNanoSpray = 0
--"ToggleLOS									-- Enable rendering of the auxiliary LOS-map overlay
--"TreeRadius = 3000							-- ?
--"UnitIconDist = 10000
--"VSync = -1									-- Enables/Disables vertical-sync (Graphics setting)
--"WireMap                        				-- Enable/Disable drawing of the map as wire-frame (no textures) (Graphic setting)


}

function widget:AddConsoleLine(msg, priority) 	-- Called when text is entered into the console (e.g. Spring.Echo). 
	if msg == "low" then						-- Type "/low" in the ingame chat(console) to activate the script.
		SendCommands(CommandList)
	end
end