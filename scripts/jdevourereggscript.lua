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

function retractTentacle()
	waveValue= 0
	fullCircle= math.pi * 2
	speed= 14
	
	for i=#TablesOfPiecesGroups["tentac"], 1 do
		waveValue= waveValue + math.pi/8
		retractPiece=  TablesOfPiecesGroups["tentac"][i]
			for k=i, 1 do
				tP(TablesOfPiecesGroups["tentac"][k],math.cos(waveValue*k)* fullCircle, 0 ,0 , speed/10)
			end
		reset(retractPiece, speed)
		WaitForTurns(retractPiece)
	end
end

function tryToGetCorpse()
	myCorpse = attachToCorpse()
	
	while lifetime < LIFE_TIME_LIMITED and not myCorpse do
		Sleep(1000)
		lifetime = lifetime + 1000
		myCorpse=attachToCorpse()
	end
	
	if not myCorpse then 
		retractTentacle()
		Spring.DestroyUnit(unitID,true,true) 
	end
	
	myCorpsePos = getUnitPositionV(myCorpse) - getUnitPositionV(unitID) --relative)
	degTable={0,-15, 35, 15,-40, -30, -10, -10, -15, 25 	}
	spoolOut(TablesOfPiecesGroups["tentac"],degTable, myCorpsePos, startOffset)
end

function spoolOut(T, axis, degTable, myCorpsePos, startOffset, randFunc, myCorpseID)
	resetT(T,0)
	mpV(T[#T],-1 * startOffset, 0)
	offSetIndex= 0
	seconds = 0
	constOffset = (math.pi * 2) 
	
	while distance(myCorpsePos, getVectorPieceRelPos(unitID, T[1])) > 15  do
		offSetIndex= math.min(offSetIndex + 1, #degTable)
		mpV(T[#T],-1 * startOffset + Vector:new(0,offSetIndex * length,0), 5)
		
		currentDegreeX = 0
		currentDegreeZ = 0
		rIndex = 0

		for i = offSetIndex, math.max(1,offSetIndex - degTable), -1 do
			rIndex= rIndex + 1
			relativeDegreeX = 0

			if degTable[rIndex] then 
				relativeDegreeX= degTable[rIndex] - currentDegreeX + randFunc()
			end
			
			currentDegreeX = currentDegreeX + relativeDegreeX 
			
			relativeDegreeZ = math.ceil((math.sin(seconds + i * constOffset/offSetIndex) * 25.0) - currentDegreeZ)
			currentDegreeZ = currentDegreeZ + relativeDegreeZ 
			tSyncIn(T[i], relativeDegreeX, 0, relativeDegreeZ, 50, UnitScript)
		end		

		freeRoot = math.max(1,offSetIndex - degTable)
		for i= freeRoot, 1, - 1 do
			--Turn towards Unit specified if last table
				if (i == freeRoot) then
					ax, ay ,az = math.rad(-currentDegreeX), 0, math.rad(currentDegreeZ)
					tSyncIn(T[i], ax, ay, az, 50, UnitScript)
					TurnPieceTowardsUnit(T[i], myCorpseID, 0.5, Vector:new(ax,ay,az))
				else -- zero
					relativeDegreeZ = math.ceil((math.sin(seconds + i * constOffset/offSetIndex) * 25.0) - currentDegreeZ)
					currentDegreeZ = currentDegreeZ + relativeDegreeZ 
				
					tSyncIn(T[i], math.random(-5,5), 0, relativeDegreeZ, 50, UnitScript)
				end
		end
		WaitForTurns(T)	
		
		Sleep(50)
		seconds= seconds + 50/1000
	end
	
	StartThread(buildAnimation)
end

BUILD_TIME = 22000
function buildAnimation ()
spendTime = BUILD_TIME
RESTTIME = 3000
milliSecondsInSecond= 1000

	while spendTime > 0 do
		GlobIndex= inc(GlobIndex)
		StartThread(followPath,
					unitID, 
					TablesOfPiecesGroups["travelling"][(GlobIndex%3)+1]			, 
					pathTable, 
					(10 * #TablesOfPiecesGroups["tentac"])/(RESTTIME * #TablesOfPiecesGroups["travelling"])/milliSecondsInSecond,
					0,
					true)
					
		showT(TablesOfPiecesGroups["FPod"],1,(spendTime/BUILD_TIME)*(#TablesOfPiecesGroups["FPod"]))
		Sleep(RESTTIME)
	end
end


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