include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_jw.lua"
include "lib_Build.lua"
include "createCorpse.lua"

buildSpot = piece "buildspot"
center = piece "center"
innergate = piece "innergate"
outergate = piece "outergate"
shaft1 = piece "shaft1"
shaft2 = piece "shaft2"
teamID = Spring.GetUnitTeam(unitID)
SIG_STILT = 2

buildIconTable = {}


ringTable = {}
for i = 1, 5, 1 do
    ringTable[i] = {}
    piecename = "gate" .. i
    ringTable[i] = piece(piecename)
end

function rumpelStiltSkin()
    SetSignalMask(SIG_STILT)
    calcUp = 0
    while true do

        randx = math.random(-0.3, 0.3)
        randz = math.random(-0.3, 0.3)
        Move(innergate, x_axis, randx, 99)
        Move(innergate, z_axis, randz, 99)
        Sleep(125)
        calcUp = calcUp + 125
        if calcUp > 4500 then
            Spring.PlaySoundFile("sounds/cOverWorldGate/coverworldgateLoop.wav")
            calcUp = 0
        end
    end
end

rechargeTime = 1*60*1000
thatMuchMoreExpensive = 1.5
teamID = Spring.GetUnitTeam(unitID)
monsterTable = {}
boolPoweredUp = false

totalTime = 0
boolReady = false
function estimateTotalTime()
    while boolReady == false do
        totalTime = totalTime + 100
        Sleep(100)
    end
end

function LoadAnimation()
    -- step = math.floor(totalTime / 20)
    -- for i = 1, 20, 1 do
        -- Show(buildIconTable[i])
        -- Sleep(step)
    -- end
    hideT(buildIconTable)
end

function powerUp(speedFactor)
    Move(outergate, y_axis, -359, 0)
    Move(shaft1, y_axis, -17, 0.3*speedFactor)
    Move(shaft2, y_axis, -35, 0.3*speedFactor)
    if totalTime ~= 0 then StartThread(LoadAnimation) end
    if boolReady == false then StartThread(estimateTotalTime) end
    WaitForMove(shaft1, y_axis)
    WaitForMove(shaft2, y_axis)
    Spin(outergate, y_axis, math.rad(42), 0.01*speedFactor)
    for i = 1, table.getn(ringTable), 1 do
        val = math.random(-80, 80)
        Spin(ringTable[i], y_axis, val, 0.05 * i*speedFactor)
    end
    Move(shaft1, y_axis, 0, 9*speedFactor)
    Move(shaft2, y_axis, 0, 15*speedFactor)
     WaitForMove(shaft1, y_axis)
    WaitForMove(shaft2, y_axis)
    boolReady = true
    Move(outergate, y_axis, 0, 32*speedFactor)
    Show(outergate)
    Spring.PlaySoundFile("sounds/cOverWorldGate/coverworldgateOpen.wav")
    for i = 1, 3, 1 do
        Spring.PlaySoundFile("sounds/cOverWorldGate/coverworldgateLoop2.wav")
        Sleep(4700)
    end
    Show(innergate)
    Signal(SIG_STILT)
    StartThread(rumpelStiltSkin)
    boolPoweredUp = true
end

function powerDown()
    for i = 1, table.getn(ringTable), 1 do
        StopSpin(ringTable[i], y_axis, 0.05)
    end
    Signal(SIG_STILT)
    Move(shaft1, y_axis, 0, 0.5)
    Move(shaft2, y_axis, 0, 0.5)
    Hide(innergate)
    Sleep(4000)
    Hide(outergate)
    Sleep(3000)
    for i = 1, table.getn(ringTable), 1 do
        StopSpin(ringTable[i], y_axis, 0)
    end

    for i = 1, table.getn(ringTable), 1 do
        val = math.ceil(math.random(-8, 8))
        Spin(ringTable[i], y_axis, math.rad(val), 0.5)
    end
    boolPoweredUp = false
end

px, py, pz = Spring.GetUnitPiecePosDir(unitID, buildSpot)



function createUnitFunction(unitTypeString)
    
    spawnedID = Spring.CreateUnit(unitTypeString, px, py, pz, 0, teamID)
    --Add impulse depending upon building direction..
    if spawnedID ~= nil then
        dx, dy, dz = Spring.GetUnitDirection(unitID)
        lmax = math.max(math.abs(dx), math.abs(math.max(dy, dz)))
        dx = dx / lmax
        dz = dz / lmax
        dx = dx
        dz = dz
        Spring.AddUnitImpulse(spawnedID, dx, 3, dz)
    end

    return spawnedID
end

boolActive = true

function getUnitAvgCost(TypeTable)
sum=0
numberUnits= 0
	for k,defID in pairs(TypeTable) do
		cost= (UnitDefs[defID].metalCost + UnitDefs[defID].energyCost)*thatMuchMoreExpensive
		sum= sum +cost
		numberUnits= numberUnits +1
	end
return sum/numberUnits
end

function getSpawnPosition(enemyID)
if not enemyID then return end
	ex, ey, ez = Spring.GetUnitPosition(enemyID) -- this should allow the unit to follow a friend closest to a foe
	if ex then
				if math.abs(ex - ox + ey - oy + ez - oz) < 5 then
					eteamid = Spring.GetUnitTeam(enemyID)
					ex, ey, ez = Spring.GetTeamStartPosition(eteamid)
				end
	return ex,ey,ez
	end
end

function theNeedOfTheMany()
intervall = 6

	boolThisCanWorkOut = false
	for i=intervall, 0, -1  do
		boolThisCanWorkOut = consumeAvailableRessourceUnit(unitID, "metal", math.ceil(i * (averageUnitCost)))			
		if boolThisCanWorkOut == true then break end
	end
	
	intervall = math.max(2,intervall)
	if  intervall == 2 then showPlayerBroke()	end

return intervall
end

unitTypeIndex= 0
function spawner()

    local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy
    local spGetUnitPosition = Spring.GetUnitPosition
    local spSpawnCEG = Spring.SpawnCEG
    local lCreateUnitFunction = createUnitFunction
    local spSetUnitMoveGoal = Spring.SetUnitMoveGoal
    local spEmitSfx = EmitSfx
    local spSetUnitNoSelect = Spring.SetUnitNoSelect

    local x, y, z = Spring.GetUnitPosition(unitID)


	creeperTypeTable= dictToTable(getCentrailOverworldGateUnitTypeTable())
    averageUnitCost = getUnitAvgCost(creeperTypeTable)



    enemyID = spGetUnitNearestEnemy(unitID)
    ox, oy, oz = Game.mapSizeX / 2, 0, Game.mapSizeZ / 2
    if enemyID then ox, oy, oz = spGetUnitPosition(enemyID) end

    while (true) do
        --- -Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")

		while boolActive== true do
		Sleep(rechargeTime)
		for i=1,#buildIconTable do
			partTime= math.ceil(rechargeTime/#buildIconTable)
			Show(buildIconTable[i])
			Sleep(partTime)
		end
			enemyID = spGetUnitNearestEnemy(unitID)

			if enemyID and type(enemyID)== "number" then
				if boolPoweredUp == false then powerUp(15) end
				spawnPortalEffect()
				hideT(buildIconTable)
				
				ex,ey,ez = getSpawnPosition(enemyID)
				if ex then
					ox, oy, oz = ex, ey, ez
					-- acquire ressources
					intervall=theNeedOfTheMany()
						for i = 1, intervall, 1 do
							unitTypeIndex= (unitTypeIndex % #creeperTypeTable) +1
							Unittype = creeperTypeTable[unitTypeIndex]

							spawnPortalEffect()
							spawnedUnit = lCreateUnitFunction(Unittype)
							if spawnedUnit then
								--spSetUnitNoSelect(spawnedUnit,true)							
								Sleep(1550)
								spSetUnitMoveGoal(spawnedUnit, ex, ey, ez)
								table.insert(monsterTable, spawnedUnit)
							end
					end
				end
			
				Sleep(4000)
				powerDown()
				
			end
		Sleep(100)
		end
	Sleep(100)	
    end
end

function showPlayerBroke()


end

function spawnPortalEffect()
    x, y, z = Spring.GetUnitPosition(unitID)
    Spring.SpawnCEG("portable", x, y + 70, z, 0, 1, 0, 60)
    Spring.SpawnCEG("holeinthesky", x, y + 320, z, 0, 1, 0, 60)
end

function TargetOS()

    local spValidUnitID = Spring.ValidUnitID
    local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy

    local spGetUnitPosition = Spring.GetUnitPosition
    local spSetUnitMoveGoal = Spring.SetUnitMoveGoal
    local boolFlipFlop = true
    while (true) do
        Sleep(12000)
        if monsterTable ~= nil and table.getn(monsterTable) > 0 then
            enemyID = nil


            if GG.ComEnders and GG.ComEnders[teamID] then enemyID = GG.ComEnders[teamID]
            else
                if spValidUnitID(monsterTable[i]) == true then
                    enemyID = spGetUnitNearestEnemy(monsterTable[i])
                end
            end


            for i = 1, table.getn(monsterTable), 1 do
                if (spValidUnitID(monsterTable[i])) == true then

                    if enemyID ~= nil then
                        ex, ey, ez = spGetUnitPosition(enemyID)
                        if math.random(0, 1) == 1 then
                            eteam = Spring.GetUnitTeam(enemyID)
                            ex, ey, ez = Spring.GetTeamStartPosition(eteam)
                        end

                        spSetUnitMoveGoal(monsterTable[i], ex, ey, ez)
                    end
                end
            end
        end
    end
end
 TableOfPieceGroups = {}
	
function script.Create()
    TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	buildIconTable= TableOfPieceGroups["troop"]
    hideT(buildIconTable)

    Hide(innergate)
    Hide(outergate)
    StartThread(spawner)
    StartThread(TargetOS)
    StartThread(powerDown)
end

function script.Activate()
 boolActive= true
	return 1
end
function script.Deactivate()
boolActive = false
	return 1
end


function script.Killed(recentDamage, _)

    createCorpseCBuilding(unitID, recentDamage)
    return 0
end