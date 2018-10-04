include "AniMatrixNative.lua"
include "NewNatives.lua"

SwingCenter1 = piece "SwingCenter1"
ALM = piece "ALM"

AFL = piece "AFL"
AFR = piece "AFR"
AL = piece "AL"
AL2 = piece "AL2"
AR = piece "AR"
AR2 = piece "AR2"

Alt = piece "Alt"
Diamond = piece "Diamond"
center = piece "center"
totem = piece "totem"
Quader01 = piece "Quader01"
Kreis01 = piece "Kreis01"
ring = piece "ring"

function spawnFire()
    x, y, z = Spring.GetUnitPosition(unitID)
    teamID = Spring.GetUnitTeam(unitID)
    while true do
        naptime = math.ceil(math.random(90000, 290000))
        randoval = math.ceil(math.random(150, 200))
        booltoo = math.random(-1, 1)
        Sleep(naptime)
        x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, ALM)
        Spring.CreateUnit("jfireplace", x + randoval, y, z + math.floor(randoval * booltoo), 0, teamID)
    end
end




function script.Create()
    StartThread(NativePartyManager)
    if math.random(0, 1) == 1 then Hide(totem) end
    decision = math.random(0, 2)
    if decision == 1 then
        Hide(Alt)
        Hide(Diamond)
    elseif decision == 2 then
        Hide(Kreis01)
        Hide(Quader01)
    else
        if math.random(0, 1) == 1 then
            Hide(Quader01)
        else
            Spin(Quader01, z_axis, math.rad(-42), 0.001)
        end
    end
    Spin(Diamond, y_axis, math.rad(-42), 0.1)

    x = math.random(0, 360)
    Turn(ring, y_axis, math.rad(x), 0)
    x = math.random(0, 360)

    Turn(center, y_axis, math.rad(x), 0)
    x = math.random(0, 360)
    Turn(totem, y_axis, math.rad(x), 0)
    StartThread(spawnFire)
end

local myTeamID = Spring.GetUnitTeam(unitID)

function script.HitByWeapon(x, z, weaponDefID, damage)
    id = Spring.GetUnitNearestEnemy(unitID)
    if id then
        teamid = Spring.GetUnitTeam(id)
        boolMetall = Spring.UseTeamResource(teamid, "metall", damage)
        boolEnergy = Spring.UseTeamResource(teamid, "energy", damage)
        if boolEnergy and boolEnergy == true then Spring.AddTeamResource(myTeamID, "energy", damage) end
        if boolMetall and boolMetall == true then Spring.AddTeamResource(myTeamID, "metall", damage) end
    else

        return 0
    end
end


function script.Killed()
end

