include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"


function script.Create()
	--generatepiecesTableAndArrayCode(unitID)
	--TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	StartThread(releaseTimer)
end

function releaseTimer()
_,_,_,_,BuildProgress  = Spring.GetUnitHealth(unitID)
	while BuildProgress < 1 do
		_,_,_,_,BuildProgress = Spring.GetUnitHealth(unitID)
		Sleep(1000)
	end

	boolSunshipActivateable=true
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end



function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	
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

boolSunshipActivateable=false
function script.Activate()
	if boolSunshipActivateable == true then
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID= Spring.GetUnitTeam(unitID)
		if x and teamID then
		Spring.Echo("Give birth")
		id=Spring.CreateUnit("jsunshipfire", x, y, z, 1, teamID)
			if id then
			Spring.Echo("Die off")
			Spring.DestroyUnit(unitID,true,true) end
		end
	end
return 1
end

function script.Deactivate()


return 0
end

function script.QueryBuildInfo() 
  return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})

