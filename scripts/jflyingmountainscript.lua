include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece("center")
peebleSpinCenter=piece("peebleSpinCenter")
mountainSpinCenter=piece("mountainSpinCenter")
peebles={}
for i=1,39 do
stringTango="peeble0"..i
peebles[i]=piece(stringTango)
end

mountains={}
for i=1,17 do
stringTango="mountain0"..i
mountains[i]=piece(stringTango)
end


function preparhalfSphereTable(size,height)
cent=math.ceil(size/2)
T={}
	for o=1,size,1 do
	T[o]={}
		for i=1,size,1 do
		--default
		T[o][i]=0
		distcent=math.sqrt((cent-i)^2+(cent-o)^2)	
			if distcent < cent-1 then
			T[o][i]=(cent-distcent)*height
			end
		end
	end
	
return T	
end

function script.Create()
SetUnitValue(19,1)
 
StartThread(waterFall)
StartThread(shieldGeometry)
teamID=Spring.GetUnitTeam(unitID)
x,y,z=Spring.GetUnitPosition(unitID)
-- Show halfSphere - Dig Hole for halfSphere
number=math.random(7,12)
	for i=1,number  do
	xa=math.random(-65,-30)
	za=math.random(-65,-30)
	one=1
	two=1
	if math.random(0,1)==1 then one= -1 end
	if math.random(0,1)==1 then two= -1 end
	GG.UnitsToSpawn:PushCreateUnit("jpeeble",x+xa*one,0,z+za*two,0,teamID)
	end
--<TERRAFORM>
 --<DIGHOLE>										
size=20
if GG.DynDefMap == nil then GG.DynDefMap={} end
if GG.DynRefMap == nil then GG.DynRefMap={} end
GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="borderblur"}
GG.DynRefMap[#GG.DynRefMap+1]=	preparhalfSphereTable(20,-8)
GG.boolForceLandLordUpdate=true



Turn(mountainSpinCenter,y_axis,math.rad(math.random(-360,360)),0)
Spin(mountainSpinCenter,y_axis,math.rad(math.random(-0.360,0.360)))
showOneOfTheMountains()
StartThread(spinUpStones)
StartThread(riseAnimation)
end

function comeOnDown()

DropAnimation()
takeVictimsToAnotherDimension()
size=32
if GG.DynDefMap == nil then GG.DynDefMap={} end
if GG.DynRefMap == nil then GG.DynRefMap={} end
GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="borderblur"}
GG.DynRefMap[#GG.DynRefMap+1]=	preparhalfSphereTable(size,4)
GG.boolForceLandLordUpdate=true
Spring.DestroyUnit(unitID,true,true)


end

function script.Killed(recentDamage,_)
DropAnimation()
takeVictimsToAnotherDimension()
size=32
if GG.DynDefMap == nil then GG.DynDefMap={} end
if GG.DynRefMap == nil then GG.DynRefMap={} end
GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="borderblur"}
GG.DynRefMap[#GG.DynRefMap+1]=	preparhalfSphereTable(size,4)
GG.boolForceLandLordUpdate=true


return 1
end

function showOneOfTheMountains()
for i=1,#mountains do
Hide(mountains[i])
end
Show(mountains[math.random(1,#mountains)])
end

function spinUpStones()
	for i=1,#peebles do
	Spin(peebles[i],y_axis,math.random(-22,22),0.001)
	end
		
	while true do
	Move(peebleSpinCenter,y_axis,math.random(-20,15),0.1)
	Spin(peebleSpinCenter,y_axis,math.random(-22,22),0.001)
	--Spin(peebleSpinCenter,x_axis,math.random(-4.2,4.2),0.001)
	Sleep(90000)
		for i=1,#peebles do
			if math.random(0,1)==1 then
			Spin(peebles[i],y_axis,math.random(-22,22),0.001)
			end
		end
	end
end
waterfallspot=piece"waterfallspot"
function waterFall()
	if math.random(0,1)==1 then
	Sleep(60000)
		while true do 
		EmitSfx(waterfallspot,1025)
		Sleep(80)
		end

	end
end

local unitdef=Spring.GetUnitDefID(unitID)
local soundfile="sounds/jMom/jMountain.ogg"
function riseAnimation()
PlaySoundByUnitType(unitdef, soundfile,0.9, 2000, 1)
downUnderVal=-200
speed=3
Move(center,y_axis,downUnderVal,0,true)

	while downUnderVal < 0 do
	downUnderVal=downUnderVal+30
	speed=speed+speed
	Move(center,y_axis,downUnderVal,speed)
		while (true==Spring.UnitScript.IsInMove (center, y_axis)) do
		EmitSfx(peebles[math.random(1,#peebles)],1024)
		Sleep(50)
		end

	end
	
Move(center,y_axis,0,12)
Spin(center,y_axis,math.random(-1.5,1.5),0.001)
	while true do
	Move(center,y_axis,math.random(5,25),math.random(0.1,1.2))
	WaitForMove(center,y_axis)
	Move(center,y_axis,math.random(-5,5),math.random(0.1,1.2))
	WaitForMove(center,y_axis)
		if math.random(1,42)==32 then
		PlaySoundByUnitType(unitdef, soundfile,0.9, 2000, 1)
		end
	end
end

function DropAnimation()

x,y,z=Spring.GetUnitPiecePosDir(unitID,center)
local speed=4
local gravity=Game.gravity
local spMovCtrlSetPos=Spring.MoveCtrl.SetPosition
	Spring.SetUnitBlocking(unitID,true)
   Spring.SetUnitNoSelect(unitID,true)
   Spring.MoveCtrl.Enable(unitID,true)  


	while (y > - 50) do
	x,y,z=Spring.GetUnitPiecePosDir(unitID,center)
	
	speed=math.min(speed+speed,gravity)
	dist=speed/10
	spMovCtrlSetPos(unitID,x,y-dist,z)
    
	Sleep(100)
	end


	for i=1, 4 do
	EmitSfx(mountains[math.random(1,#mountains)],1028)
	end
end

local IsCommender= UnitDefNames["ccomender"].id
local DamageRadius=500
function takeVictimsToAnotherDimension()
x,y,z=Spring.GetUnitPosition(unitID)
T=Spring.GetUnitsInCylinder(x,z,DamageRadius)
table.remove(T,unitID)
	if T and #T > 0 then
		for i=1,#T,1 do
		def=Spring.GetUnitDefID(T[i])
		--if is airborne or is commender TODO

		if def ~= IsCommender and UnitDefs[def].isAirUnit == false then
			Spring.DestroyUnit(T[i],false,true)
			end
		end
	end
end

function script.StartMoving()

end

function script.StopMoving()
		
		
end

function shieldGeometry()
Sleep(2500)
		EmitSfx(waterfallspot,1026)
Sleep(12000)

	while true do
		
		EmitSfx(waterfallspot,1027)
		
	rand=math.ceil(math.random(30000,190000))
	Sleep(rand)
	end

end
----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center 
end

boolOnce=true
function script.AimWeapon1( heading ,pitch)	


	return boolOnce
end


function script.FireWeapon1()	
boolOnce=false
StartThread(comeOnDown)
	return true
end