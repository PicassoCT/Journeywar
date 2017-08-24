include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

lifeTimeMaxMin = 15
lifeTimeMinMin = 5


function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"

pieces = {}
for i = 1, 8 do
    if i ~= 4 and i ~= 8 then
        name = "Kugel" .. i
        pieces[#pieces + 1] = piece(name)
    end
end

if not GG.MineFieldCounter then GG.MineFieldCounter = {} end
teamID = Spring.GetUnitTeam(unitID)
if not GG.MineFieldCounter[teamID] then GG.MineFieldCounter[teamID] = {} end
if not GG.MineFieldCounter[teamID]["gluemine"] then GG.MineFieldCounter[teamID]["gluemine"] = { counter = 0, mmax = 200 } end

function lifetimeDependingOnWater()
    minG, maxG = Spring.GetGroundExtremes()
    x, y, z = Spring.GetUnitPosition(unitID)
    highfactor = y / maxG
    subValue = 5000
    if highfactor <= 0 then highfactor = 0 end
    lifeTimeTotal = (lifeTimeMaxMin * 60 * 1000) * (1.0 - highfactor) + (lifeTimeMinMin * 60 * 1000) * highfactor
    if GG.MineFieldCounter[teamID]["gluemine"].counter > GG.MineFieldCounter[teamID]["gluemine"].mmax then
        lifeTimeTotal = lifeTimeMinMin * 60 * 1000
    end
    while lifeTimeTotal > 0 do

        Spring.SetUnitTooltip(unitID, "Gluemine - will live for " .. math.ceil((lifeTimeTotal / 60) / 1000) .. " minutes")
        lifeTimeTotal = lifeTimeTotal - subValue
        Sleep(subValue)
    end
    Spring.DestroyUnit(unitID, false, true)
end

function script.Create()
    GG.MineFieldCounter[teamID]["gluemine"].counter = GG.MineFieldCounter[teamID]["gluemine"].counter + 1
    spinT(pieces, y_axis, 0.02, 12, 22)
    spinT(pieces, x_axis, 0.02, 12, 22)
    spinT(pieces, z_axis, 0.02, 12, 22)
    StartThread(lifetimeDependingOnWater)
end

function script.Killed(recentDamage, _)
    GG.MineFieldCounter[teamID]["gluemine"].counter = GG.MineFieldCounter[teamID]["gluemine"].counter - 1
    return 1
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return center
end



function script.QueryWeapon1()
    return center
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    endofLifeFunc = function(x, y, z)
        T = getAllInCircle(x, z, 30, unitID)
        if T then
            if not GG.GluedForLife then GG.GluedForLife = {} end
            for i = 1, #T do
                if not GG.GluedForLife[T[i]] then GG.GluedForLife[T[i]] = 1 end
                GG.GluedForLife[T[i]] = GG.GluedForLife[T[i]] * 0.9
            end
        end
        Sleep(500)
        Spring.DestroyUnit(unitID, true, false)
    end
    for i = 1, 2 do
        x, y, z = Spring.GetUnitPosition(unitID)
         StartThread(cegDevil, "sfxglue", x, y, z, 300,
            function(Time) return Time < 5000 end,
            endofLifeFunc, true, 250, 0)
    end

    return true
end


function script.FireWeapon1()

    return true
end


function script.Activate()

    return 1
end

function script.Deactivate()

    return 0
end