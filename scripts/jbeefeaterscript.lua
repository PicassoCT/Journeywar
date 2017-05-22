local beefcenter = piece "beefcenter"
local footleft = piece "footleft"
local footright = piece "footright"
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
tonguespeed = 13.1

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
function expandTongue(distance, totalpitchDown, tspeed)
    --Signal(SIG_IDLE)
    if distance > (900) or totalpitchDown > 90 then
        return false
    end
    Show(tonguetip)
    for i = 1, 31, 1 do
        Show(tongue[i])
    end

    Turn(sayAAA, x_axis, math.rad(6), 7.5)
    Turn(Head, x_axis, math.rad(-8), 4.5)
    WaitForTurn(Head, x_axis)
    piecesNeeded = (distance / 28)
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

    if Spring.ValidUnitID(poorFellowsID) == true and likeAFreakTrainGoingNoWhere < someRandomArbitraryHPLimit then
        boolAiming = true
        SetUnitValue(COB.BUSY, 1)
        local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
        local px2, py2, pz2 = Spring.GetUnitBasePosition(poorFellowsID)
        local dx, dy, dz = px2 - px1, py2 - py1, pz2 - pz1
        local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID)) / 32768 * math.pi


        px, py, pz = Spring.GetUnitPosition(poorFellowsID)
        WTurn(beefcenter, y_axis, heading, 12)
        currPosX, currPosY, currPosZ = Spring.GetUnitPosition(unitID)
        distance = math.sqrt(((px - currPosX) ^ 2) + ((pz - currPosZ) ^ 2))

        if expandTongue(distance, math.deg(pitchOfLastShot), 196) == true then
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
            Turn(Head, x_axis, math.rad(-96), 9.0)
            Turn(sayAAA, x_axis, math.rad(10), 9)
            WaitForTurn(Head, x_axis)
            --Sleep(200)
            Turn(constTongue, x_axis, math.rad(-31), 17)
            WaitForMove(tonguetip, z_axis)
            WaitForTurn(Head, x_axis)

            Turn(Head, x_axis, math.rad(0), 9.0)
            Turn(sayAAA, x_axis, math.rad(0), 15)
            Turn(constTongue, x_axis, math.rad(0), 15)
            DropUnit(poorFellowsID)
            Spring.DestroyUnit(poorFellowsID, true, true)
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

            x, y, z = Spring.GetUnitPosition(unitID)
            Spring.CreateFeature("shit", x, y, z)
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

function blinky()
    Signal(SIG_MOVE)
    Sleep(15)
    Signal(SIG_IDLE)
    Sleep(16)
    Signal(SIG_BREATH)
    Sleep(20)

    Sleep(19)
    Signal(SIG_AIM)
    Sleep(18)
    Signal(SIG_WIGGLE)
    Sleep(17)
    Signal(SIG_BLINK)

    SetSignalMask(SIG_BLINK)
    local ldice = dice
    while (true) do
        for i = 1, table.getn(blinkers), 1 do

            if ldice() == true then
                if ldice() == true then
                    temp = blinkers[i]
                    StartThread(showThis, temp)
                end
            else
                temp = blinkers[i]
                StartThread(hideThis, temp)
            end
            if i > 29 then
                temp = shells[i]
                StartThread(hideThis, temp)
            end
        end
        for i = 1, table.getn(shells), 1 do
            if ldice() == true then
                temp = shells[i]
                StartThread(showThis, temp)
            else
                temp = shells[i]
                StartThread(hideThis, temp)
            end
            if i > 29 then
                temp = shells[i]
                StartThread(hideThis, temp)
            end
        end
        Sleep(1050)
    end
end

function reload()
    Sleep(12000)
    boolLoaded = true
end

function damageWatcher()
    oldHP = 0
    currentHP = 0

    currentHP = Spring.GetUnitHealth(unitID)
    oldHP = currentHP
    while (true) do
        currentHP = Spring.GetUnitHealth(unitID)
        if currentHP < oldHP then
            irgendwo = math.random(1, 38)

            Explode(shells[irgendwo], SFX.NO_HEATCLOUD + SFX.FALL)
            for i = 1, 15, 1 do

                EmitSfx(shells[irgendwo], 1028)
                EmitSfx(shells[irgendwo], 1028)
                Sleep(67)
            end
        end
        oldHP = currentHP

        if currentHP < 20 then
            if SumOfParts ~= nil and table.getn(SumOfParts) > 0 then
                for i = 1, table.getn(SumOfParts), 1 do
                    Spring.DestroyUnit(SumOfParts[i][1], true, false)
                end
            end
            Spring.DestroyUnit(tailID, true, false)
            Spring.DestroyUnit(unitID, true, false)
        end
        Sleep(150)
    end
end

function headBang()
    SetSignalMask(SIG_BREATH)
    while (true) do
        Turn(Head, x_axis, math.rad(2), 0.02)
        Turn(sayAAA, x_axis, math.rad(2), 0.02)
        WaitForTurn(Head, x_axis)
        WaitForTurn(sayAAA, x_axis)
        Turn(Head, x_axis, math.rad(-2), 0.02)
        Turn(sayAAA, x_axis, math.rad(-2), 0.02)
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

function spawnATail(x, y, z)
    middleID = Spring.CreateUnit("jbeefeatertail", x, y, z, 0, teamID)
    Spring.SetUnitMoveGoal(middleID, x, y, z)
    Spring.SetUnitNoSelect(middleID, true)
    return middleID
end

function spawnAMiddle(x, y, z)
    id, nr = getLastActiveTableIDinIntervalls(1, table.getn(SumOfParts))
    x, y, z = Spring.GetUnitPosition(id)
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


function getLastActiveTableIDinIntervalls(a, o)


    LastFoundActiveID = unitID
    nr = a
    for i = a, o, 1 do
        if Spring.ValidUnitID(SumOfParts[i][1]) == true then
            LastFoundActiveID = SumOfParts[i][1]
            nr = i
        end
    end


    return LastFoundActiveID, nr
end



--------------------------------------------------
function DistanceToPredecessor(i)
    currentX, currentY, currentZ = Spring.GetUnitPosition(SumOfParts[i][1])

    predecssorID, nr = getLastActiveTableIDinIntervalls(1, i - 1)
    px, py, pz = Spring.GetUnitPosition(predecssorID)
    distance = math.sqrt(((currentX - (px)) ^ 2) + ((currentZ - (pz)) ^ 2))
    return distance
end

function setUnitStop(nr)
    x, y, z = Spring.GetUnitPosition(SumOfParts[nr][1])
    Spring.SetUnitMoveGoal(SumOfParts[nr][1], x, y, z)
end

function getPredecessorPosition(i)
    predecssorID, nr = getLastActiveTableIDinIntervalls(1, i - 1)
    x, y, z = Spring.GetUnitPosition(SumOfParts[nr][1])
    return x, y, z
end

function updateUnitCurrentPosition(nr)
    x, y, z = Spring.GetUnitPosition(nr)
    SumOfParts[nr][2] = x
    SumOfParts[nr][3] = y
    SumOfParts[nr][4] = z
end

function setUnitInMotion(nr)
    DistanceTP = (DistanceToPredecessor(nr))
    boolValiDated = Spring.ValidUnitID((SumOfParts[nr][1]))
    --if the unit still exists and the distance to is predecessor is not to small
    if DistanceTP <= predecessorMaxDist and boolValiDated == true then
        --- -Spring.Echo("SUM1")
        setUnitStop(nr)
        updateUnitCurrentPosition(nr)
    else
        --- -Spring.Echo("SUM2")
        if nr ~= 1 and boolValiDated == true and DistanceTP > predecessorMaxDist then
            --- -Spring.Echo("SUM3")
            x, y, z = getPredecessorPosition(nr)
            Spring.SetUnitMoveGoal(SumOfParts[nr][1], x, y, z)
            updateUnitCurrentPosition(nr)
        elseif nr == 1 and boolValiDated == true and DistanceTP > predecessorMaxDist then
            --- -Spring.Echo("SUM4")
            x, y, z = Spring.GetUnitPosition(unitID)
            Spring.SetUnitMoveGoal(SumOfParts[nr][1], x, y, z)
            updateUnitCurrentPosition(nr)
        end
    end
end

function respawnUnit(nr)
    --get the active predecessor
    id, nr = getLastActiveTableIDinIntervalls(1, nr - 1)
    px, py, pz = Spring.GetUnitPosition(id)
    SumOfParts[nr] = {}
    middleManID, x, y, z = spawnAMiddle(px, py, pz)
    SumOfParts[nr][1] = middleManID
    SumOfParts[nr][2] = x
    SumOfParts[nr][3] = y
    SumOfParts[nr][4] = z
    SumOfParts[nr][5] = middleCounterValue
    Spring.SetUnitMoveGoal(SumOfParts[nr][1], px, py, pz)
end

function counterStrike()
    --function iterates through the counters and resets the validUnits, while decreasing the invalid ones. It also respawns deceased Tails
    for i = 1, table.getn(SumOfParts), 1 do
        if Spring.ValidUnitID((SumOfParts[i][1])) == true then
            --reset the counterStrike
            SumOfParts[i][5] = middleCounterValue
        else
            --decrease the counterStrike
            SumOfParts[i][5] = SumOfParts[i][5] - DecreaSor
            --check if the counter is below zero
            if SumOfParts[i][5] < 0 then
                respawnUnit(i)
            end
        end
    end
end

function expToLenghtConverter()
    while ((Spring.GetUnitExperience(unitID)) > table.getn(SumOfParts)) do
        --- -Spring.Echo("Spawning a additonal Tail")
        leastActiveTableID, nr = getLastActiveTableIDinIntervalls(1, table.getn(SumOfParts))
        newBornID = spawnAMiddle(SumOfParts[nr][2], SumOfParts[nr][3], SumOfParts[nr][4])
        toTheMax = table.getn(SumOfParts) + 1
        SumOfParts[toTheMax] = {}
        SumOfParts[toTheMax][1] = newBornID
        x, y, z = Spring.GetUnitPosition(newBornID)
        SumOfParts[toTheMax][2] = x
        SumOfParts[toTheMax][3] = y
        SumOfParts[toTheMax][4] = z
        SumOfParts[toTheMax][5] = middleCounterValue
    end
end


function spawnHeadElement()
    --spawnFirstHeadTailElement
    x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, dustemit3)
    SumOfParts[1] = {}
    middleManID, x, y, z = spawnAMiddle(x, y, z)
    SumOfParts[1][1] = middleManID
    SumOfParts[1][2] = x
    SumOfParts[1][3] = y
    SumOfParts[1][4] = z
    SumOfParts[1][5] = middleCounterValue
end

function OSLOOP()
    Sleep(100)
    spawnHeadElement()
    while (true) do
        Sleep(1000)
        expToLenghtConverter()
        counterStrike()
        for i = 1, table.getn(SumOfParts), 1 do
            setUnitInMotion(i)
        end
    end
end


function tailToLastActivePartDistance(tailID)
    id = getLastActiveTableIDinIntervalls(1, table.getn(SumOfParts))
    x, y, z = Spring.GetUnitPosition(id)
    tx, ty, tz = Spring.GetUnitPosition(tailID)
    result = math.sqrt(((x - tx) ^ 2) + ((z - tz) ^ 2))
    return result
end


function tailLoop()
    Sleep(100)
    local counter = 30

    x, y, z = Spring.GetUnitPosition(unitID)
    local tailID = spawnATail(x, y, z)

    while (true) do
        Sleep(1000)



        if Spring.ValidUnitID(tailID) == true then
            --- -Spring.Echo("unitStillExists")

            if tailToLastActivePartDistance(tailID) > tailDistance then
                if (SumOfParts == nil or table.getn(SumOfParts) == 0) then
                    x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, dustemit3)
                    Spring.SetUnitMoveGoal(tailID, x, y, z)
                    counter = 30
                else
                    --- -Spring.Echo("MoreA")
                    ---- Spring.Echo(table.getn(SumOfParts))
                    last, nr = getLastActiveTableIDinIntervalls(1, table.getn(SumOfParts))
                    tx, ty, tz = Spring.GetUnitPosition(last)

                    --- -Spring.Echo("MoreA")

                    Spring.SetUnitMoveGoal(tailID, tx, ty, tz)
                    counter = 30
                end
            else
                x, y, z = Spring.GetUnitPosition(tailID)
                Spring.SetUnitMoveGoal(tailID, x, y, z)
            end
        else
            --- -Spring.Echo("B")
            if counter > 0 then
                --recreate Tail
                counter = counter - 10
            else
                x, y, z = Spring.GetUnitPosition(unitID)
                tailID = spawnATail(x, y, z)
                counter = 30
            end
        end

        --- -Spring.Echo("TailLoop Still alive")
    end
end




function script.AimFromWeapon1()

    return constTongue
end

function script.QueryWeapon1()
    return constTongue
end

boolLoaded = true
function script.AimWeapon1(heading, pitch)

    SetSignalMask(SIG_AIM)
    if boolLoaded == true then

        --Signal(SIG_MOVE)
        Sleep(10)
        Signal(SIG_IDLE)

        Turn(beefcenter, y_axis, heading, 4)
        WaitForTurn(beefcenter, y_axis)
        headingOfLastShot = heading
        pitchOfLastShot = pitch
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

function script.Create()
    Hide(footleft)
    Hide(footright)
    StartThread(hitLoop)
    StartThread(sound)
    StartThread(blinky)
    StartThread(damageWatcher)
    StartThread(OSLOOP)
    StartThread(tailLoop)
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
    if xi == 2 and dice() == true then
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
        if dice() == true then
            StartThread(randTimeDelayedDustEmit, dustemit1)
        end
        if dice() == true then
            StartThread(randTimeDelayedDustEmit, dustemit2)
        end
        if dice() == true then
            StartThread(randTimeDelayedDustEmit, dustemit3)
        end
        WaitForTurn(dustemit1, y_axis)
        if dice() == true then
            StartThread(randTimeDelayedDustEmit, dustemit1)
        end
        WaitForTurn(dustemit2, y_axis)
        if dice() == true then
            StartThread(randTimeDelayedDustEmit, dustemit2)
        end
        if dice() == true then
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
        randdegree = math.random(-5, 5)
        Turn(Head, y_axis, math.rad(randdegree), 7)
        Turn(sayAAA, y_axis, math.rad(randdegree), 7)
        Turn(constTongue, y_axis, math.rad(randdegree), 7)
        WaitForTurn(Head, y_axis)
    end
end

function moveIt()
    SetSignalMask(SIG_MOVE)
    while (true) do
        while boolAiming == true do Sleep(100) end
        Speed = math.random(-1, 1)
        Turn(center, y_axis, math.rad(-11), 0.7)

        -- Turn(footleft,y_axis,math.rad(75),5+Speed)
        Speed = math.random(-1, 1)
        --Turn(footright,y_axis,math.rad(5),5+Speed)
        --Turn(footright,x_axis,math.rad(-17),6)
        WaitForTurn(center, y_axis)
        --WaitForTurn(footleft,y_axis)
        --WaitForTurn(footright,y_axis)
        --Turn(footright,x_axis,math.rad(0),12)
        Sleep(180)
        Speed = math.random(-1, 1)
        Turn(center, y_axis, math.rad(11), 0.7)
        --Turn(footright,y_axis,math.rad(-75),5+Speed)
        Speed = math.random(-1, 1)
        -- Turn(footleft,y_axis,math.rad(0),5+Speed)
        Speed = math.random(-1, 1)
        -- Turn(footleft,x_axis,math.rad(-17),5+Speed)
        --WaitForTurn(footleft,y_axis)
        --WaitForTurn(footright,y_axis)
        WaitForTurn(center, y_axis)
        -- Turn(footleft,x_axis,math.rad(0),12)
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
    StartThread(blinky)
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

    -- Turn(footleft,x_axis,math.rad(0),2)
    --Turn(footright,x_axis,math.rad(0),2)
    -- Turn(footleft,y_axis,math.rad(0),2)
    --Turn(footright,y_axis,math.rad(0),2)
    hideThemAll()
end

function script.StopMoving()
    StartThread(headBang)

    StartThread(timedelayedLegsdown)
    StartThread(mightIdle)
end

------------------------------------------------------------