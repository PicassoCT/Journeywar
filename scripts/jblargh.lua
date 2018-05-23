include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

SIG_STOP= 1

function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	StartThread(moveAnimationLoop)
end

function script.Killed(recentDamage, _)

    createCorpseJUnitGeneric(recentDamage)
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

function animateTheMove(delay)
delay = delay or 1000/10
	hideT(TablesOfPiecesGroups["Move"])
	Show(TablesOfPiecesGroups["default"])	
	Sleep(delay)
	
	for i=0, #TablesOfPiecesGroups["Move"] do
		if TablesOfPiecesGroups["Move"][i] then
			Show(TablesOfPiecesGroups["Move"][i])
		end
		if TablesOfPiecesGroups["Move"][i-1] then
			Hide(TablesOfPiecesGroups["Move"][i-1])
		end
		Sleep(delay)
	end
	hideT(TablesOfPiecesGroups["Move"])
	Show(TablesOfPiecesGroups["default"])	
	Sleep(delay)
end

function explodeAnimation(delay)
	for i=1, #TablesOfPiecesGroups["Explode"] do
		if TablesOfPiecesGroups["Explode"][i] then
			Show(TablesOfPiecesGroups["Explode"][i])
		end
		if TablesOfPiecesGroups["Explode"][i-1] then
			Hide(TablesOfPiecesGroups["Explode"][i-1])
		end
		Sleep(delay)
	end
end
function script.FireWeapon1()
	StartThread(explodeAnimation,100)
    return true
end

boolMoving= false
function moveAnimationLoop()
	while true do

	while boolMoving == true do
		animateTheMove()
		Sleep(10)
	end
	idle()
	Sleep(100)

	end
end


function script.StartMoving
Signal(SIG_STOP)
boolMoving= true
end

function delayedStop()
	SetSignalMask(SIG_STOP)
	Sleep(250)
	boolMoving= false
end
function script.StopMoving()
	StartThread(delayedStop)
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

