--<pieces>
include "lib_jw.lua"

repcoords = {}
replicPoints = {}
for i = 1, 8, 1 do
    replicPoints[i] = {}
    portalSX = "replicPoint" .. i
    replicPoints[i] = piece(portalSX)
    emitX, _, emitZ, _, _, _ = Spring.GetUnitPiecePosDir(unitID, replicPoints[i])

    repcoords[i] = {}
    repcoords[i][1] = emitX
    repcoords[i][2] = emitZ
end


--</pieces>
--<localVars>
unifiedBuildSpeed = 4
maxHealth = Spring.GetUnitHealth(unitID)
teamID = Spring.GetUnitTeam(unitID)
x, y, z = Spring.GetUnitPosition(unitID)


boolCharged = false


--</localVars>

--initliazer
timers = 0
function timing()
    while (true) do
        timers = timers + 1
        --Spring.Echo(timers)
        Sleep(1000)
    end
end


function ischarged()
    --get metall
    if timers > 100 then
        timers = 0
        return true
    else
        return false
    end
end



range = 55
function getFreeSpot()
    boolFoundSomething = false
    unitTable = {}
    pointsTable = {}




    for i = 1, table.getn(replicPoints), 1 do

        unitTable = Spring.GetUnitsInCylinder(repcoords[i][1], repcoords[i][2], range)


        --	giveSignal(repcoords[i][1], repcoords[i][2])
        --	giveSignal((repcoords[i][1])+range, repcoords[i][2])

        if unitTable == nil or table.getn(unitTable) == 0 then
            table.insert(pointsTable, i)
            boolFoundSomething = true
        end
    end


    if boolFoundSomething == true then
        max = table.getn(pointsTable)
        xi = math.random(1, max)

        return pointsTable[xi]

    else
        return nil
    end
end




returnFreeSpot = nil
function OS_LOOP()
    StartThread(timing)
    Sleep(50)
	baitType = getTypeTable(UnitDefs,  {
				"bonker",
				"chopper",
				"crailgun",
				"cwatchpost",
				"cDistrictNone",
				"buibaicity1",
				"buibaicity2",
				"factoryspawndecorator"	
				})
	randRobin= math.random(1,#baitType)
				
    while (true) do
        boolCharged = ischarged()

        if boolCharged == true then


            --ey, Yo, reSettin but neva forgettin

            --checking out the neighbourhood
            boolBuildItBob = false
            while (boolBuildItBob == false) do
                --checkthe Freespots for freedom
                returnFreeSpot = getFreeSpot()

                if returnFreeSpot ~= nil then
                    randRobin= randRobin % baitType + 1
					    boolBuildItBob = true
                        Spring.CreateUnit(baitType[randRobin], repcoords[returnFreeSpot][1], y, repcoords[returnFreeSpot][2], 0, teamID)
                end
                Sleep(100)
            end
            returnFreeSpot = nil
        end
        Sleep(1000)
    end
end




function script.Create()
    Spring.SetUnitBlocking(unitID, true)


    StartThread(OS_LOOP)
end

function script.Killed(recentDamage, _)
    --spawnARewarder
    teamID = Spring.GetUnitTeam(unitID)
    spx, spy, spz = Spring.GetUnitPosition(unitID)
	
	createRewardEvent(teamID)

    --<RubbleScript>
    if recentDamage > 1 then
        --This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
        spx, spy, spz = Spring.GetUnitPosition(unitID)
        teamID = Spring.GetUnitTeam(unitID)
        x = math.random(0, 3)
        heapID = Spring.CreateUnit("gCScrapHeap", spx, spy, spz, x, teamID)
        Spring.SetUnitNeutral(heapID, true)
        --</RubbleScript>
        --<ciVillian>

        teamID = Spring.GetGaiaTeamID()
        x = math.random(3, 7)
        for i = 1, x, 1 do
            maRa = math.random(1, 9)
            heapID = Spring.CreateUnit("gCiVillian", replicPoints[maRa][1], y, replicPoints[maRa][2], teamID)
        end

        --</ciVillian>
    else
        --This script spawns the rubbleHeap. If you too drunk to understad, just copy and paste into the Killed function
        spx, spy, spz = Spring.GetUnitPosition(unitID)
        teamID = Spring.GetGaiaTeamID()
        x = math.random(0, 3)
        heapID = Spring.CreateUnit("gCScrapHeapPeace", spx, spy, spz, x, teamID)
        Spring.SetUnitNeutral(heapID, true)
    end
    --</RubbleScript>


    return 1
end




