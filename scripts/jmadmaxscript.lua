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
weaponSloT={}
			
function confVehicle()
	while true do
		resetT(pieceTable)
		--	hideT(pieceNameTable)
		Sleep(100)
		weaponSloT =   buildVehicle( center, 8, 8, 28, 4, 36, 16, 28 )	
		Move(center,y_axis,50,0)

		Sleep(10000)
		Move(center,y_axis,0,0)
	end
end

function script.Create()
	pieceNameTable = getPieceTableByNameGroups(false, true)
	
	StartThread(confVehicle)
end


--- -aimining & fire weapon
function script.AimFromWeapon(weaponID)
    if weaponSloT[weaponID] then
        return weaponSloT[weaponID].aim
    end
		return center
end

function script.QueryWeapon(weaponID)
    if weaponSloT[weaponID] then
        return weaponSloT[weaponID].firepiece
    end
		return center
end



function script.AimWeapon(weaponID, heading, pitch)
	if weaponSloT[weaponID] then
		Turn(weaponSloT[weaponID].turret,y_axis,heading, 16)
		Turn(weaponSloT[weaponID].turret,x_axis,-pitch, 16)
		WaitForTurns(weaponSloT[weaponID].turret)
		return true  
	else
		return false 
	end
end


function script.FireWeapon(weaponID)
    --Spring.Echo("FireWeapon")
    if weaponSloT[weaponID] then 
		return true 
	end
	 
	 return false
end
