include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

function script.HitByWeapon(x, z, weaponDefID, damage)
end

Arm = {}
window = {}
Arm[1] = piece "Arm1"
Arm[2] = piece "Arm2"
Arm[3] = piece "Arm3"
Arm[4] = piece "Arm4"
Arm[5] = piece "Arm5"
Arm[6] = piece "Arm6"
Arm7 = piece "Arm7"
window[1] = piece "window1"
window[2] = piece "window2"
window[3] = piece "window3"


center = piece "deathpivot"

function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
    StartThread(armedAndDangerous)
end

function armedAndDangerous()
    while true do
        resetT(TablesOfPiecesGroups)
        Sleep(1000)

        snakeOnAPlane(unitID,
            Arm,
            Arm7, --FirstSensor
            window,
            x_axis, --=axis
            0.5, --=speed,
            3, --=tolerance,
            true, --=boolPartStepExecution,
            true --boolWait)
        Sleep(10000)
    end
end

function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
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

    return true
end


function script.FireWeapon1()

    return true
end



function script.StartMoving()
end

function script.StopMoving()
end

function script.Activate()

    return 1
end

function script.Deactivate()

    return 0
end

function script.QueryBuildInfo()
    return center
end

Spring.SetUnitNanoPieces(unitID, { center })

