include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

 piecesTable={}
 center = piece"center"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= center
 swarmcenter = piece"swarmcenter"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= swarmcenter
 Swarm1 = piece"Swarm1"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm1
 Swarm2 = piece"Swarm2"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm2
 Swarm3 = piece"Swarm3"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm3
 Swarm4 = piece"Swarm4"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm4
 Swarm5 = piece"Swarm5"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm5
 Swarm6 = piece"Swarm6"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm6
 Swarm7 = piece"Swarm7"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm7
 Swarm8 = piece"Swarm8"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm8
 Swarm9 = piece"Swarm9"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= Swarm9
  rotator1 = piece"rotator1"
  piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= rotator1
 rotator3 = piece"rotator3"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= rotator3
  rotator2 = piece"rotator2"
 piecesTable[#piecesTable+1]={}
 piecesTable[#piecesTable]= rotator2

 local ShowHidePiecesTable={}
for i=1,#piecesTable do
ShowHidePiecesTable[piecesTable[i]]=true
end

fish={}
for i=1,9, 1 do
name="Swarm"..i
fish[i]=piece(name)
end

subcenters={}
for i=1,9, 1 do
name="subc"..i
assert(piece(name),i)
subcenters[i]=piece(name)
end

 dopefish = piece"dopefish"
 center1 = piece"center1"
 center2 = piece"center2"
 center3 = piece"center3"
 Hide(dopefish)

-- [piecenumber]= boolShown
local centers={center1,center2,center3}

function script.Create()
Hide(dopefish)
StartThread(HideAndShowBasedUponHealth)
StartThread(rotatefish)
StartThread(movementAnimation)
Spin(rotator1,x_axis,math.rad(42),0)
Spin(rotator2,x_axis,math.rad(42),0)
Spin(rotator3,x_axis,math.rad(42),0)
end

function script.Killed(recentDamage,_)
--bloody Waters
return 1
end


local spSetUnitHealth=Spring.SetUnitHealth

function decreaseHealthUponShot()
hp=Spring.GetUnitHealth(unitID)
	if hp then
	spSetUnitHealth(unitID,hp-20)
	end
end

function HideAndShowBasedUponHealth()
local spGetUnitHealth=Spring.GetUnitHealth
local _,maxhealth=spGetUnitHealth(unitID)
local increase= 1/9

	while true do
	Sleep(300)
	hp=spGetUnitHealth(unitID)
	percentage=math.max(hp/maxhealth,0.1)

	counter=0 
		for k,v in pairs(ShowHidePiecesTable) do
		counter =counter+ increase
			if counter > percentage  then
			Hide(k)
			ShowHidePiecesTable[k]=false
			end
		
			if counter < percentage  then 
			Show(k)
			ShowHidePiecesTable[k]=true	
			end
			
		

		end
	end
end

function movementAnimation()
local lswim=swim
	while true do

		if boolMovement==true then
		lswim()
		else
			for i=1,#fish do
			Move(fish[i],z_axis,0,1)
			end
			if math.random(0,1)==1 then
			idle()
			end
		end
	Sleep(100)
		if math.random(0,15)==5 then
		PlaySoundByUnitType(fishDefID, "sounds/jfishswarm/jFishSwarmMoving.ogg",1, 1200, 1)
		end
	end

end

fishDefID=Spring.GetUnitDefID(unitID)

local  boolMovement=false
function script.StartMoving()
boolMovement=true
Signal(SIG_STOP)
end

local SIG_STOP=2
function delayedStop()
SetSignalMask(SIG_STOP)
Sleep(3500)
boolMovement=false
end

function script.StopMoving()
Signal(SIG_STOP)
StartThread(delayedStop)	
		
end

function script.Activate()
return 1
end

function script.Deactivate()
return 0
end

landaim=piece"landaim"
----aimining & fire weapon
function script.AimFromWeapon1() 
	return landaim 
end

function script.QueryWeapon1() 
	return landaim 
end

local SIG_WEAPON1=1

function script.AimWeapon1(pitch,heading)
Signal(SIG_WEAPON1)
SetSignalMask(SIG_WEAPON1)
Show(dopefish)
Turn(dopefish, y_axis,heading, 0)
Turn(dopefish, x_axis, math.rad(90), 18)
WaitForTurn(dopefish, y_axis)
Hide(dopefish)
return true
end


 

function script.FireWeapon1()

Spring.PlaySoundFile("sounds/jfishswarm/jFishSwarmFlyingAttack.wav",1)

Turn(dopefish, x_axis, math.rad(0), 0)
Hide(dopefish)
return true
end

function swim()

	for i= 1, #fish do

		if Spring.UnitScript.IsInTurn(fish[i],y_axis)==false then
		dir= math.random(-25,-5)
		Turn(fish[i],y_axis,math. rad(dir*(-1^i)),0.25)
		if math.random(0,1)==1 then 	Move(fish[i],z_axis,42,3) end
		end
	end
Sleep(150)
	for i= 1, #fish do
		if Spring.UnitScript.IsInTurn(fish[i],y_axis)==false then
		dir= math.random(-25,-5)
		Turn(fish[i],y_axis,math. rad(dir*(-1^(i+1))),0.25)
		if math.random(0,1)==1 then  Move(fish[i],z_axis,-10,3) end
		end
	end
Sleep(150)


end

function idle ()
local direction=-1
going={}
one=0
for i=1,9, 1 do
going[i]=math.random(0,1)
	if going[i]== 1 then one =i end
end

	for i=1,9 do
	if going[i]==1 then
	speed=math.random(2,5)
	if i%2==0 then direction=1 else direction=-1 end

	Turn(subcenters[i],y_axis,math.rad(179*direction),speed)
	end
	end
	
	if one ~=0 then 
	WaitForTurn(subcenters[one],y_axis)
	end
	val=math.ceil(math.random(1000,1500))
Sleep(val)

	for i=1, 9 do
	if going[i]==1 then
	speed=math.random(2,8)
	if i%2==0 then direction=1 else direction=-1 end
	
	Turn(subcenters[i],y_axis,math.rad(357*direction),speed)
	end
	end
	val=math.ceil(math.random(1200,1500))
Sleep(val)

	for i=1, 9 do
	speed=math.random(2,9)
	Turn(subcenters[i],y_axis,math.rad(0),speed)
	end

end
 

function rotatefish()
local spGetGroundHeight=Spring.GetGroundHeight
local spGetUnitPosition=Spring.GetUnitPosition

	while true do
	x,y,z=spGetUnitPosition(unitID)
	GroundHeight=spGetGroundHeight(x,z)
	boolShallowWaters=false
	if GroundHeight > - 55 then boolShallowWaters=true end 
	
		for i= 1, #centers do
		mara=85 *randSign()
			if boolShallowWaters==false then mara =math.random(-89,89) end
		Turn(centers[i],z_axis,math.rad(mara), 0.4)
		end
	WaitForTurn(centers[2],z_axis)
	end
end
----aimining & fire weapon
function script.AimFromWeapon2() 
	return center 
end

function script.QueryWeapon2() 
	return center 
end


function script.AimWeapon2( Heading ,pitch)	
return true
end
 

function script.FireWeapon2()	
val=math.random(0.5,0.75)
Spring.PlaySoundFile("sounds/jfishswarm/jFishSwarmAttack.ogg",val)

	return true
end

