include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_jw.lua"

include "lib_Build.lua"


--We could have avoid this missery.. if we had deform-animations- and neural implants.
LAltF = piece "LAltF"
LAltW = piece "LAltW"
--piecesList
LavaWheelB = piece "LavaWheelB" --redhot going into black
LavaStream = piece "LavaStream" --still yellow-orange stream
LavaWheelAlt = piece "LavaWheelAlt"

LavaExpHa = piece "LavaExpHa" --tonguelike
LavaExpWMe = piece "LavaExpWMe" --orange-red
LavaExpWSm = piece "LavaExpWSm" --yellow-orange,fastrotating

LavaDecora = piece "LavaDecora"
LavaFeatur = piece "LavaFeatur"
--emiting fire and smoke when lava ventures over new terrain.
Bubble = {}
speed=6.141
for i = 1, 4, 1 do
    Bubble[i] = {}
    x = "bubble" .. i
    Bubble[i] = piece(x)
end

SpinPoints = {}
for i = 1, 4, 1 do
    SpinPoints[i] = {}
    x = "spinpoint" .. i
    SpinPoints[i] = piece(x)
end

firEmit = {}
for i = 1, 5, 1 do
    firEmit[i] = {}
    x = "fireEmit" .. i
    firEmit[i] = piece(x)
end
--emits the Light
lavaLightEmit = piece "lavaLightEmit"
local flameTurret = piece "flameTurret"
local center = piece "center"

--/piecesList
SIG_LIGHT = 1
SIG_PRO = 2

teamID = Spring.GetUnitTeam(unitID)
boolAlternative = false

function emitit()
    SetSignalMask(SIG_LIGHT)
    while (true) do
        Sleep(60)
        rand = math.random(1, 5)
        EmitSfx(firEmit[rand], 1026)
    end
end

function procreateEmit()
    SetSignalMask(SIG_PRO)
    while (true) do
        Sleepus = math.random(40, 70)
        Sleep(Sleepus)
        EmitSfx(LavaExpWSm, 1026)
    end
end

function lavaSound()
    while (true) do
        da = math.random(0, 5)

        if da == 1 then
            Spring.PlaySoundFile("sounds/gVolcano/lavaFlow.wav")
            Sleep(12000)
        end
        if da == 2 then
            Spring.PlaySoundFile("sounds/gVolcano/lavaFlow.wav")
            waitForMe = math.random(1000, 2000)
            Sleep(waitForMe)


            Spring.PlaySoundFile("sounds/gVolcano/lavaShard.wav")
            Sleep(10001)
        end
        if da == 3 then
            Spring.PlaySoundFile("sounds/gVolcano/blubber.wav")
            Sleep(32000)
        end

        xorgIhateYou = math.random(4000, 20000)
        Sleep(xorgIhateYou)
    end
end


function resetExpander()

    Turn(LavaExpWSm, y_axis, math.rad(0), 2*speed)
    Turn(LavaExpWSm, x_axis, math.rad(0), 2*speed)
    Turn(LavaExpWSm, z_axis, math.rad(0), 2*speed)
    Turn(LavaStream, y_axis, math.rad(0), 2*speed)
    Turn(LavaStream, x_axis, math.rad(0), 2*speed)
    Turn(LavaStream, z_axis, math.rad(0), 2*speed)
    Turn(LavaExpWMe, y_axis, math.rad(0), 2*speed)
    Turn(LavaExpWMe, x_axis, math.rad(0), 2*speed)
    Turn(LavaExpWMe, z_axis, math.rad(0), 2*speed)
    Move(LavaStream, y_axis, -5, 2*speed)
    Move(LavaExpHa, y_axis, -5, 2*speed)
    Move(LavaExpWSm, y_axis, -5, 2*speed)
    WaitForMove(LavaStream, y_axis)
    WaitForMove(LavaExpHa, y_axis)
    WaitForMove(LavaExpWSm, y_axis)
    Hide(LavaExpWSm)
    Hide(LavaStream)
    Hide(LavaExpWMe)
    Hide(LavaExpHa)

    Turn(LavaExpHa, y_axis, math.rad(0), 2*speed)
    Turn(LavaExpHa, x_axis, math.rad(0), 2*speed)
    Turn(LavaExpHa, z_axis, math.rad(0), 2*speed)
    Move(LavaExpHa, y_axis, 0, 2*speed)
    Move(LavaExpHa, x_axis, 0, 2*speed)
    Move(LavaExpHa, z_axis, 0, 2*speed)

    Move(LavaExpWSm, y_axis, 0, 2*speed)
    Move(LavaExpWSm, x_axis, 0, 2*speed)
    Move(LavaExpWSm, z_axis, 0, 2*speed)

    Move(LavaStream, y_axis, 0, 2*speed)
    Move(LavaStream, x_axis, 0, 2*speed)
    Move(LavaStream, z_axis, 0, 2*speed)

    Move(LavaExpWMe, y_axis, 0, 2*speed)
    Move(LavaExpWMe, x_axis, 0, 2*speed)
    Move(LavaExpWMe, z_axis, 0, 2*speed)
    WaitForMove(LavaExpWMe, x_axis)
    WaitForMove(LavaStream, y_axis)
    WaitForMove(LavaExpWSm, y_axis)
    if boolAlternative == false then
        reSetBhigWheel()
        Sleep(800)
    end
end

function prepStage()
    Spin(LavaDecora, z_axis, math.rad(-3),speed* 0.1)
    Spin(LavaExpWSm, z_axis, math.rad(4),speed* 0.1)
    Spin(LavaExpWMe, z_axis, math.rad(2),speed* 0.1)
    Spin(LavaStream, z_axis, math.rad(2.6),speed* 0.3)
    Spin(LavaWheelAlt, z_axis, math.rad(1),speed* 0.2)

    Move(LavaExpHa, y_axis, 0, 0)
    Move(LavaExpHa, x_axis, 0, 0)
    Move(LavaExpHa, z_axis, 0, 0)
    Hide(LavaExpHa)
    Move(LavaExpWMe, y_axis, -7.5, 0)
    Hide(LavaExpWMe)
    Move(LavaFeatur, y_axis, -24, 0)
    Hide(LavaFeatur)
    Move(LavaStream, y_axis, -11, 0)
    Hide(LavaStream)
    Move(LavaWheelB, y_axis, -22, 0)
    Hide(LavaWheelB)
    Move(LavaExpWSm, y_axis, -5, 0)
    Move(LavaStream, y_axis, -10, 0)
    Hide(LavaStream)
end

function reSetBhigWheel()
    Turn(LavaWheelB, z_axis, math.rad(0),speed* 0.5)
    Turn(LavaWheelB, y_axis, math.rad(0),speed* 0.5)
    Turn(LavaWheelB, x_axis, math.rad(0),speed* 0.5)
    Move(LavaWheelB, y_axis, 0,speed* 0.5)
end

--from first appear till stable State

function idle()

    yAxeTurn = math.random(0, 360)
    forward = math.random(10, 21)
    moveUp = math.random(-0.5, 1)
    Turn(LavaWheelB, z_axis, math.rad(forward),speed* 0.13)
    Turn(LavaWheelB, y_axis, math.rad(yAxeTurn),speed* 0.08)
    Move(LavaWheelB, y_axis, moveUp, speed* 0.02)
    WaitForTurn(LavaWheelB, y_axis)

    yAxeTurn = math.random(0, 360)
    backward = math.random(-32, 15)

    moveDown = math.random(-2, 0.5)
    Turn(LavaWheelB, z_axis, math.rad(backward),speed* 0.13)
    Turn(LavaWheelB, y_axis, math.rad(yAxeTurn),speed* 0.08)
    Move(LavaWheelB, y_axis, moveDown, speed* 0.02)
    WaitForTurn(LavaWheelB, y_axis)
end

function letThereBeLight()
    while (true) do
        EmitSfx(lavaLightEmit, 1026)
        Sleep(125)
    end
end

function emitFire(piece, howOften, naptime)
    while (true) do
        for i = 0, howOften, 1 do
            EmitSfx(piece, 1025)

            if i % 3 == 0 then --smoke
                EmitSfx(piece, 258)
            end
            if i % 12 == 0 then --sparks
                EmitSfx(piece, 1024)
                --	Explode(lavaLightEmit,SFX.FALL)
            end


            i = (i + 1) % 23
            Sleep(naptime)
        end
    end
end



function LavaBoilingUp(multiply)
    Signal(SIG_PRO)
    StartThread(procreateEmit)
    Show(LavaExpWSm)
    Show(LavaExpWMe)
    Show(LavaStream)
    Show(LavaWheelB)
    if LavaWheelB ~= LavaWheelAlt then
        Show(LavaDecora)

        for i = 1, 4, 1 do
            Hide(Bubble[i])
        end

        SpinPoints = {}

    else
        for i = 1, 4, 1 do
            x = math.random(0, 1)
            xrand = math.random(-2, 2)
            y = math.random(0, 1)
            yrand = math.random(-2, 2)
            z = math.random(0, 1)
            zrand = math.random(-2, 2)
            if x == 1 then
                if xrand < 0.1 and xrand > -0.1 then
                    xrand = 0.5
                end
                Spin(Bubble[i], x_axis, math.rad(xrand), 0.02)
            end
            if y == 1 then
                if yrand < 0.1 and yrand > -0.1 then
                    yrand = 0.6
                end
                Spin(Bubble[i], y_axis, math.rad(yrand), 0.02)
            end
            if z == 1 then
                if zrand < 0.1 and zrand > -0.1 then
                    zrand = 0.7
                end
                Spin(Bubble[i], z_axis, math.rad(zrand), 0.02)
            end
            Show(Bubble[i])
        end
        for i = 1, 4, 1 do
            x = math.random(0, 1)
            xrand = math.random(-5, 5)
            y = math.random(0, 1)
            yrand = math.random(-5, 5)
            z = math.random(0, 1)
            zrand = math.random(-5, 5)
            if x == 1 or y == 0 then
                if xrand < 0.1 and xrand > -0.1 then
                    xrand = 0.5
                end
                Spin(SpinPoints[i], x_axis, math.rad(xrand), 0.02)
            end
            if y == 1 or x == 0 then
                if yrand < 0.1 and yrand > -0.1 then
                    yrand = 0.6
                end
                Spin(SpinPoints[i], y_axis, math.rad(yrand), 0.02)
            end
            if z == 1 or (x == 0 and y == 0) then
                if zrand < 0.1 and zrand > -0.1 then
                    zrand = 0.7
                end
                Spin(SpinPoints[i], z_axis, math.rad(zrand), 0.02)
            end
        end
    end

    rotaRandom = math.random(0, 360)
    Turn(center, y_axis, math.rad(rotaRandom), 0)

    Move(LavaExpWSm, y_axis, -1, 0.2*speed)
    Move(LavaExpWSm, x_axis, 5, 0.06*speed)
    WaitForMove(LavaExpWSm, y_axis)
    StartThread(emitFire, LavaExpHa, 5, 100)
    Move(LavaExpWMe, y_axis, -2.5, 0.2*speed)
    WaitForMove(LavaExpWMe, y_axis)

    Move(LavaExpWSm, x_axis, 13, 0.08*speed)
    Move(LavaExpWMe, x_axis, 7, 0.09 *speed)

    WaitForMove(LavaExpWMe, x_axis)
    Move(LavaStream, y_axis, -3, 0.2*speed)
    Move(LavaStream, x_axis, 5, 0.09*speed)
    WaitForMove(LavaStream, y_axis)

    WaitForMove(LavaStream, x_axis)

    ix = math.random(0, 1)
    if ix == 1 then
        boolAlternative = true
    end

    if boolAlternative == false then
        Turn(LavaWheelB, z_axis, math.rad(-158), 0)
        Move(LavaWheelB, y_axis, -16, 0.3*speed)
        WaitForMove(LavaWheelB, y_axis)

        Move(LavaExpWSm, x_axis, 15, 0.6*speed)
        Move(LavaExpWMe, x_axis, 22, 0.9*speed)
        Move(LavaWheelB, y_axis, -2, 0.3*speed)
        Turn(LavaWheelB, z_axis, math.rad(-77), 0.05)
        WaitForMove(LavaWheelB, y_axis)
        WaitForTurn(LavaWheelB, z_axis)
        Move(LavaExpWSm, x_axis, 0, 0.06*speed)
        Move(LavaExpWMe, x_axis, 0, 0.09*speed)
        Move(LavaWheelB, y_axis, 0, 0.09*speed)
        Turn(LavaWheelB, z_axis, math.rad(12),speed* 0.05)
        WaitForMove(LavaExpWSm, x_axis)
        WaitForMove(LavaExpWMe, x_axis)
        WaitForMove(LavaWheelB, y_axis)
        resetExpander()
    else
        Turn(LavaWheelB, x_axis, math.rad(-158),speed* 0.3)
        Turn(LavaWheelB, z_axis, math.rad(22), speed*0.3)
        Spin(LavaWheelB, y_axis, math.rad(-3), speed*0.02)
        WaitForTurn(LavaWheelB, x_axis)
        WaitForTurn(LavaWheelB, z_axis)
        Move(LavaWheelB, y_axis, -2, speed*0.3)
        WaitForMove(LavaWheelB, y_axis)
        resetExpander()
    end
end

function expanderPreparaitons()
    Hide(LavaExpWSm)
    Hide(LavaStream)
    Hide(LavaExpWMe)
    Turn(LavaExpWSm, y_axis, math.rad(90), 0)
    Turn(LavaExpWSm, x_axis, math.rad(0), 0)
    Turn(LavaExpWSm, z_axis, math.rad(0), 0)
    Turn(LavaStream, y_axis, math.rad(90), 0)
    Turn(LavaStream, x_axis, math.rad(0), 0)
    Turn(LavaStream, z_axis, math.rad(0), 0)
    Turn(LavaExpWMe, y_axis, math.rad(90), 0)
    Turn(LavaExpWMe, x_axis, math.rad(0), 0)
    Turn(LavaExpWMe, z_axis, math.rad(0), 0)

    Move(LavaExpWSm, y_axis, -5, 0)
    Move(LavaExpWSm, x_axis, 0, 0)
    Move(LavaExpWSm, z_axis, 25, 0)

    Move(LavaStream, y_axis, -9, 0)
    Move(LavaStream, x_axis, 0, 0)
    Move(LavaStream, z_axis, 25, 0)

    Move(LavaExpWMe, y_axis, 0, 0)
    Move(LavaExpWMe, x_axis, -3, 0)
    Move(LavaExpWMe, z_axis, 25, 0)
    Show(LavaExpWSm)
    Show(LavaStream)
    Show(LavaExpWMe)
end




function strechOutExpander()
    orAnother = math.random(0, 1)



    Show(LavaExpWSm)
    Show(LavaStream)
    Show(LavaExpWMe)
    Show(LavaExpWSm)
    if orAnother == 1 and boolAlternative == false then
        Show(LavaWheelB)
        Move(LavaWheelB, y_axis, 0, 0.9)
        Turn(LavaWheelB, x_axis, math.rad(0),speed* 0.5)
        Turn(LavaWheelB, z_axis, math.rad(0),speed* 0.5)
        Turn(LavaWheelB, y_axis, math.rad(0),speed* 0.5)
        WaitForTurn(LavaWheelB, x_axis)
        WaitForTurn(LavaWheelB, z_axis)
        WaitForMove(LavaWheelB, y_axis)
        Turn(LavaWheelB, x_axis, math.rad(53),speed* 0.25)
        Turn(LavaWheelB, z_axis, math.rad(0), speed*0.15)
        Turn(LavaWheelB, y_axis, math.rad(0), speed*0.15)
        WaitForTurn(LavaWheelB, x_axis)
        --setup


        Turn(LavaExpHa, z_axis, math.rad(69), speed*12)
        Move(LavaExpHa, x_axis, -5, 0)
        Move(LavaExpHa, y_axis, 4, 0)

        Show(LavaExpHa)
        WaitForTurn(LavaExpHa, z_axis)

        Turn(LavaExpHa, z_axis, math.rad(179),speed* 7) --tongue  out
        Move(LavaExpHa, x_axis, -8,speed* 3)
        Move(LavaExpHa, y_axis, 4, speed*3)
        Move(LavaExpHa, z_axis, -1.5,speed* 3)
        WaitForTurn(LavaExpHa, z_axis)
        Move(LavaExpHa, x_axis, 0,speed* 3)
        Move(LavaExpHa, y_axis, 0,speed* 3)
        Move(LavaExpHa, z_axis, 0, speed*3)

    else
        if boolAlternative == false then
            reSetBhigWheel()

            Hide(LavaExpHa)
            Move(LavaExpHa, x_axis, -5, 0)
            Move(LavaExpHa, y_axis, 2.6, 0)
            Turn(LavaExpHa, z_axis, math.rad(-226), 0)

            Turn(LavaExpHa, z_axis, math.rad(-17), speed*0.2)
            WaitForTurn(LavaExpHa, z_axis)
        end
    end
    --tongue is now ready
    StartThread(emitFire, LavaExpWSm, 15, 100)
    --lets prepare the lavawheels
    expanderPreparaitons()

    --the usual lavaMongering
    Move(LavaExpWSm, y_axis, -5,speed* 0.25)
    Move(LavaExpWMe, y_axis, -2.3, speed*0.24)
    WaitForMove(LavaExpWSm, y_axis)
    Move(LavaStream, z_axis, 27, speed*0.23)
    Move(LavaExpWMe, z_axis, 26,speed* 0.24)
    Move(LavaExpWSm, z_axis, 31, speed*0.25)
    WaitForTurn(LavaExpHa, z_axis)
    --Waiting for the usual LavaMongering

    Move(LavaExpHa, y_axis, -9, speed*0.03)
    Move(LavaExpWSm, z_axis, 36,speed* 0.51)
    Move(LavaExpWMe, z_axis, 42,speed* 0.51)
    Move(LavaStream, y_axis, -4,speed* 0.5)
    Move(LavaStream, z_axis, 27,speed* 0.5)
    WaitForMove(LavaStream, z_axis)
    WaitForMove(LavaExpWMe, z_axis)
    WaitForMove(LavaExpWSm, z_axis)
end



function prepDead()
    Show(LavaFeatur)
    Move(LavaFeatur, y_axis, 0, speed*0.3)
    roundTurn = math.random(-44, 44)
    if boolAlternative == false then
        Explode(LavaDecora, SFX.FIRE + SFX.EXPLODE_ON_HIT)

        Hide(LavaDecora)
        Turn(LavaWheelB, x_axis, math.rad(roundTurn),speed* 0.2)
        Spin(LavaWheelB, y_axis, math.rad(0.5), speed*0.001)
        Move(LavaWheelB, y_axis, -5, speed*0.1)
        WaitForMove(LavaWheelB, y_axis)
        WaitForMove(LavaFeatur, y_axis)
    end
end

function proCreate()
    x, y, z = Spring.GetUnitPosition(unitID)

    oneInSeven = math.random(1, 9)
    boolImDoneHere = false
    if oneInSeven ~= 1 then
        while (boolImDoneHere == false) do
            Signal(SIG_PRO)
            turnX = math.random(0, 360)

            Turn(center, y_axis, math.rad(turnX),speed* 0.15)
            WaitForTurn(center, y_axis)
            StartThread(procreateEmit)
            strechOutExpander()
            posX, posY, posZ, _, _, _ = Spring.GetUnitPiecePosDir(unitID, LavaExpWSm)
            posY = Spring.GetGroundHeight(posX, posZ)
            if posY < y then
                --spawn a Unit
                local heading = Spring.GetUnitHeading(unitID)
                u = Spring.CreateUnit("gLava", posX, posY, posZ, 0, teamID)
                Spring.SetUnitRotation(u, 0, -heading * math.pi / 32768, 0)
                Sleep(158000)
                resetExpander()
                boolImDoneHere = true


            else
                resetExpander()
                Sleep(5000)
            end
        end
    end
end
featureNames={"lavafeature","lavafeature2","lavafeature3"}
function killLava()
    Signal(SIG_LIGHT)

	x, y, z = Spring.GetUnitPosition(unitID)
	dx,dy,dz=Spring.GetUnitDirection(unitID)
	rx,ry,rz=Spring.GetUnitRotation(unitID)
	featureID = Spring.CreateFeature(featureNames[math.random(1,#featureNames)], x, y, z)
	Spring.SetFeatureDirection(featureID,dx,dy,dz)
	Spring.SetFeatureRotation (featureID,rx,ry,rz)
	if maRa()==true then           Explode(LavaFeatur, SFX.SHATTER) end
	
	      Spring.DestroyUnit(unitID, true, true)
end

function physicsControll()
    Sleep(50) --to make sure the unit is on the ground
    xOrg, yOrg, zOrg = Spring.GetUnitPosition(unitID)
    intVar = 1
    while (true) do
        if intVar == 1 then
            yOrg = Spring.GetGroundHeight(xOrg, zOrg)
        end

        Spring.MoveCtrl.SetPosition(unitID, xOrg, yOrg, zOrg)
        Sleep(1000)
        intVar = (intVar + 1) % 4 --from Time to Time this needs a update or the terraforming is going to screw it over
    end
end

function decalFactoryEmit()
    Sleep(300)
    posX, posY, posZ = Spring.GetUnitPosition(unitID)
    Spring.CreateUnit("decalFactory", posX, posY, posZ, 0, teamID)
end


function altMain()
    Spin(LavaDecora, z_axis, math.rad(3), 	speed*0.01)
    Spin(LavaExpWSm, z_axis, math.rad(4), 	speed*0.01)
    Spin(LavaExpWMe, z_axis, math.rad(2), 	speed*0.01)
    Spin(LavaStream, z_axis, math.rad(2.6), speed*0.1)
    Spin(LavaWheelAlt, z_axis, math.rad(1), speed*0.2)


    for i = 1, 4, 1 do

        Hide(Bubble[i])
    end
    --PhysixTakeOver
    Spring.MoveCtrl.Enable(unitID)
    StartThread(physicsControll)
    boolAlternative = true
    --startSound
    StartThread(lavaSound)
    --Hide all non Alternative pieces
    Hide(LavaWheelB)
    Hide(LavaStream)
    Hide(LavaWheelAlt)

    Hide(LavaExpHa)
    Hide(LavaExpWMe)
    Hide(LavaExpWSm)

    Hide(LavaDecora)
    Hide(LavaFeatur)
    Move(LAltF, y_axis, -20, 0)
    Move(LAltW, y_axis, -20, 0)
    Move(LAltW, y_axis, 0,speed* 0.3)
    Spin(LAltW, x_axis, math.rad(3), speed*0.02)
    WaitForMove(LAltW, y_axis)
    Move(LAltF, y_axis, 0, speed*0.3)
    WaitForMove(LAltF, y_axis)


    --idling
    --rotatot random
    howLongToIdle = math.random(0, 5)
    for i = 0, howLongToIdle, 1 do
        idle()
        Sleep(500)
    end


    --reSetBhigWheel

    proCreate()

    howLongToIdle = math.random(0, 15)
    for i = 0, howLongToIdle, 1 do

        Sleep(500)
    end




    killLava()
end



function lavaMain()
    Hide(LAltF)
    Hide(LAltW)
    --PhysixTakeOver
    Spring.MoveCtrl.Enable(unitID)
    StartThread(physicsControll)

    --startSound
    StartThread(lavaSound)
    prepStage()
    LavaBoilingUp(4)

    --idling

    if boolAlternative == false then
        howLongToIdle = math.random(0, 5)
        for i = 0, howLongToIdle, 1 do
            idle()
            Sleep(500)
        end
    end

    --reSetBhigWheel
    if boolAlternative == false then
        reSetBhigWheel()
    end
    proCreate()

    if boolAlternative == false then
        howLongToIdle = math.random(0, 15)
        for i = 0, howLongToIdle, 1 do
            idle()
            Sleep(500)
        end
    end

    prepDead()

    killLava()
end

function script.Killed()
end

--flameThrowerWeapon
ResistantUnits= mergeDict(getAbstractTypes(),getExemptFromLethalEffectsUnitTypeTable(UnitDefNames))
ResistantUnits= mergeDict(ResistantUnits, getPyroProofUnitTypeTable())
LAVA_RANGE= 60
LavaDamageSecond= 320
function lavaDamage()
x,_,z = Spring.GetUnitPosition(unitID)
removeGrass(x-64,z-64,x+64,z+64)

while true do
T= getAllNearUnit(unitID, LAVA_RANGE)
process(T,
		function (id)
			if distanceUnitToUnit(unitID,id) < LAVA_RANGE then
				return id 		
			end
		end,
		function(id)
			if id ~= unitID and  not ResistantUnits[Spring.GetUnitDefID(id)] then
				Spring.AddUnitDamage(id,math.ceil(LavaDamageSecond/300))
				   setUnitOnFire(id, math.random(190, 1500))
			end
		end
		)

Sleep(300)
end

end


function script.Create()
	Spring.SetUnitNoSelect(unitID, true)
    StartThread(emitit)
    oneThird = math.random(0, 2)
    if oneThird == 1 then
        betaIsDat = math.random(0, 3)
        if betaIsDat ~= 2 then
            Hide(LavaWheelB)
            Hide(LavaDecora)
            LavaWheelB = LavaWheelAlt
        else
            Hide(LavaWheelAlt)
        end
        StartThread(letThereBeLight)

        StartThread(lavaMain)
    else
        StartThread(altMain)
    end
	StartThread(lavaDamage)
    StartThread(decalFactoryEmit)
	StartThread(totalLifeTime)
end

function totalLifeTime()
Sleep(5*60*1000)
killLava()
end


-------------------------------------------------------- REWRITE
-- Spring.SetUnitBlocking(featureID, false,false,false)












