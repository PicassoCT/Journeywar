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

    function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
		if UnitDefs[unitDefID] then
			Spring.Echo(Spring.GetGameFrame() .. " | "..unitID.." | " .. UnitDefs[unitDefID].name )
		end
    end

    function gadget:UnitCreated(unitID, unitDefID)
        Spring.Echo(Spring.GetGameFrame() .. " | "..unitID.." | " .. UnitDefs[unitDefID].name .. " created")
    end
end