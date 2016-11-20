center=piece"center"
DroneBody=piece"DroneBody"
engine1=piece"engine1"
engine2=piece"engine2"
engine3=piece"engine3"







--unitPieces
SIG_EXAUST=1
SIG_COUNT=2
SIG_IDLE=4
SIG_MOVE=8
SIG_REPORT=16

local driveemit1 =piece"ex1"
local driveemit2 =piece"ex2"
local driveemit3 =piece"ex3"






function script.Activate()
	--activates the secondary weapon 
	
	
	
	return 1
end

function script.Deactivate()
	--deactivates the secondary weapon 
	
	
	return 0
end






function exaust()
	SetSignalMask(SIG_EXAUST)
	while(true) do
		EmitSfx(driveemit1,1024)
		EmitSfx(driveemit2,1024)
		EmitSfx(driveemit3,1024)
		Sleep(50)
	end 
end



function goTeamCNN()
	while true do
		
		x,y,z=getTarget()
		if x then
			Spring.GiveOrderToUnit(unitID, CMD.PATROL , {x, k, z }, {"shift"})
		end
		Sleep(60000)
		
	end
	
end

function move()
	
	SetSignalMask(SIG_MOVE)
	while(true) do
		Turn(DroneBody,x_axis,math.rad(38),35)
		Turn(engine2,x_axis,math.rad(13),25)
		Turn(engine3,x_axis,math.rad(30),25)
		Turn(engine1,x_axis,math.rad(19),25)
		Turn(engine1,z_axis,math.rad(12),25)
		Move(center,y_axis,-15,0.9)
		Sleep(250)
		
		
		Sleep(25000)
		Move(center,y_axis,0,12)
		resetT(piecesTable)
		Sleep(5000)
		
	end
end

boolTargetFlip=true
function getTarget()
	id=null
	if boolTargetFlip==true then
		boolTargetFlip=false
		id=Spring.GetUnitNearestAlly(unitID)
		if id then
			tx,ty,tz=Spring.GetUnitPosition(id)
			ix,iy,iz=Spring.GetUnitPosition(unitID)
			dist=math.sqrt((tx-ix)^2+(tz-iz)^2)
			
		end
		
	else
		boolTargetFlip=false 
		id=Spring.GetUnitNearestEnemy(unitID)
		if id then
			tx,ty,tz=Spring.GetUnitPosition(id)
			ix,iy,iz=Spring.GetUnitPosition(unitID)
			dist=math.sqrt((tx-ix)^2+(tz-iz)^2)
			
		end
	end
	if id then
		return Spring.GetUnitPosition(id) 
	end
	
end




boolReporting=false
function idle()
	Move(center,y_axis,0,12)
	resetT(piecesTable)
	Sleep(250)
	boolOnlyOnce=true
	boolReporting=true
	SetSignalMask(SIG_IDLE)
	while true do
		val=math.random(-8,8)
		Mul=math.random(1,4)
		Turn(engine1,x_axis,math.rad(val),math.abs(val)/10)
		Turn(engine2,x_axis,math.rad(val),math.abs(val)/10)
		Turn(engine3,x_axis,math.rad(val),math.abs(val)/10)
		Turn(DroneBody,x_axis,math.rad(val*-1),math.abs(val)/10)
		Move(center,z_axis, val*Mul*-1, 1)
		
		val=math.random(-8,8)
		Mul=math.random(1,4)
		Turn(engine1,z_axis,math.rad(val),math.abs(val)/10)
		Turn(engine2,z_axis,math.rad(val),math.abs(val)/10)
		Turn(engine3,z_axis,math.rad(val),math.abs(val)/10)
		Turn(DroneBody,z_axis,math.rad(val*-1),math.abs(val)/10)
		Move(center,x_axis, val*Mul*-1, 1)
		
		WaitForMove(center,x_axis)
		WaitForMove(center,z_axis)
	end
	
end
boolOnlyOnce=true

function script.StartMoving()
	
	Signal(SIG_IDLE)
	StartThread(move)
	
end


function reportBla()
	while true do
		Sleep(89000)
		d=math.ceil(math.random(1,29))
		string1="sounds/Missions/Mission3/news"
		string2=".ogg"
		final=string1..d..string2
		Spring.PlaySoundFile(final,0.9)
		
		
		
		Sleep(15000)
	end
end


function script.StopMoving()
	Signal(SIG_REPORT)
	Signal(SIG_MOVE)
	Signal(SIG_IDLE)
	StartThread(idle)
	
	
end




piecesTable={}
function script.Create()
	piecesTable =generatepiecesTableAndArrayCode(unitID, false)
	Spring.SetUnitNoSelect(unitID,true)
	Spring.SetUnitAlwaysVisible(unitID,true)
	StartThread(exaust)
	StartThread(reportBla)
	--StartThread(goTeamCNN)
end

function script.Killed()
	
	return 1
end