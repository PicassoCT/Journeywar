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
for i=1,6 do
sting="bone"..i
piecesTable[#piecesTable+1]=piece(sting)

end

function script.Create()
--generatepiecesTableAndArrayCode(unitID)
StartThread(iktest)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end

function echoPiecePosition(name, id)
x,y,z= Spring.GetUnitPiecePosDir(unitID,id)
Spring.Echo("Piece:"..name.." P(".. x.."/"..y.."/"..z)
end

--FOOO load the new Version
function iktest()
	Sleep(100)
		for i=1, 6 do
		stringBuild= "bone"..i
		Spring.Echo("PieceNumber for Piece"..i .." = "..(piece(stringBuild)))
		echoPiecePosition(stringBuild, (piece(stringBuild)))
		end
	
	Spring.Echo("Intialize the IK Chain")
	ikID = Spring.CreateUnitIKChain(unitID,piecesTable[1],piecesTable[6])
	Spring.Echo("UnitID".. unitID, "IkID"..ikID)
	Spring.Echo("Set IK Chain active")
	
	Spring.SetUnitIKActive(unitID, ikID, true)
	Spring.Echo("Set IK Chain is now active")
	--I add this comment only to test something
		-- static int CreateUnitIKChain(lua_State* L);
		-- static int SetUnitIKActive(lua_State* L);
		-- static int SetUnitIKGoal(lua_State* L);
		-- static int SetUnitIKPieceLimits(lua_State* L);
		--TODO adapt speed
		-- static int SetUnitIKPieceSpeed(lua_State* L);
	for i=1,#piecesTable do
		Spring.SetUnitIKPieceSpeed(ikID,piecesTable[i],0.3,0.3,0.3)
	end	
	
	while true do
		--Lol, i wrote the Api, and i dont remember it..
		ikx= math.ceil( math.random(-50,50))
		ikz= math.ceil( math.random(-50,50))
		ux,uy,uz=Spring.GetUnitPosition(unitID)
		Spring.Echo("Setting IK-Goal(X:"..ikx.."/Z:"..ikz)
		StartThread(markPosOnMap,ikx +ux,iky + uy,ikz +uz,"greenlight")		
		Spring.SetUnitIKGoal(unitID,ikID,ikx,0,ikz)
		Sleep(1000)
		
	end
end