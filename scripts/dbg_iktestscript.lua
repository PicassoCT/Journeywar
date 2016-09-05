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
for i=1,5 do
sting="bone"..i
piecesTable[#piecesTable+1]=piece(sting)
pieceNameTable[sting]=piecesTable[#piecesTable]
end

function script.Create()
--generatepiecesTableAndArrayCode(unitID)
StartThread(iktest)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

function iktest()
	ikID= Spring.CreateUnitIkChain(unitID,pieceNameTable["bone1"],pieceNameTable["bone5"])
	while true do
	--Lol, i wrote the Api, and i dont remember it..
	Spring.SetUnitIKChain(ikID, true, math.random(-100,100),math.random(-100,100),25)
	Sleep(100)
	end
end