include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
Body=piece"Body"
Hinterbein=piece"Hinterbein"
VorderBein=piece"VorderBein"
aimspot=piece"aimspot"
center=piece"center"

function script.Create()
StartThread(MoveThread)
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
end

function script.Killed(recentDamage,_)
	
	suddenDeathV(recentDamage)
	return 1
end

function MoveThread()
	while true do
		
		if boolMoving == true then
			tP(Body,-8,0,0,1.3*2)
			tP(Hinterbein,37,0,0,1.37*2)
			tP(VorderBein,22,0,0,1.37*2)
			Sleep(350)
			tP(Body,14,0,0,14*2)
			tP(Hinterbein,52,0,0, 1.15*2)
			tP(VorderBein,-77,0,0,1.99*2)
			Sleep(350)
			tP(Body,10,0,0,1.2*2)
			tP(Hinterbein,-23,0,0,1.75*2)
			tP(VorderBein,16,0,0, 1.99*2)
			Sleep(350)
			tP(Body,0,0,0,1.75*2)
			tP(Hinterbein,0,0,0,1.75*2)
			tP(VorderBein,0,0,0,1.99*2)
		else
			tP(VorderBein,-10,0,0,0.13)
			tP(Hinterbein,10,0,0,0.13)
			WMove(Body,y_axis,-1,1)
			tPrad(VorderBein,0,0,0,0.13)
			tPrad(VorderBein,0,0,0,0.13)
			tPrad(Hinterbein,0,0,0,0.13)
			WMove(Body,y_axis,0,1)
		end
		Sleep(300)
	end
	
end



----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimspot 
end



function script.QueryWeapon1() 
	return aimspot
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
	
end


function script.FireWeapon1()	
	
	return true
end



function script.StartMoving()
	boolMoving=true
end

function script.StopMoving()
	boolMoving=false
	
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

Spring.SetUnitNanoPieces(unitID,{ center})