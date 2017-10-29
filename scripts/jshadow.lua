include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"
--a walking animation using threads
--smoothly aiming the weapon, also using threads
tempORary = piece "tempORary"
tail = {}
for i = 1, 32, 1 do
    tempString = "tail" .. i
    tail[i] = piece(tempString)
end

center = piece "center"

koerperteile = {}
for i = 0, 41, 1 do
    tempString = "eyeball" .. i
    koerperteile[i + 1] = piece(tempString)
end
shadow1 = {}
shadow2 = {}
shadow2bod = piece "shadow2bod"
sh1upleg3 = piece "sh1upleg3"
sh1leg3 = piece "sh1leg3"
sh1lowleg3 = piece "sh1lowleg3"
sh1upleg4 = piece "sh1upleg4"
sh1leg4 = piece "sh1leg4"
sh1lowleg4 = piece "sh1lowleg4"
sh1upleg2 = piece "sh1upleg2"
sh1leg2 = piece "sh1leg2"
sh1lowleg2 = piece "sh1lowleg2"
sh1upleg1 = piece "sh1upleg1"
sh1leg1 = piece "sh1leg1"
sh1lowleg1 = piece "sh1lowleg1"



shadow2[1] = shadow2bod
shadow2[2] = sh1upleg3
shadow2[3] = sh1leg3
shadow2[4] = sh1lowleg3
shadow2[5] = sh1upleg4
shadow2[6] = sh1leg4
shadow2[7] = sh1lowleg4
shadow2[8] = sh1upleg2
shadow2[9] = sh1leg2
shadow2[10] = sh1lowleg2
shadow2[11] = sh1upleg1
shadow2[12] = sh1leg1
shadow2[13] = sh1lowleg1

shadow1bod = piece "shadow1bod"
shwNeck21 = piece "shwNeck21"
shwNeck22 = piece "shwNeck22"
shwHead2 = piece "shwHead2"
shwUpL23 = piece "shwUpL23"
shwLL23 = piece "shwLL23"
shwUpL24 = piece "shwUpL24"
shwLL24 = piece "shwLL24"
shwUpL21 = piece "shwUpL21"
shwLL21 = piece "shwLL21"
shwUpL22 = piece "shwUpL22"
shwLL22 = piece "shwLL22"
shadow1[1] = shadow1bod
shadow1[2] = shwNeck21
shadow1[3] = shwNeck22
shadow1[4] = shwHead2
shadow1[5] = shwUpL23
shadow1[6] = shwLL23
shadow1[7] = shwLL24
shadow1[8] = shwUpL21
shadow1[9] = shwLL21
shadow1[10] = shwUpL22
shadow1[11] = shwLL22
local boolOnTheMove = false
local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local leg_movespeed = 20
local leg_movedistance = 10

local percentage = 100
function bodybuild()

    if 1 == math.random(0, 1) then
        for i = 1, table.getn(shadow1), 1 do
            Hide(shadow1[i])
        end
        for i = 21, 38, 1 do
            Hide(koerperteile[i])
        end
    else
        for i = 1, table.getn(shadow2), 1 do
            Hide(shadow2[i])
        end

        for i = 1, 20, 1 do
            Hide(koerperteile[i])
        end

        for i = 1, table.getn(tail), 1 do
            Hide(tail[i])
        end
    end
end

function smokeEmit()
    for i = 1, 4 do
        fromTimeToTime = math.random(0, 44)
        if fromTimeToTime == 1 then
            EmitSfx(tempORary, 1024)
        end
        EmitSfx(tempORary, 1024)
        Sleep(110)
    end
end

function tailUPinParam(startP, endP)
    totalDegreeAuslenkung = 35
    for i = startP, endP, 1 do
        deg = ((math.sin(i * (3.141 / 2))) * 0.5) * totalDegreeAuslenkung
        Turn(tail[i], x_axis, math.rad(deg), 4.5)
    end
end

function tailDOWNinParam(startP, endP)
    totalDegreeAuslenkung = 35
    for i = startP, endP, 1 do
        deg = ((math.cos(i * (3.141 / 2))) * -0.5) * totalDegreeAuslenkung
        Turn(tail[i], x_axis, math.rad(deg), 4.5)
    end
end

function waveUP()
    for i = 0, 3, 1 do
        tailUPinParam((i * 8) + 1, (i * 8) + 8)
    end
end

function waveDown()

    for i = 0, 3, 1 do
        tailDOWNinParam((i * 8) + 1, (i * 8) + 8)
    end
end

function turnThemDown()
    for i = 0, 3, 1 do
        for j = 1, 8, 1 do
            Turn(tail[(i * 8) + j], x_axis, math.rad((-45 * (1 / j)) + (j / 45) * (1 / 8)), 4.9)
        end
    end
end

function shakeThatTailFeather()
    while (true) do
        while (boolOnTheMove == true) do
            Sleep(500)
            waveUP()
            for i = 1, table.getn(tail), 1 do
                Turn(tail[i], x_axis, math.rad(0), 3.2)
            end
            Sleep(500)
            waveDown()
        end
        Sleep(100)
        turnThemDown()
    end
end

function randomEyes()
    while true do
        decider = math.random(0, 1)
        if decider == 1 then
            i = math.random(1, table.getn(koerperteile))
            Show(koerperteile[i])
        else
            Hide(koerperteile[i])
        end
        Sleep(500)
    end
end

function prozent()
    percentage = 100
    while true do

        Sleep(1000)
        if percentage > 1 then
            percentage = percentage - 1
        else
            Spring.DestroyUnit(unitID, false, false)
        end
    end
end

function script.Create()
    bodybuild()
    StartThread(shakeThatTailFeather)
    StartThread(smokeEmit)
    StartThread(prozent)
    StartThread(delayedSelfDestruction)

    Hide(koerperteile[28])
    Hide(koerperteile[29])
    Hide(koerperteile[39])
    Hide(koerperteile[40])
    --Spring.SetUnitNoDraw(unitID,true)
end

function randCenter()
    xr = math.random(-8, 8)
    Turn(center, x_axis, math.rad(xr), 12)
    yr = math.random(-8, 8)
    Turn(center, y_axis, math.rad(yr), 12)
    zr = math.random(-8, 8)
    Turn(center, z_axis, math.rad(zr), 12)
end

function stepRight()
    Turn(shwNeck21, x_axis, math.rad(5), 7)
    Turn(shwNeck21, y_axis, math.rad(-3), 7)
    Turn(shwNeck22, x_axis, math.rad(-5), 7)
    Turn(shwNeck22, y_axis, math.rad(-2), 4)
    Turn(shwHead2, x_axis, math.rad(-6), 7)
    Turn(shwHead2, y_axis, math.rad(-1), 1)


    Turn(shwUpL24, x_axis, math.rad(39), 7)
    Turn(shwUpL24, y_axis, math.rad(0), 7)
    Turn(shwUpL24, z_axis, math.rad(0), 7)

    Turn(shwLL24, x_axis, math.rad(10), 7)
    Turn(shwLL24, y_axis, math.rad(14), 7)
    Turn(shwLL24, z_axis, math.rad(0), 7)
    --
    Turn(shwUpL21, x_axis, math.rad(-7), 7)

    Turn(shwLL21, x_axis, math.rad(19), 7)



    Turn(shwUpL22, x_axis, math.rad(-23), 7)


    Turn(shwLL22, x_axis, math.rad(14), 7)



    Turn(shwUpL23, x_axis, math.rad(-43), 7)


    Turn(shwLL23, x_axis, math.rad(18), 7)


    --


    Turn(sh1upleg1, x_axis, math.rad(28), 7)


    Turn(sh1upleg2, x_axis, math.rad(-40), 7)


    Turn(sh1upleg3, x_axis, math.rad(-18), 7)


    Turn(sh1upleg4, x_axis, math.rad(-13), 7)


    Turn(sh1leg1, x_axis, math.rad(-14), 7)


    Turn(sh1leg2, x_axis, math.rad(-55), 7)

    Turn(sh1leg3, x_axis, math.rad(-85), 7)

    Turn(sh1leg4, x_axis, math.rad(-110), 7)


    --
    Turn(sh1lowleg1, x_axis, math.rad(48), 7)


    Turn(sh1lowleg2, x_axis, math.rad(82), 7)


    Turn(sh1lowleg3, x_axis, math.rad(98), 7)


    Turn(sh1lowleg4, x_axis, math.rad(97), 19)
end

function stepLeft()
    Turn(shwNeck21, x_axis, math.rad(13), 7)
    Turn(shwNeck21, y_axis, math.rad(3), 7)

    Turn(shwNeck22, x_axis, math.rad(-14), 7)
    Turn(shwNeck22, y_axis, math.rad(2), 4)

    Turn(shwHead2, x_axis, math.rad(-16), 7)
    Turn(shwHead2, y_axis, math.rad(1), 7)

    Turn(shwUpL24, x_axis, math.rad(-46), 7)

    Turn(shwLL24, x_axis, math.rad(68), 7)

    --
    Turn(shwUpL21, x_axis, math.rad(-7), 7)


    Turn(shwLL21, x_axis, math.rad(-31), 7)


    Turn(shwUpL22, x_axis, math.rad(49), 7)

    Turn(shwLL22, x_axis, math.rad(-29), 7)


    Turn(shwUpL23, x_axis, math.rad(0), 7)


    Turn(shwLL23, x_axis, math.rad(75), 7)


    Turn(sh1upleg1, x_axis, math.rad(-21), 8)

    Turn(sh1upleg2, x_axis, math.rad(0), 7)

    Turn(sh1upleg3, x_axis, math.rad(0), 7)


    Turn(sh1upleg4, x_axis, math.rad(55), 7)


    Turn(sh1leg1, x_axis, math.rad(-121), 7)

    Turn(sh1leg2, x_axis, math.rad(0), 8)


    Turn(sh1leg3, x_axis, math.rad(0), 8)


    Turn(sh1leg4, x_axis, math.rad(-55), 8)


    Turn(sh1lowleg1, x_axis, math.rad(130), 8)


    Turn(sh1lowleg2, x_axis, math.rad(0), 8)


    Turn(sh1lowleg3, x_axis, math.rad(0), 7)


    Turn(sh1lowleg4, x_axis, math.rad(-55), 9)
end

--- WALKING---
local function walk()
    StartThread(smokeEmit)
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)
    while (true) do
        randCenter()
        stepLeft()
        --left leg up, right leg down
        Sleep(175)
        reSetPiece(shwNeck21)
        reSetPiece(shwNeck22)
        Sleep(175)
        stepRight()
        randCenter()
        Sleep(350)
    end
end

boolSelfDestruct = false
function reSetPiece(piecename)
    Turn(piecename, x_axis, math.rad(0), 3.5)
    Turn(piecename, y_axis, math.rad(0), 3.5)
    Turn(piecename, z_axis, math.rad(0), 3.5)
end

pieceTable = getPieceTable(unitID)
local function legs_down()
    reSetPiece(center)
    resetT(pieceTable, 3)
end

function script.StartMoving()
    boolOnTheMove = true
    -- --Spring.Echo ("starting to walk!")
    StartThread(walk)
end

function script.StopMoving()
    boolOnTheMove = false
    -- --Spring.Echo ("stopped walking!")
    Signal(SIG_WALK)
    legs_down()
end

boolOnlyOnce = false
function script.HitByWeapon(x, z, weaponDefID, damage)

    dice = math.random(1, percentage)
    secondThrow = math.random(1, percentage)
    if dice == secondThrow then
        boolSelfDestruct = true
    end
    vx, vz = math.random(-5, 5), math.random(-5, 5)
    px, py, pz = Spring.GetUnitPosition(unitID)
    Spring.SetUnitPosition(unitID, px + vx, py, pz + vz)
    return damage
end

function delayedSelfDestruction()
    while true do


        Sleep(500)
        if boolSelfDestruct == true then
            T = getAllNearUnit(unitID, 75)
            process(T,
                function(id)
                    Spring.AddUnitDamage(id, 25)
                end)
            Spring.DestroyUnit(unitID, true, true)
        end
    end
end

--- -death animation: fall over & explode
function script.Killed(recentDamage, maxHealth)
    for i = 1, #pieceTable do
        Explode(pieceTable[i], SFX.FALL + SFX.SHATTER)
    end
end