--Mission3-----------------------------------------------------------------------------------------

-- returns a Array of all reachable Nodes, beginning at nine O Clock, encoded from 1-8
function getTheCentrailTeam()
    tables = {}
    tables = Spring.GetTeamList()
    TeamCentId = nil

    for i = 1, table.getn(tables), 1 do
        temp = {}
        _, _, _, _, side, _, _, _ = Spring.GetTeamInfo(tables[i])

        if string.lower(side) == "centrail" then
            TeamCentId = tables[i]
            break
        end
    end

    if TeamCentId then
        return TeamCentId
    end

    return 1 --the SinglePlayerWorstCase
end

function avgHeightDiff(pointx, pointz, measureDist, limit)
    h1 = spGetGroundHeight(pointx + measureDist, pointz)
    h2 = spGetGroundHeight(pointx - measureDist, pointz)
    h3 = spGetGroundHeight(pointx, pointz + measureDist)
    h4 = spGetGroundHeight(pointx, pointz - measureDist)
    return ((math.abs(h1 - h2) + math.abs(h3 - h4)) / 2 < limit)
end

-- function randSign()
-- if math.random(0,1)==1 then return -1 else return 1 end
-- end

local percentOkay = nil

function condition(i, j, val)
    return (Game.mapSizeX * 0.20) < i * val and (Game.mapSizeZ * 0.20) < j * val
end

storedI = nil
storedJ = nil
function slumbuilt(i, j, goTeamTardis, val)

    if condition(i, j, val) == true then

        if storedI == nil then
            storedI = i
            storedJ = j
        end


        diceBeNice = math.random(0, 4)
        if storedI and math.abs(storedI - i) < 3 == true and math.abs(storedJ - j) < 3 == true then
            dir = 1
            if diceBeNice == 0 then
                id = spCreateUnit("ctransithub", i * val, 0, j * val, dir, goTeamTardis)
                Spring.SetUnitNoSelect(id, true)
                spSetAlwaysVisible(id, true)
                GG.SpawnPointTable[#GG.SpawnPointTable + 1] = {}
                GG.SpawnPointTable[#GG.SpawnPointTable] = { unitid = id, CoordI = i, CoordJ = j }


            elseif diceBeNice == 1 or diceBeNice == 4 then
                id = spCreateUnit("cscumslum", i * val, 0, j * val, dir, goTeamTardis)
                Spring.SetUnitNoSelect(id, true)
                spSetAlwaysVisible(id, true)


            else
                for t = -1, 1, 1 do
                    id = spCreateUnit("galgoprop", i * val + t * 82, 0, j * val + t * 82 * randSign(), dir, goTeamTardis)
                    Spring.SetUnitNoSelect(id, true)
                    spSetAlwaysVisible(id, true)
                end
            end
        end
    end
end

lastI = 0
lastJ = 0
function lastIJisFarAway(i, j)
    ReturnOfTheBoolean = (math.abs(lastI - i) + math.abs(lastJ - j)) > 12
    if ReturnOfTheBoolean == true then lastI, lastJ = i, j end
    return ReturnOfTheBoolean
end

Mission3Message = 0
Mission3CoolDownTime = 3000
Mission3Max = 9

function Mission3MessageFunc(frames)
    Mission3CoolDownTime = Mission3CoolDownTime - frames

    if Mission3CoolDownTime < 0 and Mission3Message < Mission3Max then
        Mission3CoolDownTime = 4000
        Mission3Message = Mission3Message + 1
        name = "sounds/Missions/Mission3/CurfewMessage" .. Mission3Message .. ".ogg"
        spPlaySound(name, 1.0)
    end
end

boolHarbour = 0 --A harbour is always there where the water is
function Mission3City(frame)
    --MissionFunctionTable[3][]

    --S-pring.Echo("Mission @::",MissionFunctionTable[3][3])
    --S-pring.Echo("MissionTime::",frame-MissionFunctionTable[3][2])
    --test for one player beeing combine, one beeing journeys

    if MissionFunctionTable[3][2] == nil then MissionFunctionTable[3][2] = frame end
    if MissionFunctionTable[3][3] == nil then
        MissionFunctionTable[3][3] = {}
        MissionFunctionTable[3][3] = 0
    end

    --S-pring.Echo("Mission @::",MissionFunctionTable[3][3])
    --S-pring.Echo("MissionTime::",frame-MissionFunctionTable[3][2])

    if MissionFunctionTable[3][3] == 0 then
        spPlaySound("sounds/Missions/Mission3/jdropofdreams.ogg", 1.0)
        local lavgHeightDiff = avgHeightDiff
        if Game.mapSizeX * Game.mapSizeZ < 4194304 then return true end
        --init Streets
        MissionFunctionTable[3][4] = {}

        local val = 1024
        feamID = Spring.GetGaiaTeamID()
        for i = 1, Game.mapSizeX / val, 1 do
            if (i ~= 1 and i < Game.mapSizeX / val - 1) then

                for j = 1, Game.mapSizeZ / val, 1 do
                    if (j ~= 1 and j < Game.mapSizeZ / val - 1) then



                        if spGetGroundHeight(i * val, j * val) > 0 and lavgHeightDiff(i * val, j * val, 220, 65) then
                            --S-pring.Echo("Spawning GroundDecal")
                            d = spCreateUnit("gcivdecal", i * val, 0, j * val, 0, feamID)
                            if d then
                                spSetAlwaysVisible(d, true)
                            end
                        end
                    end
                end
            end
        end
        unitTable = {}

        --init Buildings

        val = 320
        GG.Valerie = val
        GG.SpawnPointTable = {}
        GG.Nodetable = {}

        --determinate size of Map
        -- if Map > then Spawn InnerCity

        --determinate Sectors

        --S-pawn Decals
        atLeastThree = 0
        --Add Buildings by Type of Sector
        for i = 1, Game.mapSizeX / val, math.random(1, 1.4) do
            GG.Nodetable[i] = {}
            for j = 1, Game.mapSizeZ / val, math.random(1, 1.4) do
                GG.Nodetable[i][j] = {}
                GG.Nodetable[i][j] = true


                if spGetGroundHeight(i * val, j * val) > 0 and lavgHeightDiff(i * val, j * val, 40, 85) == true then

                    if (i > 3 and i % 2 == 0 and i < Game.mapSizeX / val - 3) and (j > 3 and j % 2 == 0 and j < Game.mapSizeZ / val - 3) or math.random(0, 50) == 42 then --and math.random(0,1)==1
                        dir = math.floor(math.random(1, 4))
                        --9
                        if math.random(0, 8) ~= 5 or #unitTable % 6 == 0 then

                            did = spCreateUnit("gcivilbuilding", i * val, 0, j * val, dir, feamID)
                            if math.random(0, 3) == 2 then spCreateUnit("jdrops", i * val + math.random(-55, 55), Spring.GetGroundHeigth(i * val,j*val)+math.random(500,1000), j * val + math.random(-55, 55), dir, feamID) end

                            if did then
                                unitTable[#unitTable + 1] = did
                                GG.Nodetable[i][j] = false
                                spSetAlwaysVisible(did, true)
                            end
                        elseif atLeastThree < 6 and lastIJisFarAway(i, j) == true then --Farcaster
                            atLeastThree = atLeastThree + 1
                            did = spCreateUnit("gfarcaster", i * val, 0, j * val, dir, feamID)
                            if did then
                                unitTable[#unitTable + 1] = did
                                spSetAlwaysVisible(did, true)
                                GG.SpawnPointTable[#GG.SpawnPointTable + 1] = {}
                                --assert(unitTable[#unitTable],"JW_MiniMIssion3::unitID undefined")
                                GG.SpawnPointTable[#GG.SpawnPointTable] = { unitid = unitTable[#unitTable], CoordI = i, CoordJ = j }
                                --assert(GG.SpawnPointTable[#GG.SpawnPointTable].unitid,"I m thefore i am :")
                            end
                            GG.Nodetable[i][j] = true

                        else --S-pecialbuildings limited edition
                            nid = math.random(0, 3)
                            if nid == 0 or nid == 1 then --S-pecialbuildings
                                did = spCreateUnit("gprops", i * val, 0, j * val, dir, feamID)
                                if did then
                                    unitTable[#unitTable + 1] = did
                                    GG.Nodetable[i][j] = false
                                    spSetAlwaysVisible(did, true)
                                end

                            elseif nid == 2 then
                                did = spCreateUnit("cmbuilux", i * val, 0, j * val, dir, feamID)
                                if did then
                                    unitTable[#unitTable + 1] = did
                                    GG.Nodetable[i][j] = false
                                    spSetAlwaysVisible(did, true)
                                end
                            elseif nid == 3 then
                                did = spCreateUnit("csmconverter", i * val, 0, j * val, dir, feamID)
                                if did then
                                    unitTable[#unitTable + 1] = did
                                    GG.Nodetable[i][j] = false
                                    spSetAlwaysVisible(did, true)
                                end
                            end



                            --S-lums
                            --arcos
                            --districtbuildings
                        end
                    else
                        if math.random(0, 1) == 1 then slumbuilt(i, j, feamID, val)
                        elseif math.random(0, 9) == 2 and (i > 3 and i % 2 == 1 and i < Game.mapSizeX / val - 3) and (j > 3 and j % 2 == 1 and j < Game.mapSizeZ / val - 3) then
                            did = spCreateUnit("gprops", i * val, 0, j * val, 1, feamID)
                            if did then
                                unitTable[#unitTable + 1] = did
                                GG.Nodetable[i][j] = false
                                spSetAlwaysVisible(did, true)
                            end
                        end
                    end


                else
                    if spGetGroundHeight(i * val, j * val) < -5 and boolHarbour < 3 and math.random(0, 1) == 1 then
                        boolHarbour = boolHarbour + 1

                        d = spCreateUnit("gprops", i * val, 0, j * val, 1, feamID)
                        spSetAlwaysVisible(d, true)
                    end

                    GG.Nodetable[i][j] = false
                end
                --	end
            end
        end

        did = spCreateUnit("gfarcaster", Game.mapSizeX / 2, 0, Game.mapSizeZ / 2, 1, feamID)
        if did then
            unitTable[#unitTable + 1] = did
            spSetAlwaysVisible(did, true)
            GG.SpawnPointTable[#GG.SpawnPointTable + 1] = {}
            --assert(unitTable[#unitTable],"JW_MiniMIssion3::unitID undefined")
            GG.SpawnPointTable[#GG.SpawnPointTable] = { unitid = unitTable[#unitTable], CoordI = math.floor((Game.mapSizeX / val) * 0.5), CoordJ = math.floor((Game.mapSizeZ / val) * 0.5) }
        end

        did = spCreateUnit("gspaceport", Game.mapSizeX / 2, 0, (Game.mapSizeZ / 2) - 700, 1, feamID)
        if did then
            unitTable[#unitTable + 1] = did
            spSetAlwaysVisible(did, true)
            GG.SpawnPointTable[#GG.SpawnPointTable + 1] = {}
            --assert(unitTable[#unitTable],"JW_MiniMIssion3::unitID undefined")
            GG.SpawnPointTable[#GG.SpawnPointTable] = { unitid = unitTable[#unitTable], CoordI = math.floor((Game.mapSizeX / val) * 0.5), CoordJ = math.floor((Game.mapSizeZ / val) * 0.5) }
        end



        MissionFunctionTable[3][3] = MissionFunctionTable[3][3] + 1
        MissionFunctionTable[3][2] = frame
    end

    if frame >= 30 * 60 * 25 and MissionFunctionTable[3][3] == 1 then
        MissionFunctionTable[3][3] = MissionFunctionTable[3][3] + 1
    end



    if MissionFunctionTable[3][3] == 1 and frame % 200 == 0 then
        Mission3MessageFunc(200)
        boolCityDestroyed = true
        percentAway = 0.01

        if percentOkay == nil or percentOkay < table.getn(unitTable) then percentOkay = table.getn(unitTable) end

        for i = 1, table.getn(unitTable), 1 do
            --Check if building is destroyed
            if Spring.GetUnitIsDead(unitTable[i]) == true then
                percentAway = percentAway + 1

            else
                boolCityDestroyed = false
            end
        end

        if boolCityDestroyed == false then
            res = math.min(100, math.max(1, 100 - math.floor(100 * math.min(1, (percentOkay / percentAway)))))
            timeTillReinforcements = math.floor((45000 - frame) / 1800)
            if timeTillReinforcements < 0 then MissionFunctionTable[3][3] = MissionFunctionTable[3][3] + 1 end
            Message = "Evacuation complete in:" .. timeTillReinforcements .. " minutes. " .. res .. " % of the City destroyed. "
            cout(Message)
            return false
        else
            cout("City Destroyed. Journeys Win!")
            if GG.LastAttackingJourney ~= nil then
                for i = 1, 3, 1 do
					createRewardEvent( GG.LastAttackingJourney, 100, 100)
                end
            end
            GG.UnitsToSpawn:PushCreateUnit("jvictory", Game.mapSizeX / 2, 1, Game.mapSizeZ / 2, 1, getTheCentrailTeam())
            return true
        end
    end


    if MissionFunctionTable[3][3] == 2 then
        if getTheCentrailTeam() then
				createRewardEvent( getTheCentrailTeam(), 300, 300)

        end
        GG.UnitsToSpawn:PushCreateUnit("cvictory", Game.mapSizeX / 2, 1, Game.mapSizeZ / 2, 1, getTheCentrailTeam())
        cout("City Saved. Combine win!")
        return true
    end

    return false
end
	