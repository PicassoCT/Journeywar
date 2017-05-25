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
        enabled = false
    }
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then


    function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
        Spring.Echo(Spring.GetGameFrame() .. " -> " .. UnitDefs[unitDefID].name .. " destroyed")
    end

    function gadget:UnitCreated(unitID, unitDefID)
        Spring.Echo(Spring.GetGameFrame() .. " -> " .. UnitDefs[unitDefID].name .. " created")
    end
end