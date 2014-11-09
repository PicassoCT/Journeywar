--Define the wheel pieces

--Define the pieces of the weapon

--define other pieces
local vort = piece "vort"
local vortarml = piece "vortarml"
local vDisChar1 = piece "vDisChar1"
local vortarmr = piece "vortarmr"

local vorthead = piece "vorthead02"
local vortlegupl = piece "vortlegupl"
local vortlfootl = piece "vortlfootl"
local vortlegupr = piece "vortlegupr"
local vortlfootr = piece "vortlfootr"
local boolFlipFlop=1
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_IDLE=4

local boolHasFired=false
function script.Create()
 Hide(vDisChar1)

  
end

function idle ()
SetSignalMask(SIG_IDLE)
Sleep(500)
boolMove=false
moduLater=1
while(true) do
moduLater=moduLater+1
if moduLater%4==0 then
sleepRAnd=math.random(5000,22000)
Sleep(sleepRAnd)
moduLater=math.random(-1,3)
else
Sleep(500)
end
xRand=math.random(-67,6)
zRand=math.random(7,43)
zRandR=math.random(-43,7)
yRand=math.random(0,12)
randSpeed=math.random(2,5)
Turn(vortarmr,x_axis,math.rad(xRand),randSpeed)
Turn(vortarmr,z_axis,math.rad(zRandR),randSpeed)
Turn(vortarmr,y_axis,math.rad(yRand),randSpeed)
xRand=math.random(-67,6)
zRand=math.random(7,43)
yRand=math.random(5,22)
randSpeed=math.random(2,5)
Turn(vortarml,x_axis,math.rad(xRand),randSpeed)
Turn(vortarml,z_axis,math.rad(zRand),randSpeed)
Turn(vortarml,y_axis,math.rad(yRand),randSpeed)
Sleep(450)
headTurnX=math.random(-5,34)
Turn(vorthead,x_axis,math.rad(headTurnX),1.5)
headTurnZ=math.random(-5,5)
Turn(vorthead,z_axis,math.rad(headTurnZ),1.5)
headTurnY=math.random(-12,12)
Turn(vorthead,y_axis,math.rad(headTurnY),1.5)
Sleep(150)
y=math.random(0,18)
	if y == 9 then
		Spring.PlaySoundFile("sounds/vort/vortIdle2.wav")
	end

			if y== 15 then
				Spring.PlaySoundFile("sounds/vort/vortIdle.wav")
			end
			throwDice=math.random(0,150)
			if throwDice== 45 then
		   local x,y,z=Spring.GetUnitPosition (unitID)
		   local teamID = Spring.GetUnitTeam (unitID)
		   Spring.CreateUnit("gFirePlace", x+15, y, z+15, 0, teamID)  
			end

xRand=math.random(-67,6)
zRand=math.random(7,43)
zRandR=math.random(-43,7)
yRand=math.random(0,12)
randSpeed=math.random(2,5)
Turn(vortarmr,x_axis,math.rad(xRand),randSpeed)
Turn(vortarmr,z_axis,math.rad(zRandR),randSpeed)
Turn(vortarmr,y_axis,math.rad(yRand),randSpeed)
xRand=math.random(-67,6)
zRand=math.random(7,43)
yRand=math.random(5,22)
randSpeed=math.random(2,5)
Turn(vortarml,x_axis,math.rad(xRand),randSpeed)
Turn(vortarml,z_axis,math.rad(zRand),randSpeed)
Turn(vortarml,y_axis,math.rad(yRand),randSpeed)
Sleep(600)
	
end
end

local function walk()
    Signal(SIG_IDLE)


	SetSignalMask(SIG_WALK)
	
	leg_movespeed=6
	while (true) do
	   Turn(vort,x_axis,math.rad(10),4)
	   Turn(vorthead,x_axis,math.rad(16),2)
	   Turn(vort,y_axis,math.rad(7),4)
	   Turn(vortarmr,x_axis,math.rad(-19),6)
	   Turn(vortarml,x_axis,math.rad(32),10)
	   --links vor
		Turn(vortlegupl,x_axis,math.rad(-38),10)
	    Turn(vortlfootl,x_axis,math.rad(32),13)
		--rechts hinten
		Turn(vortlegupr,x_axis,math.rad(34),10)
	    Turn(vortlfootr,x_axis,math.rad(12),13)
		WaitForTurn(vortlegupl,x_axis)
		WaitForTurn(vortlegupr,x_axis)
		
		Sleep (30)
		
		Turn(vort,x_axis,math.rad(-5),3)
		Turn(vorthead,x_axis,math.rad(-8),3)
		Turn(vort,y_axis,math.rad(-7),4)
		Turn(vortarml,x_axis,math.rad(-19),6)
		Turn(vortarmr,x_axis,math.rad(32),10)
		--rechts vor
		Turn(vortlegupr,x_axis,math.rad(-38),10)
	    Turn(vortlfootr,x_axis,math.rad(32),13)
		--links hinten
		Turn(vortlegupl,x_axis,math.rad(34),10)
	    Turn(vortlfootl,x_axis,math.rad(12),13)
		WaitForTurn(vortlegupl,x_axis)
		WaitForTurn(vortlegupr,x_axis)
	end
end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return vDisChar1 
end

function script.QueryWeapon1() 
	

	return vDisChar1
	end
	



function script.AimWeapon1( heading ,pitch)	
	Turn(vorthead,x_axis,pitch,5)
	Turn(vort,y_axis,heading,12)
	WaitForTurn(vort,y_axis)
	for i=1,2,1 do
	random=math.random(1,5)
	if random==1 then
	Spring.PlaySoundFile("sounds/vort/zap1.wav")
	elseif random==2 then
	Spring.PlaySoundFile("sounds/vort/zap2.wav")
	elseif random==3 then
	Spring.PlaySoundFile("sounds/vort/zap3.wav")
	elseif random==4 then
	Spring.PlaySoundFile("sounds/vort/zap4.wav")
	elseif random==5 then
	Spring.PlaySoundFile("sounds/vort/zap5.wav")
	elseif random==6 then
	Spring.PlaySoundFile("sounds/vort/zap6.wav")
	else
	Spring.PlaySoundFile("sounds/vort/zap7.wav")
	end
	Sleep(150)
	end
	Turn(vortarmr,x_axis,math.rad(-12),3)
	Turn(vortarmr,y_axis,math.rad(-101),23)
	Turn(vortarmr,z_axis,math.rad(75),19)
	
	Turn(vortarml,x_axis,math.rad(-38),3)
	Turn(vortarml,y_axis,math.rad(63),21)
	Turn(vortarml,z_axis,math.rad(-53),14)
	WaitForTurn(vortarmr,x_axis)
	WaitForTurn(vortarmr,y_axis)
	WaitForTurn(vortarmr,z_axis)
	WaitForTurn(vortarml,x_axis)
	WaitForTurn(vortarml,y_axis)
	WaitForTurn(vortarml,z_axis)
	Sleep(230)

	return true
end


function script.FireWeapon1()	
boolHasFired=true
	return true
end

function script.Killed(recentDamage, maxHealth)
--legs_down()

end


local function legs_down()
	Signal(SIG_WALK)
	Turn(vortarmr,x_axis,math.rad(0),3)
	Turn(vortarmr,y_axis,math.rad(0),23)
	Turn(vortarmr,z_axis,math.rad(0),19)
	
	Turn(vortarml,x_axis,math.rad(0),3)
	Turn(vortarml,y_axis,math.rad(0),21)
	Turn(vortarml,z_axis,math.rad(0),14)
	
	Turn(vortlegupl,x_axis,math.rad(0),3)
	Turn(vortlegupl,y_axis,math.rad(0),23)
	Turn(vortlegupl,z_axis,math.rad(0),19)
	
	Turn(vortlfootl,z_axis,math.rad(0),19)
	Turn(vortlfootl,x_axis,math.rad(0),3)
	Turn(vortlfootl,y_axis,math.rad(0),23)
	
	Turn(vortlegupr,x_axis,math.rad(0),3)
	Turn(vortlegupr,y_axis,math.rad(0),21)
	Turn(vortlegupr,z_axis,math.rad(0),14)
	
	Turn(vortlfootr,z_axis,math.rad(0),19)
	Turn(vortlfootr,x_axis,math.rad(0),3)
	Turn(vortlfootr,y_axis,math.rad(0),23)
	randSpeed=math.random(2,5)
	Turn(vortarmr,x_axis,math.rad(0),randSpeed)
	Turn(vortarmr,z_axis,math.rad(0),randSpeed)
	Turn(vortarmr,y_axis,math.rad(0),randSpeed)

	Turn(vortarml,x_axis,math.rad(0),randSpeed)
	Turn(vortarml,z_axis,math.rad(0),randSpeed)
	Turn(vortarml,y_axis,math.rad(0),randSpeed)			
Turn(vorthead,x_axis,math.rad(0),1.5)

Turn(vorthead,z_axis,math.rad(0),1.5)

Turn(vorthead,y_axis,math.rad(0),1.5)
end

function script.StartMoving()
boolMove=true
if boolHasFired==true then
	Turn(vort,y_axis,math.rad(0),34)
	Turn(vorthead,x_axis,math.rad(0),5)
	
	Turn(vortarmr,x_axis,math.rad(0),3)
	Turn(vortarmr,y_axis,math.rad(0),23)
	Turn(vortarmr,z_axis,math.rad(0),19)
	
	Turn(vortarml,x_axis,math.rad(0),3)
	Turn(vortarml,y_axis,math.rad(0),21)
	Turn(vortarml,z_axis,math.rad(0),14)
	boolHasFired=false
end
	

	Signal(SIG_IDLE)
    Signal(SIG_WALK)
	StartThread (walk)
end

local boolMove=false
function script.StopMoving()
		

		Signal(SIG_IDLE)
		Signal(SIG_WALK)
		legs_down()
		StartThread(idle)
		
		
end
TELEPORTRANGE=200

function TelePortation()
x,y,z=Spring.GetUnitPosition(unitID)
cmds=Spring.GetCommandQueue(unitID,4)
	for i=1,#cmds do
		if cmds[i].id and cmds[i].id == CMD.MOVE and cmds[i].params then
		tx,ty,tz=cmds[i].params[1],cmds[i].params[2],cmds[i].params[3]
		tx,ty,tz=tx-x,ty-y,tz-z
		dist=math.sqrt(tx*tx+ty*ty+tz*tz)
			if dist < TELEPORTRANGE then
			EmitSfx(vort,1024)
			for i=1,3 do
			for j=-1,1,1 do
			Spring.SpawnCeg("vortport",tx+(10*(i-5))+j*10,ty+15,tz+(10*(i-10)))
			end
			end
			Spring.SetUnitPosition(unitID,tx,ty,tz)
			return false
			end
		end
	end
return true
end

boolCharged=false
TIMETOCHARGE=42000
Timer=TIMETOCHARGE
function TelePortation()
	while true do
		if Timer > 0 then 
		Timer =Timer- 300
		else
		Timer=TIMETOCHARGE
		boolCharged=true
		end
	
	if boolCharged==true and boolMove==true then
	boolCharged=TelePortation()
	end
	Sleep(300)
	end

end