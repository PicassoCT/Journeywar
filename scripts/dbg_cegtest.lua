include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_TableOp.lua"
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
	
	while true do
	
	
	
	--Sleep(1500)	
	
			--	Spring.SpawnCEG("jvaryfoohit",x,y,z,0,1,0)
			--Sleep(1500)
			--	Spring.SpawnCEG("jvaryfoohit2",x,y,z,0,1,0)	
			--Sleep(1500)
			--	Spring.SpawnCEG("jvaryfootrail",x,y,z,0,1,0)	
			--Sleep(1500)
			--	Spring.SpawnCEG("jgalateatend",x,y,z,0,150,0)	
			Sleep(150)
				Spring.SpawnCEG("firefive",x,y+100,z,0,1,0,60)

		end

end

