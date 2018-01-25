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
	StartThread(soundBarrierDetection)
end

speedOfSound= 30--elmo/s
myDefID= Spring.GetUnitDefID(unitID)
function soundBarrierDetection()
	ox,oy,oz=Spring.GetUnitPosition(unitID)
	Sleep(300)
	timer= 0
	while true do
	x,y,z = Spring.GetUnitPosition(unitID)
		if equal(distance(ox,oy,oz,x,y,z), speedOfSound, 3) and timer <= 0then
			StartThread(PlaySoundByUnitDefID, myDefID, "sounds/cauterizer/sonicboom.wav", 1, 2000, 1, 0)
			spawnCEGAtPiece(unitID, cegemit, "supersonic",0,0,0,0,true)
			 timer= 9000
		end
		timer= timer-300
	Sleep(300)
	ox,oy,oz=x,y,z
	end

end
function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
    return 1
end
--- -aimining & fire weapon 
function script.StartMoving()
    return true
end

function script.StopMoving()
    return true
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
Sleep(100)
while nil == transformUnitInto(unitID,"cauterizerdeployed") do Sleep(100) end

end
