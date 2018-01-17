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
end

function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
    return 1
end


--- -aimining & fire weapon 
function script.AimFromWeapon1()
    return aimpiece
end

function script.QueryWeapon1()
    return aimpiece
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy
	x,y,z= getUnitMoveGoal(unitID)
	ux,uy,uz = Spring.GetUnitPosition(unitID)
    return boolMoving and x and  distance(ux,uy,uz, x,y,z) < 100 
end

function script.FireWeapon1()
	StartThread(transformIntoAttackState)
    return true
end

boolOnlyOnce = false
boolTransformComplete= false
function transformIntoAttackState()
if boolOnlyOnce == false then boolOnlyOnce = true else return end
Sleep(9000)
while nil == transformUnitInto(unitID,"cauterizerdeployed") do Sleep(100) end

end

function script.Activate()
    return 1
end

function script.Deactivate()
    return 0
end

