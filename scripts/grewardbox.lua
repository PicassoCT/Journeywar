include "createCorpse.lua"
include "lib_jw.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

function PositionChecked()
    x, y, z = Spring.GetUnitPosition(unitID)
    boolMeasure = true
    while boolMeasure == true do

        tx, ty, tz = Spring.GetUnitPosition(unitID)

        if math.abs(x - tx) + math.abs(z - tz) > 120 then boolMeasure = false end
	Sleep(100)
    end

    oldx, oldy, oldz = 0, 0, 0
    while true do
        x, y, z = Spring.GetUnitPosition(unitID)
        if oldx == x and oldy == y and oldz == z and y < Spring.GetGroundHeight(x, z) + 15 then
            T = Spring.GetUnitsInCylinder(x, z, 120)
            table.remove(T, unitID)

            if T then
                for i = 1, #T, 1 do
                    id = Spring.GetUnitDefID(T[i])
                    if id == UnitDefNames["citadell"].id or id == UnitDefNames["beanstalk"].id then dissolveAndReward(Spring.GetUnitTeam(T[i]))
                    end
                end
            end
        end

        oldx, oldy, oldz = x, y, z
      Sleep(100)	
    end
end

function dissolveAndReward(teamd)

	createRewardEvent(teamd)

    Spring.DestroyUnit(unitID, false, true)
end

function script.Create()
    StartThread(PositionChecked)
end

function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
end


function script.StartMoving()
end

function script.StopMoving()
end

