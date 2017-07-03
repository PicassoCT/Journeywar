include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

SUCKER_RANGE= 250
LIFE_TIME_LIMITED= 10000
boolAttached=false


function attachToCorpse()
	teamID=Spring.GetUnitTeam(unitID)
	if not GG.CorpseDevourer then GG.CorpseDevourer = {} end
	if not GG.CorpseDevourer[teamID] then GG.CorpseDevourer[teamID] = {} end
	x,_,z = Spring.GetUnitPosition(unitID)
    T = getAllInCircle(x, z, range)
	CorpseTypeTable = getCorpseTypeTable()
	oneTrueCorpse = nil
	
	process(T,
		function(id)
			defID=Spring.GetUnitDefID(id)
			if CorpseTypeTable[defID] then return id end
		end,
		function(id)
			if not oneTrueCorpse and  not GG.CorpseDevourer[teamID][id] then
				GG.CorpseDevourer[teamID][id] = unitID
				oneTrueCorpse = id
			end
		end
		)
		
	return oneTrueCorpse 
end

function tryToGetCorpse()
	myCorpse = attachToCorpse()
	
	while lifetime < LIFE_TIME_LIMITED and not myCorpse do
		Sleep(1000)
		lifetime = lifetime + 1000
		myCorpse=attachToCorpse()
	end
	
	if not myCorpse then 
		Spring.DestroyUnit(unitID,true,true) 
	end
	
	myCorpsePos = getUnitPositionV(myCorpse) - getUnitPositionV(unitID) --relative)
	degTable={0,-15, 35, 15,-40, -30, -10, -10, -15, 25 	}
	spoolOut(TablesOfPiecesGroups["tentac"],degTable, myCorpsePos, startOffset)
end

function spoolOut(T, axis, degTable, myCorpsePos, startOffset, randFunc)
	resetT(T,0)
	mpV(T[#T],-1 * startOffset, 0)
	offSetIndex= 0
	
	while distance(myCorpsePos, getVectorPieceRelPos(unitID, T[1])) > 15  do
		offSetIndex= offSetIndex + 1
		mpV(T[#T],-1 * startOffset + Vector:new(0,offSetIndex * length,0), 5)
		
		currentDegree = 0
		rIndex = 0
		for i = offSetIndex, 1, -1 do
			rIndex= rIndex+1
			relativeDegree= 0
			
			if degTable[rIndex] then 
				relativeDegree= degTable[rIndex] - currentDegree + randFunc()
			end
			
			currentDegree = currentDegree + relativeDegree 
			Turn(T[i], axis, math.rad(relativeDegree),speed)
		end
		
		WaitForTurns(T)
		Sleep(50)
	end
end


 -- currentDegree = 0
        -- for i = 1, 6 do
		-- relativeDegree= 0
				-- if k % 2 == 0 then
				-- relativeDegree = math.ceil((math.cos(seconds + i * constOffset) * 25.0) - currentDegree)
				-- else
					-- relativeDegree = math.ceil((math.sin(seconds + i * constOffset) * 25.0) - currentDegree)
				-- end
				-- currentDegree = currentDegree + relativeDegree   
            -- Turn(Knees[k][i], y_axis, math.rad(relativeDegree), math.abs(relativeDegree/3))

TablesOfPiecesGroups
function script.Killed()
	teamID= Spring.GetUnitTeam(unitID)
	for id, host in pairs(	GG.CorpseDevourer[teamID]) do
		if host == unitID then
		GG.CorpseDevourer[teamID][id] = nil
		end
	end
	
	return 0
end

function script.Create()
	resetAll()
	TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
	hideT(TablesOfPiecesGroups["tentac"])
	showT(TablesOfPiecesGroups["FPod"])
	hideT(TablesOfPiecesGroups["FPod"])
	showT(TablesOfPiecesGroups["Pod"])
	spinT(TablesOfPiecesGroups["corRing"],y_axis, 5, 12, 5)
	spinT(TablesOfPiecesGroups["corRing"],x_axis, 2, 42, 5)	
	spinT(TablesOfPiecesGroups["CORE"],y_axis, 15, 42, 5)
	spinT(TablesOfPiecesGroups["CORE"],x_axis, 12, 42, 5)
    StartThread(tryToGetCorpse)

end