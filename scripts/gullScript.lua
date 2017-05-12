local gull = piece "gull"
local pivot = piece "pivot"
local center = piece "center"
local heightAhead = piece "heightAhead"
local longRange = piece "longRange"
local boolStillRoomBelow = false
local SIG_SENSE = 1
local aheadHeight = 0
local currentDistance = 0
local currentHeight = 0


function thermicCycling()
    Spin(center, y_axis, math.rad(4.7), 0.5)
    if currentHeight < 50 then
        howHeightToClimb = math.random(40, 75)
        currentHeight = currentHeight + howHeightToClimb
        riseSpeed = math.random(0.2, 0.5)
        Move(gull, y_axis, currentHeight, riseSpeed)

        Turn(gull, x_axis, math.rad(5), 0.3)
        Turn(gull, z_axis, math.rad(8), 0.3)
        WaitForMove(gull, y_axis)
    end
    Sleep(18000)
    StopSpin(center, y_axis)
    Turn(center, y_axis, math.rad(0), 1.5)
    Turn(gull, x_axis, math.rad(0), 0.3)
    Turn(gull, z_axis, math.rad(0), 0.3)
end

function heightComperator()
    Signal(SIG_SENSE)
    SetSignalMask(SIG_SENSE)
    boolStillRoomBelow = true
    while (true) do
        --get height at heightAhead
        x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, heightAhead)
        aheadHeight = Spring.GetGroundHeight(x, z)
        x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, gull)
        gullHeight = Spring.GetGroundHeight(x, z)
        if gullHeight + currentHeight < aheadHeight + 10 then
            boolStillRoomBelow = false
        end
        --get currentHeight
        Sleep(2000)
    end
end

function longFlight()
    Turn(gull, y_axis, math.rad(0), 7)
    turnWhere = math.random(0, 360)
    Spin(center, y_axis, math.rad(4.7), 0.5)
    Turn(longRange, y_axis, math.rad(turnWhere), 4)
    WaitForTurn(longRange, y_axis)


    StartThread(heightComperator)
    Move(gull, y_axis, 0, 0.03)
    --lets get a distance to fly towards
    fleightDistance = math.random(100, 12000)


    Move(center, x_axis, fleightDistance, 0.4)
    while (boolStillRoomBelow == true and true == Spring.UnitScript.IsInMove(center, x_axis)) do
        Sleep(2000)
        currentHeight = currentHeight - 12
    end
    currentDistance = fleightDistance
    StopSpin(center, y_axis)
end

--statistics.. how many gulls per squarekilometer?
function gullScream()

    while (true) do
        over9000 = math.random(9001, 70000)
        random = math.random(0, 42)
        if random == 6 then
            Spring.PlaySoundFile("sounds/jBeherith/seagulls1.wav", 0.7)
        elseif random == 7 then
            Spring.PlaySoundFile("sounds/jBeherith/seagulls2.wav", 0.7)
        end

        Sleep(over9000)
    end
end


function gullIble()
    while (true) do
        --three methods of movement
        aCoinThrow = math.random(1, 3)
        --going down for the fish
        if aCoinThrow == 1 then
            thermicCycling() --lame i know.. fuck you
        elseif aCoinThrow == 2 then
            --long flight (slowly loosing height)
            longFlight()
        else
            --thermic cycling (to gain height)
            thermicCycling()
        end
        Sleep(50)
    end
end


function script.Create()
    StartThread(gullScream)
    Spring.SetUnitNoSelect(unitID, true)

    Hide(gull)
    Move(gull, x_axis, 50, 0)
    Show(gull)
    StartThread(gullIble)
end

function script.Killed(recentDamage, maxHealth)
    EmitSfx(gull, 1024)
    EmitSfx(gull, 1024)
    EmitSfx(gull, 1024)
    EmitSfx(gull, 1024)
    EmitSfx(gull, 1024)
    Spin(center, y_axis, math.rad(-42), 7)
    Move(center, y_axis, -50, 9.8)
    Sleep(800)
    return 1
end