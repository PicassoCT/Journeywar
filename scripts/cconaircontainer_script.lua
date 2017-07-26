include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center = piece "center"
reward = UnitDefNames["conair"].cost

function script.Create()
    StartThread(rewardTheFaithFull)
end

function rewardTheFaithFull()
    local teamid = Spring.GetUnitTeam(unitID)
    timer = 42000
    while timer > 0 do
        x, y, z = Spring.GetUnitPosition(unitID)
        T = getAllInCircle(x, z, 60, unitID, teamid)
        if T and #T > 0 then
				process(T,
					function(id)
					defID = Spring.GetUnitDefID(id)
					if id ~= unitID and defID ~= UnitDefNames["cconaircontainer"].id and defID ~= UnitDefNames["conair"].id  then
						finderT = Spring.GetUnitTeam(id)
						Spring.AddTeamResource(finderT, "metall", reward)
						Spring.DestroyUnit(unitID, true, false)
					end
					end
					)
        end
        timer = timer - 500
        Sleep(500)
    end
    Move(center, y_axis, -50, 2.5)
    WaitForMove(center, y_axis)
   

    Spring.DestroyUnit(unitID, true, false)
end

function script.Killed(recentDamage, _)

    return 1
end


--- -aimining & fire weapon
function script.StartMoving()
end

function script.StopMoving()
end
