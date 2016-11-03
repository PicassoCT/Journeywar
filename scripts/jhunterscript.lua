include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 
unitdef= Spring.GetUnitDefID(unitID)

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	if damage > 150 then
		StartThread(PlaySoundByUnitDefID, unitdef, "sounds/jHunter/jHunterScreach.ogg", 1, 25000, 1,0)
	end
end
center=piece"center"
aimpiece=piece"aimspot"
jHead=piece"jHead"
cHead=piece"cHead"
Com=piece"Com"

LegTable={}
LegTable[#LegTable+1]=piece"jleg1"--2
Leg2= #LegTable
LegTable[#LegTable+1]=piece"jleg2"
LegTable[#LegTable+1]=piece"jleg3"


LegTable[#LegTable+1]=piece"jleg5"--3
Leg3= #LegTable
LegTable[#LegTable+1]=piece"jleg6"
LegTable[#LegTable+1]=piece"jleg7"


LegTable[#LegTable+1]=piece"jleg9"--1
Leg1= #LegTable
LegTable[#LegTable+1]=piece"jleg10"
LegTable[#LegTable+1]=piece"jleg12"

conversionTable={}
for i=1,12 do
	cPiece= "cLeg"..i
	jPiece= "jleg"..i
	
	conversionTable[i]= {}
	conversionTable[i].cPiece=piece(cPiece)
	conversionTable[i].jPiece=piece(jPiece)
	
	
end

myDefID = Spring.GetUnitDefID(unitID)
function letsWalkAndTalk()
	
	
	while(true) do
			randSleep=math.ceil(math.random(25000,500000))
			Sleep(randSleep)
		while walkState == "stop" do
			randSleep=math.ceil(math.random(10000,25000))
			Sleep(randSleep)
		burst=math.ceil(math.random(1,3))
		for i=1,burst,1 do
			StringOfStrings="sounds/csupsold/talk"
			appendMe=math.floor(math.random(1,9))
			EndOfStrings=".wav"
			result=StringOfStrings..appendMe
			result=result..EndOfStrings
			PlaySoundByUnitDefID(myDefID,result,0.5, 2000, 1,0)

			Sleep(4200)
		end
		
		end
	end
end

function hideByUnitType()
	hideT(TablesOfPiecesGroups["cLeg"])
	Hide(cHead)
	Hide(Com)
	showT(TablesOfPiecesGroups["jleg"])
	Show(jHead)
	
	if Spring.GetUnitDefID(unitID) == UnitDefNames["chunter"].id then
		_, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
		while not buildProgress do
			Sleep(10)
		end
		
		while buildProgress and buildProgress < 1 do
			upperBound= buildProgress*12
			for i=1,upperBound do
				Hide(conversionTable[i].jPiece)
				Show(conversionTable[i].cPiece)
			end
			Sleep(50)
			_, _, _, _, buildProgress = Spring.GetUnitHealth(unitID)
		end
		
		for i=1,12 do
			Hide(conversionTable[i].jPiece)
			Show(conversionTable[i].cPiece)
		end
		Hide(jHead)
		Show(cHead)
		Show(Com)
		
	end
	
end
SIG_AIM= 2

function aimPos(speed)
	SetSignalMask(SIG_AIM)
	tP(LegTable[Leg2], 20, 0, -35, speed)
	tP(LegTable[Leg2+1], 32, -36, 76, speed)
	tP(LegTable[Leg2+2], 0, 0, 0, speed)
	
	tP(LegTable[Leg3], 31, 0, 44, speed)
	tP(LegTable[Leg3+1], 0, 27, -76, speed)
	tP(LegTable[Leg3+2], 0, 0, 0, speed)
	
	tP(LegTable[Leg1], -31, 0, 0, speed)
	tP(LegTable[Leg1+1], 56, 0, 0, speed)
	tP(LegTable[Leg1+2], 0, 0, 0, speed)
	
end
function script.Create()
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	hideByUnitType()
	StartThread(moveStatemachine)
	StartThread(letsWalkAndTalk)
end

function script.Killed(recentDamage,_)
	
	createCorpseCUnitGeneric(recentDamage)
	return 1
end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end

function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	walkState="stop"
	
	return true
	
end


function script.FireWeapon1()	
	Signal(SIG_AIM)
	StartThread(aimPos,6)
	StartThread(PlaySoundByUnitDefID, unitdef, "sounds/jHunter/jHunterDartGun.ogg", 1, 5000, 1,0)
	return true
end

walkState="stop"
boolAiming=false

function script.StartMoving()
	--idleEnd=true
	walkState="walking"
	Signal(SIG_IDLE)
end

function script.StopMoving()
	walkState="stop"
	--StartThread(idle)	
	
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end




function forward(number, speed)
	TaskTable[number].FinnishedExecution = false
	
	Turn(LegTable[number+1],x_axis,math.rad(22),speed)
	WaitForTurns(LegTable[number+1])
	Turn(LegTable[number],x_axis,math.rad(-39),speed)
	Turn(LegTable[number],z_axis,math.rad(0),speed)
	Turn(LegTable[number],y_axis,math.rad(0),speed)
	WaitForTurns(LegTable[number])
	WaitForTurns(LegTable[number+1])
	Turn(LegTable[number],x_axis,math.rad(-29),speed)
	Turn(LegTable[number+1],x_axis,math.rad(29),speed)
	
	WaitForTurns(LegTable[number],LegTable[number+1])
	TaskTable[number].FinnishedExecution = true
end

--angleY 65
function stabilize(number, speed)
	TaskTable[number].FinnishedExecution = false
	signumYAxis =1 
	if number == Leg3 then signumYAxis = -1 end
	angleY = math.random(50,90)
	
	Turn(LegTable[number],x_axis,math.rad(25),speed)
	Turn(LegTable[number+1],x_axis,math.rad(-25),speed)
	Turn(LegTable[number],y_axis,math.rad(-1*angleY*signumYAxis*-1),speed)
	
	WaitForTurns(LegTable[number],LegTable[number+1])
	TaskTable[number].FinnishedExecution = true
end

--angleY 65
function stabilizeArc(number, speed)
	TaskTable[number].FinnishedExecution = false
	angleYBegin =-42
	angleYEnd =32
	
	Turn(LegTable[number],x_axis,math.rad(25),speed)
	Turn(LegTable[number+1],x_axis,math.rad(-25),speed)
	Turn(LegTable[number],y_axis,math.rad(angleYBegin),speed)
	WaitForTurns(LegTable[number])
	WaitForTurns(LegTable[number+1])
	Turn(LegTable[number],y_axis,math.rad(angleYEnd),speed)
	WaitForTurns(LegTable[number])
	WaitForTurns(LegTable[number],LegTable[number+1])
	TaskTable[number].FinnishedExecution = true
end

function push(number, speed)
	TaskTable[number].FinnishedExecution = false
	
	Turn(LegTable[number],z_axis,math.rad(0),speed)
	Turn(LegTable[number],y_axis,math.rad(0),speed)
	Turn(LegTable[number],x_axis,math.rad(32),speed)
	Turn(LegTable[number+1],x_axis,math.rad(-32),speed)
	
	WaitForTurns(LegTable[number],LegTable[number+1])
	TaskTable[number].FinnishedExecution = true
end
--------------------------------------------------------------------------------------
SIG_IDLE = 2

function breath()
	SetSignalMask(SIG_IDLE)
	randVal=cbrandoVal(1,22)
	
	for i=1, randVal do
		Move(jHead,y_axis,-7,0.4)
		Turn(LegTable[Leg2],z_axis,math.rad(48),0.075,true)
		Turn(LegTable[Leg2+1],z_axis,math.rad(-72),0.1,true)
		Turn(LegTable[Leg2+2],z_axis,math.rad(33),0.05,true)
		
		Turn(LegTable[Leg3],z_axis,math.rad(-48),0.075,true)
		Turn(LegTable[Leg3+1],z_axis,math.rad(72),0.1,true)
		Turn(LegTable[Leg3+2],z_axis,math.rad(-33),0.05,true)
		
		Turn(LegTable[Leg1],x_axis,math.rad(48),0.075,true)
		Turn(LegTable[Leg1+1],x_axis,math.rad(-72),0.1,true)
		Turn(LegTable[Leg1+2],x_axis,math.rad(33),0.05,true)
		Sleep(100)
		WaitForTurns(LegTable)
		WaitForMove(jHead,y_axis)
		
		Move(jHead,y_axis,0,0.7)
		Turn(LegTable[Leg2],z_axis,math.rad(0),0.1,true)
		Turn(LegTable[Leg2+1],z_axis,math.rad(0),0.15,true)
		Turn(LegTable[Leg2+2],z_axis,math.rad(0),0.1,true)
		
		Turn(LegTable[Leg3],z_axis,math.rad(0),0.1,true)
		Turn(LegTable[Leg3+1],z_axis,math.rad(0),0.15,true)
		Turn(LegTable[Leg3+2],z_axis,math.rad(0),0.1,true)
		
		Turn(LegTable[Leg1],x_axis,math.rad(0),0.1,true)
		Turn(LegTable[Leg1+1],x_axis,math.rad(0),0.15,true)
		Turn(LegTable[Leg1+2],x_axis,math.rad(0),0.1,true)
		WaitForTurns(LegTable)
		WaitForMove(jHead,y_axis)
	end
	resetT(LegTable)
	WaitForTurns(LegTable)
end

function idle()
	
	Sleep(3000)
	while walkState == "stop" do
		
		Signal(SIG_IDLE)
		StartThread(breath)
		restTime=cbrandoVal(12000,24000)
		intervall=math.ceil(restTime/12)
		for i=1,12, 1 do
			Sleep(intervall)
			if walkState ~= "stop" then
				Signal(SIG_IDLE)
				break
			end
		end
	end
	Signal(SIG_IDLE)
	legs_down(false)
	
end

TaskTable={}
PUSH =1
FORWARD =2
STABILIZE = 3

function walking()
	
	if TaskTable[Leg1].FinnishedExecution== true then
		TaskTable[Leg1].CurrentFunctionIndex = (TaskTable[Leg1].CurrentFunctionIndex%3) +1
		StartThread(TaskTable[Leg1].functions[TaskTable[Leg1].CurrentFunctionIndex], Leg1, 3.141)
	end
	
	if TaskTable[Leg2].FinnishedExecution== true then
		TaskTable[Leg2].CurrentFunctionIndex = (TaskTable[Leg2].CurrentFunctionIndex%3) +1
		StartThread(TaskTable[Leg2].functions[TaskTable[Leg2].CurrentFunctionIndex], Leg2, 3.141)
	end
	
	if TaskTable[Leg3].FinnishedExecution== true then
		TaskTable[Leg3].CurrentFunctionIndex = (TaskTable[Leg3].CurrentFunctionIndex%3) +1
		StartThread(TaskTable[Leg3].functions[TaskTable[Leg3].CurrentFunctionIndex], Leg3, 3.141)
	end
end

function turning(turnState)
	normalLeg, inversedLeg = Leg3, Leg2
	if turnState == "turnRight" then
		normalLeg, inversedLeg = Leg2, Leg3
	end
	
	if TaskTable[inversedLeg].FinnishedExecution== true then
		if TaskTable[inversedLeg].CurrentFunctionIndex == 0 then TaskTable[inversedLeg].CurrentFunctionIndex = PUSH end
		
		if TaskTable[inversedLeg].CurrentFunctionIndex == PUSH then
			TaskTable[inversedLeg].CurrentFunctionIndex = STABILIZE
			
		elseif TaskTable[inversedLeg].CurrentFunctionIndex == STABILIZE then
			TaskTable[inversedLeg].CurrentFunctionIndex = FORWARD
			
		elseif TaskTable[inversedLeg].CurrentFunctionIndex == FORWARD then
			TaskTable[inversedLeg].CurrentFunctionIndex = PUSH
		end
		
		
		
		StartThread(TaskTable[inversedLeg].functions[TaskTable[inversedLeg].CurrentFunctionIndex], inversedLeg, 3.141)
	end
	
	if TaskTable[normalLeg].FinnishedExecution== true then
		TaskTable[normalLeg].CurrentFunctionIndex = (TaskTable[normalLeg].CurrentFunctionIndex%3) +1
		StartThread(TaskTable[normalLeg].functions[TaskTable[normalLeg].CurrentFunctionIndex], normalLeg, 3.141)
	end
	
	if TaskTable[Leg3].FinnishedExecution== true then
		TaskTable[Leg3].CurrentFunctionIndex = (TaskTable[Leg3].CurrentFunctionIndex%3) +1
		StartThread(TaskTable[Leg3].functions[TaskTable[Leg3].CurrentFunctionIndex], Leg3, 3.141)
	end
	
end



counter= 0
function moveStatemachine()
	StartThread(TurnDetect)
	Move(center,y_axis,0,16)
	while true do
		
		
		--Analytical IK
		if walkState ~= "stop" then
			resetT(LegTable,3)
			WaitForTurns(LegTable)
			
			TaskTable[Leg1]={
				CurrentFunctionIndex= 0 ,
				FinnishedExecution=true,
				functions={
					[1]= push,
					[2]= forward,
					[3]= stabilizeArc
				}
			}
			
			TaskTable[Leg2]={
				CurrentFunctionIndex= 2,
				FinnishedExecution=true,
				functions={
					[1]= push,
					[2]= forward,
					[3]= stabilize
				}
			}
			
			TaskTable[Leg3]={
				CurrentFunctionIndex=1 ,
				FinnishedExecution=true,
				functions={
					[1]= push,
					[2]= forward,
					[3]= stabilize
				}
			}
			
			if walkState == "walking" then StartThread(PlaySoundByUnitDefID, unitdef, "sounds/jHunter/jHunterWalk.ogg", 1, 5000, 1,0) end
			while (walkState == "walking") do
				walking()		
				Sleep(10)
			end
			
			while (walkState == "turnLeft" or walkState == "turnRight") do
				--Push > Stabilize > Forward
				turning(walkState)	
				Sleep(10)
			end
		end
		
		resetT(LegTable,3)
		WaitForTurns(LegTable)
		while (walkState == "stop") do
			idle()
			Sleep(10)
		end
		
		Sleep(50)
	end
end

function TurnDetect()
	local spGetUnitHeading=Spring.GetUnitHeading
	oldHeading=spGetUnitHeading(unitID)
	Sleep(500)
	newHeading=oldHeading
	
	while true do	
		newHeading=spGetUnitHeading(unitID)
		
		if math.abs(newHeading-oldHeading)> 10000 then
			if newHeading-oldHeading < 0 then walkState="turnLeft" else walkState="turnRight" end
		elseif walkState ~= "stop" and walkState ~= "aiming" then
			walkState="walking"
		end
		
		Sleep(500)
		oldHeading=newHeading
	end
end


function legs_down ( WaitForIt)
	resetT(TablesOfPiecesGroups["jleg"], 7)
	Move(jHead,y_axis,0, 7)
	if WaitForIt and WaitForIt == true then
		Sleep(150)
		WaitForTurns(TablesOfPiecesGroups["jleg"])
	end
end