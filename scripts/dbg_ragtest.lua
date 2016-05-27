include "suddenDeath.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

 include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

piecesTable={}
pieceNameTable={}
for i=1,8 do
sting="a"..i
piecesTable[#piecesTable+1]=piece(sting)
pieceNameTable[sting]=piecesTable[#piecesTable]
end

function script.Create()
--generatepiecesTableAndArrayCode(unitID)
StartThread(loopingRagDoll)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

function loopingRagDoll()

local pTable=recursiveAddTable({},piecesTable[1],center,pieceNameTable)
	while true do
	Sleep(5000)
	ragDoll(pTable,piecesTable[1],9.81, 35000)
	Sleep(3000)
	resetT(piecesTable)
	
	end
end



