include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
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


function hideByUnitType()

	if Spring.GetUnitDefID(unitID) == UnitDefNames["jhunter"].id then
		hideT(TablesOfPiecesGroups["cLeg"])
		Hide(cHead)
		Hide(Com)
		showT(TablesOfPiecesGroups["jleg"])
		Show(jHead)

	else
		hideT(TablesOfPiecesGroups["jleg"])
		Hide(jHead)
		showT(TablesOfPiecesGroups["cLeg"])
		Show(cHead)
		Show(Com)
	end

end

function script.Create()
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	hideByUnitType()
	StartThread(walk)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
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

	return true

end
 

function script.FireWeapon1()	

	return true
end

boolWalking=false
boolAiming=false

function script.StartMoving()
	--idleEnd=true
	boolWalking=true
end

function script.StopMoving()
	boolWalking=false
	legs_down (false)
	boolAiming=false
	
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
	if number == Leg3 then  signumYAxis = -1 end
	angleY = math.random(110,160)

	Turn(LegTable[number],x_axis,math.rad(25),speed)
	Turn(LegTable[number+1],x_axis,math.rad(-25),speed)
	Turn(LegTable[number],y_axis,math.rad(-1*angleY*signumYAxis),speed)

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

	TaskTable={}
					
counter= 0
function walk()
	Move(center,y_axis,0,16)
	while true do
	
	--Analytical IK
	if boolWalking==true and boolAiming == false then
	resetT(LegTable,3)
	WaitForTurns(LegTable)


	TaskTable[Leg1]={
		CurrentFunctionIndex= 0 ,
		FinnishedExecution=true,
			functions={
			[1]=push,
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

		while (boolWalking==true and boolAiming == false)do

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
			
		Sleep(10)
		end
		
	resetT(LegTable,3)
	WaitForTurns(LegTable)
	end
	Sleep(250)
	end
end


function resPos(piece,center,speed,number,SIG)
if not feetSignals[number] then feetSignals[number]= false end
	feetSignals[number]=false
	Turn(center,x_axis,0,speed or 0)
	Turn(center,y_axis,0,speed or 0)
	Turn(center,z_axis,0,speed or 0)
	Move(piece,x_axis,0,speed or 0,true)
	Move(piece,y_axis,0,speed or 0,true)
	Move(piece,z_axis,0,speed or 0,true)
	Signal(SIG)
end

function legs_down ( WaitForIt)
	resetT(TablesOfPiecesGroups["jleg"], 7)
	
	if WaitForIt and WaitForIt == true then
		Sleep(150)
		WaitForTurns(TablesOfPiecesGroups["jleg"])
	end
end
