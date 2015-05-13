include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
RaceDrone=piece"RaceDrone"

function script.Create()
StartThread(trail)
StartThread(uHave20Seconds)
end

function trail()
	while true do
		while boolMove==true do
		EmitSfx(RaceDrone,1024)
		Sleep(50)
		end
	Sleep(350)
	end
end

function uHave20Seconds()
Sleep(20000)
Spring.DestroyUnit(unitID,true)
end

function script.Killed(recentDamage,_)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return RaceDrone 
end



function script.QueryWeapon1() 
	return RaceDrone
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
end


boolItsOff=false
boolMove=false
function script.StartMoving()
boolMove=true
boolItsOff=true
end

function TimeDelayedDestruction()
Sleep(1000)
	if boolItsOff==false then
	Spring.DestroyUnit(unitID,false,true)		
	end
boolItsOff=false
end

function script.StopMoving()
boolMove=false
StartThread(TimeDelayedDestruction)
end
