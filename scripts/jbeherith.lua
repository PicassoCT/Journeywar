include "lib_UnitScript.lua"
include "jVitalFunctions.lua"
include "createCorpse.lua"
--Pieces
treeSpot = piece "treeSpot"
nomnom1 = piece "nomnom1"

frontAppendixTable = {}
for i = 1, 7, 1 do
    frontAppendixTable[i] = {}
    piecename = "jBH2A" .. i
    frontAppendixTable[i] = piece(piecename)
end
boolAPPinBattle1 = false
boolAPPinBattle2 = false
boolAPPinBattle3 = false
boolAPPinBattle4 = false
boolAPPinBattle5 = false
appendixBooleans = {}
table.insert(appendixBooleans, boolAPPinBattle1)
table.insert(appendixBooleans, boolAPPinBattle2)
table.insert(appendixBooleans, boolAPPinBattle3)
table.insert(appendixBooleans, boolAPPinBattle4)
table.insert(appendixBooleans, boolAPPinBattle5)
local headingTable = {}
for i = 1, 5, 1 do headingTable[i] = 0 end

appendixTable1 = {}
appendixTable3 = {}
appendixTable4 = {}
appendixTable5 = {}

local overTableA = {}
table.insert(overTableA, appendixTable1)
table.insert(overTableA, frontAppendixTable)
table.insert(overTableA, appendixTable3)
table.insert(overTableA, appendixTable4)
table.insert(overTableA, appendixTable5)

for i = 1, 5, 1 do
    if i ~= 2 then
        for j = 1, 7, 1 do
            piecename = "jBH" .. i
            piecename = piecename .. "A"
            piecename = piecename .. j
            insertMe = piece(piecename)
            if i == 1 then
                appendixTable1[j] = insertMe
            elseif i == 3 then
                appendixTable3[j] = insertMe
            elseif i == 4 then
                appendixTable4[j] = insertMe
            else
                appendixTable5[j] = insertMe
            end
        end
    end
end
butFlyTable = {}
bnr = 6
for i = 1, bnr, 1 do
    butFlyTable[i] = {}
    piecename = "jBButFly" .. i
    butFlyTable[i] = piece(piecename)
    butFlyTable[i + bnr] = false
end

butFlyWingsTable = {}
for i = 1, bnr * 2, 1 do
    butFlyWingsTable[i] = {}
    piecename = "jBBFWing" .. i
    butFlyWingsTable[i] = piece(piecename)
end

galTable = {}
--fishes
jBFish1 = piece "jBFish1"
jBFish2 = piece "jBFish2"
jBFish3 = piece "jBFish3"
jB3Fish3 = piece "jB3Fish3"
jB3Fish2 = piece "jB3Fish2"
jB3Fish1 = piece "jB3Fish1"
jBshark1 = piece "jBshark1"
jBshark02 = piece "jBshark02"
jBshatail1 = piece "jBshatail1"
jBshatail0 = piece "jBshatail0"
jBGal02 = piece "jBGal02"
jBGalCon02 = piece "jBGalCon02"
jBGalExp02 = piece "jBGalExp02"
jBGal = piece "jBGal"
jBGalCon = piece "jBGalCon"
jBGalExp = piece "jBGalExp"
jBGal03 = piece "jBGal03"
jBGalCon03 = piece "jBGalCon03"
jBGalExp03 = piece "jBGalExp03"
jBGal01 = piece "jBGal01"
jBGalCon01 = piece "jBGalCon01"
jBGalExp01 = piece "jBGalExp01"

table.insert(galTable, jBGal)
table.insert(galTable, jBGal01)
table.insert(galTable, jBGal02)
table.insert(galTable, jBGal03)

boolCollib01busy = false
jBColib01 = piece "jBColib01"
jBColibWd0 = piece "jBColibWd0"
jBColibWu0 = piece "jBColibWu0"

boolCollibbusy = false
jBColib = piece "jBColib"
jBColibWup = piece "jBColibWup"
jBColibWdo = piece "jBColibWdo"
local ms1 = piece "ms1"
local ms2 = piece "ms2"
local body = piece "jBeCenter"
jBeGuBig = piece "jBeGuBig"
jBeGuSmal0 = piece "jBeGuSmal0"
jBeGuSmall = piece "jBeGuSmall"
gullcircle = piece "gullcircle"
swimWaterHeight = 73.5

fishes = {}
table.insert(fishes, jBFish1)
table.insert(fishes, jBFish2)
table.insert(fishes, jBFish3)
table.insert(fishes, jB3Fish2)
table.insert(fishes, jB3Fish1)
table.insert(fishes, jB3Fish3)


fishCenters = {}
for i = 1, 12, 1 do
    fishCenters[i] = {}
    tempiece = "fishCenter" .. i
    fishCenters[i] = piece(tempiece)
end


--enum
--70->90 are trees
optObjects = {}
for i = 1, 121, 1 do
    optObjects[i] = {}
    tempiece = "obj" .. i
    optObjects[i] = piece(tempiece)
end

HeGotLegAndKnowsHowToUseIt = {}
for i = 1, 6, 1 do
    HeGotLegAndKnowsHowToUseIt[i] = {}
    tempiece = "jBeLeg" .. i
    HeGotLegAndKnowsHowToUseIt[i] = piece(tempiece)
end

local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
local loaded = false
local cargo = 0
local cargoMax = 5
local checkRange = 60

sloth = {}
for i = 1, 5, 1 do
    sloth[i] = {}
    tempiece = "transportAttach" .. i
    sloth[i] = piece(tempiece)
end

dustEmit = {}
for i = 1, 6, 1 do
    dustEmit[i] = {}
    tempiece = "dustEmit" .. i
    dustEmit[i] = piece(tempiece)
end

emitPlants = {}
for i = 1, 12, 1 do
    emitPlants[i] = {}
    tempiece = "paPlant" .. i
    emitPlants[i] = piece(tempiece)
end

impalePoint1 = piece "impalePoint1"
boolImpale1 = false
impalePoint2 = piece "impalePoint2"
boolImpale2 = false
--/Pieces
degXAppTable = {}
degZAppTable = {}
for i = 1, 5, 1 do
    degXAppTable[i] = {}
    degXAppTable[i] = 0
    degZAppTable[i] = {}
    degZAppTable[i] = 0
end

local spx = 0.5
local spz = 0.5


boolAttached = {}
for i = 1, 5, 1 do
    boolAttached[i] = false
end
--Signal
local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_MOVE = 4
--/Signal
--Booleans


boolConstMove = false
boolPeaceFool = true
boolAmok = false
boolNewInertia = false
local boolwalk = true
--/Booleans

--<Inertia>


treeInertiaMultiplier = 1.0
plantInertiaMulitplier = 0.65
--</Inertia>
--<Passenger Values>
local passengertable = {}

--</Passenger Values>
--<UnitValues>
lastLifeTime = 30000
piMalDaumen = 3
gmassiveDamage = 600
inertiaBlendInFactor = 1.0
--</UnitValues>
--FUNKTIONS (ALOT OF THEM)
--on steroids everyon has seen BAR - Tl,dr; function generates a new Beherith everytime it is
--called, by idling with a NumberGen+Random through the Piecelist using Show. Also does some basic work like spinning up the doves#
--<animalKingdom>
function wiggleFishes()
    while (true) do
        wiggle = math.random(-5, 5)
        depth = math.random(-12, 0)
        randy = math.random(1, 6)
        if wiggle == 0 then
            Move(fishes[randy], y_axis, depth, 0.2)
        end
        for i = 1, table.getn(fishes), 1 do
            Turn(fishes[i], y_axis, math.rad(wiggle), 0.35)
        end
        randy = math.random(1, 6)
        WaitForTurn(fishes[randy], y_axis)
        for i = 1, table.getn(fishes), 1 do
            Turn(fishes[i], y_axis, math.rad(wiggle * -1), 0.35)
        end
        randy = math.random(1, 6)
        WaitForTurn(fishes[randy], y_axis)
        Sleep(10)
    end
end

function anShark1()
    while (true) do
        force = math.random(4, 12)
        Turn(jBshark1, y_axis, math.rad(force * -1), 0.6)
        Turn(jBshatail1, y_axis, math.rad((force / 0.5)), 0.3)
        WaitForTurn(jBshatail1, y_axis)
        WaitForTurn(jBshark1, y_axis)
        Turn(jBshark1, y_axis, math.rad(force), 0.6)
        Turn(jBshatail1, y_axis, math.rad(((force * -1) / 0.5)), 0.3)
        WaitForTurn(jBshatail1, y_axis)
        WaitForTurn(jBshark1, y_axis)
        Turn(jBshark1, y_axis, math.rad(0), 0.6)
        Turn(jBshatail1, y_axis, math.rad(0), 0.3)
        Sleep(500)
    end
end



function anShark2()
    while (true) do
        force = math.random(4, 12)
        Turn(jBshark02, y_axis, math.rad(force * -1), 0.6)
        Turn(jBshatail0, y_axis, math.rad((force / 0.5)), 0.3)
        WaitForTurn(jBshatail0, y_axis)
        WaitForTurn(jBshark02, y_axis)
        Turn(jBshark02, y_axis, math.rad(force), 0.6)
        Turn(jBshatail0, y_axis, math.rad(((force * -1) / 0.5)), 0.3)
        WaitForTurn(jBshatail0, y_axis)
        WaitForTurn(jBshark02, y_axis)
        Turn(jBshark02, y_axis, math.rad(0), 0.6)
        Turn(jBshatail0, y_axis, math.rad(0), 0.3)
        Sleep(500)
    end
end

function script.TransportPickup(passengerID)
    -- no napping!
    local passengerTeam = Spring.GetUnitTeam(passengerID)
    local ourTeam = Spring.GetUnitTeam(unitID)
    if not Spring.AreTeamsAllied(passengerTeam, ourTeam) then
        return
    end


    --if opera has full house
    if cargo >= cargoMax then return end
    SetUnitValue(COB.BUSY, 1)




    local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
    local px2, py2, pz2 = Spring.GetUnitBasePosition(passengerID)
    local dx, dy, dz = px2 - px1, py2 - py1, pz2 - pz1
    local dist = (dx ^ 2 + dy ^ 2) ^ 0.5

    --openBayDoors

    if dist > 250 then return end
    table.insert(passengertable, passengerID)
    cargo = cargo + 1
    --get passengers defid
    passengerDefID = Spring.GetUnitDefID(passengerID)
    if passengerDefID == UnitDefNames["bg"].id or passengerDefID == UnitDefNames["tiglil"].id or passengerDefID == UnitDefNames["skinfantry"].id or passengerDefID == UnitDefNames["vort"].id then
        AttachUnit(sloth[cargo], passengerID)
    else
        AttachUnit(body, passengerID)
        Spring.SetUnitNoDraw(passengerID, true)
    end
    loaded = true
    SetUnitValue(COB.BUSY, 0)
end


function script.TransportDrop(passengerID, x, y, z)
    if loaded == false then return end
    --if unit not loaded
    notloaded = true
    for i = 1, cargo, 1 do
        if passengertable[i] == passengerID then
            notloaded = false
        end
    end

    if notloaded == true then
        --Spring.Echo("NotLoaded")
        return
    end

    SetUnitValue(COB.BUSY, 1)

    Spring.SetUnitNoDraw(passengerID, false)

    DropUnit(passengerID)
    cargo = cargo - 1

    if cargo <= 0 then
        loaded = false
    end
    SetUnitValue(COB.BUSY, 0)
end







function collibJob01()
    turn = math.random(0, 360)
    newHeight = math.random(0, 13)
    outMove = math.random(-42, 5)
    Turn(jBColib01, y_axis, turn, 1.2)
    Move(jBColib01, y_axis, newHeight, 0.2)
    Move(jBColib01, x_axis, outMove, 0.4)
    WaitForTurn(jBColib01, y_axis)
    randSleep = math.random(150, 1800)
    Sleep(randSleep)
    boolCollib01busy = false
end

function butFlyJob(nr)

    turn = math.random(0, 360)
    newHeight = math.random(3, 32)
    outMove = math.random(-25, 25)
    Turn(butFlyTable[nr], y_axis, turn, 0.02)
    Move(butFlyTable[nr], y_axis, newHeight, 0.1)
    Move(butFlyTable[nr], x_axis, outMove, 0.02)
    WaitForTurn(butFlyTable[nr], y_axis)
    randSleep = math.random(150, 1800)
    Sleep(randSleep)
    butFlyTable[nr + bnr] = false
end

function collibJob()
    turn = math.random(0, 360)
    newHeight = math.random(0, 13)
    outMove = math.random(-42, 5)
    Turn(jBColib, y_axis, turn, 0.5)
    Move(jBColib, y_axis, newHeight, 0.3)
    Move(jBColib, x_axis, outMove, 0.6)
    WaitForTurn(jBColib, y_axis)
    randSleep = math.random(150, 1800)
    Sleep(randSleep)
    boolCollibbusy = false
end

--butterflys

function turnButtFlys()
    while (true) do
        for i = 1, bnr, 1 do
            if butFlyTable[i + bnr] == false then
                butFlyTable[i + bnr] = true
                StartThread(butFlyJob, i)
            end
        end
        Sleep(300)
    end
end

function turnCollibs()
    while (true) do
        if boolCollib01busy == false then
            boolCollib01busy = true
            StartThread(collibJob01)
        end
        if boolCollibbusy == false then
            boolCollibbusy = true
            StartThread(collibJob)
        end

        Sleep(300)
    end
end

function galDirection()
    while (true) do
        throwADice = math.random(0, 32)
        if throwADice == 16 then
            throwADice = (throwADice % 3) + 1
            disDance = math.random(-70, 0)
            Move(galTable[throwADice], x_axis, disDance, 0.1)
        end

        for i = 1, table.getn(galTable), 1 do
            dirAction = math.random(0, 34)
            Turn(galTable[i], x_axis, math.rad(dirAction), 0.1)
        end
        Sleep(12000)
    end
end

function SirgalertHead()
    while (true) do
        if boolwalk == false then
            Show(jBGalCon)
            Show(jBGalCon01)
            Show(jBGalCon03)
            Show(jBGalCon02)


            Hide(jBGalExp)
            Hide(jBGalExp01)
            Hide(jBGalExp03)
            Hide(jBGalExp02)

            Sleep(1300)
            Hide(jBGalCon)
            Hide(jBGalCon01)
            Hide(jBGalCon03)
            Hide(jBGalCon02)

            Show(jBGalExp)
            Show(jBGalExp01)
            Show(jBGalExp03)
            Show(jBGalExp02)
            Sleep(2300)

        else
            Sleep(2000)
            Hide(jBGalCon)
            Hide(jBGalCon01)
            Hide(jBGalCon03)
            Hide(jBGalCon02)
            Hide(jBGalExp)
            Hide(jBGalExp01)
            Hide(jBGalExp03)
            Hide(jBGalExp02)
        end
    end
end

function flapCollibWings()
    while true do
        Sleep(210)
        Show(jBColibWup)
        Show(jBColibWu0)
        Hide(jBColibWdo)
        Hide(jBColibWd0)
        Sleep(200)
        Hide(jBColibWup)
        Hide(jBColibWu0)
        Show(jBColibWdo)
        Show(jBColibWd0)
    end
end

lasttime = 1
randSpeed = 0.5
function flapWing(nr, degree, strength)
    lasttime = lasttime + 1
    if lasttime % 2 == 0 then
        randSpeed = math.random(0.5, 1.5)
        lasttime = 0
    end

    Turn(butFlyWingsTable[nr], x_axis, math.rad(degree), randSpeed)
end

function flapButtFlyWings()
    while (true) do

        for i = 1, table.getn(butFlyWingsTable), 2 do
            howUp = math.random(-36, -16)
            howFast = math.random(0.05, 0.1)
            StartThread(flapWing, i, howUp, howFast)
            StartThread(flapWing, i + 1, (howUp * -1), howFast)
        end
        sleeptime = math.random(850, 1500)
        Sleep(sleeptime)
        --down
        for i = 1, table.getn(butFlyWingsTable), 2 do
            howDown = math.random(16, 36)
            howFast = math.random(0.1, 0.2)
            StartThread(flapWing, i, howDown, howFast)
            StartThread(flapWing, i + 1, (howDown * -1), howFast)
        end
        sleeptime = math.random(650, 1200)
        Sleep(sleeptime)
    end
end

function tiltGullCircle()
    while true do
        tilt = math.random(-8, 8)
        Turn(gullcircle, z_axis, math.rad(tilt), 0.0000001)
        WaitForTurn(gullcircle, z_axis)
        Sleep(1000)
    end
end

--</animalKingdom>
--builds a new Beherith with every call
function beheBodyBuilder()
    basic = math.random(1, 3)
    additions = math.random(3, 7)
    for i = 1, table.getn(optObjects), 1 do
        if i % basic == 0 or i % additions == 0 then
            Show(optObjects[i])
        else
            Hide(optObjects[i])
        end
    end
end

function setUp()
    beheBodyBuilder()
    StartThread(wiggleFishes)
    StartThread(anShark1)
    StartThread(anShark2)
    StartThread(flapButtFlyWings)
    StartThread(turnButtFlys)
    StartThread(galDirection)
    StartThread(SirgalertHead)
    StartThread(turnCollibs)
    StartThread(flapCollibWings)
    StartThread(tiltGullCircle)
    for i = 1, 12, 1 do
        Hide(emitPlants[i])
    end

    for i = 1, 12, 1 do
        spin = math.random(-10, -5)
        Spin(fishCenters[i], y_axis, math.rad(spin), 0.5)
    end


    Spin(gullcircle, y_axis, math.rad(0.2), 0.5)
    Spin(jBeGuBig, y_axis, math.rad(10), 0.5)
    Spin(jBeGuSmal0, y_axis, math.rad(-10), 0.5)
    Spin(jBeGuSmall, y_axis, math.rad(10), 0.5)
end


function tickTockTackle()
    Spring.PlaySoundFile("sounds/jbeherith/trumpet.wav")
    Sleep(lastLifeTime)
    StartThread(bloodEmit, 3000)
    --Keep Doves over Cadaver for a while
    Hide(gullcircle)
    Hide(jBeGuBig)
    Hide(jBeGuSmal0)
    Hide(jBeGuSmall)
    Turn(body, y_axis, math.rad(15), 0.5)
    for i = 1, 6, 1 do
        Turn(HeGotLegAndKnowsHowToUseIt[i], x_axis, math.rad(62), 5)
    end
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[2], x_axis)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[4], x_axis)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[6], x_axis)
    WaitForTurn(body, y_axis)
    Move(body, y_axis, -40.5, 3.5)
    Move(body, z_axis, 16, 1.5)
    WaitForTurn(body, y_axis)
    WaitForMove(body, y_axis)
    Turn(body, y_axis, math.rad(0), 2.5)
    EmitSfx(body, 1025)
    EmitSfx(body, 1024)
    Sleep(50)
    EmitSfx(body, 1024)
    Sleep(50)
    EmitSfx(body, 1025)
    EmitSfx(body, 1024)
    Sleep(50)
    EmitSfx(body, 1025)
    EmitSfx(body, 1024)
    WaitForTurn(body, y_axis)

    for i = 1, 121, 2 do
        EmitSfx(optObjects[i], 1025)
    end

    --Spawn the big biorotting Feature and some gulls to circle on
    local x, y, z = Spring.GetUnitPosition(unitID)

    local teamID = Spring.GetGaiaTeamID()
    dir = math.random(1, 4)
    datID = Spring.CreateUnit("gJBigBioWaste", x, y, z, dir, teamID)
    dx, dy, dz = Spring.GetUnitDirection(datID)
    Spring.SetUnitDirection(datID, dx, dy, dz)
    Spring.SetUnitNeutral(datID, true)
    rondo = math.random(2, 9)
    for i = 1, rondo, 1 do
        datID = Spring.CreateUnit("gull", x - i, y, z + i, 0, teamID)
        Spring.SetUnitNeutral(datID, true)
    end

    Spring.DestroyUnit(unitID, true, false)
end

function trampleTier()
    px, py, pz = Spring.GetUnitPiecePosDir(unitID, treeSpot)
    T = getAllInCircle(px, pz, 50, unitID)
    if T then
        buildings = getBuildingInT(T, UnitDefs)
        if buildings then
            process(buildings,
                function(id)
                    Spring.DestroyUnit(id, false, false, id)
                    Spring.DestroyUnit(id, false, false, unitID)
                end)
        else
            process(T,
                function(id)
                    if id ~= unitID then
                        return id
                    end
                end,
                function(id) --filter out air units
                    ux, uy, uz = Spring.GetUnitPosition(id)
                    if uy - 100 < py then
                        return id
                    end
                end,
                function(id)
                    Spring.DestroyUnit(id, false, false, unitID)
                end)
        end
    end
end

--funkyFunction: Activates the AMOK Mode
function script.Activate()


    --sound
    --change speedsettings
    --activate trampleWeapon
    return 1
end

function script.Deactivate()
    --set the MovementSpeed back to the original speed
    --boolAmok Code
    --SetUnitValue(COB.MAX_SPEED,340787)--sets the speed to 5,2 *65533
    --if boolAmok== false then
    --boolAmok=true
    --SetUnitValue(COB.MAX_SPEED,340787)--sets the speed to 5,2 *65533
    --Hide(gullcircle)
    --
    --Hide(jBeGuBig)
    --Hide(jBeGuSmal0)
    --StartThread(tickTockTackle)
    --
    --end
    return 0
end


function showFish()
    Sleep(8000)
    Show(jBFish1)
    Show(jBFish2)
    Show(jBFish3)
    Show(jB3Fish3)
    Show(jB3Fish2)
    Show(jB3Fish1)
    Show(jBshark1)
    Show(jBshark02)
    Show(jBshatail1)
    Show(jBshatail0)
    Show(jBGal02)
    Show(jBGalCon02)
    Show(jBGalExp02)
    Show(jBGal)
    Show(jBGalCon)
    Show(jBGalExp)
    Show(jBGal03)
    Show(jBGalCon03)
    Show(jBGalExp03)
    Show(jBGal01)
    Show(jBGalCon01)
    Show(jBGalExp01)
end

function hideFish()

    Hide(jBFish1)
    Hide(jBFish2)
    Hide(jBFish3)
    Hide(jB3Fish3)
    Hide(jB3Fish2)
    Hide(jB3Fish1)
    Hide(jBshark1)
    Hide(jBshark02)
    Hide(jBshatail1)
    Hide(jBshatail0)
    Hide(jBGal02)
    Hide(jBGalCon02)
    Hide(jBGalExp02)
    Hide(jBGal)
    Hide(jBGalCon)
    Hide(jBGalExp)
    Hide(jBGal03)
    Hide(jBGalCon03)
    Hide(jBGalExp03)
    Hide(jBGal01)
    Hide(jBGalCon01)
    Hide(jBGalExp01)
end

--Sensors
function enterWater(howLong)
    for j = 1, howLong, 1 do
        for i = 1, table.getn(dustEmit), 1 do
            EmitSfx(dustEmit[i], 1026)
        end
        Sleep(100)
    end
end

function leaveWater(howLong)
    for j = 1, howLong, 1 do
        for i = 1, table.getn(dustEmit), 1 do
            EmitSfx(dustEmit[i], 1026)
            EmitSfx(body, 1026)
        end
        Sleep(100)
    end
end

--function:Detects if unit is in water: switches between waterwalk/groundwalk, activates waterfall on exit
boolWaterShy = true
function waterDetect()
    while (true) do
        bx, height, bz = Spring.GetUnitBasePosition(unitID)

        if height < -12 then
            boolwalk = false

            SetUnitValue(COB.UPRIGHT, 1)
            temp = height * -1
            if boolWaterShy == true then
                boolWaterShy = false
                StartThread(showFish)
                StartThread(enterWater, 80)
            end
            Move(body, y_axis, temp - swimWaterHeight, 8)

        else
            if boolWaterShy == false then
                boolWaterShy = true
                StartThread(leaveWater, 60)
            end
            hideFish()
            boolwalk = true
            SetUnitValue(COB.UPRIGHT, 0)
            Move(body, y_axis, 0, 19)
        end
        Sleep(266)
    end
end

--function: Detects turns, adjusts Movement according
function turnDetect()
    heading = Spring.GetUnitHeading(unitID)
    headingOfOld = heading
    Sleep(500)
    while (true) do
        heading = Spring.GetUnitHeading(unitID)
        if math.rad(headingOfOld) - math.rad(heading) > piMalDaumen then
            boolConstTurn = true
        else
            boolConstTurn = false
        end
        Sleep(500)
        headingOfOld = heading
    end
end

function constMoveDetec()
    StartThread(walkSwimMovement)
    SetSignalMask(SIG_MOVE)
    boolTempMove = false
    Sleep(450)
    if boolTempMove == true then
        boolConstMove = true

    else
        boolConstMove = false
    end
end

--Intertia is detected via synchronized Turns and MoveComands (Saves Engine Calls)
--function:computes the Inertia resulting from the old Inertia and the new Inertia

Infantry = {}
Infantry[UnitDefNames["bg"].id] = true
Infantry[UnitDefNames["tiglil"].id] = true
Infantry[UnitDefNames["skinfantry"].id] = true
Infantry[UnitDefNames["vort"].id] = true
Infantry[UnitDefNames["css"].id] = true

function isInfantry(passengerDefID)
    if Infantry[passengerDefID] then return true else return false end
end



function emitFootStepSound()
    deci = math.random(1, 3)
    if deci == 1 then
        Spring.PlaySoundFile("sounds/jbeherith/behefootstep1.wav")
    elseif deci == 2 then
        Spring.PlaySoundFile("sounds/jbeherith/behefootstep2.wav")
    else
        Spring.PlaySoundFile("sounds/jbeherith/behefootstep3.wav")
    end
end

function emitPlantsFunc(footNr)
    if footNr == 1 then
        Explode(emitPlants[1], SFX.FALL + SFX.NO_HEATCLOUD)
        Explode(emitPlants[2], SFX.FALL + SFX.NO_HEATCLOUD)

    elseif footNr == 2 then
        Explode(emitPlants[3], SFX.FALL + SFX.NO_HEATCLOUD)
        Explode(emitPlants[4], SFX.FALL + SFX.NO_HEATCLOUD)
    elseif footNr == 3 then
        Explode(emitPlants[5], SFX.FALL + SFX.NO_HEATCLOUD)
        Explode(emitPlants[6], SFX.FALL + SFX.NO_HEATCLOUD)
    elseif footNr == 4 then
        Explode(emitPlants[7], SFX.FALL + SFX.NO_HEATCLOUD)
        Explode(emitPlants[8], SFX.FALL + SFX.NO_HEATCLOUD)
    elseif footNr == 5 then
        Explode(emitPlants[9], SFX.FALL + SFX.NO_HEATCLOUD)
        Explode(emitPlants[10], SFX.FALL + SFX.NO_HEATCLOUD)
    else
        Explode(emitPlants[11], SFX.FALL + SFX.NO_HEATCLOUD)
        Explode(emitPlants[12], SFX.FALL + SFX.NO_HEATCLOUD)
    end
end

function swim()
    for i = 1, table.getn(HeGotLegAndKnowsHowToUseIt), 1 do
        Turn(HeGotLegAndKnowsHowToUseIt[i], x_axis, math.rad(62), 1)
    end
    Sleep(10)
end

function trampleThePeople()

    Turn(body, y_axis, math.rad(-4.5), 0.2)
    Turn(body, x_axis, math.rad(-3), 0.2)
    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(-9), 0.2)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(-5), 0.1)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(-7), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[6], y_axis, 0, 2)

    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[1], y_axis, 3, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(12), 0.3)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(-15), 0.3)

    WaitForTurn(HeGotLegAndKnowsHowToUseIt[1], x_axis)
    WaitForTurns(HeGotLegAndKnowsHowToUseIt)
    emitPlantsFunc(1)
    EmitSfx(dustEmit[1], 1024)
    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(0), 3)
    Move(HeGotLegAndKnowsHowToUseIt[1], y_axis, 0, 5)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(-20), 3)
    Move(HeGotLegAndKnowsHowToUseIt[2], y_axis, 3, 5)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(0), 3)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[1], x_axis)
    emitFootStepSound()
    WaitForTurns(HeGotLegAndKnowsHowToUseIt)
    emitPlantsFunc(2)
    EmitSfx(dustEmit[2], 1024)
    trampleTier()
    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(-11), 3)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(0), 3)
    Move(HeGotLegAndKnowsHowToUseIt[2], y_axis, 0, 5)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(-20), 3)
    Move(HeGotLegAndKnowsHowToUseIt[3], y_axis, 3, 5)
    WaitForTurns(HeGotLegAndKnowsHowToUseIt)
    emitFootStepSound()
    emitPlantsFunc(3)
    EmitSfx(dustEmit[3], 1024)
    --right side, turn behe slighty left

    Turn(body, y_axis, math.rad(4.5), 0.2)
    Turn(body, x_axis, math.rad(3), 0.2)

    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(-9), 0.4)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(-7), 0.4)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(-6), 0.4)
    Move(HeGotLegAndKnowsHowToUseIt[3], y_axis, 0, 0.2)

    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(-20), 3)
    Move(HeGotLegAndKnowsHowToUseIt[4], y_axis, 3, 5)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(12), 3)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(-11), 3)
    WaitForTurns(HeGotLegAndKnowsHowToUseIt)
    emitPlantsFunc(4)
    EmitSfx(dustEmit[4], 1024)




    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(0), 3)
    Move(HeGotLegAndKnowsHowToUseIt[4], y_axis, 0, 1)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(-20), 3)
    Move(HeGotLegAndKnowsHowToUseIt[5], y_axis, 3, 5)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(0), 3)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[6], x_axis)
    emitFootStepSound()
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[5], x_axis)
    emitPlantsFunc(5)
    EmitSfx(dustEmit[5], 1024)

    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(-11), 3)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(0), 3)
    Move(HeGotLegAndKnowsHowToUseIt[5], y_axis, 0, 5)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(-20), 3)
    Move(HeGotLegAndKnowsHowToUseIt[6], y_axis, 3, 5)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[5], x_axis)
    emitFootStepSound()
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[6], x_axis)
    emitPlantsFunc(6)
    EmitSfx(dustEmit[6], 1024)
end

-- Depending Loops
function walkSwimMovement()
    SetSignalMask(SIG_WALK)
    while (true) do

        while boolwalk == true do
            if boolAmok == false then
                walkWithSway()
            else
                trampleThePeople()
            end
            Sleep(20)
        end


        while boolwalk == false do
            swim()
        end
        Sleep(120)
    end
end

function leftLeg()
    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(9), 0.1)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(5), 0.1)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(7), 0.1)
    Sleep(250)

    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(-9), 0.05)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(-5), 0.05)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(-7), 0.05)
end

function rightLeg()

    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(9), 0.1)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(7), 0.1)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(6), 0.1)

    Sleep(250)

    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(-9), 0.04)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(-7), 0.04)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(-6), 0.04)
end


--function: Simulates the Walk Animation + Particle Effects (Dust/Grass)
function walkWithSway()
    --inertiarelatedstuff: ruessel,
    -- left side turn behe slightly right
    Turn(body, y_axis, math.rad(-4.5), 0.02)
    Turn(body, x_axis, math.rad(-3), 0.02)
    Move(HeGotLegAndKnowsHowToUseIt[6], y_axis, 0, 0.2)
    StartThread(leftLeg)
    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[1], y_axis, 3, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(12), 0.3)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(-15), 0.3)

    WaitForTurn(HeGotLegAndKnowsHowToUseIt[1], x_axis)
    emitPlantsFunc(1)
    EmitSfx(dustEmit[1], 1024)
    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(0), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[1], y_axis, 0, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[2], y_axis, 3, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(0), 0.3)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[1], x_axis)
    emitFootStepSound()
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[2], x_axis)
    emitPlantsFunc(2)
    EmitSfx(dustEmit[2], 1024)
    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(-11), 0.3)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(0), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[2], y_axis, 0, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[3], y_axis, 3, 0.5)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[2], x_axis)
    emitFootStepSound()
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[3], x_axis)
    emitPlantsFunc(3)
    EmitSfx(dustEmit[3], 1024)
    --right side, turn behe slighty left

    Turn(body, y_axis, math.rad(4.5), 0.02)
    Turn(body, x_axis, math.rad(3), 0.02)
    StartThread(rightLeg)
    Move(HeGotLegAndKnowsHowToUseIt[3], y_axis, 0, 0.2)

    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[4], y_axis, 3, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(12), 0.3)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(-11), 0.3)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[4], x_axis)
    emitPlantsFunc(4)
    EmitSfx(dustEmit[4], 1024)

    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(0), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[4], y_axis, 0, 0.1)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[5], y_axis, 3, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(0), 0.3)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[6], x_axis)
    emitFootStepSound()
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[5], x_axis)
    emitPlantsFunc(5)
    EmitSfx(dustEmit[5], 1024)

    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(-11), 0.3)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(0), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[5], y_axis, 0, 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(-20), 0.3)
    Move(HeGotLegAndKnowsHowToUseIt[6], y_axis, 3, 0.5)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[5], x_axis)
    emitFootStepSound()
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[6], x_axis)
    emitPlantsFunc(6)
    EmitSfx(dustEmit[6], 1024)

    --equalize both sides
end

--function: Grows Grass beneath the beherith and controlls the idle animations (only activated if no weapon aims
function eatWithFrontAppendix()
    throwDice = math.random(0, 1)
    if throwDice == 1 then
        Show(nomnom1)
        Turn(frontAppendixTable[1], y_axis, math.rad(0), 0.6)
        for i = 1, 7, 1 do
            Turn(frontAppendixTable[i], x_axis, math.rad(-20), 0.6)
        end
        WaitForTurn(frontAppendixTable[7], x_axis)

        Move(nomnom1, y_axis, -33, 27)
        Move(nomnom1, z_axis, 17, 18)
        WaitForMove(nomnom1, y_axis)
        Hide(nomnom1)


        for i = 1, 7, 1 do
            Turn(frontAppendixTable[i], x_axis, math.rad(0), 0.3)
        end
        Move(nomnom1, y_axis, 0, 0)
        Move(nomnom1, z_axis, 0, 0)
    else
        throwDice = math.random(0, 1)
        if throwADice == 1 then
            ripple(frontAppendixTable, 14, "X", 2, 0.5, true, napTime)
        else
            ripple(frontAppendixTable, 14, "Y", 2, 0.6, true, napTime)
        end
    end
end


function mONmoNmoN()
    while (true) do

        while (boolPeaceFool and boolwalk == true) do
            eatWithFrontAppendix()

            grandSleep = math.random(3000, 6000)
            Sleep(grandSleep)
        end


        Sleep(500)
    end
end

function bloodEmit(Time)
    while (Time > 0) do
        EmitSfx(body, 1025)
        EmitSfx(body, 1025)
        EmitSfx(body, 1025)
        Sleep(90)
        Time = Time - 90
    end
end

function script.Killed(recentDamage, maxhealth)
    mydef = Spring.GetUnitDefID(unitID)
    StartThread(PlaySoundByUnitDefID, mydef, "sounds/jbeherith/death.ogg", 1, 6000, 5, 0)
    --Turn Behe downward
    StartThread(bloodEmit, 3000)
    --Keep Doves over Cadaver for a while
    Hide(gullcircle)
    Hide(jBeGuBig)
    Hide(jBeGuSmal0)
    Hide(jBeGuSmall)
    Turn(body, y_axis, math.rad(15), 0.5)
    for i = 1, 6, 1 do
        Turn(HeGotLegAndKnowsHowToUseIt[i], x_axis, math.rad(62), 5)
    end
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[2], x_axis)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[4], x_axis)
    WaitForTurn(HeGotLegAndKnowsHowToUseIt[6], x_axis)
    WaitForTurn(body, y_axis)
    Move(body, y_axis, -40.5, 3.5)
    Move(body, z_axis, 16, 1.5)
    WaitForTurn(body, y_axis)
    WaitForMove(body, y_axis)
    Turn(body, y_axis, math.rad(0), 2.5)
    EmitSfx(body, 1025)
    EmitSfx(body, 1024)
    Sleep(50)
    EmitSfx(body, 1024)
    Sleep(50)
    EmitSfx(body, 1025)
    EmitSfx(body, 1024)
    Sleep(50)
    EmitSfx(body, 1025)
    EmitSfx(body, 1024)
    WaitForTurn(body, y_axis)

    for i = 1, 121, 2 do
        EmitSfx(optObjects[i], 1025)
    end

    --Spawn the big biorotting Feature and some gulls to circle on
    createCorpseJUnitBig(recentDamage)
    x, y, z = Spring.GetUnitPosition(unitID)
    gaiaTeamID = Spring.GetGaiaTeamID()
    rondo = math.random(2, 9)
    for i = 1, rondo, 1 do
        datID = Spring.CreateUnit("gull", x - i, y, z + i, 0, gaiaTeamID)
        Spring.SetUnitNeutral(datID, true)
    end

    return 1
end

--function: Shows and Hides Objects (Gallertas, Collibribirdwings)

--OS-Loop watches for damage: If massive Damage is detected Trees and plants are SFXed and Blood is oozed
function damageWatcher()
    hitPoints = Spring.GetUnitHealth(unitID)
    hitPointsOfOld = hitPoints
    Sleep(500)
    while (true) do
        hitPoints = Spring.GetUnitHealth(unitID)

        if hitPointsOfOld - hitPoints > gmassiveDamage then
            random = math.random(1, 121)
            Explode(optObjects[random], SFX.FALL + SFX.FIRE)

            local unitX, unitY, unitZ = Spring.GetUnitPosition(unitID)
            local emitX, emitY, emitZ = Spring.GetUnitPiecePosition(unitID, optObjects[random])
            emitPointHeight = emitY + unitY
            howDeep = math.random(3, 9)
            for i = 1, howDeep, 1 do
                Spring.SpawnCEG("bloodspray", emitX + unitX, emitPointHeight - 1, emitZ + unitZ, 0, 1, 0, 50, 0)
                Spring.SpawnCEG("bloodspray", emitX + unitX, emitPointHeight, emitZ + unitZ, 0, 1, 0, 50, 0)
                Spring.SpawnCEG("bloodspray", emitX + unitX, emitPointHeight + 1, emitZ + unitZ, 0, 1, 0, 50, 0)
                emitPointHeight = emitPointHeight - 3
            end

            EmitSfx(optObjects[random], 1025)
            EmitSfx(optObjects[random], 1025)
            Sleep(50)
            EmitSfx(body, 1025)
            EmitSfx(body, 1025)
        end
        Sleep(500)
        hitPointsOfOld = hitPoints
    end
end


--func: called by the engine when units starts moving
function script.StartMoving()
    Signal(SIG_MOVE)
    StartThread(constMoveDetec)
    boolMoving = true
end

--func:resets legs
function legs_down()
    Turn(body, x_axis, math.rad(0), 0.5)
    Turn(body, y_axis, math.rad(0), 0.5)
    Turn(body, z_axis, math.rad(0), 0.5)
    for i = 1, 6, 1 do
        Move(HeGotLegAndKnowsHowToUseIt[i], y_axis, 0, 0.3)
    end

    Turn(HeGotLegAndKnowsHowToUseIt[1], x_axis, math.rad(0), 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[2], x_axis, math.rad(0), 0.5)
    Turn(HeGotLegAndKnowsHowToUseIt[3], x_axis, math.rad(0), 0.5)
    emitFootStepSound()
    Turn(HeGotLegAndKnowsHowToUseIt[4], x_axis, math.rad(0), 0.6)
    Turn(HeGotLegAndKnowsHowToUseIt[5], x_axis, math.rad(0), 0.6)
    Turn(HeGotLegAndKnowsHowToUseIt[6], x_axis, math.rad(0), 0.5)
    emitFootStepSound()
end

function script.StopMoving()
    boolMoving = false
    Signal(SIG_MOVE)
    Signal(SIG_WALK)
    legs_down()
end

--------------------------------------------------------------------------


--PassengerPart
--physixloops

function FloraPhysixLoop() --Programmed by Cubex - Warning: This function pseudo-code was mentally programmed in my bathroom and then implemented in lua, can contain shit traces
    --Speed Ups
    local spGetUnitPosition = Spring.GetUnitPosition
    local spGetUnitPiecePosition = Spring.GetUnitPiecePosition
    local spGetUnitVectors = Spring.GetUnitVectors
    local spGetPieceRotation = Spring.UnitScript.GetPieceRotation
    local spIsInTurn = Spring.UnitScript.IsInTurn
    local pi = math.pi
    local abs = math.abs

    --Functions
    local function GetUnitPiecePos(unit, piece) --function by jK
        local x, y, z = spGetUnitPosition(unit)
        local front, up, right = spGetUnitVectors(unit)
        local px, py, pz = spGetUnitPiecePosition(unit, piece)
        return x + (pz * front[1] + py * up[1] + px * right[1]),
        y + (pz * front[2] + py * up[2] + px * right[2]),
        z + (pz * front[3] + py * up[3] + px * right[3])
    end

    --Parameters
    --local Randomness = 0.50 --Adding some random to trees, never conviced me, use at your wish
    local Scale = 0.9 --0.6 --Scales the current applied force, bigger means more shakey
    local Speed = 0.12 --How much Time takes a tree to turn to spetified angle, improves smoothness (too high might cause too radical moves, too low can cause lack of Time to react)
    local RotationLimit = pi / 10 --6 --The maximum angle which a tree can rotate
    local MoveThreshold = pi / 22 --If the movement is less than this, don't move, used to avoid "shake effect" in trees
    local RefreshInterval = 66 --How much ms to wait for each iteration
    local TreePosition = {} --Each tree position (last x axis, last z axis) used to calculate the diference betwen each loop and checks how much the tree was moved until last check

    --Initialization
    --- -Spring.Echo("RING RING RING!!! BANANA PHONE!!!") --For knowing if unit script runs or it crashed :/
    for i = 70, 90 do
        local Piece = optObjects[i]
        --Show(Piece) --Used for looking all trees
        local px, _, pz = GetUnitPiecePos(unitID, Piece) --Actual Position
        TreePosition[i] = { px, pz } --update the last position with the actual
    end

    --Code
    while true do
        for i = 70, 90 do
            if i ~= 83 and i ~= 81 and i ~= 85 then
                local Piece = optObjects[i]
                local px, _, pz = GetUnitPiecePos(unitID, Piece) --Actual Position
                local lx, lz = unpack(TreePosition[i]) --get the last position
                TreePosition[i] = { px, pz } --update the last position with the actual

                --calculate the piece base traveled distance until the last update
                px = (px - lx) -- * (random() + Randomness)
                pz = (pz - lz) -- * (random() + Randomness)
                px = px * Scale
                pz = pz * Scale

                if abs(px) > RotationLimit then
                    if px < 0 then px = -RotationLimit
                    else px = RotationLimit
                    end
                elseif abs(px) < MoveThreshold then
                    px = 0
                end

                if abs(pz) > RotationLimit then
                    if pz < 0 then pz = -RotationLimit
                    else pz = RotationLimit
                    end
                elseif abs(pz) < MoveThreshold then
                    pz = 0
                end
                --in addition
                local spx = Speed
                if math.deg(px) < 4 and math.deg(px) > -4 then
                    spx = negInvert((math.deg(px)) / 22)
                end

                local spz = Speed
                if math.deg(pz) < 4 and math.deg(pz) > -4 then
                    spz = negInvert((math.deg(pz)) / 22)
                end

                if spx < 0.05 then spx = 0.05 end
                if spz < 0.05 then spz = 0.05 end



                Turn(Piece, x_axis, px, spx)
                Turn(Piece, z_axis, pz, spz)

                if true == spIsInTurn(Piece, x_axis) or true == spIsInTurn(Piece, x_axis) then
                else
                    x, y, z = spGetPieceRotation(Piece)
                    if math.deg(abs(x)) < 3 then Turn(Piece, x_axis, 0, spx) else Turn(Piece, x_axis, (x * -0.75), spx) end
                    if math.deg(abs(z)) < 3 then Turn(Piece, z_axis, 0, spx) else Turn(Piece, z_axis, (z * -0.75), spz) end
                end
                --/in addition
            end
        end
        Sleep(RefreshInterval)
    end
end

-- Cubex's Ecosystem ends here, bye indentation :( I will miss you

function acquireVehicleDegree()
    ax, ay, az, _, _, _ = Spring.GetUnitPiecePosDir(unitID, ms1)
    bx, by, bz, _, _, _ = Spring.GetUnitPiecePosDir(unitID, ms2)
    --deg=math.atan2(by-ay,math.sqrt(((bz-az)^2)+((ay-by)^2)))*(180/pi)

    -- dx,dy,dz=Spring.GetUnitDirection(unitID)
    opposite = ay - by

    local ax = ax - bx
    local az = az - bz

    local len = math.sqrt(ax * ax + az * az)


    deg = math.floor(math.atan2(opposite, len) * (180 / 3.14159))


    return deg
end


local aVd = acquireVehicleDegree()

function pendulumApp(nr, limit, spx, spz)
    limit = limit / 7

    while (true) do
        for xi = 1, 7, 1 do
            Turn(overTableA[nr][xi], x_axis, math.rad(degXAppTable[nr]), spx)
            Turn(overTableA[nr][xi], z_axis, math.rad(degZAppTable[nr]), spz)
        end
        WaitForTurn(overTableA[nr][7], x_axis)
        WaitForTurn(overTableA[nr][7], z_axis)

        degXAppTable[nr] = (degXAppTable[nr] * -0.75) + (aVd / 7)
        degZAppTable[nr] = degZAppTable[nr] * -0.75

        xMul = 1
        zMul = 1
        if degXAppTable[nr] < 0 then xMul = -1 end
        if degZAppTable[nr] < 0 then zMul = -1 end
        if math.abs(degXAppTable[nr]) > limit then degXAppTable[nr] = limit * xMul end
        if math.abs(degZAppTable[nr]) > limit then degZAppTable[nr] = limit * zMul end

        if degXAppTable[nr] < 0.1 + (aVd / 7) and degXAppTable[nr] > -0.1 + (aVd / 7) and degZAppTable[nr] < 0.1 and degZAppTable[nr] > -0.1 then
            for xi = 1, 7, 1 do
                Turn(overTableA[nr][xi], x_axis, math.rad(aVd / 7), spx)
                Turn(overTableA[nr][xi], z_axis, math.rad(0), spz)
            end

            Sleep(200)
        end
        Sleep(50)
    end
end


--appendxiphysixloop
function AppendixPhysixLoop() --Programmed by Cubex - Warning: This function pseudo-code was mentally programmed in my bathroom and then implemented in lua, can contain shit traces
    --Speed Ups
    local spGetUnitPosition = Spring.GetUnitPosition
    local spGetUnitPiecePosition = Spring.GetUnitPiecePosition
    local spGetUnitVectors = Spring.GetUnitVectors
    local spIsInTurn = Spring.UnitScript.IsInTurn
    local pi = math.pi
    local abs = math.abs

    --Functions
    local function GetUnitPiecePos(unit, piece) --function by jK
        local x, y, z = spGetUnitPosition(unit)
        local front, up, right = spGetUnitVectors(unit)
        local px, py, pz = spGetUnitPiecePosition(unit, piece)
        return x + (pz * front[1] + py * up[1] + px * right[1]),
        y + (pz * front[2] + py * up[2] + px * right[2]),
        z + (pz * front[3] + py * up[3] + px * right[3])
    end

    --Parameters
    --local Randomness = 0.50 --Adding some random to trees, never conviced me, use at your wish
    local Scale = 0.98 --0.6 --Scales the current applied force, bigger means more shakey
    local Speed = 0.16 --How much Time takes a tree to turn to spetified angle, improves smoothness (too high might cause too radical moves, too low can cause lack of Time to react)
    local RotationLimit = pi / 12 --6 --The maximum angle which a tree can rotate
    local MoveThreshold = pi / 64 --If the movement is less than this, don't move, used to avoid "shake effect" in trees
    local RefreshInterval = 100 --How much ms to wait for each iteration
    local AppPosPosition = {} --Each tree position (last x axis, last z axis) used to calculate the diference betwen each loop and checks how much the tree was moved until last check
    for i = 1, 5 do
        StartThread(pendulumApp, i, 90, 0.05, 0.05)
    end
    --Initialization
    --- -Spring.Echo("RING RING RING!!! BANANA PHONE!!!") --For knowing if unit script runs or it crashed :/
    for i = 1, 5, 1 do
        local Piece = overTableA[i][1]
        --Show(Piece) --Used for looking all trees
        local px, _, pz = GetUnitPiecePos(unitID, Piece) --Actual Position
        AppPosPosition[i] = { px, pz } --update the last position with the actual
    end

    --Code
    while true do
        for i = 1, 5 do

            local Piece = overTableA[i][1]
            if boolAttached[i] == false then
                local px, _, pz = GetUnitPiecePos(unitID, Piece) --Actual Position
                local lx, lz = unpack(AppPosPosition[i]) --get the last position
                AppPosPosition[i] = { px, pz } --update the last position with the actual

                --calculate the piece base traveled distance until the last update
                px = (px - lx) -- * (random() + Randomness)
                pz = (pz - lz) -- * (random() + Randomness)
                px = px * Scale
                pz = pz * Scale

                if abs(px) > RotationLimit then
                    if px < 0 then px = -RotationLimit
                    else px = RotationLimit
                    end
                elseif abs(px) < MoveThreshold then
                    px = 0
                end

                if abs(pz) > RotationLimit then
                    if pz < 0 then pz = -RotationLimit
                    else pz = RotationLimit
                    end
                elseif abs(pz) < MoveThreshold then
                    pz = 0
                end
                --in addition
                spx = Speed
                if math.deg(px) < 4 and math.deg(px) > -4 then
                    spx = negInvert((math.deg(px)) / 22)
                end

                spz = Speed
                if math.deg(pz) < 4 and math.deg(pz) > -4 then
                    spz = negInvert((math.deg(pz)) / 22)
                end

                if spx > 0.05 then spx = 0.05 end
                if spz > 0.05 then spz = 0.05 end

                px = math.deg(px) / 7
                pz = math.deg(pz) / 7

                degXAppTable[i] = degXAppTable[i] + px
                degZAppTable[i] = degZAppTable[i] + pz


                --/in addition
            end
        end
        Sleep(RefreshInterval)
        aVd = acquireVehicleDegree()
    end
end


--function floodrops all the passengers(important for amok.. else passengers die with the beherith )



function script.Create()
    StartThread(treeTrample)
    StartThread(mONmoNmoN)
    beheBodyBuilder()
    setUp()
    StartThread(damageWatcher)
    StartThread(waterDetect)
    StartThread(FloraPhysixLoop)
    StartThread(AppendixPhysixLoop)
    --StartThread(interiaBlender)
    --StartThread(FloraPhysixLoop)
end



boolMoving = false

function treeTrample()
    treeTypeTable = getTypeTable(UnitDefNames, {
        "jtree1",
        "jtree2",
        "jtree3",
        "jtree41",
        "jtree42",
        "jtree43",
        "jtree44",
        "jtree45",
        "jtree46",
        "jtree47"
    })
    while true do

        while boolMoving == true do
            x, _, z = Spring.GetUnitPiecePosDir(unitID, treeSpot)
            T = getAllInCircle(x, z, 15, unitID, teamID)
            if T then
                T = getUnitsOfTypeInT(T, treeTypeTable)

                if T and #T > 0 then
                    GG.TreesTrampled = true

                    if not GG.TableTreesTrampled then GG.TableTreesTrampled = {} end

                    for i = 1, #T do
                        GG.TableTreesTrampled[T[i]] = T[i]
                    end
                end
            end
            Sleep(150)
        end
        Sleep(300)
    end
end




--WEAPONS
--------------------------------------------------------------------------
-- RegAttacks
function script.AimFromWeapon1()

    --	EmitSfx(frontAppendixTable[1],1025)

    return frontAppendixTable[1]
end

function script.QueryWeapon1()
    return frontAppendixTable[1]
end



function script.AimWeapon1(heading, pitch)

    Turn(frontAppendixTable[1], y_axis, heading, 8)

    for i = 1, 7, 1 do
        Turn(frontAppendixTable[i], x_axis, math.rad(-18), 8.3)
    end

    WaitForTurn(frontAppendixTable[1], y_axis)
    WaitForTurn(frontAppendixTable[7], x_axis)

    headingTable[1] = heading
    return true
end

impaled = {}

function vampireSticky(imPalePoint, enemyID)
    table.insert(impaled, enemyID)
    eneMineHealth = Spring.GetUnitHealth(enemyID)
    Spring.MoveCtrl.Enable(enemyID)
    Spring.MoveCtrl.SetNoBlocking(enemyID, true)
    Spring.SetUnitBlocking(enemyID, false, false, false)
    AttachUnit(imPalePoint, enemyID)
    local spValidUID = Spring.ValidUnitID
    while (spValidUID(enemyID) == true) do
        Sleep(50)
        EmitSfx(imPalePoint, 1025)
        Sleep(10)
        EmitSfx(imPalePoint, 1025)
        eneMineHealth = eneMineHealth - 1
        Spring.SetUnitHealth(enemyID, eneMineHealth)
    end

    if imPalePoint == impalePoint1 then
        boolImpale1 = false
    else
        boolImpale2 = false
    end

    table.remove(impaled, enemyID)
end

--function throws the enemy
function throwThatGuy(heading, temp)
    heading = heading / 182 --now in Degrees

    x = math.ceil(1 / math.cos(math.rad(heading)))
    z = math.sqrt(1 + (x ^ 2))
    z = math.ceil(math.random(22, 39) * z)
    Spring.AddUnitDamage(temp, 100, 90, unitID, -1, x, 150, z)
end


--function MoveControlls keeps the unit attached and drops the unit.. also deactivates collision
function MoveControll(point, eneID, nr)
    Spring.MoveCtrl.Enable(eneID)
    Spring.MoveCtrl.SetNoBlocking(eneID, true)
    Spring.SetUnitBlocking(eneID, false, false, true)
    boolAttached[nr] = true
    AttachUnit(point, eneID)
    local spValidUID = Spring.ValidUnitID
    while (spValidUID(eneID) == true and boolAttached[nr] == true) do
        Sleep(50)
    end
    DropUnit(eneID)
    Spring.MoveCtrl.SetNoBlocking(eneID, false)
    Spring.SetUnitBlocking(eneID, true, true, true)
    boolAttached[nr] = false
    Spring.MoveCtrl.Disable(eneID)
end

function impale(UnitToImpale)
    --Spring.Echo("Empale")
    if boolImpale1 == false then
        boolImpale1 = true
        StartThread(vampireSticky, impalePoint1, UnitToImpale)
    elseif boolImpale2 == false then
        boolImpale2 = true
        StartThread(vampireSticky, impalePoint2, UnitToImpale)
    end
end

--TODO
function getUnitFiredUponAttachAndImpulse1(heading)
    Sleep(500)
    upx, upy, upz = Spring.GetUnitPiecePosDir(unitID, frontAppendixTable[1])
    unitsInCircle = {}
    unitsInCircle = Spring.GetUnitsInCylinder(upx, upz, checkRange)

    unitsInCircle[unitID] = nil
    unitsStompedLately = {}
    if unitsInCircle ~= nil then

        for i = 1, table.getn(unitsInCircle), 1 do
            if unitsInCircle[i] ~= nil then
                lastAttackerID = Spring.GetUnitLastAttacker(unitsInCircle[i])
                if lastAttackerID == unitID then table.insert(unitsStompedLately, unitsInCircle[i]) end
            end
        end

        if unitsStompedLately ~= nil and table.getn(unitsStompedLately) ~= 0 then
            if impaled ~= nil and table.getn(impaled) ~= 0 then
                for i = 1, table.getn(impaled), 1 do
                    table.remove(unitsStompedLately, impaled[i])
                end
            end

            throwingDwarfs = math.random(1, table.getn(unitsStompedLately))
            temp = {}
            temp = unitsStompedLately[throwingDwarfs]
            --Spring.Echo("UnitID",unitID.. "Throwing Dwarfs", temp)
            if (isInfantry(temp) == true and boolImpale1 == false or boolAPPinBattle2 == false) then
                --Spring.Echo("ImpaleTime")
                StartThread(impale, temp)

            else
                StartThread(MoveControll, frontAppendixTable[7], temp, 2)

                for i = 1, table.getn(frontApendixTable), 1 do
                    Turn(frontApendixTable[i], x_axis, math.rad(18), 0.05)
                end
                WaitForTurn(frontAppendixTable[7], x_axis)
                Sleep(800)
                for i = 1, table.getn(frontApendixTable), 1 do
                    Turn(frontApendixTable[i], x_axis, math.rad(-18), 0.5)
                end
                WaitForTurn(frontAppendixTable[7], x_axis)
                Sleep(1420)
                boolAttached[2] = false
                Sleep(150)
                throwThatGuy(heading, temp)



                --take back appendix then throw (random dirAction)
                --add impulse
            end
        end
    end
end

--throws the unit grabbed by the elephant appendix
function getUnitFiredUponAttachAndImpulse(apendixTable, nr, heading)

    appendixBooleans[nr] = true
    Sleep(600)
    upx, upy, upz, _, _, _ = Spring.GetUnitPiecePosDir(unitID, apendixTable[1])
    unitsInCircle = Spring.GetUnitsInCylinder(upx, upz, checkRange)
    table.remove(unitsInCircle, unitID)
    if unitsInCircle ~= nil then
        unitsStompedLately = {}
        for i = 1, table.getn(unitsInCircle), 1 do
            lastAttackerID = Spring.GetUnitLastAttacker(unitsInCircle[i])
            if lastAttackerID == unitID then
                table.insert(unitsStompedLately, unitsInCircle[i])
            end
        end
        if impaled ~= nil then
            for i = 1, table.getn(impaled), 1 do
                table.remove(unitsStompedLately, impaled[i])
            end
        end

        if table.getn(unitsStompedLately) ~= 0 then


            throwingDwarfs = math.floor(math.random(1, table.getn(unitsStompedLately)))
            temp = {}
            temp = unitsStompedLately[throwingDwarfs]
            StartThread(MoveControll, apendixTable[7], temp, nr)

            zMultiplicator = 0
            if nr == 1 or nr == 3 then
                zMultiplicator = -1
            elseif nr == 4 or nr == 5 then
                zMultiplicator = 1
            else
                zMultiplicator = 0.01
            end
            xRandomizer = math.random(-0.5, 0.5)


            for i = 1, table.getn(apendixTable), 1 do
                Turn(apendixTable[i], z_axis, math.rad(18 * zMultiplicator), 2)
                Turn(apendixTable[i], x_axis, math.rad(18 * xRandomizer), 2)
            end
            WaitForTurn(apendixTable[7], z_axis)
            for i = 1, table.getn(apendixTable), 1 do
                Turn(apendixTable[i], z_axis, math.rad(-18 * zMultiplicator), 9)
            end
            Sleep(1420)
            boolAttached[nr] = false
            Sleep(150)
            throwThatGuy(heading, temp)

            --take back appendix then throw (random dirAction)
            --add impulse
        end
    end
    appendixBooleans[nr] = false
end

function script.FireWeapon1()
    getUnitFiredUponAttachAndImpulse1(headingTable[1])
    Sleep(4000)
end

--function: Impailor Weapon attaches and manages the Physix of two impaled Units
--If unit is crushable.
--weapon 2
function script.AimWeapon2(heading, pitch)

    Turn(appendixTable1[1], y_axis, heading, 3)


    for i = 1, 7, 1 do
        Turn(appendixTable1[i], z_axis, math.rad(18), 4.3)
    end

    WaitForTurn(appendixTable1[1], y_axis)
    WaitForTurn(appendixTable1[7], z_axis)

    headingTable[2] = heading
    return true
end

function script.AimFromWeapon2()



    return appendixTable1[1]
end

function script.QueryWeapon2()
    return appendixTable1[1]
end


function script.FireWeapon2()
    StartThread(getUnitFiredUponAttachAndImpulse, appendixTable1, 1, headingTable[2])
end

--weapon3
function script.AimWeapon3(heading, pitch)

    Turn(appendixTable3[1], y_axis, heading, 6)


    for i = 1, 7, 1 do
        Turn(appendixTable3[i], z_axis, math.rad(18), 4.3)
    end

    WaitForTurn(appendixTable3[1], y_axis)
    WaitForTurn(appendixTable3[7], z_axis)

    headingTable[3] = heading
    return true
end

function script.AimFromWeapon3()



    return appendixTable3[1]
end

function script.QueryWeapon3()
    return appendixTable3[1]
end


function script.FireWeapon3()
    StartThread(getUnitFiredUponAttachAndImpulse, appendixTable3, 3, headingTable[3])
end

--weapon 4
function script.AimWeapon4(heading, pitch)

    Turn(appendixTable4[1], y_axis, heading, 3)


    for i = 1, 7, 1 do
        Turn(appendixTable4[i], z_axis, math.rad(-18), 4.3)
    end

    WaitForTurn(appendixTable4[1], y_axis)
    WaitForTurn(appendixTable4[7], z_axis)

    headingTable[4] = heading
    return true
end

function script.AimFromWeapon4()



    return appendixTable4[1]
end

function script.QueryWeapon4()
    return appendixTable4[1]
end


function script.FireWeapon4()
    StartThread(getUnitFiredUponAttachAndImpulse, appendixTable4, 4, headingTable[4])
end


--weapon 5
function script.AimWeapon5(heading, pitch)

    Turn(appendixTable5[1], y_axis, heading, 6)


    for i = 1, 7, 1 do
        Turn(appendixTable5[i], z_axis, math.rad(-18), 4.3)
    end

    WaitForTurn(appendixTable5[1], y_axis)
    WaitForTurn(appendixTable5[7], z_axis)
    headingTable[5] = heading

    return true
end

function script.AimFromWeapon5()



    return appendixTable5[1]
end

function script.QueryWeapon5()
    return appendixTable5[1]
end


function script.FireWeapon5()
    StartThread(getUnitFiredUponAttachAndImpulse, appendixTable5, 5, headingTable[5])
end


--	weapon 5
-- function script.AimWeapon5( heading, pitch )

-- Turn(appendixTable5[1],y_axis,heading,6)


-- for i=1,7,1 do
-- Turn(appendixTable5[i],z_axis,math.rad(18),4.3)
-- end

-- WaitForTurn(appendixTable5[1],y_axis)
-- WaitForTurn(appendixTable5[7],z_axis)


-- return true
-- end
--weapon 6
function script.AimFromWeapon6()



    return body
end

function script.QueryWeapon6()
    return body
end


function script.FireWeapon6()
    for i = 1, table.getn(dustEmit), 1 do
        EmitSfx(dustEmit[i], 1025)
        EmitSfx(dustEmit[i], 1024)
        Sleep(25)
    end
end


function script.AimWeapon6(heading, pitch)

    if boolAmok == true then
        return true
    end
end

--AmokSphere
--function: attaches every unit that is close enough to be trampeled to the feet of the Beherith,