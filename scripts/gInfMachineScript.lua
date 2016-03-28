include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"
 include "lib_Build.lua" 

 pieceTable={}
 for i=1, 80, 1 do
 name="p"..i
 pieceTable[#pieceTable+1]=piece(name) 
 end
center=piece"center"

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end

function rebuildThread()

	while true do
				
	StartThread(buildInfernalMachine,center, 16, pieceTable)
	Sleep(10000)
	reseT(pieceTable)
	end

end


function script.Create()
StartThread(rebuildThread)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

