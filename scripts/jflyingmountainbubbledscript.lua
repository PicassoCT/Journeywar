include "createCorpse.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece("center")

mountainSpinCenter=piece("center")
peebles={}

mountains={}
for i=1,6 do
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


StartThread(shieldGeometry)
teamID=Spring.GetUnitTeam(unitID)
x,y,z=Spring.GetUnitPosition(unitID)
-- Show halfSphere - Dig Hole for halfSphere





Turn(mountainSpinCenter,y_axis,math.rad(math.random(-360,360)),0)
Spin(mountainSpinCenter,y_axis,math.rad(math.random(-0.360,0.360)))
showOneOfTheMountains()


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
	spMovCtrlSetPos(unitID,x,y-dist,z+2)
    
	Sleep(100)
	end


	for i=1, 4 do
	EmitSfx(mountains[math.random(1,#mountains)],1028)
	end
end

local IsCommender={[UnitDefNames["ccomender"].id]=true}
local DamageRadius=500
function takeVictimsToAnotherDimension()
x,y,z=Spring.GetUnitPosition(unitID)
T=Spring.GetUnitsInCylinder(x,z,DamageRadius)
table.remove(T,unitID)
	if T and #T > 0 then
		for i=1,#T,1 do
		def=Spring.GetUnitDefID(T[i])
		--if is airborne or is commender TODO
			if IsCommender[def] == nil and UnitDefNames[def].isAirUnit == true then
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
Sleep(1500)
		EmitSfx(mountainSpinCenter,1026)
Sleep(13000)

	while true do
		
		EmitSfx(mountainSpinCenter,1027)
		
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