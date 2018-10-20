include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

damgedInFrame=nil
function script.HitByWeapon(x, z, weaponDefID, damage)
damgedInFrame= Spring.GetGameFrame()
end

aimpiece = piece"aimpiece"

function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	 hideAll(unitID)
	 showT(TablesOfPiecesGroups["NGon"],1,27)
	 showT(TablesOfPiecesGroups["Bubble"])
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

function script.Killed(recentDamage)
	if not damgedInFrame or recentDamage <= 0 or Spring.GetGameFrame() < damgedInFrame - 15 then
		vannishAnimation()
	else
		deathAnimation()
	end
end

function vannishAnimation()
end
function deathAnimation()
end

function script.QueryBuildInfo()
    return center
end

Spring.SetUnitNanoPieces(unitID, { center })

