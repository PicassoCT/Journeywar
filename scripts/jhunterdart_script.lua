include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 
 jHunterDartDamage= 150

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


function script.Create()
	Spring.SetUnitNoSelect(unitID,true)
	Spring.SetUnitAlwaysVisible(unitID,true)
	StartThread(timeTillBoom)
end


center=piece"center"

local BOOM=3000

function timeTillBoom()
	Sleeptime=500
	dirSign=-1
	value=math.pi/15
	for i=1, 10,1 do
	tx,ty,tz =Spring.UnitScript.GetPieceRotation(center)
		Turn(center,y_axis,ty + value*dirSign, 2*math.abs(dirSign))
		Turn(center,x_axis,tx + value*dirSign, 2*math.abs(dirSign))
		dirSign=dirSign*-1.25
		Sleeptime= math.max(math.ceil(Sleeptime*0.8),50)
		Sleep(Sleeptime)
	end

	x,y,z=Spring.GetUnitPosition(unitID)
	T=getAllInCircle(x,z,64 ,unitID)
	for i=1,#T do
	Spring.AddUnitDamage(T[i], jHunterDartDamage) 
	end
	
	Spring.SpawnCEG("antimatter",x,y+15,z,0,1,0,50,0)
	Spring.DestroyUnit(unitID,false,true)
end

function script.Killed(recentDamage,_)
return 1
end


