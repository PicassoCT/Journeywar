include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"


--<pieces>
include "lib_UnitScript.lua"
include "lib_jw.lua"
include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

reloadTime= 29000
SIGHT_RANGE= 45000
Droneemit = piece"DroneEmit1"
DroneemitDistance= 10

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


boolBuildDrones = false
returnFreeSpot = nil
function OS_LOOP()
    StartThread(timing)
    Sleep(50)
	baitType = {
				UnitDefNames["bonker"].id,
				UnitDefNames["cdistrictnone"].id,
				UnitDefNames["buibaicity1"].id,
				UnitDefNames["cwatchpost"].id,
				UnitDefNames["smconverter"].id,
				UnitDefNames["crailgun"].id,
				UnitDefNames["factoryspawndecorator"].id,	
				UnitDefNames["chopper"			].id			
				}
	randRobin= math.random(1,#baitType)
				
    while (true) do
        boolCharged = ischarged()

        if boolCharged == true then
			if boolBuildDrones== false then
				spawnBuilding()
			else		
				spawnDefenseDrone()
			end
        end
        Sleep(1000)
    end
end

myDrone=nil
function createCauterizerDroneIfThereIsNone()
boolDroneExists= false
if myDrone then
boolDroneExists= Spring.GetUnitIsDead(myDrone) 
end
	if not myDrone or not boolDroneExists or boolDroneExists ==false then
		return createUnitAtPiece(unitID, UnitDefNames["cauterizer"].id, Droneemit, Spring.GetUnitTeam(unitID))
	end
end

function spawnDefenseDrone()
 enemyID = Spring.GetUnitNearestEnemy(unitID, SIGHT_RANGE)
        if enemyID then
			 Sleep(reloadTime)
			while not myDart do
				myDart = createCauterizerDroneIfThereIsNone()
				Sleep(100)
			end
	       ex, ey, ez = Spring.GetUnitPosition(enemyID)
           Command(myDart, "attack", { x = ex, y = ey, z = ez }, { "shift" })

            boolNotDeadYet = Spring.GetUnitIsDead(myDart)
            while boolNotDeadYet and boolNotDeadYet == false do
                Sleep(200)
                boolNotDeadYet = Spring.GetUnitIsDead(myDart)
            end
        end
		Sleep(100)
end

TablesOfPiecesGroups = {}
function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
    Spring.SetUnitBlocking(unitID, true)

	for i=1,30, 1 do
		StartThread(littleCars, i)
	end
    StartThread(OS_LOOP)
end

function littleCars(idx)
	local car = TablesOfPiecesGroups["Car"][idx]
	local pivot = TablesOfPiecesGroups["Pivot"][idx]
	randDelay=math.ceil(math.random(0,19000))
	Sleep(randDelay)

	if not car then return end
	reset(car)
	while true do
		local dir = randSign()
		local roadDir= math.random(1,6) * 60
		if dir < 0 then 	 Turn(car,y_axis,math.rad(180),0,true) else  Turn(car,y_axis,math.rad(0),0,true) end
		Turn(pivot,y_axis,math.rad(roadDir),0)
		Move(car,x_axis,45*dir,0,true)
		Move(car,x_axis,-45*dir,math.random(1,4))
		WaitForMoves(car)
		Sleep(100)
	end

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
        x = 3
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

function spawnBuilding()
            --checking out the neighbourhood
            boolBuildItBob = false
            while (boolBuildItBob == false) do
                --checkthe Freespots for freedom
                returnFreeSpot = getFreeSpot()

                if returnFreeSpot ~= nil then
                    randRobin= (randRobin % #baitType) + 1
					    boolBuildItBob = true
                        Spring.CreateUnit(baitType[randRobin], repcoords[returnFreeSpot][1], y, repcoords[returnFreeSpot][2], 0, teamID)
                end
                Sleep(100)
            end
            returnFreeSpot = nil
end

function script.Activate()
	boolBuildDrones = true
	Move(Droneemit,y_axis,DroneemitDistance,1)
end

function script.Deactivate()
	boolBuildDrones = false
Move(Droneemit,y_axis,0,1)
end