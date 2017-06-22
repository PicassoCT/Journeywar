function gadget:GetInfo()
    return {
        name = "jw_unit-test",
        desc = "Spawns one of every type of unit, issues commands of every type to that unit",
        author = "Picasso",
        date = "SPAM/SPAM/SPAM/LOVELYSPAM",
        version = "v0.1.ham.and.jam.and...",
        license = "GPL spam v3.0 or later",
        layer = -1,
        enabled = true
    }
end


if gadgetHandler:IsSyncedCode() then
    -------------------------------------
    -- Includes
    VFS.Include('scripts/lib_UnitScript.lua')

    ---------------- SYNCED---------------
    -- CONFIG --
    boolRunUnitTest = false
    function gadget:RecvLuaMsg(msg, playerID)
        if msg then
            ident = string.low(string.sub(msg, 1, 3))
            if ident and ident == "tst" then
                playerTeamID = tonumber(string.sub(msg, 5, string.len(msg)))
                boolRunUnitTest = true
            end
        end
    end

    function gadget:GameFrame(n)
        if n % 3 == 0 and boolRunUnitTest == true then
            unitTest()
            boolRunUnitTest = false
        end
    end

    playerTeamID = Spring.GetGaiaTeamID()

    function unitTest()
        UnitsTotal = table.getn(UnitDefNames)

        pow2 = 2
        while pow2 < UnitsTotal do pow2 = pow2 * 2 end

        mapSizeX, mapSizeZ = Game.mapSizeX / (pow2 / 2), Game.mapSizeZ / (pow2 / 2)
        xIndex, zIndex = 1, 1
        teamID = playerTeamID

        for k, v in pairs(UnitDefNames) do
            x = ringcrement(x, mapSizeX, 1)
            if x == mapSizeX then
                z = ringcrement(z, mapSizeZ, 1)
            end

            id = Spring.CreateUnit(v.id, x, 0, z, teamID)
            Command(id, "stop", {}, { "shift" })
            Command(id, "cloak", {}, { "shift" })
            Command(id, "cloak", {}, { "shift" })
            Command(id, "move", { x = x, y = 0, z = z + 25 }, { "shift" })
            Command(id, "setactive", {}, { "shift" })
            Command(id, "setactive", {}, { "shift" })
            Command(id, "attack", { x = x, y = 0, z = z + 25 }, { "shift" })
            Command(id, "setactive", {}, { "shift" })
            Command(id, "attack", { x = x, y = 0, z = z - 25 }, { "shift" })
        end
    end
else --Unsynced 
    local function sendUnitTestStartMessage()
        tID = Spring.GetMyTeamID()
        Spring.SendLuaRulesMsg("TST|" .. tID)
    end

    gadgetHandler.actionHandler.AddChatAction(gadget, 'unittest run', sendUnitTestStartMessage, "")
end