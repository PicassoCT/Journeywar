include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"
aimpiece = piece "aimpiece"

function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	StartThread(playDeployAnimation)
end

function script.Killed(recentDamage, _)
    createCorpseCUnitGeneric(recentDamage)
    return 1
end

AMMUNITION = 600
--- -aimining & fire weapon Gattling
function script.AimFromWeapon1()
    return aimpiece
end



function script.QueryWeapon1()
    return aimpiece
end
function playDeployAnimation()
boolFireReady = false

boolFireReady= true
end
boolFireReady = false
function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return boolFireReady ==true and AMMUNITION > 0
end


function script.FireWeapon1()
	Spring.Echo("Cauterizer:: Ammunition ".. AMMUNITION)
	AMMUNITION = AMMUNITION -1
    return true
end

--- -aimining & fire weapon Suicide Starburst
function script.AimFromWeapon2()
    return aimpiece
end



function script.QueryWeapon2()
    return aimpiece
end

boolOneShot = true
function script.AimWeapon2(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return AMMUNITION < 1 and boolOneShot == true
end


function script.FireWeapon2()
boolOneShot = false
	StartThread(delayedSelfDestruction)
    return true
end

function delayedSelfDestruction()
Sleep(1)
Spring.DestroyUnit(unitID, false, true)
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
