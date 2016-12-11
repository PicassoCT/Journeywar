include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
TIME=15000

function script.Create()
	StartThread(wiggleWaitAndBirth)
end

function script.Killed(recentDamage,_)
	
	return 1
end
----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end
teamid=Spring.GetUnitTeam(unitID)
function wiggleWaitAndBirth()
	for i=1,25, 1 do
		Sleep(math.ceil(TIME/25)+math.ceil(math.random(20,300)))
		Spin(center,x_axis,math.rad(math.random(-42,42)),math.random(2,9))
		Spin(center,z_axis,math.rad(math.random(-42,42)),math.random(2,9))
	end
	StopSpin(center,x_axis)
	StopSpin(center,z_axis)
	x,y,z=Spring.GetUnitPosition(unitID)
	id=Spring.CreateUnit("jracedart",x,y,z, 0, teamid)
	ed=Spring.GetUnitNearestEnemy(id)
	if ed then
		ex,ey,ez=Spring.GetUnitPosition(ed)
		Spring.SetUnitMoveGoal(id,ex,ey,ez)
	end
	Spring.DestroyUnit(unitID,false,true)
end