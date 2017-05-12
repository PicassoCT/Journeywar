include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


--modified stridercode
--Define the pieces of the weapon
strider = piece "strider"
automg = piece "automg"
flare1 = piece "flare01"
flare2 = piece "flare02"
striderlegA = piece "striderleg" --2
striderlegB = piece "striderle1"
striderlegC = piece "striderle0"

striderlegA2 = piece "striderle4" --3
striderlegB2 = piece "striderle2"
striderlegC2 = piece "striderle3"

striderlegA3 = piece "striderle7" --1
striderlegB3 = piece "striderle5"
striderlegC3 = piece "striderle6"
deathpivot = piece "deathpivot"

Sens1 = piece "Sens1"
Sens2 = piece "Sens2"
Sens3 = piece "Sens3"

relPos1 = piece "relPos1"
relPos2 = piece "relPos2"
relPos3 = piece "relPos3"

center1 = piece "center1"
center2 = piece "center2"
center3 = piece "center3"
--define other pieces

pOrg1 = piece "pOrg1"
pOrg2 = piece "pOrg2"
pOrg3 = piece "pOrg3"

LegOrg1 = piece "LegOrg1"
LegOrg2 = piece "LegOrg2"
LegOrg3 = piece "LegOrg3"

turnSpeed = 1
PI2 = 6.1831853071795
PI = 3.14159

local StriTable = {
    [1] = {
        UpLeg = striderlegA3, --1
        Leg = striderlegB3,
        LowLeg = striderlegC3,
        UpOrg = pOrg1
    },
    [2] = {
        UpLeg = striderlegA, --2
        Leg = striderlegB,
        LowLeg = striderlegC,
        UpOrg = pOrg2
    },
    [3] = {
        UpLeg = striderlegA2, --3
        Leg = striderlegB2,
        LowLeg = striderlegC2,
        UpOrg = pOrg3
    }
}

SIG_WALK = 1 --signal for the walk animation thread
SIG_AIM = 2 --signal for the weapon aiming thread
SIG_F1 = 4
SIG_F2 = 8
SIG_F3 = 16
SIG_ORG = 32
SIG_WARP = 128
SIG_IDLE = 256


LegTable = {}
LegTable[#LegTable + 1] = piece "striderleg" --2
Leg2 = #LegTable
LegTable[#LegTable + 1] = piece "striderle1"
LegTable[#LegTable + 1] = piece "striderle0"


LegTable[#LegTable + 1] = piece "striderle4" --3
Leg3 = #LegTable
LegTable[#LegTable + 1] = piece "striderle2"
LegTable[#LegTable + 1] = piece "striderle3"


LegTable[#LegTable + 1] = piece "striderle7" --1
Leg1 = #LegTable
LegTable[#LegTable + 1] = piece "striderle5"
LegTable[#LegTable + 1] = piece "striderle6"

--You who venture here in hope of awesome source, turn back now,
--nothing but Goons in drag await you here
function script.Create()

    Move(strider, y_axis, -110, 0)
    tP(LegTable[Leg3], z_axis, math.rad(143), 0)
    tP(LegTable[Leg3 + 1], z_axis, math.rad(-176), 0)
    tP(LegTable[Leg2], z_axis, math.rad(-143), 0)
    tP(LegTable[Leg2 + 1], z_axis, math.rad(176), 0)
    tP(LegTable[Leg1], x_axis, math.rad(143), 0)
    tP(LegTable[Leg1 + 1], x_axis, math.rad(-176), 0)

    Hide(relPos1)
    Hide(relPos2)
    Hide(relPos3)
    Hide(pOrg1)
    Hide(pOrg2)
    Hide(pOrg3)
    Hide(LegOrg1)
    Hide(LegOrg2)
    Hide(LegOrg3)

    for i = 1, #LegTable, 1 do
        Turn(LegTable[i], x_axis, math.rad(0), 0)
        Turn(LegTable[i], z_axis, math.rad(0), 0)
        Turn(LegTable[i], y_axis, math.rad(0), 0)
    end
    Hide(flare1)
    Hide(flare2)
    Hide(deathpivot)
    StartThread(relativeTurnFeet)

    StartThread(resetOrgHeading)
    StartThread(walk)
end

function lenghtOfVectorSum(vx, vy, vz, tx, ty, tz)
    vx, vy, vz = vx + tx, vy + ty, vz + tz
    return math.sqrt(vx * vx + vy * vy + vz * vz)
end

function InInterVal(Low, Val, Max)
    return not (Val < Low or Val > Max)
end

MAXDIST = 92 --magic number out of upspring
LOWLEGLENGTH = 36
UPLEGLENGTH = 55
UPLEGSQR = 3025
LEGLENGTH = 43
LEGSQR = 6241




function stepItUp(x, y, z)
    T = Spring.GetUnitsInCylinder(x, z, 7)
    table.remove(T, unitID)
    if T then
        if table.getn(T) > 0 then
            --was zum Geier hab ich hier gecodet
            scaleX, scaleY, scaleZ, offsetX, offsetY, offsetZ, volumeType, testType, primaryAxis, bdisabled = Spring.GetUnitCollisionVolumeData(unitID)
            if scaleY / 2 + offsetY < MAXDIST then
                return y + scaleY / 2 + offsetY
            end
        end
    end
    return y
end

smothVals = {}
nrofsteps = 4
weightArray = {
    [1] = 0.125,
    [2] = 0.125,
    [3] = 0.25,
    [4] = 0.5
}
--this function filters the handed over turnvalues, so they may not leave the rangelimit
function smoothVal(val, legnr, nr)
    --if true== true then return val end

    if not smothVals[legnr] then
        smothVals[legnr] = {}
    end
    if not smothVals[legnr][nr] then
        smothVals[legnr][nr] = {}
        for i = 1, nrofsteps do smothVals[legnr][nr][i] = val end
    end

    --copy Back
    for i = 1, nrofsteps - 1, 1 do
        smothVals[legnr][nr][i] = smothVals[legnr][nr][i + 1]
    end

    smothVals[legnr][nr][nrofsteps] = val

    --evaluation
    sum = 0
    for i = 1, nrofsteps do
        sum = sum + smothVals[legnr][nr][i] * weightArray[i]
    end


    return sum
end


--this function turns the legs handed over, to point at the x,y,z coordinates
--unitPos --targetPoint --UpLeg
outOfRange = false
stillInRange = true
errorInterpolation = false
correctMovement = true
function resolveKinematics(x, y, z, tPx, tPy, tPz, lorgx, lorgy, lorgz, number, targPoint)

    --zero-Vector from the legsocket, to the groundtargPoint

    zvx, zvy, zvz = (tPx - lorgx), tPy - lorgy, (tPz - lorgz)
    BASEDISTANCE = math.sqrt(zvx * zvx + zvy * zvy + zvz * zvz)

    if (BASEDISTANCE > 122) then
        return outOfRange, errorInterpolation
    end

    --CinematicExceedsTreshold
    --you are in deep deep trouble --> abort animation there early and get feet inwards asap

    BASEDISTSQR = BASEDISTANCE * BASEDISTANCE
    ycomp = math.abs(zvy) - LOWLEGLENGTH
    BASELOWLEGDIST = math.sqrt(zvx * zvx + ycomp * ycomp + zvz * zvz)


    --Spring.Echo("StriderScript::ResolvoingKinematiks")
    --Turn it y-directionwise

    yaw = math.atan2(zvz, zvx)
    -- - 32767 <--> +32767 +32767 0 - 65533
    --sanitizedHeading=math.abs(currentHeading +32767)/182

    --uplegyaw=smoothVal(math.rad(180)-(math.rad(currentHeading)+math.rad(-90)+yaw),1)
    uplegyaw = smoothVal(math.rad(180) - (math.rad(currentHeading) + math.rad(-90) + yaw), number, 1)
    --Spring.Echo(uplegyaw)
    --	if Limit(uplegyaw,-90,90)== false then return stillInRange, errorInterpolation end
    Turn(StriTable[number].UpLeg, y_axis, uplegyaw, turnSpeed)

    --first lets get the rad for the upper leg
    beta = math.acos((LEGSQR - UPLEGSQR - BASEDISTSQR) / (-2 * UPLEGLENGTH * BASEDISTANCE))
    alpha = math.atan2(zvx, zvy) + beta

    uplegval = smoothVal(PI + alpha, number, 2) % PI2
    if Limit(uplegval, math.rad(-42), math.rad(42)) == false then return stillInRange, errorInterpolation end

    --	Spring.Echo("Strider_upval"..uplegval)
    Turn(StriTable[number].UpLeg, x_axis, uplegval, turnSpeed)

    -- gama=-3.14159+(1.570796326-beta)+(1.570796326-math.acos((BASELOWLEGDIST*BASELOWLEGDIST+LEGLENGTH*LEGLENGTH-UPLEGLENGTH*UPLEGLENGTH)/(2*LEGLENGTH*BASELOWLEGDIST)))
    optgama = -beta - (math.acos((BASELOWLEGDIST * BASELOWLEGDIST + LEGLENGTH * LEGLENGTH - UPLEGLENGTH * UPLEGLENGTH) / (2 * LEGLENGTH * BASELOWLEGDIST)))
    -- Spring.Echo("JW_STRIDER.."..gama.." ->"..optgama)

    optgama = smoothVal(optgama, number, 3)
    if Limit(optgama, math.rad(-85), math.rad(25)) == false then return stillInRange, errorInterpolation end
    Turn(StriTable[number].Leg, x_axis, optgama, turnSpeed, true)

    lowoptgame = smoothVal(-1 * (3.14159 + alpha) - optgama, number, 4)

    --if math.abs(lowoptgame) > 3.14159/2 then return false end
    if Limit(lowoptgame, math.rad(-45), math.rad(45)) == false then return stillInRange, errorInterpolation end
    Turn(StriTable[number].LowLeg, x_axis, lowoptgame, turnSpeed, true)

    --Turn Leg

    return stillInRange, correctMovement
end

--this function turns the legs handed over, to point at the x,y,z coordinates
function keepFeetRelative(targPoint, center, sensor, Signal, upLeg, Leg, lowLeg, movX, movY, movZ, number)

    SetSignalMask(Signal)
    feetSignals[number] = true

    --Send the piece to the local position it starts from
    Move(targPoint, x_axis, movX, 0)
    Move(targPoint, y_axis, movY, 0)
    Move(targPoint, z_axis, movZ, 0)

    --localisation for speedups
    local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
    local lresolveKinematics = resolveKinematics
    local spGetUnitVelocity = Spring.GetUnitVelocity
    local spGetUnitPosition = Spring.GetUnitPosition
    local spGetGroundHeight = Spring.GetGroundHeight
    inRange, goodMovement = true, false
    local lstepitup = stepItUp


    --get the StartPosition of the unit
    local sx, sy, sz = spGetUnitPosition(unitID)
    errorCount = 0
    Sleep(2)
    while inRange == true and errorCount < 3 do


        --grab the currentVelocity of the Unit
        vx, vy, vz, vl = spGetUnitVelocity(unitID)
        vx, vy, vz = (vx) * vl, (vy) * vl, (vz) * vl

        --get the current Position of the Unit
        rx, ry, rz = spGetUnitPosition(unitID)
        --get the current Position of the targPoint where the leg should go
        px, py, pz, _, _, _ = spGetUnitPiecePosDir(unitID, targPoint)

        --computate the relative grounddistance to Unitbase
        gd = (spGetGroundHeight(px, py) - ry) * -1

        --how far the Unit has moved away from the StartPosition
        tx, ty, tz = (rx - sx), (ry - sy), (rz - sz)

        --current Heading difference in deg
        deg = (orgHeading - currentHeading)

        -- we turn the MoveVector by
        tx, tz = RotationMatrice(tx, tz, math.rad(currentHeading + deg)) --rad


        --Velocity comes as elmos per frame
        --here we calculate wether a hitsphere is beneath the foot
        gd = lstepitup(tx, gd, tz)

        --finall
        Move(targPoint, z_axis, tz * -1, vz * 30)
        --Move(targPoint,y_axis,gd,vy*30)
        Move(targPoint, x_axis, tx * -1, vx * 30)
        -- res=(orgHeading- currentHeading)*-1

        --lebgbase pos
        ulbx, ulby, ulbz = spGetUnitPiecePosDir(unitID, StriTable[number].UpOrg)
        tx, ty, tz = spGetUnitPiecePosDir(unitID, targPoint)
        --to succesfully resolve cinematics we need the units position, the base pieces position and the upLegsPosition
        inRange, goodMovement = lresolveKinematics(rx, ry, rz, tx, ty, tz, ulbx, ulby, ulbz, number, targPoint)
        if goodMovement == false then
            errorCount = errorCount + 1
        end

        Sleep(5)
    end
    Spring.Echo("JW_STRIDER:KinematikLimitReached")
end


function headToDeg(head)
    if head < 0 then return 360 + (head / 182.4) end
    return head / 182.4
end


feetSignals = { [1] = false, [2] = false, [3] = false }

--Function to keep the feet turn-wise relative to the ground
orgHeading = headToDeg(Spring.GetUnitHeading(unitID))
currentHeading = headToDeg(Spring.GetUnitHeading(unitID))
diffdance = 0
striderHeigthOverride = false
function relativeTurnFeet()
    local lfeet = { [1] = { center = center1 }, [2] = { center = center2 }, [3] = { center = center3 } }
    local Pos = { [1] = relPos1, [2] = relPos2, [3] = relPos3 }

    local LikeWarmApplePi = math.pi / 2
    local spGetUnitHeading = Spring.GetUnitHeading
    local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
    local spGetGroundHeight = Spring.GetGroundHeight
    local count = 0
    local min = 9000
    local lheadToDeg = headToDeg
    local gravity = Game.gravity / 2


    while true do

        for i = 1, 3, 1 do
            if feetSignals[i] == true then

                currentHeading = lheadToDeg(spGetUnitHeading(unitID))
                diffdance = 0

                if currentHeading < orgHeading + 180 and currentHeading > orgHeading then
                    diffdance = (currentHeading - orgHeading) * -1
                else
                    if currentHeading < orgHeading then
                        diffdance = (orgHeading - currentHeading)
                    else
                        diffdance = ((orgHeading + 360) - currentHeading)
                    end
                end
                --Spring.Echo("StriderScript::Org->"..orgHeading.. " Cur->"..currentHeading.." Dif->"..diffdance)
                Turn(lfeet[i].center, y_axis, math.rad(diffdance), 0, true)
            end
        end
        Sleep(10)

        --the Stridercenter has to be kept relative to the ground
        count = ((count + 10) % 100)
        if count % 100 == 0 then
            x, baseheight, z, _, _, _ = spGetUnitPiecePosDir(unitID, deathpivot)
            min = spGetGroundHeight(x, z)

            for i = 1, #lfeet, 1 do
                x, y, z, _, _, _ = spGetUnitPiecePosDir(unitID, Pos[i])
                h = spGetGroundHeight(x, z)
                if h and h < min then min = h end
            end

            diffy = ((baseheight - min) * -1) - 14
            if striderHeigthOverride == false then
                Move(strider, y_axis, diffy, gravity)
            end
        end
    end
end

--- WALKING---
function deactiveAnim(number, signal)
    Signal(signal)
    feetSignals[number] = false
    --swing and bring foot forward

    tP(StriTable[number].UpOrg, 24, 0, 0, 10)
    tP(StriTable[number].Leg, -72, 0, 0, 10)
    tP(StriTable[number].LowLeg, 0, 0, 0, 10)
    WaitForTurns(StriTable[number].LowLeg, StriTable[number].Leg, StriTable[number].UpOrg)

    tP(StriTable[number].UpOrg, -28, 0, 0, 15)
    tP(StriTable[number].Leg, 9, 0, 0, 15)
    WaitForTurns(StriTable[number].Leg, StriTable[number].UpOrg)
    tP(StriTable[number].UpOrg, 0, 0, 0, 10)
    tP(StriTable[number].Leg, 0, 0, 0, 10)
    WaitForTurns(StriTable[number].Leg, StriTable[number].UpOrg)
end

function forward(number, speed)
    TaskTable[number].FinnishedExecution = false

    Turn(LegTable[number + 1], x_axis, math.rad(22), speed)
    WaitForTurns(LegTable[number + 1])
    Turn(LegTable[number], x_axis, math.rad(-39), speed)
    Turn(LegTable[number], z_axis, math.rad(0), speed)
    Turn(LegTable[number], y_axis, math.rad(0), speed)
    WaitForTurns(LegTable[number])
    WaitForTurns(LegTable[number + 1])
    Turn(LegTable[number], x_axis, math.rad(-29), speed)
    Turn(LegTable[number + 1], x_axis, math.rad(29), speed)

    WaitForTurns(LegTable[number], LegTable[number + 1])
    TaskTable[number].FinnishedExecution = true
end

--angleY 65
function stabilize(number, speed)
    TaskTable[number].FinnishedExecution = false
    signumYAxis = 1
    if number == Leg3 then signumYAxis = -1 end
    angleY = math.random(110, 160)

    Turn(LegTable[number], x_axis, math.rad(25), speed)
    Turn(LegTable[number + 1], x_axis, math.rad(-25), speed)
    Turn(LegTable[number], y_axis, math.rad(-1 * angleY * signumYAxis), speed)

    WaitForTurns(LegTable[number], LegTable[number + 1])
    TaskTable[number].FinnishedExecution = true
end

--angleY 65
function stabilizeArc(number, speed)
    TaskTable[number].FinnishedExecution = false
    angleYBegin = -42
    angleYEnd = 32

    Turn(LegTable[number], x_axis, math.rad(25), speed)
    Turn(LegTable[number + 1], x_axis, math.rad(-25), speed)
    Turn(LegTable[number], y_axis, math.rad(angleYBegin), speed)
    WaitForTurns(LegTable[number])
    WaitForTurns(LegTable[number + 1])
    Turn(LegTable[number], y_axis, math.rad(angleYEnd), speed)
    WaitForTurns(LegTable[number])
    WaitForTurns(LegTable[number], LegTable[number + 1])
    TaskTable[number].FinnishedExecution = true
end

function push(number, speed)
    TaskTable[number].FinnishedExecution = false

    Turn(LegTable[number], z_axis, math.rad(0), speed)
    Turn(LegTable[number], y_axis, math.rad(0), speed)
    Turn(LegTable[number], x_axis, math.rad(32), speed)
    Turn(LegTable[number + 1], x_axis, math.rad(-32), speed)

    WaitForTurns(LegTable[number], LegTable[number + 1])
    TaskTable[number].FinnishedExecution = true
end

TaskTable = {}

counter = 0
function walk()
    Move(strider, y_axis, 0, 16)
    while true do

        --Analytical IK
        if boolWalking == true and boolAiming == false then
            resetT(LegTable, 3)
            WaitForTurns(LegTable)


            TaskTable[Leg1] = {
                CurrentFunctionIndex = 0,
                FinnishedExecution = true,
                functions = {
                    [1] = push,
                    [2] = forward,
                    [3] = stabilizeArc
                }
            }

            TaskTable[Leg2] = {
                CurrentFunctionIndex = 2,
                FinnishedExecution = true,
                functions = {
                    [1] = push,
                    [2] = forward,
                    [3] = stabilize
                }
            }

            TaskTable[Leg3] = {
                CurrentFunctionIndex = 1,
                FinnishedExecution = true,
                functions = {
                    [1] = push,
                    [2] = forward,
                    [3] = stabilize
                }
            }

            while (boolWalking == true and boolAiming == false) do

                if TaskTable[Leg1].FinnishedExecution == true then
                    TaskTable[Leg1].CurrentFunctionIndex = (TaskTable[Leg1].CurrentFunctionIndex % 3) + 1
                    StartThread(TaskTable[Leg1].functions[TaskTable[Leg1].CurrentFunctionIndex], Leg1, 1.41)
                end

                if TaskTable[Leg2].FinnishedExecution == true then
                    TaskTable[Leg2].CurrentFunctionIndex = (TaskTable[Leg2].CurrentFunctionIndex % 3) + 1
                    StartThread(TaskTable[Leg2].functions[TaskTable[Leg2].CurrentFunctionIndex], Leg2, 1.41)
                end

                if TaskTable[Leg3].FinnishedExecution == true then
                    TaskTable[Leg3].CurrentFunctionIndex = (TaskTable[Leg3].CurrentFunctionIndex % 3) + 1
                    StartThread(TaskTable[Leg3].functions[TaskTable[Leg3].CurrentFunctionIndex], Leg3, 1.41)
                end

                Sleep(10)
            end

            resetT(LegTable, 3)
            WaitForTurns(LegTable)
        end
        Sleep(250)
    end
end


function resPos(piece, center, speed, number, SIG)
    if not feetSignals[number] then feetSignals[number] = false end
    feetSignals[number] = false
    Turn(center, x_axis, 0, speed or 0)
    Turn(center, y_axis, 0, speed or 0)
    Turn(center, z_axis, 0, speed or 0)
    Move(piece, x_axis, 0, speed or 0, true)
    Move(piece, y_axis, 0, speed or 0, true)
    Move(piece, z_axis, 0, speed or 0, true)
    Signal(SIG)
end

function legs_down(WaitForIt)
    echo("Legs Down")
    resPos(relPos1, center1, 5, 1, SIG_F1)
    resPos(relPos2, center2, 5, 2, SIG_F2)
    resPos(relPos3, center3, 5, 3, SIG_F3)
    Move(strider, y_axis, -10, 62)
    Turn(striderlegA2, x_axis, math.rad(0), 2)
    Turn(striderlegA2, y_axis, math.rad(0), 2)
    Turn(striderlegA2, z_axis, math.rad(0), 2)
    Turn(striderlegB2, x_axis, math.rad(0), 2)
    Turn(striderlegB2, y_axis, math.rad(0), 2)
    Turn(striderlegB2, z_axis, math.rad(0), 2)
    Turn(striderlegC2, x_axis, math.rad(0), 2)
    Turn(striderlegC2, y_axis, math.rad(0), 2)
    Turn(striderlegC2, z_axis, math.rad(0), 2)
    Turn(striderlegA, x_axis, math.rad(0), 2)
    Turn(striderlegA, y_axis, math.rad(0), 2)
    Turn(striderlegA, z_axis, math.rad(0), 2)
    Turn(striderlegB, x_axis, math.rad(0), 2)
    Turn(striderlegB, y_axis, math.rad(0), 2)
    Turn(striderlegB, z_axis, math.rad(0), 2)
    Turn(striderlegC, x_axis, math.rad(0), 2)
    Turn(striderlegC, y_axis, math.rad(0), 2)
    Turn(striderlegC, z_axis, math.rad(0), 2)
    Turn(striderlegA3, x_axis, math.rad(0), 2)
    Turn(striderlegA3, y_axis, math.rad(0), 2)
    Turn(striderlegA3, z_axis, math.rad(0), 2)
    Turn(striderlegB3, x_axis, math.rad(0), 2)
    Turn(striderlegB3, y_axis, math.rad(0), 2)
    Turn(striderlegB3, z_axis, math.rad(0), 2)
    Turn(striderlegC3, x_axis, math.rad(0), 2)
    Turn(striderlegC3, y_axis, math.rad(0), 2)
    Turn(striderlegC3, z_axis, math.rad(0), 2)
    if WaitForIt and WaitForIt == true then
        Sleep(150)
        WaitForTurn(striderlegA2, x_axis)
        WaitForTurn(striderlegA2, y_axis)
        WaitForTurn(striderlegA2, z_axis)
        WaitForTurn(striderlegB2, x_axis)
        WaitForTurn(striderlegB2, y_axis)
        WaitForTurn(striderlegB2, z_axis)
        WaitForTurn(striderlegC2, x_axis)
        WaitForTurn(striderlegC2, y_axis)
        WaitForTurn(striderlegC2, z_axis)
        WaitForTurn(striderlegA, x_axis)
        WaitForTurn(striderlegA, y_axis)
        WaitForTurn(striderlegA, z_axis)
        WaitForTurn(striderlegB, x_axis)
        WaitForTurn(striderlegB, y_axis)
        WaitForTurn(striderlegB, z_axis)
        WaitForTurn(striderlegC, x_axis)
        WaitForTurn(striderlegC, y_axis)
        WaitForTurn(striderlegC, z_axis)
        WaitForTurn(striderlegA3, x_axis)
        WaitForTurn(striderlegA3, y_axis)
        WaitForTurn(striderlegA3, z_axis)
        WaitForTurn(striderlegB3, x_axis)
        WaitForTurn(striderlegB3, y_axis)
        WaitForTurn(striderlegB3, z_axis)
        WaitForTurn(striderlegC3, x_axis)
        WaitForTurn(striderlegC3, y_axis)
        WaitForTurn(striderlegC3, z_axis)
    end
end

function resetOrgHeading()
    Sleep(500)
    orgHeading = headToDeg(Spring.GetUnitHeading(unitID))

    while true do
        torqheading = orgHeading
        --if the strider turns this way or that way, we update only once in a while
        while (math.abs(torqheading - headToDeg(Spring.GetUnitHeading(unitID))) > 5) do
            orgHeading = headToDeg(Spring.GetUnitHeading(unitID))
            torqheading = orgHeading
            Sleep(2000)
        end

        --he is on its way turning slightly
        while (math.abs(torqheading - headToDeg(Spring.GetUnitHeading(unitID))) <= 5) do
            orgHeading = headToDeg(Spring.GetUnitHeading(unitID))
            torqheading = orgHeading
            Sleep(1200)
        end
        Sleep(1500)
        orgHeading = headToDeg(Spring.GetUnitHeading(unitID))
    end
end


function script.StartMoving()
    Spring.Echo("starting to walk!")
    Signal(SIG_ORG)
    Signal(SIG_WARP)
    idleEnd = true

    boolWalking = true
end

US = Spring.UnitScript
function lookLeft()
    syncTurnInTime(strider, 0, 28, 0, 1000, 0, 0, 0)
    syncTurnInTime(striderlegA2, 5, 0, 0, 1000, 0, 0, 0)
    syncTurnInTime(striderlegA, -2, 0, 1, 1000, 0, 0, 0)
    syncTurnInTime(striderlegA3, -1, 0, 4, 1000, 0, 0, 0)
    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
    randoVal = math.ceil(math.random(1, 4) * 1000)
    Sleep(randoVal)
end

function lookRight()

    syncTurnInTime(strider, 0, -28, 0, 1000, 0, 28, 0)
    syncTurnInTime(striderlegA2, -3, 0, -1, 1000, 5, 0, 0)
    syncTurnInTime(striderlegA, 2, 0, 0, 1000, -2, 0, 1)
    syncTurnInTime(striderlegA3, -1, 0, -4, 1000, -1, 0, 4)
    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
    randoVal = math.ceil(math.random(1, 4) * 1000)
    Sleep(randoVal)
end

function lookAround()
    SetSignalMask(SIG_IDLE)
    --turn left
    lookLeft()
    --turn right
    lookRight()

    syncTurnInTime(strider, 0, 0, 0, 1000, 0, -28, 0)
    syncTurnInTime(striderlegA2, 0, 0, 0, 1000, -3, 0, -1)
    syncTurnInTime(striderlegA, 0, 0, 0, 1000, 2, 0, 1)
    syncTurnInTime(striderlegA3, 0, 0, 0, 1000, 0, 0, -4)
    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
end

function breath()
    SetSignalMask(SIG_IDLE)
    randVal = cbrandoVal(1, 22)

    for i = 1, randVal do

        Turn(striderlegA2, x_axis, math.rad(-3), 0.05, true)
        Turn(striderlegA, x_axis, math.rad(-3), 0.05, true)
        Turn(striderlegA3, x_axis, math.rad(-3), 0.05, true)
        Turn(strider, x_axis, math.rad(3), 0.05, true)
        WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
        Turn(striderlegA2, x_axis, math.rad(1), 0.05, true)
        Turn(striderlegA, x_axis, math.rad(1), 0.05, true)
        Turn(striderlegA3, x_axis, math.rad(1), 0.05, true)
        Turn(strider, x_axis, math.rad(-1), 0.05, true)
        WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
    end
    Turn(strider, x_axis, math.rad(0), 0.05)
    Turn(striderlegA2, x_axis, math.rad(0), 0.05)
    Turn(striderlegA, x_axis, math.rad(0), 0.05)
    Turn(striderlegA3, x_axis, math.rad(0), 0.05)
    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
end

function swayLeftRight(boolLeft, distancefX, distancefY, motiontimer)
    if boolLeft == true then
        dAXSigPosZ = 1.0 --left positiv
        dAXSigNegZ = -1.0 --left negative
    else
        dAXSigPosZ = -1.0 --left positiv
        dAXSigNegZ = 1.0 --left negative
    end

    offsetZ = distancefX / 3

    syncMoveInTime(strider, distancefX * dAXSigNegZ, distancefY, 0, motiontimer, distancefX * dAXSigNegZ * -1, distancefY, 0)
    syncTurnInTime(striderlegA2, 0, 0, -121 + offsetZ * dAXSigPosZ * 7, motiontimer, 0, 0, -121 + offsetZ * dAXSigPosZ * 7 * -1)
    syncTurnInTime(striderlegB2, 0, 0, 125 + offsetZ * dAXSigNegZ * 4, motiontimer, 0, 0, 125 + offsetZ * dAXSigNegZ * 4 * -1)

    syncTurnInTime(striderlegA, 0, 0, 121 + offsetZ * dAXSigNegZ, motiontimer, 0, 0, 121 + offsetZ * dAXSigNegZ * -1)
    syncTurnInTime(striderlegB, 0, 0, -125 + offsetZ * dAXSigPosZ * 3, motiontimer, 0, 0, -125 + offsetZ * dAXSigPosZ * 3 * -1)

    syncTurnInTime(striderlegA3, 130, 0, -30 * dAXSigPosZ, motiontimer, 130, 0, -30 * dAXSigPosZ * -1)
    syncTurnInTime(striderlegB3, -155, 0, 0, motiontimer, -160, 0, 0)
    Turn(striderlegB3, x_axis, math.rad(-155), 12)

    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
    --inverted tupels
    syncMoveInTime(strider, distancefX * dAXSigNegZ * -1, distancefY, 0, motiontimer, distancefX * dAXSigNegZ, distancefY, 0)
    syncTurnInTime(striderlegA2, 0, 0, -121 + offsetZ * dAXSigPosZ * 7 * -1, motiontimer, 0, 0, -121 + offsetZ * dAXSigPosZ * 7)
    syncTurnInTime(striderlegB2, 0, 0, 125 + offsetZ * dAXSigNegZ * 4 * -1, motiontimer, 0, 0, 125 + offsetZ * dAXSigNegZ * 4)

    syncTurnInTime(striderlegA, 0, 0, 121 + offsetZ * dAXSigNegZ * -1, motiontimer, 0, 0, 121 + offsetZ * dAXSigNegZ)
    syncTurnInTime(striderlegB, 0, 0, -125 + offsetZ * dAXSigPosZ * 3 * -1, motiontimer, 0, 0, -125 + offsetZ * dAXSigPosZ * 3)


    syncTurnInTime(striderlegA3, 130, 0, -30 * dAXSigPosZ * -1, motiontimer, 130, 0, -30 * dAXSigPosZ)
    syncTurnInTime(striderlegB3, -160, 0, 0, motiontimer, -155, 0, 0)

    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)
end

function kneelRiseAKnight() --SirLongLeg
    SetSignalMask(SIG_IDLE)

    dirAXSignPosZ = 1.0 --left positiv
    dirAXSignNegZ = -1.0 --left negative


    syncTurnInTime(striderlegA2, 0, 0, -121, 1000, 0, 0, 0)
    syncTurnInTime(striderlegB2, 0, 0, 156, 1000, 0, 0, 0)
    syncTurnInTime(striderlegA, 0, 0, 121, 1000, 0, 0, 0)
    syncTurnInTime(striderlegB, 0, 0, -156, 1000, 0, 0, 0)
    syncTurnInTime(striderlegA3, 121, 0, 0, 1000, 0, 0, 0)
    syncTurnInTime(striderlegB3, -148, 0, 0, 1000, 0, 0, 0)
    syncMoveInTime(strider, 0, -105, 0, 2000)
    WaitForMove(strider, y_axis)
    WaitForTurns(strider, striderlegA, striderlegA2, striderlegA3)


    if maRa() == true then
        swayTime = cbrandoVal(1, 6)
        for i = 1, swayTime, 1 do

            swayLeftRight(i % 2 == 0, math.random(10, 25), -105, 4000)
        end
    end


    timeKneel = 0
    offSetswing = 5
    while timeKneel < 12000 do
        syncTurnInTime(striderlegA2, 0, 0, -121 + offSetswing, 2000, 0, -121 + offSetswing * -1, 0)
        syncTurnInTime(striderlegB2, 0, 0, 156 - offSetswing, 2000, 0, 156 - offSetswing * -1, 0)
        syncTurnInTime(striderlegA, 0, 0, 121 - offSetswing, 2000, 0, 121 - offSetswing * -1, 0)
        syncTurnInTime(striderlegB, 0, 0, -156 + offSetswing, 2000, 0, -156 + offSetswing * -1, 0)
        syncTurnInTime(striderlegA3, 121 - offSetswing, 0, 0, 2000, 0, 121 - offSetswing * -1, 0)
        syncTurnInTime(striderlegB3, -148 + offSetswing, 0, 0, 2000, 0, 148 + offSetswing * -1, 0)
        Move(strider, y_axis, -105 + offSetswing, 50)
        Sleep(2000)
        offSetswing = offSetswing * -1
        timeKneel = timeKneel + 2000
    end
    legs_down()
end

idleFunctions = {}
idleFunctions[#idleFunctions + 1] = breath
idleFunctions[#idleFunctions + 1] = lookAround
idleFunctions[#idleFunctions + 1] = kneelRiseAKnight



function idle()
    striderHeigthOverride = true

    Sleep(100)
    idleEnd = false
    boolWalking = false
    Sleep(3000)
    while idleEnd == false and boolAiming == false do

        Signal(SIG_IDLE)
        index = math.random(1, #idleFunctions)
        StartThread(idleFunctions[index])
        restTime = cbrandoVal(12000, 24000)
        intervall = math.ceil(restTime / 12)
        for i = 1, 12, 1 do
            Sleep(intervall)
            if idleEnd == true or boolAiming == true then
                Signal(SIG_IDLE)
                break
            end
        end
    end
    striderHeigthOverride = false
    legs_down(false)
end


function script.StopMoving()
    Spring.Echo("stopped walking!")

    Signal(SIG_F1)
    Signal(SIG_F2)
    Signal(SIG_F3)
    Signal(SIG_WARP)
    legs_down(false)
    boolAiming = false
    StartThread(idle)
end

--- -aimining & fire weapon
function script.AimFromWeapon1()
    return flare1
end

function script.QueryWeapon1()
    return flare1
end

function script.AimWeapon1(heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy
    idleEnd = true

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(automg, y_axis, heading)
    Turn(automg, x_axis, -pitch)

    return true
end

function script.FireWeapon1()
    return true
end

function setLegDownStrider(lspeed)
    speed = lspeed or 1
    val = math.random(36, 39)
    tP(striderlegA, 0, 0, val, 0.1 * speed)
    tP(striderlegB, 0, 0, -1 * val - 6, 0.3 * speed)
    tP(striderlegA2, 0, 0, -1 * val, 0.1 * speed)
    tP(striderlegB2, 0, 0, val + 6, 0.3 * speed)

    tP(striderlegA3, 35, 0, 0, 0.1 * speed)
    tP(striderlegB3, -42, 0, 0, 0.3 * speed)
    WaitForTurns(striderlegA, striderlegB, striderlegA2, striderlegB2, striderlegA3, striderlegB3)
end


--lift rear foot	
function liftCenterFoot(sigum)

    tP(striderlegA3, 49, 0, 0, 0.7)
    tP(striderlegB3, -22, 0, -1 * sigum * 24, 0.7)
    WaitForTurns(striderlegA3, striderlegB3)
    tP(striderlegA3, 35, 0, 0, 0.7)
    tP(striderlegB3, -45, 0, 0, 0.7)
end


function liftRightFoot(sigum)
    --lift right foot
    tP(striderlegA2, 0, 0, -43, 0.7)
    tP(striderlegB2, 0, 0, 54, 0.7)
    WaitForTurns(striderlegA2, striderlegB2)
    tP(striderlegA2, 0, 0, -65, 0.7)
    tP(striderlegB2, 0, 0, 68, 0.7)
end

function liftLeftFoot(sigum)
    --lift left foot
    tP(striderlegA, 0, 0, 43, 0.7)
    tP(striderlegB, 0, 0, -54, 0.7)
    WaitForTurns(striderlegA, striderlegB)
    tP(striderlegA, 0, 0, 65, 0.7)
    tP(striderlegB, 0, 0, -65, 0.7)
end


function TurnStrider(boolLeft, speed)
    sigum = 1
    if boolLeft == true then
        sigum = -1
    end




    val = math.random(18, 32)
    --Turn Forward/Backward

    tP(striderlegA, sigum * val, 0, 24, speed)
    tP(striderlegB, -1 * sigum * val, 0, -24, speed)

    --Turn Forward/Backward

    tP(striderlegA2, -1 * sigum * val, 0, -24, speed) --4
    tP(striderlegB2, sigum * val, 0, 24, speed)

    --rear leg
    tP(striderlegA3, 20, 0, sigum * 24, speed)
    tP(striderlegB3, -22, 0, -1 * sigum * 24, speed)

    tP(strider, y_axis, math.rad(5 * sigum), 0.19)
    WaitForTurns(striderlegA, striderlegB, striderlegA2, striderlegB2, striderlegA3, striderlegB3)
    tP(strider, y_axis, math.rad(0), 0.9)


    Sleep(600)

    StartThread(liftCenterFoot, sigum)

    Sleep(600)

    StartThread(liftLeftFoot, sigum)


    Sleep(600)
    StartThread(liftRightFoot, sigum)

    WaitForTurns(striderlegA, striderlegB, striderlegA2, striderlegB2, striderlegA3, striderlegB3)

    setLegDownStrider(1)
end

boolAiming = false
--- -aimining & fire weapon 2
function WarpCanonStance()
    SetSignalMask(SIG_WARP)
    Move(strider, y_axis, -13, 0.5)
    oldHeading = currentHeading
    Sleep(50)
    setLegDownStrider(4)
    while true do

        --Turn
        while math.abs(oldHeading - currentHeading) > 1 do

            oldHeading = currentHeading
            TurnStrider(oldHeading - currentHeading < 0, 1.2)
        end
        oldHeading = currentHeading
        setLegDownStrider(1)

        WaitForMove(strider, y_axis)
        Move(strider, y_axis, -13, 0.5)
        Turn(striderlegA, z_axis, math.rad(38), 0.1)
        Turn(striderlegB, z_axis, math.rad(-44), 0.3)

        Turn(striderlegA2, z_axis, math.rad(-38), 0.1)
        Turn(striderlegB2, z_axis, math.rad(44), 0.2)

        Turn(striderlegA3, x_axis, math.rad(33), 0.1)
        Turn(striderlegB3, x_axis, math.rad(-39), 0.3)
        WaitForTurns(striderlegA, striderlegB, striderlegA2, striderlegB2, striderlegA3, striderlegB3)

        WaitForMove(strider, y_axis)
        Move(strider, y_axis, -16, 0.5)
    end
end

function script.AimFromWeapon2()
    return strider
end

function script.QueryWeapon2()
    return flare2
end

function script.AimWeapon2(heading, pitch)
    idleEnd = true

    --SetSignalMask(SIG_AIM)
    boolAiming = true
    --aiming animation: instantly turn the gun towards the enemy
    Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 1)

    Turn(flare2, y_axis, heading, 25)
    WaitForTurn(flare2, y_axis)

    boolAiming = false

    return true
end

function script.FireWeapon2()

    boolAiming = false
    Signal(SIG_WARP)
    StartThread(WarpCanonStance)
    Sleep(450)
    Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 0)
    return true
end

function script.Killed()
    Turn(deathpivot, x_axis, math.rad(8), 2)

    Turn(deathpivot, y_axis, math.rad(15), 2)

    Turn(deathpivot, x_axis, math.rad(-9), 3)
    WaitForTurn(deathpivot, x_axis)
    Turn(deathpivot, x_axis, math.rad(-25), 2)
    WaitForTurn(deathpivot, x_axis)
    Turn(deathpivot, x_axis, math.rad(-83), 1)

    Turn(striderlegA3, x_axis, math.rad(-12), 2)
    Sleep(50)
    Turn(striderlegB3, x_axis, math.rad(13), 2)
    WaitForTurn(deathpivot, x_axis)
    WaitForTurn(striderlegB3, x_axis)
    WaitForTurn(striderlegA3, x_axis)
    WaitForTurn(deathpivot, y_axis)
    WaitForTurn(deathpivot, x_axis)
    --

    Turn(striderlegA, z_axis, math.rad(-10), 5)
    Turn(striderlegB, y_axis, math.rad(8), 2)
    Turn(striderlegB, z_axis, math.rad(28), 2)
    Turn(striderlegA2, x_axis, math.rad(8), 2)
    Turn(striderlegA2, z_axis, math.rad(-11), 2)
    Turn(striderlegB2, z_axis, math.rad(28), 3)
    Turn(striderlegB2, y_axis, math.rad(-26), 4)
    WaitForTurn(striderlegA, z_axis)
    WaitForTurn(striderlegB, y_axis)
    WaitForTurn(striderlegA2, y_axis)
    WaitForTurn(striderlegA2, x_axis)
    WaitForTurn(striderlegB, z_axis)


    WaitForTurn(striderlegB2, y_axis)

    WaitForTurn(striderlegB2, z_axis)


    Sleep(2047)

    Explode(striderlegA, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegB, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegC, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegA2, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegB2, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegC2, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegA3, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegB3, SFX.FALL + SFX.NO_HEATCLOUD)
    Explode(striderlegC3, SFX.FALL + SFX.NO_HEATCLOUD)

    Explode(strider, SFX.FALL + SFX.FIRE)
    --- -Spring.Echo ("He is dead, Jim!")
end