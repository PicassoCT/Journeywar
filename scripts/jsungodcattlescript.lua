include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"
include "lib_jw.lua"

local piecesTable = {}
center = piece "center"
piecesTable[#piecesTable+1] = center
turnerPoint = piece "turnerPoint"
piecesTable[#piecesTable+1] = turnerPoint
Main = piece "Main"
piecesTable[#piecesTable+1] = Main

Head = piece "Head"
piecesTable[#piecesTable+1] = Head


EggCannon = piece "EggCannon"
piecesTable[#piecesTable+1] = EggCannon
upleg1 = piece "upleg1"
piecesTable[#piecesTable+1] = upleg1
EggRotator=piece"EggRotator"
LLegTable = {}
LegTable = {}

upLegTable={}
Lupleg1 = piece "Lupleg1"
upLegTable[#upLegTable+1] = Lupleg1
upleg2 = piece "upleg2"
upLegTable[#upLegTable+1] = upleg2
Lupleg2 = piece "Lupleg2"
upLegTable[#upLegTable+1] = Lupleg2
upleg3 = piece "upleg3"
upLegTable[#upLegTable+1] = upleg3
Lupleg3 = piece "Lupleg3"
upLegTable[#upLegTable+1] = Lupleg3

RateOfDecrease = 65

_, MAGICRESPAWNNUMBER = Spring.GetUnitHealth(unitID)
MAGICRESPAWNNUMBER = MAGICRESPAWNNUMBER / 2
ItterationsTillReSpawn = 0
GROWUPTIME= 3*60*1000
SIG_MOVE = 1
SIG_LAY = 2
SIG_GET = 4
myDefID= Spring.GetUnitDefID(unitID)
myTeamID = Spring.GetUnitTeam(unitID)


sounds={
"sounds/jSunCattle/UrScream.wav",
"sounds/jSunCattle/move.ogg",
}

function costlyWhileOnTheMove()
    local lSetUnitHealth = Spring.SetUnitHealth
    local lGetUnitHealth = Spring.GetUnitHealth
    while (true) do

        while boolMoving == true do
			Sleep(500)
			health = lGetUnitHealth(unitID)
            lSetUnitHealth(unitID, health - RateOfDecrease * (0.05 * math.max(1, GG.SunGodCattleTable[myTeamID])))
        end

        health = lGetUnitHealth(unitID)
        lSetUnitHealth(unitID, health - 2 * (0.05 * math.max(1, GG.SunGodCattleTable[myTeamID])))

        Sleep(1000)
    end
end

function layDownYourWorryHead()

    SetSignalMask(SIG_LAY)
	
    Sleep(900)
    boolMoving = false
	boolUpright= false
    Signal(SIG_GET)
	legDown(8)

    Turn(Main, z_axis, math.rad(0), 12)
    Turn(turnerPoint, z_axis, math.rad(-45), 12)
    WaitForTurn(turnerPoint, z_axis)

    Turn(turnerPoint, z_axis, math.rad(-85), 0.4)
    WaitForTurn(turnerPoint, z_axis)
	spawnCegAtUnit(unitID,"dirt",0,10,0)
    Sleep(2000)

	while boolMoving == false do
		for i = 1, #LegTable, 1 do
			tSyncIn(LegTable[i],math.random(22, 40),math.random(22, 40),math.random(22, 40)*-1,1500)
		end
		
		for i = 1, #TableOfPieceGroups["KLeg"], 1 do
			pied= TableOfPieceGroups["KLeg"][i]
			tSyncIn(pied,math.random(22, 40),math.random(22, 40),math.random(22, 50), 1500)
			tSyncIn(TableOfPieceGroups["KLLeg"][i],math.random(22, 40),math.random(22, 40),math.random(22, 50), 1500)
			
		end
		rest=math.random(1,16)
		Sleep(1500*rest)
    end


    --lay DownAnimation
end



function getUpAndMove()
    SetSignalMask(SIG_GET)
    Turn(center, y_axis, math.rad(0), 0.85)
	legDown(80)
	WaitForTurns(LegTable)
    Turn(turnerPoint, z_axis, math.rad(0), 0.27)
    Turn(Main, z_axis, math.rad(zRotationMain), 0.27)
standUpFactor=1
steps=400
    while (true == Spring.UnitScript.IsInTurn(piecesTable[2], z_axis))  do
		 tval= math.random(10,60)
		 for i = 1, 3 do
			tSyncIn(TableOfPieceGroups["KLeg"][i],math.random(-10,10),0, -tval, steps*2)
			tSyncIn(TableOfPieceGroups["KLLeg"][i],math.random(-10,10),0, -2*tval, steps*2)
		 end
		 
		standUpFactor=standUpFactor/2
        for i = 1, #LegTable do
			if i % 2 == 0 then
			tSyncIn(LegTable[i],math.random(-10,10),0, 41*standUpFactor, steps)
			tSyncIn(LLegTable[i],math.random(-10,10),0, 150,steps)
			
			else
			tSyncIn(LegTable[i],math.random(-10,10),0, 0,steps)
			tSyncIn(LLegTable[i],math.random(-10,10),0, 0,steps)
			end			
        end   
   
        Sleep(steps)     

		for i = 1, #LegTable do
			if i % 2 == 0 then
				tSyncIn(LegTable[i],math.random(-10,10),0, 41*standUpFactor,steps)
				tSyncIn(LLegTable[i],math.random(-10,10),0, math.random(20,70)*standUpFactor,steps)			
			else
				tSyncIn(LegTable[i],math.random(-10,10),0, -71,steps)
				tSyncIn(LLegTable[i],math.random(-10,10),0, 140,steps)
			end			
        end   
	
        Sleep(steps)
    end
	resetT(LegTable,10)
	resetT(LLegTable,10)
	setSpeedEnv(unitID,1.0)
	StartThread(swingAppendix)
 StartThread(PlaySoundByUnitDefID, myDefID, sounds[math.random(1,#sounds)], 0.5, 2000, 1, 0)
 boolUpright= true
 while boolMoving == true do
		 tval= math.random(10,60)
		 for i = 1, 3 do
			tSyncIn(TableOfPieceGroups["KLeg"][i],math.random(-35,35),0, -tval, 1600)
			tSyncIn(TableOfPieceGroups["KLLeg"][i],math.random(-35,35),0, -2*tval, 1600)
		 end
		 		 
		for i = 1, #LegTable do
			if i % 2 == 0 then
				tSyncIn(LegTable[i], -25+ math.random(-5,5),0, -zRotationMain,800)
				tSyncIn(LLegTable[i],25+ math.random(-5,5),0, -zRotationMain,800)			
			else
				tSyncIn(LegTable[i],30 +math.random(-5,5),0,-zRotationMain,800)
				tSyncIn(LLegTable[i],-30 + math.random(-5,5),0, -zRotationMain,800)
			end			
        end  	
		Sleep(800)	
		for i = 1, #LegTable do
			if i % 2 == 1 then
				tSyncIn(LegTable[i], -25+ math.random(-5,5),0, 0,800)
				tSyncIn(LLegTable[i],25+ math.random(-5,5),0, 0,800)			
			else
				tSyncIn(LegTable[i],30 +math.random(-5,5),0, 0,800)
				tSyncIn(LLegTable[i],-30 + math.random(-5,5),0, 0,800)
			end			
        end  	
		Sleep(800)		
	end
	legDown()
end

function swingAppendix()
appMax= #TableOfPieceGroups["App"]
while boolMoving== true do
	Sleep(250)
	factor = (Spring.GetGameFrame() %300/300)*math.pi*2
	yval = math.random(-5,5)/5
	
	for i = 1,appMax do
		tSyncIn(TableOfPieceGroups["App"][i],math.cos(factor+i*((math.pi)/appMax))*42,yval,-zRotationMain,250)
	end
	
end


end

boolMoving = false
_, originalHealth = Spring.GetUnitHealth(unitID)
function script.StartMoving()
	if boolDead== false then
    Signal(SIG_MOVE)
    Signal(SIG_LAY)
    Signal(SIG_GET)
    boolMoving = true

    StartThread(getUpAndMove)
	end
end

function legDown(speed)
	speed=speed or 3.25
	turnT(LegTable,0,0,-zRotationMain,speed)
end

function script.StopMoving()
	if boolDead==false then

    Signal(SIG_LAY)
    legDown()
    StartThread(layDownYourWorryHead)
	end
end



boolDefBuffActive = true

oldFrame = 0
currentFrame = 0
cegSpawnValue = 225
boolFirstTime=false
boolCurrentlyDrawing=false
function drawBlood(x,z)
if boolCurrentlyDrawing== true then return end
boolCurrentlyDrawing= true
raddeg= (x/z)*2*math.pi
firstBlood= TableOfPieceGroups["Blood"]
turnPieceRandDir(firstBlood,0, 360,-360,360,-360,360,-360)
Turn(firstBlood,y_axis,math.rad(raddeg),0)
spinT(TableOfPieceGroups["Blood"],z_axis,5,-42,42)
process(TableOfPieceGroups["Blood"],
		function(id)
			movePieceToPiece(unitID,id, firstBlood, 0)
			WaitForMoves(id)
			spinRand(id, -22,22, 0.02)
			mSyncIn(id,0,0,0,1500)
		
		end
		)
		Sleep(1500)
process(TableOfPieceGroups["Blood"],
		function(id)
			if id ~= firstBlood then
				movePieceToPiece(unitID,id, firstBlood,3)		
			end
		end
		)		
		WaitForMoves(TableOfPieceGroups["Blood"])
boolCurrentlyDrawing=false
end

function script.HitByWeapon(x, z, weaponDefID, damage)
	if damage > 50 then
		StartThread(drawBlood,x,z)
	end

    if damage then
        boolDefBuffActive = false
        Signal(SIG_MOVE)
        degree = math.deg(math.atan2(x, z))
        ItterationsTillReSpawn = ItterationsTillReSpawn + damage
        currentFrame = Spring.GetGameFrame()
        if currentFrame > oldFrame + 250 then
            oldFrame = currentFrame
            x, y, z = Spring.GetUnitPosition(unitID)
			Spring.SpawnCEG("greencross", x, y + 120, z, 0, 1, 0, 50, 0)
        end
		
        if ItterationsTillReSpawn > MAGICRESPAWNNUMBER then
		    ItterationsTillReSpawn = math.abs(ItterationsTillReSpawn - MAGICRESPAWNNUMBER)
            eggCounter = eggCounter +1
        end
		
		if eggCounter > 1 and boolFirstTime==false then
			StartThread(ReloadEggGun)
			boolFirstTime=true
		end
		hp= Spring.GetUnitHealth(unitID)
        Spring.SetUnitHealth(unitID, hp+ (1.41*damage))
    end
    return 0
end

eggCounter = 0
boolDead=false
function deathAnimation()
	boolDead=true
	Move(Main,y_axis,math.rad(-44), 50)
	WTurn(Main,z_axis,math.rad(-20), 50)
	tSyncIn(center,0,0,70,1000)
	spawnCegAtPiece(unitID, Main , "blueblood", 0,30,0)
	spawnCegAtUnit(unitID,"dirt",0,20,0)


	Sleep(500)
	spawnCegAtUnit(unitID,"helioloadaurora",0,20,0)

	turnT(TableOfPieceGroups["Leg"],z_axis,-1*math.random(-35,-25),35/1.5)
	turnT(TableOfPieceGroups["LLeg"],z_axis,-1*math.random(-110,-80),90/1.5)
	turnT(TableOfPieceGroups["KLeg"],z_axis,-1*math.random(25,35),40/1.5)
	turnT(TableOfPieceGroups["KLLeg"],z_axis,-1*math.random(70,90),80/1.5)
	Sleep(500)
		spawnCegAtPiece(unitID, Main , "blueblood", 0,30,0)
	Sleep(500)
		spawnCegAtPiece(unitID, center , "blueblood",0,30,0)
	Sleep(500)
	x,y,z=Spring.GetUnitPosition(unitID)
		for i=1,5 do
			spawnCegAtPiece(unitID, center , "blueblood", math.random(-15,15),30,math.random(-15,15))
			Spring.CreateUnit("jsuneggnogg", x + math.random(-15,15), y,  z + math.random(-15,15), 0, myTeamID)
			Sleep(500)
		end
		WaitForTurns(Main,center)
		WaitForMoves(Main,center)
	return 1
end

function script.Killed(damage, _)
	signalAll(16)
	setSpeedEnv(unitID,0.0)
	deathAnimation()

    GG.SunGodCattleTable[myTeamID] = GG.SunGodCattleTable[myTeamID] - 1
    --fallingDown Animation
    return 0
end

_,maxHealth = Spring.GetUnitHealth(unitID)
--DeBuff Cycle
local spGetUnitHealth = Spring.GetUnitHealth
local spSpawnCEG = Spring.SpawnCEG
UNITDEBUFFVAL = 25
function applyDeBuff(T)
    unithealth = Spring.GetUnitHealth(unitID)
    local ratio = unithealth / maxHealth
    for i = 1, #T, 1 do
        hp = spGetUnitHealth(T[i])
        if ratio < 0.3 then
            Spring.AddTeamResource(myTeamID, "metal", 3)
        end
        Spring.SetUnitHealth(T[i], { paralyze = hp * (15 - (15 * ratio)) })
        --sfx
        x, y, z = Spring.GetUnitPosition(T[i])
        spSpawnCEG("parallyzebuff", x, y + 10, z, 0, 1, 0, 50, 0)
    end
end

Eye2=piece"Eye2"
function DeBuff()
    local spGetUnitsInCylinder = Spring.GetUnitsInCylinder
    local spGetUnitPosition = Spring.GetUnitPosition
    local RANGE = 600

    while true do
        x, y, z = spGetUnitPosition(unitID)
        if boolDefBuffActive == true then
            T = spGetUnitsInCylinder(x, z, RANGE)
            if T then T = filterAllUnitsForDeBuff(T) end
            if T then applyDeBuff(T) end
            EmitSfx(1025, Eye2) -- Placeholder Sfx
        end
        Sleep(500)
    end
end

local spGetUnitTeam = Spring.GetUnitTeam
function filterAllUnitsForDeBuff(Table)
    table.remove(Table, unitID)
    if Table then
        RT = {}
        for i = 1, #Table, 1 do
            if spGetUnitTeam(Table[i]) ~= myTeamID then RT[#RT + 1] = Table[i] end
        end
        if #RT > 0 then return RT end
    end
end

boolHitIt = false
function threadStarter()
		delayTillComplete(unitID)   				
        StartThread(costlyWhileOnTheMove)
		Sleep(GROWUPTIME)

        StartThread(DeBuff)

end

TableOfPieceGroups={}
zRotationMain=math.random(0,50)
function buildUnit()

	for i=1, #TableOfPieceGroups["rRock"] do
		indexPiece = TableOfPieceGroups["rRock"][i]
		if maRa() then Show(indexPiece) end
		turnPieceRandDir(indexPiece,0, 360,-360,360,-360,360,-360)
	end

end
function testDrawBlood()
	while true do
		x,z= math.random(-100,100)/100,math.random(-100,100)/100
		drawBlood(x,z)
		Sleep(1000)
	end
end
function script.Create()
	Spring.SetUnitBlocking(unitID,false)
	resetAll(unitID)
	setSpeedEnv(unitID,1.0)
	TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	StartThread(testDrawBlood)
	hideT( TableOfPieceGroups["Egg"])
	LegTable= TableOfPieceGroups["Leg"]
	LLegTable= TableOfPieceGroups["LLeg"]
	hideT(TableOfPieceGroups["Blood"])
	hideT(TableOfPieceGroups["rRock"])
	hideT(TableOfPieceGroups["Egg"])
	buildUnit()
    if not GG.SunGodCattleTable then GG.SunGodCattleTable = {} end
    if not GG.SunGodCattleTable[myTeamID] then GG.SunGodCattleTable[myTeamID] = 0 end
    GG.SunGodCattleTable[myTeamID] = GG.SunGodCattleTable[myTeamID] + 1
    StartThread(threadStarter)
end

function script.AimFromWeapon1()
    return EggCannon
end

function script.QueryWeapon1()
    return EggCannon
end

function spreadLegs(counterPitch,speed)
	Turn(TableOfPieceGroups["Leg"][1],z_axis,counterPitch+math.rad(60),speed)
	Turn(TableOfPieceGroups["LLeg"][1],z_axis,math.rad(-60),speed)	
	Turn(TableOfPieceGroups["Leg"][3],z_axis,counterPitch+math.rad(60),speed)
	Turn(TableOfPieceGroups["LLeg"][3],z_axis,math.rad(-60),speed)	
	Turn(TableOfPieceGroups["Leg"][3],z_axis,counterPitch+math.rad(60),speed)
	Turn(TableOfPieceGroups["LLeg"][4],z_axis,math.rad(-60),speed)
	
	Turn(TableOfPieceGroups["Leg"][2],z_axis,-counterPitch+  math.rad(-60),speed)
	Turn(TableOfPieceGroups["LLeg"][2],z_axis,  math.rad(60),speed)	
	Turn(TableOfPieceGroups["Leg"][5],z_axis,-counterPitch+  math.rad(-60),speed)
	Turn(TableOfPieceGroups["LLeg"][5],z_axis,  math.rad(60),speed)	
	Turn(TableOfPieceGroups["Leg"][6],z_axis,-counterPitch+  math.rad(-60),speed)
	Turn(TableOfPieceGroups["LLeg"][6],z_axis,  math.rad(60),speed)	
	WaitForTurns(TableOfPieceGroups["LLeg"],TableOfPieceGroups["Leg"])
end


chargeUpTime= 3500
function ReloadEggGun()
	if boolReloading== true or boolReloaded== true then return end	
	boolReloading=true
	while boolUpright==false or not TableOfPieceGroups do
		Sleep(100)
	end
	hideT(TableOfPieceGroups["Egg"])
	Spin(EggRotator,x_axis,math.rad(720),0.015)
	
	for i=1,#TableOfPieceGroups["Egg"]-1, 1 do		
		if TableOfPieceGroups["Egg"][i-1] then Hide(TableOfPieceGroups["Egg"][i-1] ) end
		if TableOfPieceGroups["Egg"][i] then Show(TableOfPieceGroups["Egg"][i] ) end
		rest= math.ceil(chargeUpTime/#TableOfPieceGroups["Egg"])
		Sleep(rest)
	end
	spawnCegAtPiece(unitID, EggCannon, "helioloadaurora", 0)	
	boolReloaded=true
	boolReloading=false
end


storedHeading =0
storedPitch   =0
boolUpright= true
boolReloading=false
boolReloaded=false
function script.AimWeapon1(heading, pitch)
	Signal(SIG_LAY)
	storedHeading =heading
	storedPitch   =pitch

	if boolReloaded == false  then	
			return false
	end

	

	if boolUpright== true and boolReloaded == true and eggCounter > 0 then
		Turn(Main,z_axis,math.rad(0),12)
		Turn(center,y_axis, heading+math.rad(-90), 12)		
		WaitForTurns(Main,center)
		spreadLegs( storedPitch, 5)
		return true
	end	
	
	return false  
end

function script.FireWeapon1()
	eggCounter=eggCounter -1
	spawnCegAtPiece(unitID, EggCannon, "helioloadaurora", 0)
	hideT( TableOfPieceGroups["Egg"])
	StartThread(ReloadEggGun)
	Turn(Main,y_axis,math.rad(zRotationMain),0.7)
	Turn(center,y_axis,math.rad(0),0.7)
return true
end