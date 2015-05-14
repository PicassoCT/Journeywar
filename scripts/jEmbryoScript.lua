
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 



center = piece"center"

Egg1=piece"Egg1"
Egg2=piece"Egg2"
Egg3=piece"Egg3"
Egg4=piece"Egg4"
Egg5=piece"Egg5"

buildspot=center
function script.Create()
Spring.SetUnitHealth(unitID,1)
StartThread(wiggleAndUnfold)
end

function wiggleAndUnfold()
local spGetUnitHealth=Spring.GetUnitHealth
Hide(Egg2)
Hide(Egg3)
Hide(Egg4)
Hide(Egg5)
hp=spGetUnitHealth(unitID)

Move(Egg3,z_axis,26,0)
Move(Egg5,z_axis,30,0)
Move(Egg2,z_axis,-26,0)
Move(Egg4,z_axis,-30,0)

	while hp < 50 do
	hp=spGetUnitHealth(unitID)
	Wig=math.random(-360,360)
	Turn(Egg1,z_axis,math.rad(Wig),0.1)
	Sleep(1500)
	end
	
	Show(Egg2)
	Show(Egg3)
	Move(Egg2,z_axis,0,3)
	Move(Egg3,z_axis,0,3)
	
	
	while hp < 75 do
		hp=spGetUnitHealth(unitID)
	Wig=math.random(-360,360)
	Turn(Egg1,z_axis,math.rad(Wig),0.1)
	degg3x,degg3y=math.random(-4,4),math.random(-15,15)
	degg2x,degg2y=math.random(-4,4),math.random(-15,15)
	Turn(Egg3,x_axis,math.rad(degg3x),0.01)
	Turn(Egg3,y_axis,math.rad(degg3y),0.01)
	Turn(Egg2,x_axis,math.rad(degg2x),0.01)
	Turn(Egg2,y_axis,math.rad(degg2y),0.01)
	
	
	Sleep(1500)
	
	
	end
	
	Show(Egg4)
	Show(Egg5)
	Move(Egg4,z_axis,0,3)
	Move(Egg5,z_axis,0,3)
	
	
	while true do
	
		
	Wig=math.random(-360,360)
	Turn(Egg1,z_axis,math.rad(Wig),0.1)
	degg3x,degg3y=math.random(-4,4),math.random(-15,15)
	degg2x,degg2y=math.random(-4,4),math.random(-15,15)
	Turn(Egg3,x_axis,math.rad(degg3x),0.01)
	Turn(Egg3,y_axis,math.rad(degg3y),0.01)
	Turn(Egg2,x_axis,math.rad(degg2x),0.01)
	Turn(Egg2,y_axis,math.rad(degg2y),0.01)
	Turn(Egg4,y_axis,math.rad(degg3y*-1),0.01)
	Turn(Egg5,y_axis,math.rad(degg2y*-1),0.01)
	
	rand=math.ceil(math.random(340,2200))
	Sleep(rand)
	
	end
end

function script.Killed(recentDamage,_)


return 1
end


