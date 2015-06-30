	include "suddenDeath.lua"
	include "lib_OS.lua"
	include "lib_TableOp.lua"
	include "lib_Build.lua" 

	center = piece"center"

	local SIG_DELAYSTOP=4
	
	function script.StartMoving()
	boolWalk=true
	Signal(SIG_DELAYSTOP)

	end

	function delayedStop()
	SetSignalMask(SIG_DELAYSTOP)
	Sleep(500)
	boolWalk=false

	end
	
	function script.StopMoving()
			Signal(SIG_DELAYSTOP)
			StartThread(delayedStop)
			
	end

local 	boolWalk= false
local	boolAttack=false
------------------------------------------------------------------------------------UNITCODE	
function script.Create()


--DEBUG
	 ux,uy,uz=Spring.GetUnitPosition(unitID)
	Spring.MoveCtrl.Enable(unitID)
	Spring.MoveCtrl.SetPosition(unitID,ux,uy+90,uz)
--DEBUG


--center,Arm_Max,Leg_Max, Body_Double_Max,Head_Max, Deco_Max, DecoD,Body_Max, symDegFilterFunction, linDegFilterFunction)
StartThread(testThread)
end

function testThread()
while(1) do
StartThread(buildVehicle,center,AMax,LMax, DMax,HMax, DecoM, DecoD,BMax, symDegFilterFunction, linDegFilterFunction)
Sleep(30000)
end

end
	----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center 
end

function script.AimWeapon1( CockPiting ,pitch)	

	return true

end

function script.FireWeapon1()	
	return true
end

	