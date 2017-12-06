feet = {}
for i = 1, 6, 1 do
    x = i - 1
    feet[i] = {}
    feet[i][1] = {}
    feet[i][2] = {}
    tempR = "rightleg" .. x
    tempD = "rightlegl" .. x
    feet[i][1] = piece(tempR)
    feet[i][2] = piece(tempD)

    --add upperfeet at [1]

    --add lowerfeet at [2]

    feet[i + 6] = {}
    feet[i + 6][1] = {}
    feet[i + 6][2] = {}
    tempR = "leftleg" .. x
    tempD = "leftleglo" .. x
    feet[i + 6][1] = piece(tempR)
    feet[i + 6][2] = piece(tempD)
end
interVallHalf = 9
center = piece "center"
hdlmain = piece "hdlaumain"
walls = {}
for i = 1, 3, 1 do
    walls[i] = {}
    walls[i][1] = {}
    temp = "hWall" .. i
    walls[i][1] = piece(temp)
    Hide(walls[i][1])
    Move(walls[i][1], y_axis, -20, 0)

    walls[i][2] = {}
    walls[i][3] = {} --interVallStart
    walls[i][4] = {} --interVallEnd

    walls[i][3] = 0 --interVallStart
    walls[i][4] = 0 --interVallEnd
    walls[i][2] = false
end

eye = {}
for i = 1, 6, 1 do
    eye[i] = {}
    tempPiece = "Eye" .. i
    eye[i] = piece(tempPiece)
end
SIG_WALK = 2
SIG_DELAY = 4
SIG_DELAYL = 16
SIG_RETURN = 8

hlfus1 = piece "hlfus1"
hlfus2 = piece "hlfus2"
hlfusspore = piece "hlfusspore"
hlfusspor0 = piece "hlfusspor0"
hlamocircl = piece "hlamocircl"
hlamocirc2 = piece "hlamocirc2"
hlamo = piece "hlamo"
hlgun = piece "hlgun"



function legs_Down()
    for i = 1, 12 do
        Turn(feet[i][1], x_axis, math.rad(0), 12)
        Turn(feet[i][1], y_axis, math.rad(0), 12)
        Turn(feet[i][1], z_axis, math.rad(0), 12)


        Turn(feet[i][2], x_axis, math.rad(0), 12)
        Turn(feet[i][2], y_axis, math.rad(0), 12)
        Turn(feet[i][2], z_axis, math.rad(0), 12)
    end
end




function getFreeWall()

    for i = 1, 3, 1 do
        if walls[i][2] == false then return i end
    end
    return nil
end


function TurnShield(nr, degree)
    --	--Spring.Echo("Reached TurnShield")
    walls[nr][2] = true --in use
    Show(walls[nr][1])
    Move(walls[nr][1], y_axis, 0, 66)
    WaitForMove(walls[nr][1], y_axis)
    Turn(walls[nr][1], y_axis, math.rad(degree), 22)
    WaitForTurn(walls[nr][1], y_axis)
    walls[nr][3] = degree - interVallHalf
    walls[nr][4] = degree + interVallHalf
    countNumber = 2000

    while (boolMoving == false and countNumber > 0) do
        Sleep(350)
        countNumber = countNumber - 350
    end

    Move(walls[nr][1], y_axis, -20, 66)
    WaitForMove(walls[nr][1], y_axis)
    Hide(walls[nr][1])
    walls[nr][2] = false
end


function script.HitByWeapon(x, z, weaponDefID, damage)
    degree = math.deg(math.atan2(x, z))

    --check Allready established Walls
    for i = 1, 3, 1 do
        if walls[i][2] == true and degree > walls[i][3] and degree < walls[i][4] then
            return 0
        end -- we have a Wall in Place, no damage taken
    end
    x = getFreeWall()
    if x ~= nil then
        --getFreeWall
        StartThread(TurnShield, x, degree)
        return 0
        --if not nil showWall, then StartThread Turn
    else
        return damage
    end
end

function moveFoot(nr, speed, delay)



    if nr < 7 then
        if nr == 1 or nr == 6 then
            Turn(feet[nr][1], y_axis, math.rad(0), speed * 2)

        else
            Turn(feet[nr][1], y_axis, math.rad(0), speed)
        end


        --move foot up and retract inwards

        Turn(feet[nr][1], z_axis, math.rad(-54), speed)
        WaitForTurn(feet[nr][1], y_axis)
        --WaitForTurn(feet[nr][1],z_axis)
        Turn(feet[nr][2], z_axis, math.rad(108), speed)
        WaitForTurn(feet[nr][2], z_axis)
        --turn forward, expand
        if nr == 1 or nr == 6 then
            Turn(feet[nr][1], y_axis, math.rad(60), speed * 2)

        else
            Turn(feet[nr][1], y_axis, math.rad(60), speed)
        end




        WaitForTurn(feet[nr][1], y_axis)
        if nr == 1 or nr == 6 then
            Turn(feet[nr][2], z_axis, math.rad(-20), speed * 4.5)
            WaitForTurn(feet[nr][2], z_axis)
        end
        Turn(feet[nr][1], z_axis, math.rad(0), speed)
        WaitForTurn(feet[nr][1], z_axis)
        Turn(feet[nr][2], z_axis, math.rad(0), speed)
        --turn down
        Turn(feet[nr][1], y_axis, math.rad(0), speed * 0.8)
        WaitForTurn(feet[nr][1], y_axis)
       
        --turn midway, retract halfup

        --turn back-- turn down

        Turn(feet[nr][1], y_axis, math.rad(-75), speed * 0.7)
        WaitForTurn(feet[nr][1], y_axis)
        Sleep(100)
        Turn(feet[nr][1], z_axis, math.rad(-35), speed)
        Turn(feet[nr][2], z_axis, math.rad(60), speed)

        WaitForTurn(feet[nr][1], z_axis)
        WaitForTurn(feet[nr][2], z_axis)
        --move foot up and retract inwards



    else --move foot up and retract inwards
        if nr == 7 or nr == 12 then
            Turn(feet[nr][1], y_axis, math.rad(0), speed * 2)

        else
            Turn(feet[nr][1], y_axis, math.rad(0), speed)
        end


        Turn(feet[nr][1], z_axis, math.rad(54), speed)
        WaitForTurn(feet[nr][1], y_axis)
        Turn(feet[nr][2], z_axis, math.rad(-108), speed)
        WaitForTurn(feet[nr][2], z_axis)
        --turn forward, expand
        if nr == 7 or nr == 12 then
            Turn(feet[nr][1], y_axis, math.rad(-60), speed * 2.5)
        else
            Turn(feet[nr][1], y_axis, math.rad(-60), speed)
        end



        WaitForTurn(feet[nr][1], y_axis)
        if nr == 7 or nr == 12 then
            Turn(feet[nr][2], z_axis, math.rad(20), speed * 4.5)
            WaitForTurn(feet[nr][2], z_axis)
        end

        Turn(feet[nr][1], z_axis, math.rad(0), speed)
        WaitForTurn(feet[nr][1], z_axis)
        Turn(feet[nr][2], z_axis, math.rad(0), speed)
        --turn down
        Turn(feet[nr][1], y_axis, math.rad(0), speed * 0.8)

        WaitForTurn(feet[nr][1], y_axis)
        --turn midway, retract halfup

        --turn back-- turn down

        Turn(feet[nr][1], y_axis, math.rad(75), speed * 0.7)
        WaitForTurn(feet[nr][1], y_axis)
        Sleep(100)
        Turn(feet[nr][1], z_axis, math.rad(35), speed)
        Turn(feet[nr][2], z_axis, math.rad(-60), speed)

        WaitForTurn(feet[nr][1], z_axis)
        WaitForTurn(feet[nr][2], z_axis)
        --move foot up and retract inwards
    end
end

function walk()
    for i = 1, 3, 1 do
        Hide(walls[i][1])
    end
    local feetFetishism = moveFoot

    SetSignalMask(SIG_WALK)
    while true do
        for i = 1, 6, 1 do
            StartThread(feetFetishism, i, 3, 0)
            StartThread(feetFetishism, i + 6, 3, 0)
            Sleep(180)
        end
        Turn(hdlmain, x_axis, math.rad(-3), 0.025)
        Sleep(1800)
        Turn(hdlmain, x_axis, math.rad(3), 0.045)
    end
end

reloadProj = piece "hlamo"
TurnPoint = piece "turnPoint"
boolReadyToFire = true

function reloadAnimation()
    boolReadyToFire = false
    Turn(TurnPoint, x_axis, math.rad(0), 0)
    --StopSpin(reloadProj,z_axis,0)
    Turn(reloadProj, x_axis, math.rad(0), 0)
    Spin(reloadProj, y_axis, math.rad(42), 4)
    Show(reloadProj)
    Move(reloadProj, y_axis, 14, 3)
    WaitForMove(reloadProj, y_axis)
    --StopSpin(reloadProj,y_axis,0)

    --Turn(reloadProj,y_axis,math.rad(0),12)
    Turn(TurnPoint, x_axis, math.rad(90), 17)
    WaitForTurn(TurnPoint, x_axis)
    --Spin(reloadProj,z_axis,math.rad(42),4)
    boolReadyToFire = true
end

function delayedMove()
    SetSignalMask(SIG_DELAY)
    Sleep(50)
    boolMoving = true
end

function delayedLegsDown()
    SetSignalMask(SIG_DELAYL)
    Sleep(650)
    legs_Down()
end

boolMoving = false
function script.StartMoving()

    Signal(SIG_DELAY)
    StartThread(delayedMove)
    StartThread(walk)
    Signal(SIG_DELAYL)
end

function script.StopMoving()

    Signal(SIG_WALK)
    boolMoving = false
    StartThread(delayedLegsDown)
end


function eyeLoop()
    --Spring.Echo("JW_HEADLAUNCH_EYELOOP")
    for i = 2, 6, 1 do
        xRand = math.random(-360, 360)
        yRand = math.random(-360, 360)
        zRand = math.random(-360, 360)
        Spin(eye[i], x_axis, math.rad(xRand), speed)
        Spin(eye[i], y_axis, math.rad(yRand), speed)
        Spin(eye[i], z_axis, math.rad(zRand), speed)
    end


    while (true) do
        xRand = math.random(-40, 20)
        yRand = math.random(-66, 66)
        speed = math.random(4, 19)
        Turn(eye[1], x_axis, math.rad(xRand), speed)
        Turn(eye[1], y_axis, math.rad(yRand), speed)
        WaitForTurn(eye[1], x_axis)
        WaitForTurn(eye[1], y_axis)
        SleepRand = math.ceil(math.random(50, 800))
        Sleep(SleepRand)
    end
end



--- AIMING & SHOOTING---
function script.QueryWeapon1()
    return hlgun
end

function script.AimFromWeapon1()
    return hlgun
end



--must return true to allow the weapon to shot. return false denies the weapon from shooting
--can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon1(heading, pitch)
    Turn(hlgun, y_axis, heading, 7)
    WaitForTurn(hlgun, y_axis)
    --make sure the aiming animation is only run once

    if boolReadyToFire == true then
        return true
    else
        return false
    end
end


function script.Create()
    --leave()
    Hide(reloadProj)
    StartThread(eyeLoop)
    Spin(hlfus1, y_axis, math.rad(192), 0.5)
    Spin(hlfus2, y_axis, math.rad(-192), 0.5)
    Spin(hlfusspore, y_axis, math.rad(222), 0.5)
    Spin(hlfusspor0, y_axis, math.rad(222), 0.5)

    Spin(hlamo, y_axis, math.rad(-145), 0.5)
    Spin(hlamocircl, y_axis, math.rad(200), 0.5)
    Spin(hlamocirc2, y_axis, math.rad(-200), 0.5)
    StartThread(reloadAnimation)
end

function reTurnGun()
    SetSignalMask(SIG_RETURN)
    Sleep(1000)
    Turn(hlgun, y_axis, math.rad(0), 5)
end

--called after the weapon has fired
function script.FireWeapon1()
    Signal(SIG_RETURN)
    StartThread(reTurnGun)
    Hide(reloadProj)
    Move(reloadProj, y_axis, 0, 0)
    Turn(reloadProj, x_axis, math.rad(0), 0)
    Sleep(10)
    StartThread(reloadAnimation)
end


--- -death animation: fall over & explode
function script.Killed(recentDamage, maxHealth)
    for i = 1, 3, 1 do
        Hide(walls[i][1])
    end
    Explode(hlgun, SFX.SHATTER + SFX.NO_HEATCLOUD)

    Hide(hlgun)
    Turn(center, x_axis, math.rad(190), 100)
    WaitForTurn(center, x_axis)
    spasmPlasm = math.random(1, 22)
    for i = 1, spasmPlasm, 1 do
        theChoosenOne = math.ceil(math.random(1, 11))
        randSpeed = math.random(2, 9)
        StartThread(moveFoot, theChoosenOne, randSpeed, 0)
        if i % 7 == 0 then Sleep(2000) end
    end
    Sleep(1000)
    for i = 1, 6, 1 do
        Explode(feet[i][1], SFX.FALL + SFX.FIRE)
        Explode(feet[i + 6][1], SFX.FALL + SFX.FIRE)
        Explode(feet[i][2], SFX.FALL + SFX.FIRE)
        Explode(feet[i + 6][2], SFX.FALL + SFX.FIRE)

        Sleep(180)
    end

    return 0
end
