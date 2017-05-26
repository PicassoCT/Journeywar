include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


center = piece "center"
local dustemit1 = piece "dustemit1"
local dustemit2 = piece "dustemit2"
local dustemit3 = piece "dustemit3"
local dustemit4 = piece "dustemit4"



SIG_WIGGLE = 1
SIG_BLINK = 2
SIG_MOVE = 4
SIG_LEGS = 8
SIG_IDLE = 16
SIG_BLINK = 32


function randTimeDelayedDustEmit(piecenr)
    x = math.random(300, 1800)
    Sleep(x)

    if maRa() == true then
        EmitSfx(piecenr, 1024)
    else
        EmitSfx(piecenr, 1027)
        Sleep(350)
    end
    xi = math.random(0, 3)
    if xi == 2 and maRa() == true then
        Sleep(350)
        EmitSfx(piecenr, 1025)
    end
end

snakeTable = {}
TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
snakeTable = TablesOfPiecesGroups["snake"]




function script.Create()
    resetT(snakeTable)
    StartThread(moveIt)

    hideT(snakeTable,1,22)
end

function dustEmits()
    if maRa() == true then
        StartThread(randTimeDelayedDustEmit, dustemit1)
    end
    if maRa() == true then
        StartThread(randTimeDelayedDustEmit, dustemit2)
    end
    if maRa() == true then
        StartThread(randTimeDelayedDustEmit, dustemit3)
    end
    if maRa() == true then
        StartThread(randTimeDelayedDustEmit, dustemit4)
    end
end

function forTheBlinkOfAnEye()
    SetSignalMask(SIG_BLINK)
	showOP = math.random(0,3)
	if showOP < 2 then
	for i=1 ,#snakeTable,1 do 
		Show(snakeTable[i])
		Sleep(150)
		if i > 5 then
		Hide(snakeTable[i]-5)
		end
	end
	elseif showOP == 2 then
		showT(snakeTable)
	elseif showOP== 3 then
		hideT(snakeTable)
	end
    
end

function snakeMovement(times, relDegTable)
    times = times + 0.05
    currentDegree = 0
    for i = 1, #snakeTable do
        --
        relativeDegree = math.ceil((math.cos(times + i * constOffset) * 65.0) - currentDegree)
        relDegTable[i] = relativeDegree
        currentDegree = currentDegree + relativeDegree
    end

    for i = 1, #snakeTable do
        Turn(snakeTable[i], y_axis, math.rad(relDegTable[i]), relDegTable[i])
    end
    return times, relDegTable
end

boolTurning = false
boolTurnLeft = false
function turnDetector()
    while true do
        Sleep(200)
        boolTurning, boolTurnLeft = compareHeading(nil, nil, 90, 40)
    end
end

function turnSnakeMovement(turnValue)

    if boolTurnLeft == true then turnValue = turnValue * -1 end
    for i = 1, #snakeTable do      
        WaitForTurn(snakeTable[i], y_axis)
        Turn(snakeTable[i], y_axis, math.rad(turnValue), turnValue)
		
    end
	
	 for i = 1, #snakeTable do      
        WaitForTurn(snakeTable[i], y_axis)
		  if boolTurning == false then break end
    end
end

coilSpeed = math.pi / 50
function moveIt()
    Sleep(350)
    echo("Move it started")
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)
    StartThread(keepAboveGround)
    StartThread(turnDetector)
    constOffset = (math.pi * 3) / #snakeTable
    times = 0
    relDegTable = {}
    accumulatedTurnValue = 0

    while true do
        if boolTurning == false then
            accumulatedTurnValue = 5
            times, relDegTable = snakeMovement(times, relDegTable)
        else
            accumulatedTurnValue = math.min(50, accumulatedTurnValue + accumulatedTurnValue)
            turnSnakeMovement(accumulatedTurnValue)
        end
        Sleep(100)
    end
end

function updateChangeRate(boolNewOverground, boolLastOverground, changeRate)
    if boolNewOverground == true and boolLastOverground == false then changeRate = -1; return changeRate, boolNewOverground end
    if boolNewOverground == false and boolLastOverground == true then changeRate = 1; return changeRate, boolNewOverground end

    return changeRate * 1.025, boolNewOverground
end

upSpeed = 6
downSpeed = 0.7
function keepAboveGround()
    local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
    local spGetSmoothMeshHeight = Spring.GetSmoothMeshHeight
    local lastDeg = {}
    for i = 1, #snakeTable do lastDeg[i] = { deg_ = 0, changeRate = 1, boolLastOverground = true } end

    while true do
	 if math.random(0,25) == 10 then
	  for i = 1, #snakeTable - 7 do
			hideT(snakeTable,1, 22)
			WTurn(snakeTable[i], x_axis, math.rad(0), 0.1)
	  end
	 end
        for i = 1, #snakeTable - 7 do
            px, py, pz = spGetUnitPiecePosDir(unitID, snakeTable[i + 4])
            gh = spGetSmoothMeshHeight(px, py)

            boolNewOverground = (math.abs((py + 9000 - gh) - 9000) > 150)

            lastDeg[i].changeRate, lastDeg[i].boolLastOverground = updateChangeRate(boolNewOverground, lastDeg[i].boolLastOverground, lastDeg[i].changeRate)
            lastDeg[i].deg_ = math.max(0, math.min(23, lastDeg[i].deg_ + lastDeg[i].changeRate / (#snakeTable - i)))

            WTurn(snakeTable[i], x_axis, math.rad(lastDeg[i].deg_), 0.1)
        end
		
		for i =  #snakeTable - 7, #snakeTable do
		 WTurn(snakeTable[i], x_axis, math.rad(15), 0.1)
		end
        Sleep(1000)
    end
end

function script.StartMoving()
    Signal(SIG_BLINK)
    StartThread(forTheBlinkOfAnEye)

    StartThread(moveIt)
end

function idleFromScratch(signum)
    signum = signum or 1
    Signal(SIG_IDLE)
    SetSignalMask(SIG_IDLE)
    while true do
        Sleep(3000)
			Signal(SIG_MOVE)
        scratchrand = 0.1
        showT(snakeTable)
        rVal = math.random(-2, 2)
        for i = 2, #snakeTable do
            val = (50 - (#snakeTable - i)) * signum
            Turn(snakeTable[i], y_axis, math.rad(val), scratchrand) --+ (sign*(#snakeTable-i)/10) + sign*rVal
            if i < 24 then
                Turn(snakeTable[i], x_axis, math.rad(10), scratchrand)
            elseif i > 23 then
                Turn(snakeTable[i], x_axis, math.rad(35), scratchrand)
            end
        end
        Turn(snakeTable[1], z_axis, math.rad(-10), scratchrand)


        for i = 1, #snakeTable do
            WaitForTurns(snakeTable[i], y_axis)
        end
        naptime = math.random(9000, 19999)
        Sleep(naptime)
       	hideT(snakeTable,1, 22)
    end
end



function script.StopMoving()

    StartThread(idleFromScratch, randSign())
end




function script.Killed(recentDamage, maxHealth)

    return 1
end