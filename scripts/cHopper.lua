local mine1 = piece "hopper1"
local mine2 = piece "hopper2"
local mine3 = piece "hopper3"
local mine4 = piece "hopper4"
local mine5 = piece "hopper5"
local mine6 = piece "hopper6"
minetable = {}
minetable[1] = mine1
minetable[2] = mine2
minetable[3] = mine3
minetable[4] = mine4
minetable[5] = mine5
minetable[6] = mine6
local firePoint = piece "jumppoint"

local sixShots = 6



function script.Create()
end




--- AIMING & SHOOTING---
----------------------------------------- WEAPON ONE ----------------------------
function script.AimFromWeapon1()
    return firePoint
end

function script.QueryWeapon1()
    return firePoint
end


function script.AimWeapon1(heading, pitch)

    if sixShots > 0 then
        Move(minetable[sixShots], y_axis, 42, 72)
        WaitForMove(minetable[sixShots], y_axis)
        Hide(minetable[sixShots])
        return true
    else
        return false
    end
end



function script.FireWeapon1()
    tempPiece = minetable[sixShots]
    EmitSfx(tempPiece, 1024)
    sixShots = sixShots - 1
    Hide(tempPiece)
    if sixShots == 0 then
        Spring.DestroyUnit(unitID, false, true)
    end
end



function script.Killed(recentDamage, maxHealth)

    return 1
end
