function gadget:GetInfo()
    return {
        name = "jw_ComEnder",
        desc = "Ends the game if endgame units die",
        author = "Picasso",
        date = "January, 2010",
        license = "GNU GPL, v2 or later",
        layer = 16,
        enabled = true -- loaded by default?
    }
end

if (gadgetHandler:IsSyncedCode()) then
-- INCLUDES
VFS.Include("scripts/lib_jw.lua" )
VFS.Include("scripts/lib_OS.lua" )
VFS.Include("scripts/lib_UnitScript.lua" )
VFS.Include("scripts/lib_Build.lua" 	)


-- gameOfThronesMode
local boolGameOfThronesActive = toBool(Spring.GetModOptions().gameofthrones )	
	
    local C_COMMANDER_DEF_ID = UnitDefNames["ccomender"].id
    local J_COMMANDER_DEF_ID = UnitDefNames["jabyss"].id

    function gadget:UnitDestroyed(Unit, UnitDef, Team, attackerID, attackerDefID, attackerTeamID)
        if not GG.LazarusDeviceActive then GG.LazarusDeviceActive = {} end
        if (UnitDef == C_COMMANDER_DEF_ID and (GG.LazarusDeviceActive[Unit] == nil or GG.LazarusDeviceActive[Unit] <= 0))
                or UnitDef == J_COMMANDER_DEF_ID then
            --any code to be executed when commander dies
				--in game of thrones mode transfer all units to the killing enemy
				if boolGameOfThronesActive == true then
						allTeamUnits = Spring.GetTeamUnits(Team)
						process(allTeamUnits,
						function(id)
							transferUnitTeam(id, attackerTeamID)
						end
						)
				end
            Spring.KillTeam(Team)
        end
    end

    --NOTE: EOF
end