
include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 



function script.Create()
StartThread(WaitForBuilding)

end

function WaitForBuilding()
Sleep(100)
health,  maxHealth,  paralyzeDamage,  captureProgress,  buildProgress=Spring.GetUnitHealth(unitID)
	while (buildProgress and buildProgress < 1.0) do
	--Spring.Echo("JLTReeSpawn:"..buildProgress)
health,  maxHealth,  paralyzeDamage,  captureProgress,  buildProgress=Spring.GetUnitHealth(unitID)
	Sleep(100)
	end

team=Spring.GetUnitTeam(unitID)
x,y,z=Spring.GetUnitPosition(unitID)
id=Spring.CreateUnit("jtree4"..(math.random(1,7)),x,y,z,1,team,fals,false)

	while not id or Spring.GetUnitIsDead(id)==true do
	id=Spring.CreateUnit("jtree4"..(math.random(1,7)),x,y,z,1,team,fals,false)
	end
	
	
Spring.DestroyUnit(unitID,false,true)

end

function script.Killed(recentDamage,_)


return 1
end
