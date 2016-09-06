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
--FOOO load the new Version
function iktest()
	Spring.Echo("Intialize the IK Chain")
	ikID= Spring.CreateUnitIKChain(unitID,pieceNameTable["bone1"],pieceNameTable["bone5"])
	Spring.Echo("Set IK Chain active")
	Spring.SetUnitIKActive(ikID, true)
		-- static int CreateUnitIKChain(lua_State* L);
		-- static int SetUnitIKActive(lua_State* L);
		-- static int SetUnitIKGoal(lua_State* L);
		-- static int SetUnitIKPieceLimits(lua_State* L);
		--TODO adapt speed
		-- static int SetUnitIKPieceSpeed(lua_State* L);
		
	while true do
		--Lol, i wrote the Api, and i dont remember it..
		Spring.Echo("Setting IK-Goal")
		Spring.SetUnitIKGoal(unitID,ikID, math.random(-100,100), math.random(-100,100),25)
		
		Sleep(1000)
	end
end