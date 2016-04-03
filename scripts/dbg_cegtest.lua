include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
Quader04=piece"Quader04"

function script.Create()
--generatepiecesTableAndArrayCode(unitID)
StartThread(emitSFX)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


function emitSFX()
	x,y,z=Spring.GetUnitPosition(unitID)
	modHeight=0
	i=0
	while true do
		modHeight=(modHeight%250)+10

	
	--Sleep(1500)	
	
			--	Spring.SpawnCEG("jvaryfoohit",x,y,z,0,1,0)
			--Sleep(1500)
			--	Spring.SpawnCEG("jvaryfoohit2",x,y,z,0,1,0)	
			--Sleep(1500)
			--	Spring.SpawnCEG("jvaryfootrail",x,y,z,0,1,0)	
			Sleep(1500)
				Spring.SpawnCEG("cnanotics",x,y+400,z,1,0,0,0)	
			Sleep(1500)
			randoX,randoZ=math.random(-50,50),math.random(-50,50)
				Spring.SpawnCEG("bghdexplode",x,y+400,z,0,1,0,60)
			--	Spring.SpawnCEG("citlightpillar",x,y+400,z,0,-1,0,60)

		end

end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end



function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 
