include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

--Define the wheel pieces

--Define the pieces of the weapon
amturret = piece "amturret"
SIG_FLARE = 1
leftAm = {}
for i = 1, 14, 1 do
    leftAm[i] = {}
    temp = "amemit1" .. i
    leftAm[i] = piece(temp)
end

rightAm = {}
for i = 0, 13, 1 do
    rightAm[i + 1] = {}
    temp = "amemit2" .. i
    rightAm[i + 1] = piece(temp)
end


teamID = Spring.GetUnitTeam(unitID)

function script.Create()
end

maxspeed = math.ceil(UnitDefNames["campro"].speed * 65533)

boolReadyFire = true
function flareThread()

    for i = 1, 14, 1 do
        if i < 3 then
            EmitSfx(leftAm[i], 1024)
            EmitSfx(rightAm[i], 1024)

        else
            EmitSfx(leftAm[i], 1024)
            EmitSfx(rightAm[i], 1024)
            Sleep(50)
            --EmitSfx(leftAm[i],1024)
            --EmitSfx(rightAm[i],1024)
        end
        Sleep(120)
    end
end

--- -aimining & fire weapon
function script.AimFromWeapon1()
    return amturret
end

function script.QueryWeapon1()
    return amturret
end

function script.AimFromWeapon2()
    return amturret
end

function script.QueryWeapon2()
    return amturret
end

boolTurretAimed = false
SIG_AIM = 4
function script.AimWeapon1(heading, pitch)
    boolTurretAimed = false
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)
    Turn(amturret, y_axis, heading, 2.1)
    WaitForTurn(amturret, y_axis)
    boolTurretAimed = true
    return true
end

function script.AimWeapon2(heading, pitch)
    return boolTurretAimed
end


function script.FireWeapon1()


    StartThread(flareThread)
    return true
end

function script.FireWeapon2()


    return true
end

function script.Killed(recentDamage, maxHealth)
    EmitSfx(amturret, 1025)
    Explode(amturret, SFX.FIRE + SFX.FALL)
    x, _, z = Spring.GetUnitPosition(unitID)
    defID = UnitDefNames["campro"].id
    T2 = getExemptFromLethalEffectsUnitTypeTable(UnitDefNames)
    tooClose = getAllInCircle(x, z, 190, unitID)
    process(tooClose,
        function(id)
            if Spring.GetUnitDefID(id) ~= UnitDefNames["campro"].id then

                return id
            end
        end,
        function(id)
            def = Spring.GetUnitDefID(id)
            if not T2[def] then
                return id
            end
        end,
        function(id)
            GG.UnitsToKill:PushKillUnit(id)
        end)


    size = 8
    if GG.DynDefMap == nil then GG.DynDefMap = {} end
    if GG.DynRefMap == nil then GG.DynRefMap = {} end
    GG.DynDefMap[#GG.DynDefMap + 1] = { x = x / 8, z = z / 8, Size = size, blendType = "melt", filterType = "borderblur" }
    GG.DynRefMap[#GG.DynRefMap + 1] = prepareHalfSphereTable(size, -1)

    Sleep(450)
    EmitSfx(amturret, 1025)
    return
end

--Building



function script.StartMoving()
end

function script.StopMoving()
end