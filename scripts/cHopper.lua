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

local totalShots = 12
ArmorFactor = 0.1 

function script.Create()
end


function script.HitByWeapon(x,z,weaponDefID, damage)
	if weaponDefID == WeaponDefNames["chopper"].id then

	return 0
	end

return damage * ArmorFactor
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

    if totalShots > 0 then
		if minetable[math.ceil(totalShots/2)] then
        Move(minetable[math.ceil(totalShots/2)], y_axis, 42, 72)
        WaitForMove(minetable[math.ceil(totalShots/2)], y_axis)
		end
		if minetable[math.ceil(totalShots/2)+1] then
        Hide(minetable[math.ceil(totalShots/2)+1])
		end
        return true
    else
        return false
    end
end



function script.FireWeapon1()
    tempPiece = minetable[math.ceil(totalShots/2)]
	  totalShots = totalShots - 1
	if tempPiece then
		EmitSfx(tempPiece, 1024)
		Hide(tempPiece)
	end
    if totalShots == 0 then
        Spring.DestroyUnit(unitID, false, true)
    end
end



function script.Killed(recentDamage, maxHealth)

    return 1
end
