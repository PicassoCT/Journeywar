include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

center = piece "center"
pieceTable = generatepiecesTableAndArrayCode(unitID, false)
pieceNameTable = {}
local SIG_DELAYSTOP = 4

function script.StartMoving()
    boolWalk = true
    Signal(SIG_DELAYSTOP)
end

function delayedStop()
    SetSignalMask(SIG_DELAYSTOP)
    Sleep(500)
    boolWalk = false
end

function script.StopMoving()
    Signal(SIG_DELAYSTOP)
    StartThread(delayedStop)
end

local boolWalk = false
local boolAttack = false
------------------------------------------------------------------------------------ UNITCODE
function confVehicle()
    resetT(pieceTable)
	--	hideT(pieceNameTable)
    Sleep(100)
    StartThread(buildVehicle, center, 0, 7, 28, 4, 36, 0, 28 )	
end

function script.Create()
	pieceNameTable = makePiecesTablesByNameGroups(false, true)

    --DEBUG
    ux, uy, uz = Spring.GetUnitPosition(unitID)
	Spring.MoveCtrl.Enable(unitID,true)
	Spring.MoveCtrl.SetPosition(unitID, ux, uy+70, uz)
	
	
	StartThread(confVehicle)
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return center
end

function script.QueryWeapon1()
    return center
end

function script.AimWeapon1(heading, pitch)

    return true
end

function script.FireWeapon1()
    return true
end