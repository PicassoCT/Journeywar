local footleft = piece "footleft"
local footright = piece "footright"
local middleman01 = piece "middleman01"
local middleman02 = piece "middleman02"
center = piece "center"
local dustemit1 = piece "dustemit1"
local dustemit2 = piece "dustemit2"
local dustemit3 = piece "dustemit3"
local dustemit4 = piece "dustemit4"

tale1 = piece "tale1"
tale2 = piece "tale2"
tale3 = piece "tale3"
tale4 = piece "tale4"
talesOfInterest = {}
table.insert(talesOfInterest, tale1)
table.insert(talesOfInterest, tale2)
table.insert(talesOfInterest, tale3)
table.insert(talesOfInterest, tale4)

SIG_WIGGLE = 1
SIG_BLINK = 2
SIG_MOVE = 4
SIG_LEGS = 8
SIG_IDLE = 16
SIG_BLINK = 32
shells = {}
for i = 1, 80, 1 do
    shells[i] = {}
    tempString = "Shell" .. i
    shells[i] = piece(tempString)
end

blinkers = {}
for i = 1, 84, 1 do
    blinkers[i] = {}
    tempString = "blink" .. i
    blinkers[i] = piece(tempString)
end

function randTimeDelayedDustEmit(piecenr)
    x = math.random(300, 1800)
    Sleep(x)

    if dice() == true then
        EmitSfx(piecenr, 1024)
    else
        EmitSfx(piecenr, 1027)
        Sleep(350)
    end
    xi = math.random(0, 3)
    if xi == 2 and dice() == true then
        Sleep(350)
        EmitSfx(piecenr, 1025)
    end
end

function moveIt()
    SetSignalMask(SIG_MOVE)
    while (true) do
        Speed = math.random(-1, 1)
        Turn(center, y_axis, math.rad(-11), 0.7)
        Turn(footleft, y_axis, math.rad(75), 5 + Speed)
        Speed = math.random(-1, 1)
        Turn(footright, y_axis, math.rad(5), 5 + Speed)
        Turn(footright, x_axis, math.rad(-17), 6)
        WaitForTurn(footleft, y_axis)
        WaitForTurn(footright, y_axis)
        Turn(footright, x_axis, math.rad(0), 12)
        Sleep(180)
        Speed = math.random(-1, 1)
        Turn(center, y_axis, math.rad(11), 0.7)
        Turn(footright, y_axis, math.rad(-75), 5 + Speed)
        Speed = math.random(-1, 1)
        Turn(footleft, y_axis, math.rad(0), 5 + Speed)
        Speed = math.random(-1, 1)
        Turn(footleft, x_axis, math.rad(-17), 5 + Speed)
        WaitForTurn(footleft, y_axis)
        WaitForTurn(footright, y_axis)
        Turn(footleft, x_axis, math.rad(0), 12)
        Sleep(180)
    end
end

function hideThemAll()

    for i = 1, table.getn(shells), 1 do
        Hide(shells[i])
        Sleep(50)
    end


    for i = 1, table.getn(blinkers), 1 do
        Sleep(50)
        Hide(blinkers[i])
    end
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
                EmitSfx(shells[irgendwo], 1026)
                EmitSfx(shells[irgendwo], 1026)
                Sleep(67)
            end
        end
        oldHP = currentHP
        Sleep(150)
    end
end


function hideThis(nr, boolIsBlink)
    timedelayed = math.random(2, 1000)
    Sleep(timedelayed)
    if boolIsBlink == true then
        Hide(blinkers[nr])
    else
        Hide(shells[nr])
    end
end

function showThis(nr, boolIsBlink)
    timedelayed = math.random(2, 1000)
    Sleep(timedelayed)
    if boolIsBlink == true then
        Show(blinkers[nr])
    else
        Show(shells[nr])
    end
end

function dice()
    i = math.random(0, 1)
    if i == 1 then
        return true
    else
        return false
    end
end


function blinky()
    SetSignalMask(SIG_BLINK)
    while (true) do
        for i = 1, table.getn(blinkers), 1 do

            if dice() == true then
                if dice() == true then
                    Hide(blinkers[i])
                    --StartThread(showThis,temp,true)
                end
            else
                Hide(blinkers[i])
                --	StartThread(hideThis,temp,true)
            end
        end

        for i = 1, table.getn(shells), 1 do
            Show(shells[i])
            if dice() == true then
                Show(shells[i])
            else
                Hide(shells[i])
            end
        end
        ron = math.random(250, 1050)
        Sleep(ron)
    end
end


function script.Create()
    --StartThread(blinky)
    Hide(tale1)
    Hide(tale2)
    Hide(tale3)
    Hide(tale4)
    StartThread(damageWatcher)
end

function dustEmits()
    if dice() == true then
        StartThread(randTimeDelayedDustEmit, dustemit1)
    end
    if dice() == true then
        StartThread(randTimeDelayedDustEmit, dustemit2)
    end
    if dice() == true then
        StartThread(randTimeDelayedDustEmit, dustemit3)
    end
    if dice() == true then
        StartThread(randTimeDelayedDustEmit, dustemit4)
    end
end

function forTheBlinkOfAnEye()
    SetSignalMask(SIG_BLINK)
    Sleep(250)
    delendaCartago = math.random(0, 1)
    if delendaCartago == 0 then
        for i = 1, 2, 1 do
            x = 0
            if i == 1 then
                x = math.random(1, 2)
            else x = math.random(3, 4)
            end

            Show(talesOfInterest[x])
        end

    else
        x = math.random(1, 4)
        Show(talesOfInterest[x])
    end
    blink = math.random(15, 25)
    Sleep(blink)
    for i = 1, table.getn(talesOfInterest), 1 do
        Hide(talesOfInterest[i])
    end
end

function wiggleTail()
    SetSignalMask(SIG_WIGGLE)

    while (true) do
        turner = math.random(15, 19)
        Turn(middleman01, y_axis, math.rad(turner), 0.5)
        xi = 1
        if dice() == true then xi = -1 end
        Turn(dustemit3, y_axis, math.rad((turner * 2 * xi)), 1.5)
        Turn(dustemit1, y_axis, math.rad((turner * 2 * xi * -1)), 1.5)
        Turn(middleman02, y_axis, math.rad((turner % 5) * xi), 0.5)
        dustEmits()

        WaitForTurn(middleman01, y_axis)
        Turn(middleman01, y_axis, math.rad(turner * -1), 0.5)
        Turn(dustemit3, y_axis, math.rad((turner * 2 * xi * -1)), 1.5)
        Turn(dustemit1, y_axis, math.rad((turner * 2 * xi)), 1.5)
        Turn(middleman02, y_axis, math.rad((turner % 5) * xi * -1), 0.5)
        dustEmits()
        WaitForTurn(middleman01, y_axis)
        Sleep(280)
    end
end



function script.StartMoving()
    Signal(SIG_BLINK)
    StartThread(forTheBlinkOfAnEye)
    Move(center, y_axis, 0, 12)
    Signal(SIG_IDLE)
    Signal(SIG_MOVE)
    Signal(SIG_WIGGLE)
    Signal(SIG_BLINK)
    StartThread(blinky)
    StartThread(moveIt)

    StartThread(wiggleTail)
end

function idleFromScratch()
    SetSignalMask(SIG_IDLE)
    ti = math.random(0, 2)
    if ti == 1 then
        scratchrand = math.random(2, 5)
        for i = 1, scratchrand, 1 do
            Turn(footright, x_axis, math.rad(132), 5)
            Turn(footright, y_axis, math.rad(0), 5)
            Turn(footright, z_axis, math.rad(28), 5)
            Sleep(1200)
            Turn(footright, x_axis, math.rad(109), 5)
            Turn(footright, y_axis, math.rad(0), 5)
            Turn(footright, z_axis, math.rad(26), 5)
            Sleep(1200)
        end
        Turn(footright, x_axis, math.rad(0), 5)
        Turn(footright, y_axis, math.rad(0), 5)
        Turn(footright, z_axis, math.rad(0), 5)
    elseif ti == 2 then
        Move(center, y_axis, 45, 12)
        Turn(middleman01, x_axis, math.rad(17), 0.3)
        Turn(middleman02, x_axis, math.rad(-17), 0.3)
        WaitForTurn(middleman01, x_axis)
        WaitForTurn(middleman02, x_axis)
        for i = 1, 6, 1 do
            Turn(footleft, x_axis, math.rad(53), 4)
            Turn(footright, x_axis, math.rad(84), 5)
            Sleep(1200)
            Turn(footleft, x_axis, math.rad(84), 4)
            Turn(footright, x_axis, math.rad(53), 5)
            Sleep(1200)
        end
        Sleep(4200)
        Move(center, y_axis, 0, 12)
        Turn(middleman01, x_axis, math.rad(0), 0.3)
        Turn(middleman02, x_axis, math.rad(0), 0.3)
        WaitForTurn(middleman01, x_axis)
        WaitForTurn(middleman02, x_axis)
        Turn(footleft, x_axis, math.rad(0), 4)
        Turn(footright, x_axis, math.rad(0), 5)

    else
        for i = 1, 6, 1 do
            Turn(middleman01, x_axis, math.rad(7), 0.3)
            Turn(middleman02, x_axis, math.rad(-7), 0.3)
            WaitForTurn(middleman01, x_axis)
            WaitForTurn(middleman02, x_axis)
            Turn(middleman01, x_axis, math.rad(-7), 0.3)
            Turn(middleman02, x_axis, math.rad(7), 0.3)
            WaitForTurn(middleman01, x_axis)
            WaitForTurn(middleman02, x_axis)
        end
    end
    naptime = math.random(9000, 19999)
    Sleep(naptime)
    if dice() == true then
        StartThread(idleFromScratch)
    end
end

function timedelayedLegsdown()
    SetSignalMask(SIG_LEGS)
    Sleep(500)
    Signal(SIG_BLINK)
    Signal(SIG_MOVE)
    Signal(SIG_WIGGLE)

    Signal(SIG_IDLE)
    Sleep(500)

    Turn(footleft, x_axis, math.rad(0), 2)
    Turn(footright, x_axis, math.rad(0), 2)
    Turn(footleft, y_axis, math.rad(0), 2)
    Turn(footright, y_axis, math.rad(0), 2)
    hideThemAll()
    if dice() == true then
        StartThread(idleFromScratch)
    end
end

function script.StopMoving()
    Signal(SIG_BLINK)
    StartThread(forTheBlinkOfAnEye)
    Signal(SIG_LEGS)
    StartThread(timedelayedLegsdown)
end




function script.Killed(recentDamage, maxHealth)

    return 1
end