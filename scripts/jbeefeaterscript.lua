include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

local beefcenter = piece "beefcenter"

local tonguetip = piece "tonguetip"
headingOfLastShot = 0
pitchOfLastShot = 0


local neck = piece "neck"
local center = piece "center"
local dustemit1 = piece "dustemit1"
local dustemit2 = piece "dustemit2"
local dustemit3 = piece "dustemit3"
local Head = piece "Head"
local sayAAA = piece "sayAAA"
tonguespeed = 73.1

local SIG_MOVE = 1
local SIG_WIGGLE = 2
local SIG_LEGS = 4
local SIG_LEGS = 8
local SIG_BREATH = 16
local SIG_AIM = 32
local SIG_IDLE = 64
someRandomArbitraryHPLimit = 1600
teamID = Spring.GetUnitTeam(unitID)
middleCounterValue = 35
tailDistance = 280
predecessorMaxDist = 250
local boolIsMoving = false
--variables that sound like supervillians
DecreaSor = 1
local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
schuppe06 = piece("schuppe06")

shells = {}
for i = 1, 40, 1 do
    shells[i] = {}
    tempString = "Shell" .. i
    shells[i] = piece(tempString)
end

tongue = {}
for i = 1, 31, 1 do
    tongue[i] = {}
    tempString = "tongue" .. i
    tongue[i] = piece(tempString)
end
constTongue = tongue[31]
blinkers = {}
for i = 1, 40, 1 do
    blinkers[i] = {}
    tempString = "blink" .. i
    blinkers[i] = piece(tempString)
end

previousMaxGroundHeight = 0
function obsticleTest()
    hx, hy, hz, _, _, _ = Spring.GetUnitPiecePosDir(unitID, tonguetip)
    groundHeight = Spring.GetGroundHeight(hx, hz)


    if groundHeight > hy then
        return true
    else
        return false
    end
end

--function: this. expands the tongue, while constantly checking if the the tonguetip passes through terrain
function expandTongue(dist, totalpitchDown, tspeed)
    --Signal(SIG_IDLE)
    if dist > (900) or totalpitchDown > 90 then
        return false
    end
    Show(tonguetip)
    for i = 1, 31, 1 do
        Show(tongue[i])
    end

    Turn(sayAAA, x_axis, math.rad(6), 7.5)
    Turn(Head, x_axis, math.rad(-8), 4.5)
    WaitForTurn(Head, x_axis)
    piecesNeeded = (dist / 28)
    degreePerPiece = (totalpitchDown / piecesNeeded) * -1
    boolObsticleDiscovered = false
    pieceWorkedOn = 1
    Move(tonguetip, z_axis, 0, tspeed)

    while (boolObsticleDiscovered == false and pieceWorkedOn < piecesNeeded) do
        Move(tongue[pieceWorkedOn], z_axis, 0, tspeed)
        Turn(tongue[pieceWorkedOn], x_axis, math.rad(degreePerPiece), 0.05)
        WaitForMove(tongue[pieceWorkedOn], z_axis)
        boolObsticleDiscovered = obsticleTest()

        pieceWorkedOn = pieceWorkedOn + 1
    end


    if boolObsticleDiscovered == false then

        return true
    else
        return false
    end
end

function retractTongue()
    Signal(SIG_IDLE)


    for i = 1, 31, 1 do
        Move(tongue[i], z_axis, -28, tonguespeed)
        Turn(tongue[i], x_axis, math.rad(0), 0.5)
    end
    Move(tonguetip, z_axis, -48, tonguespeed)

    WaitForMove(tonguetip, z_axis)
    for i = 1, 31, 1 do
        Hide(tongue[i])
    end

    Hide(tonguetip)
end

Infantry = {}
Infantry[UnitDefNames["bg"].id] = true
Infantry[UnitDefNames["tiglil"].id] = true
Infantry[UnitDefNames["skinfantry"].id] = true
Infantry[UnitDefNames["vort"].id] = true
Infantry[UnitDefNames["css"].id] = true

function isInfantry(passengerDefID)
    if Infantry[passengerDefID] then return true else return false end
end


function timedelaySound()
    Sleep(1900)
    Spring.PlaySoundFile("sounds/beafeater/beefeater.wav")
end

boolAiming = false
function hitManThread(poorFellowsID)
    likeAFreakTrainGoingNoWhere, _, _, _, _ = Spring.GetUnitHealth(poorFellowsID)
    team = Spring.GetUnitTeam(poorFellowsID)
    if Spring.ValidUnitID(poorFellowsID) == true and team ~= teamID then
        boolAiming = true
        SetUnitValue(COB.BUSY, 1)

        local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
        local px2, py2, pz2 = Spring.GetUnitBasePosition(poorFellowsID)
        local dx, dy, dz = px2 - px1, py2 - py1, pz2 - pz1
        local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID)) / 32768 * math.pi


        px, py, pz = Spring.GetUnitPosition(poorFellowsID)
        WTurn(beefcenter, y_axis, heading, 12)
        currPosX, currPosY, currPosZ = Spring.GetUnitPosition(unitID)
        distanceVal = distance(px1, py1, pz1, px2, py2, pz2)

        if expandTongue(distanceVal, math.deg(pitchOfLastShot), 196.0) == true and doesUnitExistAlive(poorFellowsID) then
            --attach the poor fellow too the tongue tip
            AttachUnit(tonguetip, poorFellowsID)

            if isInfantry(poorFellowsID) == true then

                Spring.PlaySoundFile("sounds/beafeater/beefeatersnatch.wav")
                --play sound depending upon type
            else
                --play roarsoundfile
                StartThread(timedelaySound)
            end

            --Sleep(1800)
            StartThread(retractTongue)
            --Sleep(2000)
            Turn(Head, x_axis, math.rad(-96), 9)
            Turn(sayAAA, x_axis, math.rad(10), 9)
            WaitForTurn(Head, x_axis)
            --Sleep(200)
            Turn(constTongue, x_axis, math.rad(-31), 17)
            WaitForMove(tonguetip, z_axis)
            WaitForTurn(Head, x_axis)

            Turn(Head, x_axis, math.rad(0), 9)
            Turn(sayAAA, x_axis, math.rad(0), 15)
            Turn(constTongue, x_axis, math.rad(0), 15)
            DropUnit(poorFellowsID)
            Spring.DestroyUnit(poorFellowsID, false, true)
            poopStack = poopStack + 10

        else
            --retract Tongue
            StartThread(retractTongue)
            --Throw head Back
            Turn(Head, x_axis, math.rad(0), 93)
            Turn(sayAAA, x_axis, math.rad(0), 15)
            Turn(constTongue, x_axis, math.rad(0), 15)
        end
        boolAiming = false
    end
end

poopStack = 0
function butIPoopFromThere()
    while true do
        Sleep(1000)
        if poopStack > 50 then

            x, y, z = Spring.GetUnitPosition(middleID)
			gaiaTeamID = Spring.GetGaiaTeamID()
            Spring.CreateUnit("gshit", x, y, z, 1, gaiaTeamID)
            poopStack = 0
        end
    end
end

storedStoogeId = nil
boolUnitHit = false
function hitIt(poorFellowsID)
    storedStoogeId = poorFellowsID
    boolUnitHit = true
end

function hitLoop()
    while (true) do
        Sleep(100)
        if boolUnitHit == true then
            boolUnitHit = false
            hitManThread(storedStoogeId)
        end
    end
end

function hideThis(piecename)
    timedelayed = math.random(0, 1000)
    Sleep(timedelayed)
    Hide(piecename)
end

function showThis(piecename)
    timedelayed = math.random(0, 1000)
    Sleep(timedelayed)
    Show(piecename)
end

function dice()
    i = math.random(0, 1)
    if i == 1 then return true
    else
        return false
    end
end

function sound()
    while (true) do
        fromTimeToTime = math.random(15000, 30000)
        Sleep(fromTimeToTime)
        if boolIsMoving == true then
            Spring.PlaySoundFile("sounds/beafeater/movinbeef.wav")
        end
    end
end



function reload()
    Sleep(12000)
    boolLoaded = true
end


function headBang()
    SetSignalMask(SIG_BREATH)
    while (true) do
        Turn(Head, x_axis, math.rad(2), 0.2)
        Turn(sayAAA, x_axis, math.rad(2), 0.2)
        WaitForTurn(Head, x_axis)
        WaitForTurn(sayAAA, x_axis)
        Turn(Head, x_axis, math.rad(-2), 0.2)
        Turn(sayAAA, x_axis, math.rad(-2), 0.2)
        WaitForTurn(Head, x_axis)
        WaitForTurn(sayAAA, x_axis)
        Sleep(10)
    end
end

local SumOfParts = {}
--first entry subtable= unitid
--second entry subtable= exposX
--third entry subtable= exposY
--third entry subtable= exposZ
-- entry subtable= counterVar

function spawnAMiddle(x, y, z)
    teamID = Spring.GetUnitTeam(unitID)
    x, y, z = Spring.GetUnitPosition(unitID)
    middleID = Spring.CreateUnit("jbeefeatermiddle", x, y, z, 0, teamID)
    Spring.SetUnitMoveGoal(middleID, x, y, z)
    Spring.SetUnitNoSelect(middleID, true)

    return middleID, x, y, z
end

function instantRetract()
    for i = 1, 31, 1 do
        Move(tongue[i], z_axis, -28, 0)
        Hide(tongue[i])
        Turn(tongue[i], x_axis, math.rad(0), 0.5)
    end
    Move(tonguetip, z_axis, -48, 0)
    Hide(tonguetip)
end




--------------------------------------------------
function DistanceToPredecessor()
    cuX, cuY, cuZ = Spring.GetUnitPiecePosDir(unitID, schuppe06)
    cx, cy, cz = Spring.GetUnitPosition(middleID)

    return distance(cuX, cuY, cuZ, cx, cy, cz)
end

function setUnitStop()
    Command(middleID, "stop", {})
end

function setUnitInMotion()
    DistanceTP = (DistanceToPredecessor())
    if Spring.GetUnitIsDead(middleID) == true then return end
    --if the unit still exists and the distance to is predecessor is not to small
    if DistanceTP <= predecessorMaxDist then
        --- -Spring.Echo("SUM1")
        setUnitStop()

    else
        x, y, z = Spring.GetUnitPiecePosDir(unitID, schuppe06)
        Spring.SetUnitMoveGoal(middleID, x, y, z)
    end
end

myMiddle = nil
function respawnUnit()
    if not Spring.ValidUnitID(myMiddle) or Spring.GetUnitIsDead(myMiddle) == true then
        --get the active predecessor
        px, py, pz = Spring.GetUnitPosition(unitID)

        myMiddle, x, y, z = spawnAMiddle(px, py, pz)


        Spring.SetUnitMoveGoal(myMiddle, px, py, pz)
    end
end



function OSLOOP()
    Sleep(100)

    while (true) do
        Sleep(1000)
        respawnUnit()

        setUnitInMotion()
    end
end







function script.AimFromWeapon1()

    return constTongue
end

function script.QueryWeapon1()
    return constTongue
end

tongue31 = piece "tongue31"
boolLoaded = true
function script.AimWeapon1(heading, pitch)
	 Signal(SIG_AIM)
	 Signal(SIG_MOVE)
	 Signal(SIG_IDLE)
	 Signal(SIG_BREATH)
    SetSignalMask(SIG_AIM)
    if boolLoaded == true then


        Sleep(10)
        Signal(SIG_IDLE)
        Signal(SIG_MOVE)
        Turn(Head, x_axis, math.rad(-37), 4)
        Turn(sayAAA, x_axis, math.rad(14), 4)
        Turn(beefcenter, y_axis, heading, 4)
        Turn(tongue31, x_axis, -pitch, 4)
        WaitForTurn(beefcenter, y_axis)

        return true
    else
        return false
    end
end


function script.FireWeapon1()


    boolLoaded = false
    StartThread(reload)
    return true
end

if not GG.BeeefeaterTable then GG.BeeefeaterTable = {} end
if not GG.BeeefeaterTable[teamID] then GG.BeeefeaterTable[teamID] = { father = {} } end
if not GG.BeeefeaterTable[teamID][unitID] then GG.BeeefeaterTable[teamID][unitID] = { middle = {}, tails = {} } end
function script.Create()
    StartThread(sound)

    StartThread(OSLOOP)

    StartThread(hitLoop)
    StartThread(retractTongue)
    StartThread(butIPoopFromThere)
    instantRetract()
end

function script.Killed()
end

function randTimeDelayedDustEmit(piecenr)
    x = math.random(300, 800)
    Sleep(x)
    dice = math.random(0, 1)
    if dice == 1 then
        EmitSfx(piecenr, 1024)
    else

        EmitSfx(piecenr, 1027)
        Sleep(350)
    end
    xi = math.random(0, 3)
    if xi == 2 and maRa() == true then
        Sleep(150)
        EmitSfx(piecenr, 1025)
    end
end

function idleTongue()
    Move(tonguetip, z_axis, 0, 23)
    Sleep(2000)
    Show(tonguetip)
    WaitForMove(tonguetip, z_axis)
    Sleep(450)
    Move(tonguetip, z_axis, -48, 33)
    Sleep(500)
    Hide(tonguetip)
    WaitForMove(tonguetip, z_axis)
end

function wiggleTail()
    SetSignalMask(SIG_WIGGLE)
    oldfirst = 0
    oldsecond = 0

    while (true) do
        first = math.random(-16, 16)
        if oldfirst < 0 then
            if first < 0 then
                first = first * -1
            end
        end
        oldfirst = first
        second = math.random(-35, 35)
        if oldsecond < 0 then
            if second < 0 then
                second = second * -1
            end
        end
        oldsecond = second
        Turn(dustemit1, y_axis, math.rad(first), 4)
        Turn(dustemit2, y_axis, math.rad(second), 4)
        if maRa() == true then
            StartThread(randTimeDelayedDustEmit, dustemit1)
        end
        if maRa() == true then
            StartThread(randTimeDelayedDustEmit, dustemit2)
        end
        if maRa() == true then
            StartThread(randTimeDelayedDustEmit, dustemit3)
        end
        WaitForTurn(dustemit1, y_axis)
        if maRa() == true then
            StartThread(randTimeDelayedDustEmit, dustemit1)
        end
        WaitForTurn(dustemit2, y_axis)
        if maRa() == true then
            StartThread(randTimeDelayedDustEmit, dustemit2)
        end
        if maRa() == true then
            StartThread(randTimeDelayedDustEmit, dustemit3)
        end
        Sleep(280)
    end
end

function mightIdle()
    SetSignalMask(SIG_IDLE)
    t = math.random(2, 6)
    for i = 1, t, 1 do
        idleTongue()
        slerand = math.random(900, 1900)
        Sleep(slerand)
    end
end

function moveIt()
    SetSignalMask(SIG_MOVE)
    while (true) do
        while boolAiming == true do Sleep(100) end
        Speed = math.random(-1, 1)
        Turn(center, y_axis, math.rad(-11), 0.7)


        Speed = math.random(-1, 1)

        WaitForTurn(center, y_axis)

        Sleep(180)
        Speed = math.random(-1, 1)
        Turn(center, y_axis, math.rad(11), 0.7)

        Speed = math.random(-1, 1)

        Speed = math.random(-1, 1)

        WaitForTurn(center, y_axis)

        Sleep(180)
    end
end

function hideThemAll()

    for i = 1, 40, 1 do
        Hide(shells[i])
        Sleep(50)
    end


    for i = 1, 40, 1 do
        Sleep(50)
        Hide(blinkers[i])
    end
end

function script.StartMoving()
    Hide(tonguetip)
    Turn(Head, y_axis, math.rad(0), 13)
    Turn(sayAAA, y_axis, math.rad(0), 13)
    Turn(constTongue, y_axis, math.rad(0), 13)
    if boolAiming == false then
        Turn(beefcenter, y_axis, math.rad(0), 14)
    end

    StartThread(moveIt)
    boolIsMoving = true
    StartThread(wiggleTail)
end

function timedelayedLegsdown()
    SetSignalMask(SIG_LEGS)
    Signal(SIG_MOVE)
    Sleep(10)
    Signal(SIG_BLINK)
    Signal(SIG_IDLE)


    Signal(SIG_WIGGLE)
    Signal(SIG_LEGS)
    Sleep(500)
    boolIsMoving = false
    Sleep(500)


    hideThemAll()
end

function script.StopMoving()
    StartThread(headBang)

    StartThread(timedelayedLegsdown)
    StartThread(mightIdle)
end

------------------------------------------------------------