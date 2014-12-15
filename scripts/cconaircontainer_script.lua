include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"
reward= UnitDefNames["conair"].cost

function script.Create()
StartThread(rewardTheFaithFull)

end

function rewardTheFaithFull()
local teamid=Spring.GetUnitTeam(unitID)
timer=42000
	while timer > 0 do
	x,y,z=Spring.GetUnitPosition(unitID)
	T=grabEveryone(unitID,x,z,60,teamid)
		if T and #T > 0 then
		finderT=Spring.GetUnitTeam(T[1])
		Spring.AddTeamResource(finderT,"metall",reward)
		Spring.DestroyUnit(unitID,true,false)
		break
		end
	timer=timer-500
	Sleep(500)
	end
Move(center,y_axis,-50,2.5)
WaitForMove(center,y_axis)
	x,y,z=Spring.GetUnitPosition(unitID)
	T=grabEveryone(unitID,x,z,60,teamid)
		if T and #T > 0 then
		finderT=Spring.GetUnitTeam(T[1])
		Spring.AddTeamResource(finderT,"metall",reward)
		Spring.DestroyUnit(unitID,true,false)		
		end

Spring.DestroyUnit(unitID,true,false)
end

function script.Killed(recentDamage,_)

return 1
end


----aimining & fire weapon
function script.StartMoving()

end

function script.StopMoving()
		
		
end
