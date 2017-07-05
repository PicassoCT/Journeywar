include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

SUCKER_RANGE = 250
LIFE_TIME_LIMITED = 100000
boolAttached = false
LENGTHOFPIECE = 10

function attachToCorpse()
    teamID = Spring.GetUnitTeam(unitID)
    if not GG.CorpseDevourer then GG.CorpseDevourer = {} end
    if not GG.CorpseDevourer[teamID] then GG.CorpseDevourer[teamID] = {} end
    x, _, z = Spring.GetUnitPosition(unitID)
    T = getAllInCircle(x, z, SUCKER_RANGE)
    CorpseTypeTable = getCorpseTypeTable()
    oneTrueCorpse = nil

    process(T,
        function(id)
            defID = Spring.GetUnitDefID(id)
            if CorpseTypeTable[defID] then return id end
        end,
        function(id)
            if not oneTrueCorpse and not GG.CorpseDevourer[teamID][id] then
                GG.CorpseDevourer[teamID][id] = unitID
                oneTrueCorpse = id
            end
        end)

    return oneTrueCorpse
end

function retractTentacle()
    waveValue = 0
    fullCircle = math.pi * 2
    speed = 14

    for i = #TablesOfPiecesGroups["tentac"], 1 do
     
        waveValue = waveValue + math.pi / 8
        retractPiece = TablesOfPiecesGroups["tentac"][i]
        for k = i, 1 do
            tP(TablesOfPiecesGroups["tentac"][k], math.cos(waveValue * k) * fullCircle, 0, 0, speed / 10)
        end
        reset(retractPiece, speed)
        WaitForTurns(retractPiece)
		  WMove(TablesOfPiecesGroups["tentac"][#TablesOfPiecesGroups["tentac"]], y_axis,LENGTHOFPIECE*i,22)
    end
end
function moveCoreUpAndDown()
while true do
WMove(Core,y_axis,math.random(0,1),3)
WMove(Core,y_axis,math.random(-4,-2),3)

end
end
teamID=Spring.GetUnitTeam(unitID)
function tryToGetCorpse()
	lifetime=0

    myCorpse = attachToCorpse()
		x,y,z= Spring.GetUnitPosition(unitID)
	 myCorpse = Spring.CreateUnit("cegtest",x,y,z+200,1,teamID)

    while lifetime < LIFE_TIME_LIMITED and not myCorpse do
        Sleep(1000)
        lifetime = lifetime + 1000
        myCorpse = attachToCorpse()
    end

    if  myCorpse == nil then
			retractTentacle()
			Spring.DestroyUnit(unitID, true, true)
			return 
    end

    myCorpsePos = getUnitPositionV(myCorpse) - getUnitPositionV(unitID) --relative)
	  echo("corpsepos")
	  echoT( myCorpsePos)
     degTable = { 0, -15, 35, 15, -40, -30, -10, -10, -15, 25 }

    spoolOut(TablesOfPiecesGroups["tentac"], x_axis, degTable, myCorpsePos, LENGTHOFPIECE*#TablesOfPiecesGroups["tentac"] )
end

function spoolOut(T, axis, degTable, myCorpsePos, startOffset, randFunc, myCorpseID)
    resetT(T, 0)
		WMove(TablesOfPiecesGroups["tentac"][#TablesOfPiecesGroups["tentac"]], y_axis,LENGTHOFPIECE*#TablesOfPiecesGroups["tentac"],0)
	 hideT(TablesOfPiecesGroups["tentac"])

    Move(T[#T],y_axis, -1* startOffset, 0)
	 Show(T[1])
    offSetIndex = 0
    seconds = 0
    constOffset = (math.pi * 2)
		echoT(getVectorPieceRelPos(unitID, T[1]))
    while distance(myCorpsePos, getVectorPieceRelPos(unitID, T[1])) > 15 do
        offSetIndex = math.min(offSetIndex + 1, #degTable)
        mPV(T[#T], -1 * startOffset + Vector:new(0, offSetIndex * LENGTHOFPIECE, 0), 5)

        currentDegreeX = 0
        currentDegreeZ = 0
        rIndex = 0

        for i = offSetIndex, math.max(1, offSetIndex - degTable), -1 do
				Show(T[i])
            rIndex = rIndex + 1
            relativeDegreeX = 0

            if degTable[rIndex] then
                relativeDegreeX = degTable[rIndex] - currentDegreeX + randFunc()
            end

            currentDegreeX = currentDegreeX + relativeDegreeX

            relativeDegreeZ = math.ceil((math.sin(seconds + i * constOffset / offSetIndex) * 25.0) - currentDegreeZ)
            currentDegreeZ = currentDegreeZ + relativeDegreeZ
            tSyncIn(T[i], relativeDegreeX, 0, relativeDegreeZ, 50, UnitScript)
        end

        freeRoot = math.max(1, offSetIndex - degTable)
        for i = freeRoot, 1, -1 do
            --Turn towards Unit specified if last table
            if (i == freeRoot) then
                ax, ay, az = math.rad(-currentDegreeX), 0, math.rad(currentDegreeZ)
                tSyncIn(T[i], ax, ay, az, 50, UnitScript)
                TurnPieceTowardsUnit(T[i], myCorpseID, 0.5, Vector:new(ax, ay, az))
            else -- zero
                relativeDegreeZ = math.ceil((math.sin(seconds + i * constOffset / offSetIndex) * 25.0) - currentDegreeZ)
                currentDegreeZ = currentDegreeZ + relativeDegreeZ

                tSyncIn(T[i], math.random(-5, 5), 0, relativeDegreeZ, 50, UnitScript)
            end
        end
        WaitForTurns(T)

        Sleep(50)
        seconds = seconds + 50 / 1000
    end

    StartThread(buildAnimation)
end

BUILD_TIME = 22000
function buildAnimation()
    spendTime = BUILD_TIME
    RESTTIME = 3000
    milliSecondsInSecond = 1000
		GlobIndex=0
    while spendTime > 0 do
        GlobIndex = inc(GlobIndex)
        StartThread(followPath,
            unitID,
            TablesOfPiecesGroups["travelling"][(GlobIndex % 3) + 1],
            TablesOfPiecesGroups["tentac"],
            (10 * #TablesOfPiecesGroups["tentac"]) / (RESTTIME * #TablesOfPiecesGroups["travelling"]) / milliSecondsInSecond,
            0,
            true)

        showT(TablesOfPiecesGroups["FPod"], 1, (spendTime / BUILD_TIME) * (#TablesOfPiecesGroups["FPod"]))
        Sleep(RESTTIME)
    end
end


TablesOfPiecesGroups ={}
function script.Killed()
teamID = Spring.GetUnitTeam(unitID)
for id, host in pairs(GG.CorpseDevourer[teamID]) do
    if host == unitID then
        GG.CorpseDevourer[teamID][id] = nil
    end
end

return 0
end

Core = piece"CORE"
function script.Create()
	resetAll(unitID)
	TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
	hideT(TablesOfPiecesGroups["travelling"])
	hideT(TablesOfPiecesGroups["tentac"])
	showT(TablesOfPiecesGroups["FPod"])
	hideT(TablesOfPiecesGroups["FPod"])
	showT(TablesOfPiecesGroups["Pod"])

	for i=1, #TablesOfPiecesGroups["corRing"] do
		StartThread(shiverOS, TablesOfPiecesGroups["corRing"][i],0,2,0,2,0,2, 1)
	end
	spinT(TablesOfPiecesGroups["corRing"], z_axis, 5, 12, 25)
	spinT(TablesOfPiecesGroups["corRing"], x_axis, 2, 6, 12)
	spinT(TablesOfPiecesGroups["corRing"], x_axis, 2, 6, 12)
	Spin(Core, y_axis, math.rad( 15), 65)
	Spin(Core, z_axis, math.rad( 42), 65)
	
	for i=1, #TablesOfPiecesGroups["FPod"] do
		StartThread(wiggleOS, TablesOfPiecesGroups["FPod"][i],3,6,3,6,3,6, 5)
	end
	for i=1, #TablesOfPiecesGroups["Pod"] do
		StartThread(wiggleOS, TablesOfPiecesGroups["Pod"][i],-12,12,-16,16,-16,16, 5)
	end
	hideT(TablesOfPiecesGroups["tentac"])
	StartThread(moveCoreUpAndDown)
	StartThread(tryToGetCorpse)
end