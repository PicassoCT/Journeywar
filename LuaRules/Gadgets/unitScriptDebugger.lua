--statue spawn gadget

function gadget:GetInfo()
    return {
        name = "UnitScriptDebugger",
        desc = "",
        author = "pica",
        date = "3rd of May 2010",
        license = "Free",
        layer = 109,
        version = 1,
        enabled = true
    }
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear
if (gadgetHandler:IsSyncedCode()) then
	EncounterData ={}


    function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
	
		if UnitDefs[unitDefID] then
			attacker = Spring.GetUnitLastAttacker(unitID)
				if attacker then
				attackerDefID = Spring.GetUnitDefID(attacker)
				
				--Spring.Echo(Spring.GetGameFrame() .. " | "..unitID.." | " .. UnitDefs[unitDefID].name.." destroyed by ".. UnitDefs[attackerDefID].name)
			else
			--	Spring.Echo(Spring.GetGameFrame() .. " | "..unitID.." | " .. UnitDefs[unitDefID].name.." destroyed ")

			end
		end
    end
	
	

    function gadget:UnitCreated(unitID, unitDefID)
      -- Spring.Echo(Spring.GetGameFrame() .. " | "..unitID.." | " .. UnitDefs[unitDefID].name .. " created")
    end
end