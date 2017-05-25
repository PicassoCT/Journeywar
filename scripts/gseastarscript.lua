include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"
local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
SIG_WALK = 2
boolCringeNotRunning = true
function script.HitByWeapon(x, z, weaponDefID, damage)
    if maRa() == true and boolCringeNotRunning == true then

        StartThread(cringe)
    end
    return damage
end

myDefID = Spring.GetUnitDefID(unitID)
function cringe()
    boolCringeNotRunning = false
    value = math.random(-42, 42)
    for k = 1, 5 do
        for i = 2, 6 do
            sign = randSign()

            WTurn(Knees[k][i], y_axis, math.rad(value * sign), 42)
        end
    end

    boolCringeNotRunning = true
end


center = piece "center"
fooNction = piece
piecesTable = makeKeyPiecesTable(unitID, fooNction)

function LiftFunction(KneeT, Speed)
    for i = 1, #KneeT, 1 do
        Turn(KneeT[i], x_axis, math.rad(7), Speed)
    end
    WaitForTurn(KneeT[1], x_axis)
end

function deathTimer()

    headingofold = Spring.GetUnitHeading(unitID)
    lifetime = 60 * 1000 * 8
    Sleep(lifetime)


    local spGetUnitPosition = Spring.GetUnitPosition

    newHeading = Spring.GetUnitHeading(unitID)
    x, y, z = spGetUnitPosition(unitID)
    Sleep(1000)
    ox, oy, oz = spGetUnitPosition(unitID)
    while x - ox ~= 0 or x - ox ~= 0 or x - ox ~= 0 or headingofold ~= newHeading do
        ox, oy, oz = x, y, z
        headingofold = newHeading
        x, y, z = spGetUnitPosition(unitID)
        Sleep(1000)
        newHeading = Spring.GetUnitHeading(unitID)
    end

    cosFunc = function(val) return math.cos(val) end
    waveATable(Knees, x_axis, cosFunc, -1, 0.32, math.random(0.77, 1.4), 4.5, true)


    Spring.DestroyUnit(unitID, true, false)
end

--wiggles the feet, and applies motion if turning
function wiggleFeet(FirstPoint, NaturalDeg)

    for k = 1, 5 do
        frame = Spring.GetGameFrame()
        frame = frame / 300
        piEight = 3.1415 / math.floor(math.random(4, 12))
        dice = math.random(-25, 25)
        for i = 1, 6 do
            sperd = math.random(1, 5) / 100
            val = math.sin(frame + piEight * i) * dice
            Turn(Knees[k][i], y_axis, math.rad(val), sperd)
        end
    end

    WaitForTurn(Knees[#Knees][6], y_axis)
    Sleep(3000)
end




local spGetGroundHeight = Spring.GetGroundHeight
local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir

function HowHighIsTheTireMama(i, piecename)
    x, y, z, _, _, _ = spGetUnitPiecePosDir(unitID, piecename)
    h = spGetGroundHeight(x, z)
    return y, h
end


Knees = {}

firstAxis = {}
for nr = 1, 5 do
    firstAxis[#firstAxis + 1] = piecesTable["ConTurn" .. nr]; nr = nr + 1
end
nr = 1
SensorTable = {}
for k = 1, 5 do
    Knees[k] = {}
    SensorTable[k] = {}

    for i = 1, 6 do
        Knees[k][i] = piecesTable["Feet" .. (nr)]
        SensorTable[k][i] = piecesTable["Sensor" .. (nr)]
        nr = nr + 1
    end
end

sensorT = {}
sensorT[#sensorT + 1] = piecesTable["Feet1"]
sensorT[#sensorT + 1] = piecesTable["Feet7"]
sensorT[#sensorT + 1] = piecesTable["Feet13"]
sensorT[#sensorT + 1] = piecesTable["Feet19"]
sensorT[#sensorT + 1] = piecesTable["Feet25"]
LiftF = LiftFunction
LowerF = LowerFunction

inPieces = {}

function script.Create()

    inPieces = Spring.GetUnitPieceMap(unitID)
    resetT(inPieces)
    for nr = 1, 5 do
        Turn(firstAxis[nr], y_axis, math.rad(-190 + (65) * nr), 0)
    end

    configTable = { id = unitID, centerNode = center, nr = 5, feetTable = { firstAxis = firstAxis, Knees = Knees }, sensorTable = sensorT, ElementWeight = 5, FeetLiftForce = 3, LiftFunction = LiftF, Height = 32, WiggleFunc = wiggleFeet, tipTable = SensorTable }
    StartThread(adaptiveAnimationThreadStarter, configTable, inPieces, 4, unitID)
    StartThread(deathTimer)
    StartThread(FeedMe)
end

function adaptiveAnimationThreadStarter(configTable, inPieces, Sig, id)
    Signal(Sig)
    SetSignalMask(Sig)
    StartThread(adaptiveAnimation, configTable, inPieces, id, Spring.UnitScript)
end

seastardefID = Spring.GetUnitDefID(unitID)
Seastars = {}
table.insert(Seastars, seastardefID)

infantryTable = getInfantryTypeTable()
creeperTypeTable = getCreeperTypeTable()
corpseTypeTable = getCorpseTypeTable()
neutralTypeTable = getNeutralTypeTable()
function FeedMe()
    Sleep(13000)
    while true do
        --Something nearby
        boolfoundSomething = false
        Sensor = 1

        for i = 1, #sensorT, 1 do
            x, y, z = Spring.GetUnitPiecePosDir(unitID, sensorT[i])
            T = getAllInCircle(x, z, 80, unitID)

            if T then filterOutUnitsOfType(T, Seastars) end
            T = process(T,
                function(id)
                    uDefid = Spring.GetUnitDefID(id)
                    if id ~= unitID and uDefid ~= myDefID and neutralTypeTable[uDefid] or infantryTable[uDefid] or creeperTypeTable[uDefid] or corpseTypeTable[uDefid] then
                        return id
                    end
                end,
                function(id)
                    if id then
                        transportID = Spring.GetUnitTransporter(id)
                        if transportID == nil or transportID == unitID then
                            return id
                        end
                    end
                end)
            if T and #T > 0 then
                boolfoundSomething = true;
                Sensor = i;
                break
            end
        end

        if boolfoundSomething == true then

            Signal(4)
            Signal(8)
            --Attach victim

            --roll in Corresponding Feed Thread
            index = 1
            if #T > 1 then index = math.ceil(math.random(1, #T)) end

            if Spring.ValidUnitID(T[index]) == true then
                if infantryTable[Spring.GetUnitDefID(T[index])] then
                    selects = math.random(1, 4)
                    StartThread(PlaySoundByUnitDefID, myDefID, "sounds/gSeastar/scream" .. selects .. ".ogg", 0.5, 2000, 2, 0)
                end
                AttachUnit(Knees[Sensor][1], T[index])
                Turn(sensorT[Sensor], y_axis, math.rad(90), 2)
                for i = 1, 6 do
                    Turn(Knees[Sensor][i], x_axis, math.rad(-15), 5.33)

                    WaitForTurn(Knees[Sensor][i], x_axis)
                end
                Sleep(250)
                for i = 1, 6 do
                    Turn(Knees[Sensor][i], y_axis, math.rad(75), 5.33)
                    Turn(Knees[Sensor][i], x_axis, math.rad(3), 3.33)
                    WaitForTurn(Knees[Sensor][i], y_axis)
                end
                Sleep(250)
                WaitForTurn(sensorT[Sensor], y_axis)
                DropUnit(T[index])
                Spring.DestroyUnit(T[index], true, true)
            end

            StartThread(adaptiveAnimationThreadStarter, configTable, inPieces, 4, unitID)

            Sleep(12000)
        end

        Sleep(500)
    end
end

function script.Killed(recentDamage, _)

    createCorpseJUnitGeneric(recentdamage)
    return 1
end



function script.StartMoving()
    if GG.MovementOS_Table and GG.MovementOS_Table[unitID] and GG.MovementOS_Table[unitID].boolmoving then
        GG.MovementOS_Table[unitID].boolmoving = true
    end
end

function delayedSetStop()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)
    Sleep(500)
    GG.MovementOS_Table[unitID].boolmoving = false
end

function script.StopMoving()
    if GG.MovementOS_Table and GG.MovementOS_Table[unitID] and GG.MovementOS_Table[unitID].boolmoving then
        StartThread(delayedSetStop)
    end
end

function script.Activate()

    return 1
end

function script.Deactivate()

    return 0
end

function script.QueryBuildInfo()
    return center
end


function script.TransportPickup(passengerID)

    SetUnitValue(COB.BUSY, 1)

    SetUnitValue(COB.BUSY, 0)
end


function script.TransportDrop(passengerID, x, y, z)
    SetUnitValue(COB.BUSY, 1)



    SetUnitValue(COB.BUSY, 0)
end

Spring.SetUnitNanoPieces(unitID, { center })