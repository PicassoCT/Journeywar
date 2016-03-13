include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
SIG_FOLD=2
SIG_MOVE=4
SIG_RESET=8
SIG_UNFOLD=16
SIG_BREATH=32
SIG_UPGRADE=64

GroundRotor=piece"GroundRotor"
VegWheel=piece"VegWheel"
LightWheel=piece"LightWheel"
FullBloom=piece"FullBloom"
greenWheelEnd=piece"greenWheelEnd"
flare=piece"flare"

LightRots={}
for i=1,5 do
name="LightRot"..i
LightRots[i]=piece(name)
end

Lights={}
for i=1,5 do
name="Light"..i
Lights[i]=piece(name)
end

Roots={}
for i=1,5 do
name="RootW"..i
Roots[i]=piece(name)
end

GreenRot={}
for i=1,7 do
name="GreenRot"..i
GreenRot[i]=piece(name)
end

GreenLeaves={}
for i=1,6 do
name="Green"..i
GreenLeaves[i]=piece(name)
end

feetFetish={}
for i=1, 6, 1 do
feetFetish[i]={}
feetFetish[i][1]={}-- the Upper joint
feetFetish[i][2]={} -- upper leg
feetFetish[i][3]={} --lower joint
feetFetish[i][4]={} --lower leg
feetFetish[i][5]={} --dirt emitter

temp1= "UpJoin0"..i
temp2= "UpLeg0"..i
temp3= "LoJoin0"..i
temp4= "LoLeg0"..i
temp5= "DirEmit"..i

feetFetish[i][1]=piece(temp1)-- the Upper joint
feetFetish[i][2]=piece(temp2) -- upper leg
feetFetish[i][3]=piece(temp3) --lower joint
feetFetish[i][4]=piece(temp4) --lower leg
feetFetish[i][5]=piece(temp5) --dir emitter
end

function script.Create()
Hide(flare)

StartThread(PlantLoop)
StartThread(launchBuildingThread)
end



function script.Killed(recentDamage,_)
suddenDeathjBuildCorpse(unitID, recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

rotDistance=-14

function PlantLoop()

Spin(GroundRotor,z_axis,math.rad(-6),0.1)


	for i=1,#Roots,1 do
	Spin(Roots[i],x_axis,math.rad(math.random(-20,20)),0.1)
	Spin(Roots[i],z_axis,math.rad(math.random(-250,250)),0.1)
	end	

	for i=1,#Lights,1 do
	Spin(Lights[i],x_axis,math.rad(-12*((-1)^i)),0.1)
	if LightRots[i] then	Turn(LightRots[i],z_axis,math.rad(((i-1)* (rotDistance/1.25))-rotDistance),0) end	
	end	
	
	for i=1,#GreenRot, 1 do
	if i~=7 then
	Turn(GreenRot[i],z_axis,math.rad((i-1)*rotDistance),0,true)
	else
	Turn(GreenRot[i],z_axis,math.rad((i-2)*rotDistance),0,true)
	end
	if GreenLeaves[i] then
	Spin(GreenLeaves[i],x_axis,math.rad(26),0.1) end
	end
	Spin(VegWheel,z_axis,math.rad(22),0)
	Spin(LightWheel,z_axis,math.rad(22),0)
	while true do


	Move(FullBloom,y_axis,10,1.22)
	WaitForMove(FullBloom,y_axis)
	Move(FullBloom,y_axis,0,1.22)
	WaitForMove(FullBloom,y_axis)
	end
end


function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
end

 
function liftFeet(nr)
signed=1
	if nr== 3 or nr ==6 or nr==1 then
	signed=-1
	end
Turn(feetFetish[nr][1],z_axis,math.rad(19*signed),1.7)
Turn(feetFetish[nr][3],z_axis,math.rad(9*signed),1.7)

end

function TurnF(nr,deg,boolWait)
Turn(feetFetish[nr][1],y_axis,math.rad(deg),2)
if boolWait== nil or boolWait==true then
WaitForTurn(feetFetish[nr][1],y_axis)
end

end

function lowerFeet(nr,boolWait)
Turn(feetFetish[nr][1],z_axis,math.rad(0),1.7)
Turn(feetFetish[nr][3],z_axis,math.rad(0),1.7)
	if boolWait== nil or boolWait==true then
	WaitForTurn(feetFetish[nr][1],x_axis)
	WaitForTurn(feetFetish[nr][3],x_axis)
	end

EmitSfx(feetFetish[nr][5],1024)

end

function moveIt()
SetSignalMask(SIG_MOVE)
comonSpeed=0.2
	while(true) do

	lowerFeet(1,false)

	liftFeet(3)
	liftFeet(5)
	lowerFeet(2,true)
	Turn(center,y_axis,math.rad(2),0.1)
--	Turn(roof,x_axis,math.rad(0.5),0.025)
	comonValue=comonValue-5

	TurnF(3,40,false)
	TurnF(5,-30,true)
	lowerFeet(3,false)
	lowerFeet(5,false)
	TurnF(1,0,false)
	TurnF(2,0,false)
	liftFeet(4)
	liftFeet(6)
	WaitForTurn(center,y_axis)
	Turn(center,y_axis,math.rad(-2),0.1)
--	Turn(roof,x_axis,math.rad(-0.5),0.025)
	comonValue=comonValue+5
	comonSpeed=0.2
	TurnF(4,-56,false)
	TurnF(6,57,true)
	
	lowerFeet(4,false)
	lowerFeet(6,false)
	TurnF(3,0,false)
	TurnF(5,0,false)
	liftFeet(1)
	liftFeet(2)
	TurnF(1,56,false)
	TurnF(2,-50,true)
	TurnF(4,0,false)
	TurnF(6,0,false)
	Sleep(50)
	WaitForTurn(center,y_axis)
	Sleep(10)
	end
end
justOnce=true
function script.StartMoving()
Signal(SIG_MOVE)
StartThread(moveIt)								
													
end

function legs_down()
	for i=1,table.getn(feetFetish),1 do
		for j=1,4, 1 do
		Turn(feetFetish[i][j],x_axis,math.rad(0),3.141)
		Turn(feetFetish[i][j],y_axis,math.rad(0),3.141)
		Turn(feetFetish[i][j],z_axis,math.rad(0),3.141)
		end
	end

end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end

function script.QueryBuildInfo() 
  return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})

boolLaunch=false
dtime=10000

function launchBuilding(time)
boolLaunch=true
dtime=time
end

function launchBuildingThread()
Move(flare,y_axis,15,0)
while boolLaunch==false do
Sleep(1000)
end

Sleep(dtime)
Spring.SetUnitAlwaysVisible(unitID,true)
Spring.SetUnitNoSelect(unitID,true)
Move(center,y_axis,4900,25)
	while (true==Spring.UnitScript.IsInMove (center, y_axis)) do
	EmitSfx(flare,1025)
	Sleep(100)
	end
Spring.SetUnitAlwaysVisible(unitID,false)
end
