
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 



function script.Create()
	
	--<buildanimationscript>
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID=Spring.GetUnitTeam(unitID)
	GG.UnitsToSpawn:PushCreateUnit("cbuildanimation",x,y,z,0,teamID)
	
	
	--</buildanimationscript>
	
	StartThread(speachHolder)
end

function speachHolder()
	local unitDefID=Spring.GetUnitDefID(unitID)
	
	while(true) do
		
		speach=math.random(0,9)
		if speach== 1 then
			PlaySoundByUnitType(unitDefID,"sounds/ccampole/speecha.wav",1,9000,0.1)
		elseif speach == 2 then
			PlaySoundByUnitType(unitDefID,"sounds/ccampole/speechb.wav",1,9000,0.1)
		elseif speach == 3 then
			PlaySoundByUnitType(unitDefID,"sounds/ccampole/speechc.wav",1,9000,0.1)
		elseif speach == 4 then
			PlaySoundByUnitType(unitDefID,"sounds/ccampole/speechd.wav",1,9000,0.1)
		elseif speach ==5 then
			PlaySoundByUnitType(unitDefID,"sounds/ccampole/speeche.wav",1,9000,0.1)
			
		else 
			
			--do nothing
		end
		Sleep(15000)
		well=math.random(80000,180000)
		Sleep(well)
	end
	
end
function script.Killed()
	
end