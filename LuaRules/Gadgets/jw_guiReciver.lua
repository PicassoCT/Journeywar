function gadget:GetInfo()
    return {
        name = "jw_guiReciver",
        desc = "Recives messages from the gui thread",
        author = "zwzsg",
        date = "3rd of May 2010",
        license = "Free",
        layer = 0,
        version = 1,
        enabled = true
    }
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then

    local ZoneDefs = {
        [UnitDefNames["triggerzone"].id] = true,
        [UnitDefNames["actionzone"].id] = true,
        [UnitDefNames["reservoirzone"].id] = true,
    }

    function NxtIofChar(startindex, str, char)
        for i = startindex + 1, string.len(str), 1 do
            if str:sub(i, i) == char then return i end
        end
        return string.len(str)
    end

    function gadget:RecvLuaMsg(msg, playerID)
        if msg then
            ident =  string.lower(string.sub(msg, 1, 3))
            Spring.Echo(msg)

            if ident == "upg" then
                name, active, spectator, teamID, allyTeamID, pingTime, cpuUsage, country, rank, _ = Spring.GetPlayerInfo(playerID)

                if GG.ComEnders ~= nil and GG.ComEnders[teamID] ~= nil then
                    id = GG.ComEnders[teamID]

                    local env = Spring.UnitScript.GetScriptEnv(id)
                    if env then
                        --- -Spring.Echo("Upgrade "..string.ident(msg,5,string.len(msg)).." i choose You")
                        env.theActualUpgrade(string.sub(msg, 5, string.len(msg)))
                    end
                end
            end

            if ident == "dea" then
                name, active, spectator, teamID, allyTeamID, pingTime, cpuUsage, country, rank, _ = Spring.GetPlayerInfo(playerID)
                --TODO coordx|coordz| type of Zone

                firstStop = NxtIofChar(3, msg, "|")
                secondStop = NxtIofChar(firstStop, msg, "|")
                thirdStop = NxtIofChar(secondStop, msg, "|")
                --Spring.Echo("Stop:"..firstStop.." "..secondStop.." "..thirdStop)

                typeOfZone = string.lower(string.sub(msg, firstStop + 1, secondStop - 1))
                coordx = string.sub(msg, secondStop + 1, thirdStop - 1)
                coordz = string.sub(msg, thirdStop + 1, string.len(msg))


                if typeOfZone == "tz" then
                    GG.UnitsToSpawn:PushCreateUnit("triggerzone", coordx, 0, coordz, 0, teamID)
                elseif typeOfZone == "az" then
                    GG.UnitsToSpawn:PushCreateUnit("actionzone", coordx, 0, coordz, 0, teamID)
                elseif typeOfZone == "rz" then
                    GG.UnitsToSpawn:PushCreateUnit("reservoirzone", coordx, 0, coordz, 0, teamID)
                elseif typeOfZone == "del" then
                    TableOfUnits = Spring.GetUnitsInCylinder(coordx, coordz, 50)
                    if TableOfUnits and #TableOfUnits > 0 then
                        for i = 1, #TableOfUnits do
                            id = Spring.GetUnitDefID(TableOfUnits[i])
                            if id and ZoneDefs[id] then
                                Spring.DestroyUnit(TableOfUnits[i], true, true)
                            end
                        end
                    end
                end

                if teamID then
                end
            end
        end
    end
end