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
	ikID= Spring.CreateUnitIKChain(unitID,pieceNameTable["bone1"],pieceNameTable["bone5"])
	Spring.SetUnitIKActive(ikID, true)
			-- static int CreateUnitIKChain(lua_State* L);

		-- static int SetUnitIKActive(lua_State* L);

		-- static int SetUnitIKGoal(lua_State* L);

		-- static int SetUnitIKPieceLimits(lua_State* L);

		-- static int SetUnitIKPieceSpeed(lua_State* L);
	for pieceid,v in pairs(pieceNameTable) do
		if type(pieceid)== number then
		Spring.SetUnitIKGoal(unitID,ikID,v, 0.1,0.2,0.3)
		end
	end
		
	while true do
		--Lol, i wrote the Api, and i dont remember it..
		Spring.SetUnitIKGoal(unitID,ikID, math.random(-100,100),math.random(-100,100),25)
		Sleep(1000)
	end
end