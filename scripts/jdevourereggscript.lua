include "createCorpse.lua"
include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

SUCKER_RANGE = 250
LIFE_TIME_LIMITED = 100000
boolAttached = false
LENGTHOFPIECE = 10
    CorpseTypeTable = getCorpseTypeTable()
	
function attachToCorpse()
    teamID = Spring.GetUnitTeam(unitID)
    if not GG.CorpseDevourer then GG.CorpseDevourer = {} end
    if not GG.CorpseDevourer[teamID] then GG.CorpseDevourer[teamID] = {} end
    x, _, z = Spring.GetUnitPosition(unitID)
    T = getAllInCircle(x, z, SUCKER_RANGE)

    oneTrueCorpse = nil
	
    T = process(T,
        function(id)
            defID = Spring.GetUnitDefID(id)
            if CorpseTypeTable[defID] then return id end
        end,
        function(id)
            if not oneTrueCorpse and not GG.CorpseDevourer[teamID][id] then
                GG.CorpseDevourer[teamID][id] = unitID
                oneTrueCorpse = id
					return id
				end
        end)

    return oneTrueCorpse
end

function turnTowardsVictim()
	if not myCorpseID or myCorpseID == -math.huge then return end
	
	cx,cy,cz= Spring.GetUnitPosition(myCorpseID)
	ux,uy,uz= Spring.GetUnitPosition(unitID)
	cx,cy,cz = ux- cx, uy-cy, uz-cz
	degree = 180 + math.floor(math.atan2(cx, cz)*(180/math.pi))
	Turn(tentaclecenter, y_axis, math.rad(degree),0)

end

function retractTentacle()
    waveValue = 0
    fullCircle = math.pi * 2
    speed = 6

    for i = offSetselector, 1,-1 do

        waveValue = waveValue + math.pi / 8
        retractPiece = TablesOfPiecesGroups["tentac"][i]
		tP(retractPiece,0,0,0,speed)
        for k = i+1, 1,-1 do
			if TablesOfPiecesGroups["tentac"][k] then
            tP(TablesOfPiecesGroups["tentac"][k],  math.sin(waveValue * k) * fullCircle, math.cos(waveValue * k) * fullCircle, 0, speed )
			end
        end
		mSyncIn(TablesOfPiecesGroups["tentac"][#TablesOfPiecesGroups["tentac"]],0,-1* (#TablesOfPiecesGroups["tentac"]-i) * LENGTHOFPIECE,0, 1)		
		WaitForTurns(TablesOfPiecesGroups["tentac"])
		WaitForMoves(TablesOfPiecesGroups["tentac"][#TablesOfPiecesGroups["tentac"]])
    end
end

function moveCoreUpAndDown()

    while true do
        WMove(Core, y_axis, math.random(0, 1), 3)
			Sleep(10)
        WMove(Core, y_axis, math.random(-4, -2), 3)
    end
end
SIG_SUCK = 2
tentaclecenter= piece"tentaclecenter"
lifetime = 0
myCorpseID = -math.huge
   degTable = {}
    for i = 1, 3 do
        degTable[i] = -90 / 3
    end
    for i = 4, 12 do
        degTable[i] = 180 / 8
    end
    degTable[#degTable + 1] = 15
	
function tryToGetCorpse()

while true do
    repeat 
        Sleep(1000)
        lifetime = lifetime + 1000
        myCorpseID = attachToCorpse()

    until lifetime > LIFE_TIME_LIMITED or Spring.ValidUnitID(myCorpseID) == true 

    if lifetime > LIFE_TIME_LIMITED or  Spring.ValidUnitID(myCorpseID) == false  then
        retractTentacle()
        Spring.DestroyUnit(unitID, true, true)
    end
		
	turnTowardsVictim()
   boolSuccesfullDeployed = spoolOut(TablesOfPiecesGroups["tentac"], x_axis, degTable, LENGTHOFPIECE * #TablesOfPiecesGroups["tentac"], myCorpseID, degTable)

		if boolSuccesfullDeployed == true then
			buildAndDeployTroops()
			Spring.DestroyUnit(myCorpseID, true, true)
			Spring.DestroyUnit(unitID, true, true)
		else
				retractTentacle()
				initialPose()
		end
	end

end

function buildAndDeployTroops()
	rest =math.ceil(BUILD_TIME/100)
	for i=1,100 do
		Sleep(rest)
		progress = i/100
	showT(TablesOfPiecesGroups["FPod"],1,math.ceil(progress*#TablesOfPiecesGroups["FPod"]))
		
	end
	Sleep(3000)

	for i=1, #TablesOfPiecesGroups["FPod"] do
		Sleep(1000)
		createUnitAtPiece(unitID, UnitDefNames["jskinfantry"].id, TablesOfPiecesGroups["FPod"][i])
		Explode(TablesOfPiecesGroups["FPod"][i], SFX.SHATTER)
		Hide(TablesOfPiecesGroups["FPod"][i])
	end

end
    offSetselector = 0
function spoolOut(T, axis, degTable, startOffset, myCorpseID, degTable)
	 if type(myCorpseID)~= "number" or Spring.ValidUnitID(myCorpseID) == false or Spring.GetUnitIsDead(myCorpseID) == true then return end
    showT(TablesOfPiecesGroups["tentac"]) --delMe

    resetT(T, 0)

    WaitForMoveAllAxis(TablesOfPiecesGroups["tentac"][#TablesOfPiecesGroups["tentac"]], y_axis, startOffset * -1, 0)
    hideT(TablesOfPiecesGroups["tentac"])

    Show(T[1])

    seconds = 0
    constOffset = (math.pi * 2)
    zWavefactor = 1
    offSetselector = 0
		
	mP(T[#T], 0,  -1 * startOffset + (offSetselector) * LENGTHOFPIECE , 0, 0)
	WaitForMoves(T[#T])

    while zWavefactor > 0.1 do
			if Spring.GetUnitIsDead(myCorpseID) == true or distanceUnitToUnit(unitID, myCorpseID) > SUCKER_RANGE*0.75 then
				return false
			end

        if distancePieceToUnit(unitID, T[1], myCorpseID) < 65 then
            zWavefactor = zWavefactor * 0.74
        end


        offSetselector = math.min(offSetselector + 1, #T - 1)

		
		
      local  position = Vector:new(0, 0, 0)
        position.y = -1 * startOffset + (offSetselector) * LENGTHOFPIECE
		syncMove(T[#T], position.x, position.y, position.z, 20)
		
        currentDegreeX = 0
        currentDegreeZ = 0
        rselector = 0

        selectorStart = math.min(offSetselector, #T)
        selectorEnd = math.max(1, selectorStart - #degTable)
        showT(T, 1, selectorStart)

        for i = selectorStart, selectorEnd, -1 do

            rselector = rselector + 1
            relativeDegreeX = 0
            if degTable[rselector] then
                relativeDegreeX = degTable[rselector] - currentDegreeX
            end
            relativeDegreeZ = math.ceil((math.sin(seconds + i * constOffset / offSetselector) * 25.0) - currentDegreeZ)
            currentDegreeZ = currentDegreeZ + relativeDegreeZ

            if rselector >= #degTable then
                currentDegreeX = 0
                relativeDegreeX = 0
            end

            tSyncIn(T[i], relativeDegreeX, 0, relativeDegreeZ * zWavefactor, 500, Spring.UnitScript)
        end

        for i = selectorEnd, 1, -1 do
            relativeDegreeZ = math.ceil((math.sin(seconds + i * constOffset / offSetselector) * 25.0) - currentDegreeZ)
            currentDegreeZ = currentDegreeZ + relativeDegreeZ
            tSyncIn(T[i], 0, 0, relativeDegreeZ * zWavefactor, 500, Spring.UnitScript)
        end

        Sleep(500)
        seconds = seconds + 500 / 1000
    end
	index= 0
	for k,v in pairs(	TablesOfPiecesGroups["travelling"]) do
	index= inc(index)
    StartThread(buildAnimation, index, v)
	end
	  StartThread(PlaySoundByUnitDefID, Spring.GetUnitDefID(unitID), "sounds/jdevoureregg/suck.ogg", 0.5, 6000, 1, 0)
		return true

end
progress= 0
BUILD_TIME = 50000
function buildAnimation(selector, pieceName)
	 local selector = selector
    spendTime = BUILD_TIME
    RESTTIME = 3000

    Sleep((selector-1) * 3000 +1)
    while true do
        Hide(pieceName)

        movePieceToPiece(unitID,
            pieceName,
            TablesOfPiecesGroups["tentac"][1],
            0,
				{x=0,y=0,z=0},
				true)
			Sleep(10)
        WaitForMove(pieceName,x_axis)
        WaitForMove(pieceName,y_axis)
        WaitForMove(pieceName,z_axis)
		
        Show(pieceName)
        t = Spring.GetUnitPieceInfo(unitID, pieceName)

        followPath(unitID,
            pieceName,
            TablesOfPiecesGroups["tentac"],
            25,
            5,
            true,
            true,
            { x = 0, y = 0, z = 0 })
           -- { x = -t.offset[1], y = -t.offset[2], z = -t.offset[3] })

        WaitForMove(pieceName,x_axis)
        WaitForMove(pieceName,y_axis)
        WaitForMove(pieceName,z_axis)
			Hide(pieceName)
        Sleep(RESTTIME)
    end
end

TablesOfPiecesGroups = {}
function script.Killed()
	Signal(SIG_KILLED)
    teamID = Spring.GetUnitTeam(unitID)
    for id, host in pairs(GG.CorpseDevourer[teamID]) do
        if host == unitID then
            GG.CorpseDevourer[teamID][id] = nil
        end
    end
	retractTentacle()
	explodeT(TablesOfPiecesGroups["FPod"], SFX.FALL +SFX.SHATTER+SFX.NO_HEATCLOUD)
    return 0
end

function initialPose()
 resetAll(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
    hideT(TablesOfPiecesGroups["travelling"])
    hideT(TablesOfPiecesGroups["tentac"])
    showT(TablesOfPiecesGroups["FPod"])
    hideT(TablesOfPiecesGroups["FPod"])
    showT(TablesOfPiecesGroups["Pod"])

    for i = 1, #TablesOfPiecesGroups["corRing"] do
		StartThread(shiverOS, TablesOfPiecesGroups["corRing"][i], 0, 2, 0, 2, 0, 2, 1)
    end
    spinT(TablesOfPiecesGroups["corRing"], z_axis, 5, 12, 25)
    spinT(TablesOfPiecesGroups["corRing"], x_axis, 2, 6, 12)
    spinT(TablesOfPiecesGroups["corRing"], x_axis, 2, 6, 12)
    Spin(Core, y_axis, math.rad(15), 65)
    Spin(Core, z_axis, math.rad(42), 65)


end
SIG_KILLED= 4
function initialization()
	SetSignalMask(SIG_KILLED)
	 initialPose()
	delayTillComplete(unitID)
    for i = 1, #TablesOfPiecesGroups["FPod"] do
        StartThread(wiggleOS, TablesOfPiecesGroups["FPod"][i], 3, 6, 3, 6, 3, 6, 5)
    end
    for i = 1, #TablesOfPiecesGroups["Pod"] do
        StartThread(wiggleOS, TablesOfPiecesGroups["Pod"][i], -12, 12, -16, 16, -16, 16, 5)
    end
    hideT(TablesOfPiecesGroups["tentac"])
    StartThread(moveCoreUpAndDown)
    StartThread(tryToGetCorpse)
end

Core = piece "CORE"
function script.Create()
    StartThread(initialization)
end