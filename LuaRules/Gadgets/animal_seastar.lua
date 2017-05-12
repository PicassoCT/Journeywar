VFS.Include("scripts/lib_OS.lua")
VFS.Include("scripts/lib_UnitScript.lua")
VFS.Include("scripts/lib_Build.lua")



gaiaTeamID = Spring.GetGaiaTeamID()



function handleSeaStars(frame, seastarcounter)
    if frame > 9000 and frame % 300 == 0 and seastarcounter < 5 then
        x, z = getPathFullfillingCondition(GetSpot_condDeepSea, 32, { minBelow = -25, maxAbove = -120 })
        tx, tz = getPathFullfillingCondition(GetSpot_condDeepSea, 32, { minBelow = 0, maxAbove = -24 })

        if x and z and tx and tz then
            id = Spring.CreateUnit("gseastar", x, -50, z, 1, gaiaTeamID)

            if math.random(0, 1) == 1 then
                Spring.SetUnitMoveGoal(id, tx, 0, tz)
            else
                x, y, z = Spring.GetUnitPosition(id)
                tx, ty, tz = mirrorMapCenter(x, y, z)
                Spring.SetUnitMoveGoal(id, tx, ty, tz)
            end
        end
    end
end
	
	
	