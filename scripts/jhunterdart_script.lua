include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 


function script.Create()
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitAlwaysVisible(unitID,true)
StartThread(timeTillBoom)
end


emitspot=piece"RaceDrone"

local BOOM=3000

function timeTillBoom()
	Sleep(2500)
	x,y,z=Spring.GetUnitPosition(unitID)
	T=getAllInCircle(x,z,100,unitID)
	for i=1,#T do
	Spring.AddUnitDamage(T[i],90) 
	end
	
	Spring.SpawnCEG("tess",x,y+25,z,0,1,0,50,0)
	Spring.DestroyUnit(unitID,false,true)
end

function script.Killed(recentDamage,_)
return 1
end


