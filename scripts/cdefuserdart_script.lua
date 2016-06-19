include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
dart=piece"dart"

function script.Create()
	StartThread(trail)
	StartThread(uHave20Seconds)
end

function trail()
	while true do
		EmitSfx(dart,1024)
		Sleep(100)
	end
end

function uHave20Seconds()
	Sleep(20000)
	dropDead()
end


function script.Killed(recentDamage,_)
	
	
	return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return dart 
end



function script.QueryWeapon1() 
	return dart
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
	
end


function script.FireWeapon1()	
	
	return true
end

function dropDead()
	Move(center,y_axis,-22,12)
	Sleep(2000)
	Spring.DestroyUnit(unitID,true)
end


function script.StartMoving()
	Signal(SIG_DROP)
	
end

local SIG_DROP=2

function TimeDelayedDrop()
	SetSignalMask(SIG_DROP)
	Sleep(2000)
	dropDead()
end

function script.StopMoving()
	Signal(SIG_DROP)
	StartThread(TimeDelayedDrop)
end