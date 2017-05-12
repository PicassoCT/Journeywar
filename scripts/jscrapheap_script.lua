include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"
include "lib_jw.lua"

apend = {}
spin = {}
Leg = {}
Husk = {}
Shield = {}
PillP = {}
Pillar = {}
Balls = {}
Pipe = {}
Drip = {}
Shell = {}
Fluid = {}
Contain = {}
Ring = {}
Transport = {}
center = piece(center)
Transport3 = piece "Transport3"
Transport[3] = Transport3
Drip3 = piece "Drip3"
Drip[3] = Drip3
Root = piece(Root)
Pipe8 = piece "Pipe8"
Pipe[8] = Pipe8
Pipe7 = piece "Pipe7"
Pipe[7] = Pipe7
Pipe6 = piece "Pipe6"
Pipe[6] = Pipe6
Pipe5 = piece "Pipe5"
Pipe[5] = Pipe5
Pipe4 = piece "Pipe4"
Pipe[4] = Pipe4
Pipe3 = piece "Pipe3"
Pipe[3] = Pipe3
Pipe2 = piece "Pipe2"
Pipe[2] = Pipe2
Pipe1 = piece "Pipe1"
Pipe[1] = Pipe1
Shell1 = piece "Shell1"
Shell[1] = Shell1
Shell2 = piece "Shell2"
Shell[2] = Shell2
Shell3 = piece "Shell3"
Shell[3] = Shell3
Shield2 = piece "Shield2"
Shield[2] = Shield2
Shield1 = piece "Shield1"
Shield[1] = Shield1
Shield4 = piece "Shield4"
Shield[4] = Shield4
Shield5 = piece "Shield5"
Shield[5] = Shield5
Drip1 = piece "Drip1"
Drip[1] = Drip1
Soup = piece(Soup)
Flood = piece(Flood)
FloodRing = piece(FloodRing)
Balls6 = piece "Balls6"
Balls[6] = Balls6
Contain2 = piece "Contain2"
Contain[2] = Contain2
Fluid2 = piece "Fluid2"
Fluid[2] = Fluid2
Contain1 = piece "Contain1"
Contain[1] = Contain1
Fluid1 = piece "Fluid1"
Fluid[1] = Fluid1
Husk1 = piece "Husk1"
Husk[1] = Husk1
Husk2 = piece "Husk2"
Husk[2] = Husk2
Husk3 = piece "Husk3"
Husk[3] = Husk3
Balls5 = piece "Balls5"
Balls[5] = Balls5
Balls4 = piece "Balls4"
Balls[4] = Balls4
Balls3 = piece "Balls3"
Balls[3] = Balls3
Balls2 = piece "Balls2"
Balls[2] = Balls2
Balls1 = piece "Balls1"
Balls[1] = Balls1
Drip2 = piece "Drip2"
Drip[2] = Drip2
ldrop = piece(ldrop)
sdrop = piece(sdrop)
Transport1 = piece "Transport1"
Transport[1] = Transport1
Transport2 = piece "Transport2"
Transport[2] = Transport2
Shield3 = piece "Shield3"
Shield[3] = Shield3
Balls7 = piece "Balls7"
Balls[7] = Balls7
Balls8 = piece "Balls8"
Balls[8] = Balls8
Balls9 = piece "Balls9"
Balls[9] = Balls9
Balls10 = piece "Balls10"
Balls[10] = Balls10
Ring1 = piece "Ring1"
Ring[1] = Ring1
Ring2 = piece "Ring2"
Ring[2] = Ring2
Ring3 = piece "Ring3"
Ring[3] = Ring3
Ring4 = piece "Ring4"
Ring[4] = Ring4
Ring5 = piece "Ring5"
Ring[5] = Ring5
Ring6 = piece "Ring6"
Ring[6] = Ring6
spin1 = piece "spin1"
spin[1] = spin1
Pillar1 = piece "Pillar1"
Pillar[1] = Pillar1
PillP2 = piece "PillP2"
PillP[2] = PillP2
PillP3 = piece "PillP3"
PillP[3] = PillP3
PillP4 = piece "PillP4"
PillP[4] = PillP4
Pillar2 = piece "Pillar2"
Pillar[2] = Pillar2
Pillar3 = piece "Pillar3"
Pillar[3] = Pillar3
Pillar4 = piece "Pillar4"
Pillar[4] = Pillar4
spin2 = piece "spin2"
spin[2] = spin2
Pillar5 = piece "Pillar5"
Pillar[5] = Pillar5
PillP6 = piece "PillP6"
PillP[6] = PillP6
PillP7 = piece "PillP7"
PillP[7] = PillP7
PillP8 = piece "PillP8"
PillP[8] = PillP8
Pillar6 = piece "Pillar6"
Pillar[6] = Pillar6
Pillar7 = piece "Pillar7"
Pillar[7] = Pillar7
Pillar8 = piece "Pillar8"
Pillar[8] = Pillar8
spin3 = piece "spin3"
spin[3] = spin3
Pillar13 = piece "Pillar13"
Pillar[13] = Pillar13
PillP14 = piece "PillP14"
PillP[14] = PillP14
PillP15 = piece "PillP15"
PillP[15] = PillP15
PillP16 = piece "PillP16"
PillP[16] = PillP16
Pillar14 = piece "Pillar14"
Pillar[14] = Pillar14
Pillar15 = piece "Pillar15"
Pillar[15] = Pillar15
Pillar16 = piece "Pillar16"
Pillar[16] = Pillar16
spin4 = piece "spin4"
spin[4] = spin4
Pillar9 = piece "Pillar9"
Pillar[9] = Pillar9
PillP10 = piece "PillP10"
PillP[10] = PillP10
PillP11 = piece "PillP11"
PillP[11] = PillP11
PillP12 = piece "PillP12"
PillP[12] = PillP12
Pillar10 = piece "Pillar10"
Pillar[10] = Pillar10
Pillar11 = piece "Pillar11"
Pillar[11] = Pillar11
Pillar12 = piece "Pillar12"
Pillar[12] = Pillar12
MortalFlesh = piece(MortalFlesh)
Leg01 = piece "Leg01"
Leg[1] = Leg01
Leg02 = piece "Leg02"
Leg[2] = Leg02
Leg03 = piece "Leg03"
Leg[3] = Leg03
Leg04 = piece "Leg04"
Leg[4] = Leg04
apend1 = piece "apend1"
apend[1] = apend1
apend2 = piece "apend2"
apend[2] = apend2
BabyWalk = piece(BabyWalk)
Baby = piece(Baby)
Navel = piece(Navel)
--PIECESLIST::BEGIN |>----------------------------
--PIECES
piecesTable = {}
center = piece "center"
piecesTable[#piecesTable + 1] = center
Transport3 = piece "Transport3"
piecesTable[#piecesTable + 1] = Transport3
Drip3 = piece "Drip3"
piecesTable[#piecesTable + 1] = Drip3
Root = piece "Root"
piecesTable[#piecesTable + 1] = Root
Pipe8 = piece "Pipe8"
piecesTable[#piecesTable + 1] = Pipe8
Pipe7 = piece "Pipe7"
piecesTable[#piecesTable + 1] = Pipe7
Pipe6 = piece "Pipe6"
piecesTable[#piecesTable + 1] = Pipe6
Pipe5 = piece "Pipe5"
piecesTable[#piecesTable + 1] = Pipe5
Pipe4 = piece "Pipe4"
piecesTable[#piecesTable + 1] = Pipe4
Pipe3 = piece "Pipe3"
piecesTable[#piecesTable + 1] = Pipe3
Pipe2 = piece "Pipe2"
piecesTable[#piecesTable + 1] = Pipe2
Pipe1 = piece "Pipe1"
piecesTable[#piecesTable + 1] = Pipe1
Shell1 = piece "Shell1"
piecesTable[#piecesTable + 1] = Shell1
Shell2 = piece "Shell2"
piecesTable[#piecesTable + 1] = Shell2
Shell3 = piece "Shell3"
piecesTable[#piecesTable + 1] = Shell3
Shield2 = piece "Shield2"
piecesTable[#piecesTable + 1] = Shield2
Shield1 = piece "Shield1"
piecesTable[#piecesTable + 1] = Shield1
Shield4 = piece "Shield4"
piecesTable[#piecesTable + 1] = Shield4
Shield5 = piece "Shield5"
piecesTable[#piecesTable + 1] = Shield5
Drip1 = piece "Drip1"
piecesTable[#piecesTable + 1] = Drip1
Soup = piece "Soup"
piecesTable[#piecesTable + 1] = Soup
Flood = piece "Flood"
piecesTable[#piecesTable + 1] = Flood
FloodRing = piece "FloodRing"
piecesTable[#piecesTable + 1] = FloodRing
Balls6 = piece "Balls6"
piecesTable[#piecesTable + 1] = Balls6
Contain2 = piece "Contain2"
piecesTable[#piecesTable + 1] = Contain2
Fluid2 = piece "Fluid2"
piecesTable[#piecesTable + 1] = Fluid2
Contain1 = piece "Contain1"
piecesTable[#piecesTable + 1] = Contain1
Fluid1 = piece "Fluid1"
piecesTable[#piecesTable + 1] = Fluid1
Husk1 = piece "Husk1"
piecesTable[#piecesTable + 1] = Husk1
Husk2 = piece "Husk2"
piecesTable[#piecesTable + 1] = Husk2
Husk3 = piece "Husk3"
piecesTable[#piecesTable + 1] = Husk3
Balls5 = piece "Balls5"
piecesTable[#piecesTable + 1] = Balls5
Balls4 = piece "Balls4"
piecesTable[#piecesTable + 1] = Balls4
Balls3 = piece "Balls3"
piecesTable[#piecesTable + 1] = Balls3
Balls2 = piece "Balls2"
piecesTable[#piecesTable + 1] = Balls2
Balls1 = piece "Balls1"
piecesTable[#piecesTable + 1] = Balls1
Drip2 = piece "Drip2"
piecesTable[#piecesTable + 1] = Drip2
ldrop = piece "ldrop"
piecesTable[#piecesTable + 1] = ldrop
sdrop = piece "sdrop"
piecesTable[#piecesTable + 1] = sdrop
Transport1 = piece "Transport1"
piecesTable[#piecesTable + 1] = Transport1
Transport2 = piece "Transport2"
piecesTable[#piecesTable + 1] = Transport2
Shield3 = piece "Shield3"
piecesTable[#piecesTable + 1] = Shield3
Balls7 = piece "Balls7"
piecesTable[#piecesTable + 1] = Balls7
Balls8 = piece "Balls8"
piecesTable[#piecesTable + 1] = Balls8
Balls9 = piece "Balls9"
piecesTable[#piecesTable + 1] = Balls9
Balls10 = piece "Balls10"
piecesTable[#piecesTable + 1] = Balls10
Ring1 = piece "Ring1"
piecesTable[#piecesTable + 1] = Ring1
Ring2 = piece "Ring2"
piecesTable[#piecesTable + 1] = Ring2
Ring3 = piece "Ring3"
piecesTable[#piecesTable + 1] = Ring3
Ring4 = piece "Ring4"
piecesTable[#piecesTable + 1] = Ring4
Ring5 = piece "Ring5"
piecesTable[#piecesTable + 1] = Ring5
Ring6 = piece "Ring6"
piecesTable[#piecesTable + 1] = Ring6
spin1 = piece "spin1"
piecesTable[#piecesTable + 1] = spin1
Pillar1 = piece "Pillar1"
piecesTable[#piecesTable + 1] = Pillar1
PillP2 = piece "PillP2"
piecesTable[#piecesTable + 1] = PillP2
PillP3 = piece "PillP3"
piecesTable[#piecesTable + 1] = PillP3
PillP4 = piece "PillP4"
piecesTable[#piecesTable + 1] = PillP4
Pillar2 = piece "Pillar2"
piecesTable[#piecesTable + 1] = Pillar2
Pillar3 = piece "Pillar3"
piecesTable[#piecesTable + 1] = Pillar3
Pillar4 = piece "Pillar4"
piecesTable[#piecesTable + 1] = Pillar4
spin2 = piece "spin2"
piecesTable[#piecesTable + 1] = spin2
Pillar5 = piece "Pillar5"
piecesTable[#piecesTable + 1] = Pillar5
PillP6 = piece "PillP6"
piecesTable[#piecesTable + 1] = PillP6
PillP7 = piece "PillP7"
piecesTable[#piecesTable + 1] = PillP7
PillP8 = piece "PillP8"
piecesTable[#piecesTable + 1] = PillP8
Pillar6 = piece "Pillar6"
piecesTable[#piecesTable + 1] = Pillar6
Pillar7 = piece "Pillar7"
piecesTable[#piecesTable + 1] = Pillar7
Pillar8 = piece "Pillar8"
piecesTable[#piecesTable + 1] = Pillar8
spin3 = piece "spin3"
piecesTable[#piecesTable + 1] = spin3
Pillar13 = piece "Pillar13"
piecesTable[#piecesTable + 1] = Pillar13
PillP14 = piece "PillP14"
piecesTable[#piecesTable + 1] = PillP14
PillP15 = piece "PillP15"
piecesTable[#piecesTable + 1] = PillP15
PillP16 = piece "PillP16"
piecesTable[#piecesTable + 1] = PillP16
Pillar14 = piece "Pillar14"
piecesTable[#piecesTable + 1] = Pillar14
Pillar15 = piece "Pillar15"
piecesTable[#piecesTable + 1] = Pillar15
Pillar16 = piece "Pillar16"
piecesTable[#piecesTable + 1] = Pillar16
spin4 = piece "spin4"
piecesTable[#piecesTable + 1] = spin4
Pillar9 = piece "Pillar9"
piecesTable[#piecesTable + 1] = Pillar9
PillP10 = piece "PillP10"
piecesTable[#piecesTable + 1] = PillP10
PillP11 = piece "PillP11"
piecesTable[#piecesTable + 1] = PillP11
PillP12 = piece "PillP12"
piecesTable[#piecesTable + 1] = PillP12
Pillar10 = piece "Pillar10"
piecesTable[#piecesTable + 1] = Pillar10
Pillar11 = piece "Pillar11"
piecesTable[#piecesTable + 1] = Pillar11
Pillar12 = piece "Pillar12"
piecesTable[#piecesTable + 1] = Pillar12
MortalFlesh = piece "MortalFlesh"
piecesTable[#piecesTable + 1] = MortalFlesh
Leg01 = piece "Leg01"
piecesTable[#piecesTable + 1] = Leg01
Leg02 = piece "Leg02"
piecesTable[#piecesTable + 1] = Leg02
Leg03 = piece "Leg03"
piecesTable[#piecesTable + 1] = Leg03
Leg04 = piece "Leg04"
piecesTable[#piecesTable + 1] = Leg04
apend1 = piece "apend1"

apend[#apend + 1] = apend1
piecesTable[#piecesTable + 1] = apend1
apend2 = piece "apend2"
piecesTable[#piecesTable + 1] = apend2
apend[#apend + 1] = apend2
BabyWalk = piece "BabyWalk"
piecesTable[#piecesTable + 1] = BabyWalk
Baby = piece "Baby"
piecesTable[#piecesTable + 1] = Baby
Navel = piece "Navel"
piecesTable[#piecesTable + 1] = Navel

WeeImATree = Spring.GetUnitDefID(unitID)
Trees = getTreeTypeTable(UnitDefNames)
boolWeeImATree = Trees[WeeImATree] or false

SIG_DEATH = 32

function contemplateOrigin()

    boolPositionUnchanged = true
    xo, yo, zo = Spring.GetUnitPosition(unitID)
    while (boolPositionUnchanged == true) do
        x, y, z = Spring.GetUnitPosition(unitID)
        if math.abs(x - xo) > 10 and math.abs(z - zo) > 10 then
            boolPositionUnchanged = false
            hideT(piecesTable)

            if boolWeeImATree == true then
                Show(Transport3)
            else
                pieceOfChoice = Transport[irand(1, 2)]
                Show(pieceOfChoice)
            end

            Signal(SIG_DEATH)
        end
        Sleep(2000)
    end
end



--scrapMain=piece "scrapMain"
function diceHide(piecename)
    i = math.random(0, 1)
    if i == 1 then
        Hide(piecename)
    else
        Show(piecename)
    end
end


function init()

    if boolWeeImATree == true then
        hideT(piecesTable)
        Show(Transport[3])
        Show(Root)

    else
        turnTableRand(Ring)
        turnTableRand(Shell)
        turnTableRand(Husk)

        Hide(Root)
        Hide(Transport[3])
        hideT(Drip)
        Hide(Soup)
        Hide(Flood)
        hideT(Fluid)
        Hide(ldrop)
        Hide(sdrop)

        if maRa() == true then
            StartThread(maMa)
        end

        StartThread(flailingFlesh)

        --Shells
        for i = 1, #Shield, 1 do
            StartThread(shieldset, i)
        end

        for i = 1, #Balls, 1 do
            StartThread(Ballsset, i)
        end
        --	process(Shell, 	function(id,axis) Move(id,axis,math.random(-10,42),0)end,y_axis)
        for i = 1, #Pipe do
            StartThread(pipes, i)
        end

        for i = 1, #Husk do
            StartThread(Huskset, i)
        end

        if maRa() == true then
            StartThread(Pump1)
        end

        if maRa() == true then
            StartThread(Pump2)
        end

        d = math.random(-45, 45)
        dis = math.random(25, 45)

        for i = 1, #Ring do
            --echo("Ring"..i)
            Turn(Ring[i], x_axis, math.rad(d), 0)
            x, z = drehMatrix(dis, dis, 0, 0, i * (360 / #Ring))
            moveUnitPieceToGroundPos(unitID, Ring[i], x, z, 1.8, 3)
            Show(Ring[i])
        end

        StartThread(pillarHandling)
    end
end

function pillarHandling()
    --echo("pillarHandling")
    val = 360 - math.random(10, 150)
    counter = 1
    boolPillarbreath = maRa()
    if boolPillarbreath == false then
        for j = 1, #spin, 1 do
            v = counter * (val / #spin)
            Turn(spin[j], y_axis, math.rad(v), 0)
            Turn(spin[j], x_axis, math.rad(90) * randSign(), 1)
        end
        WaitForTurns(spin)
    end
    for i = 1, #Pillar, 4 do
        --echo("pillarHandling"..i)
        Show(Pillar[i])
        counter = counter + 1
        if spin[i] then
            Move(Pillar[i], z_axis, 90, 0, true)
            Sleep(20)
        end

        for j = i + 1, math.min(i + 4, #Pillar), 1 do
            --echo("pillarHandlingj"..j)
            if maRa() == true then
                Show(Pillar[j])
                movePieceToPiece(unitID, Pillar[j], PillP[j])
            end
        end
    end


    if boolPillarbreath == true then
        --breath it
        counter = 0
        predecessor = Pillar[1]
        for k, v in pairs(Pillar) do
            counter = counter + 1
            rand = math.random(-32, 32)
            if counter % 2 == 0 then
                StartThread(breath, predecessor, v, x_axis, rand, 0.5, 10, 0.4 / 10)
            else
                predecessor = v
            end
        end
    end

    --stay upright and fall down


    for i = 1, #Pipe do
        StopSpin(Pipe[i], y_axis)
        StopSpin(Pipe[i], x_axis)
    end
end

function Ballsset(i)

    Move(Balls[i], z_axis, math.random(-40, 40), 0)
    Move(Balls[i], x_axis, math.random(-40, 40), 0)
    Move(Balls[i], y_axis, math.random(25, 50), 0, true)
    Show(Balls[i])
    PseudoPhysix(Balls[i], Balls[i], 6)
    DropPieceToGround(unitID, Balls[i], 5, true, false)
end

function Huskset(i)

    Move(Husk[i], z_axis, math.random(-40, 40), 0)
    Move(Husk[i], x_axis, math.random(-40, 40), 0, true)

    Show(Husk[i])
    --PseudoPhysix(Husk[i],Husk[i], 6)
    DropPieceToGround(unitID, Husk[i], 5, true, false)
    turnPieceRandDir(Husk[i], 0)
end

function shieldset(i)

    Move(Shield[i], z_axis, math.random(-120, 120), 0)
    Move(Shield[i], x_axis, math.random(-120, 120), 0)
    Move(Shield[i], y_axis, math.random(40, 182), 0, true)
    Show(Shield[i])
    PseudoPhysix(Shield[i], Shield[i], 6)
    DropPieceToGround(unitID, Shield[i], 5, true, false)
end

function Pump1()

    Turn(Flood, y_axis, 0, 0)
    Show(Drip1)
    moveUnitPieceToGroundPos(unitID, Drip1, math.random(-72, 72), math.random(-72, 72), 0)
    Spin(Flood, z_axis, math.rad(-42), 1)

    Show(Flood)
    Show(Soup)
end

function Pump2()

    moveUnitPieceToGroundPos(unitID, Drip2, math.random(-72, 72), math.random(-72, 72), 0)
    Show(Drip2)

    while true do
        Turn(Drip2, y_axis, math.rad(math.random(-180, 180)), 0.002)
        xval = math.random(-18, 18)
        Turn(Drip2, z_axis, math.rad(xval), 0.02)
        Turn(ldrop, z_axis, math.rad(-xval), 0.2)
        WaitForTurn(Drip2, x_axis)
        Move(ldrop, y_axis, -5, 25)
        Show(ldrop)
        WaitForMove(ldrop, y_axis)
        Show(sdrop)
        Hide(ldrop)
        X, Y, Z = Spring.GetUnitPiecePosition(unitID, ldrop)
        Move(ldrop, y_axis, -35, 32)
        WaitForMove(ldrop, y_axis)
        EmitSfx(ldrop, 1025)
        Hide(sdrop)
        reset(sdrop)
        reset(ldrop)
        Sleep(300)
    end
end

targetPos = piece "targetPos"

function flailingFlesh()
    Show(MortalFlesh)
    showT(apend)
    val = math.random(0, 360)
    Turn(MortalFlesh, y_axis, math.rad(val), 0)
    showT(Leg)
    signum = -1
    live = math.ceil(math.random(20, 60) * 1000)

    speed = math.max(math.sqrt(speed), 0.001)
    while live > 0 do
        --echo("flailingFlesh")
        signum = signum * -1


        for i = 1, #Leg do
            turnPieceRandDir(Leg[i], speed, 120, -120, 180, -180, 8, -5)
        end
        val = iRand(-12, 12)
        valor = iRand(-12, 12)
        Turn(apend[1], y_axis, math.rad(signum * val), 0.13, false)
        Turn(apend[2], x_axis, math.rad(signum * val), 0.13, false)
        Turn(apend[1], x_axis, math.rad(signum * valor), 0.13, false)
        Turn(apend[2], x_axis, math.rad(signum * valor), 0.13, false)



        if live > 15000 then
            if maRa() == maRa() then
                pName = Leg[iRand(1, #Leg)]
                spawnCegAtPiece(unitID, pName, "greenbloodspray", 0)
            else
                pName = Balls[iRand(1, #Balls)]
                spawnCegAtPiece(unitID, pName, "bloodspray", 0)
            end
        end

        Sleep(2000)
        live = live - 2000
    end

    resetT(Leg, 0.1)
end

speed = 50
function maMa()

    linenumber = 1
    distx, disty = math.random(35, 60) * randSign(), math.random(35, 60) * randSign()
    Move(BabyWalk, x_axis, distx, 0)
    Move(BabyWalk, z_axis, disty, 0)


    Show(Baby)
    Show(Navel)
    BabyDir = 0

    signum = -1

    live = math.ceil(math.random(20, 60) * 1000)
    --echo("ljscrapheap:"..linenumber);linenumber=linenumber+1--2

    while live > 0 do
        distx, disty = math.random(35, 60) * randSign(), math.random(35, 60) * randSign()
        Move(Baby, y_axis, -4, 0)
        Move(Baby, x_axis, distx, 4.5)
        Move(Baby, z_axis, disty, 4.5)
        WaitForMoves(Baby)

        signum = signum * -1
        --Move Baby
        valLueSpin = iRand(15, 90) * signum
        Turn(Baby, y_axis, math.rad(valLueSpin), 0.3)
        valLueSpin = valLueSpin * -1
        Turn(Navel, y_axis, math.rad(valLueSpin), 0.3)
        WaitForTurn(Baby, y_axis)

        if maRa() == true then
            --echo("This kills it")
            bx, by, bz = Spring.GetUnitPiecePosition(unitID, targetPos)
            --echo("No This kills it")
            --	moveUnitPieceToGroundPos(unitID,Baby,bx,bz,0.2,-2)
            --echo("None of those kills it")
            Sleep(1000)
            WaitForTurns(Baby, Navel)
        end
        --echo("ljscrapheap:"..linenumber);linenumber=linenumber+1 --5
        Sleep(1000)
        live = live - 2000
    end

    --echo("Did you kill my mama")

    Hide(Baby)
    Hide(Navel)
end

function pipes(i)

    if maRa() == true then
        xval = math.random(-35, 35)
        zval = math.random(-35, 35)
        val = math.random(-42, 42)
        Spin(Pipe[i], y_axis, math.rad(val), 0.3)
        Move(Pipe[i], x_axis, xval, 0)
        Move(Pipe[i], y_axis, 50, 0)
        Move(Pipe[i], z_axis, zval, 0)
        if maRa() == true then
            dice = math.random(3, 9)
            for j = 1, dice, 1 do
                Turn(Pipe[i], x_axis, math.rad(10 * -1 ^ j), math.random(0.72, 0.75))
                Turn(Pipe[i], z_axis, math.rad(math.random(-30, 30)), 0.5)
                if math.random(0, 1) == 1 then
                    WaitForTurn(Pipe[i], x_axis)
                else
                    WaitForTurn(Pipe[i], z_axis)
                end
                Sleep(200)
            end
        else
            turnPieceRandDir(Pipe[i], 0, 30, -30, 360, -360, 30, -30)
        end


        Sleep(100)

        Show(Pipe[i])
        reset(Pipe[i], math.random(9, 22))
        Spin(Pipe[i], y_axis, math.rad(math.random(-42, 42)))
        WaitForTurn(Pipe[i], x_axis)
        WaitForTurn(Pipe[i], z_axis)
        WaitForMove(Pipe[i], y_axis)
        StopSpin(Pipe[i], y_axis)
        Turn(Pipe[i], y_axis, math.rad(0), 6)
        WaitForMove(Pipe[i], x_axis)
        WaitForMove(Pipe[i], z_axis)
    end
end


function TimeOfMyLife()

    SetSignalMask(SIG_DEATH)

    foo = function(pieces)
        dice = math.random(-1, 1)
        dice = (dice / math.abs(dice)) * -20
        Turn(pieces, x_axis, math.rad(dice), 0)
    end

    process(Shell, foo)

    Sleep(240000)
    Move(center, y_axis, -30, 1)
    WaitForMove(center, y_axis)
    Spring.DestroyUnit(unitID, false, false)
end

function script.Killed()
    return 1
end

function script.Create()

    init()
    if boolWeeImATree == false then
        x, y, z = Spring.GetUnitPosition(unitID)
        teamID = Spring.GetUnitTeam(unitID)
        GG.UnitsToSpawn:PushCreateUnit("gdecjscrapheap", x, y, z, 0, teamID)
    end

    StartThread(TimeOfMyLife)
    StartThread(contemplateOrigin)
end