VFS.Include("scripts/lib_OS.lua")
VFS.Include("scripts/lib_UnitScript.lua")
VFS.Include("scripts/lib_Build.lua")



function BuildAvatara(units, allreadyExistingAvatara)

    if #units <= 1 then
        it = 1
    else
        it = sanitizeRandom(1, #units)
    end
    x, y, z = Spring.GetUnitPosition(units[it])
    if x and not allreadyExistingAvatara or Spring.ValidUnitID(allreadyExistingAvatara) == false or Spring.GetUnitIsDead(allreadyExistingAvatara) == true then
        teamid = Spring.GetUnitTeam(units[it])
        if teamid then
            avataraID = Spring.CreateUnit("jvaryavatara", x, y, z, 1, teamid) --TODO BECONTINUED)
            allreadyExistingAvatara = avataraID
        end
    end

    if Spring.ValidUnitID(allreadyExistingAvatara) == true and Spring.GetUnitIsDead(allreadyExistingAvatara) == false then
        tx, ty, tz = Spring.GetUnitPosition(allreadyExistingAvatara)
        frame = Spring.GetGameFrame()
        for i = 1, #units do
            if i < varyFooNeeded + 5 then
                ox, oz = Rotate(0, 50 + (units[i] % 120), ((units[i] * 150) % 3000) + frame / 64)
                Spring.SetUnitMoveGoal(units[i], tx + ox, ty, tz + oz)
            end
        end
    end

    return allreadyExistingAvatara
end

varyTaraID = UnitDefNames["jvaryavatara"].id
varyFooNeeded = tonumber(UnitDefs[varyTaraID].customParams.varyfooneeded)

function handleVaryFoos(frame)
    if frame > 0 and frame % 300 == 0 then
        if not GG.VaryFooAvatara then GG.VaryFooAvatara = {} end

        for team, unittable in pairs(VariousFoos) do
            if table.getn(unittable) > varyFooNeeded then
                if GG.VaryFooAvatara[team] then
                    GG.VaryFooAvatara[team] = BuildAvatara(unittable, GG.VaryFooAvatara[team])
                else
                    GG.VaryFooAvatara[team] = BuildAvatara(unittable)
                end
            end
        end
    end
end
	
	
	