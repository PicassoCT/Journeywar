include "lib_UnitScript.lua"

--theEggssAlgo
WaterPoint = piece "PushUpPoint"
SpinPoint = piece "SpinPoint"
eggstage1 = piece "eggstage1"
eggstage2 = piece "eggstage2"
eggstage3a = piece "eggstage3a"
eggstage3b = piece "eggstage3b"
lilTig = piece "lilTig"
pulsUp = piece "pulsUp"
pulsUp2 = piece "pulsUp2"
SIG_PULSE = 1

MaxDistance = 25
teamID = Spring.GetUnitTeam(unitID)
local spgetUnitPosition = Spring.GetUnitPosition
local spGetGroundHeight = Spring.GetGroundHeight


function getToWaterLevelPlusBouncing()


    x, ty, z = spgetUnitPosition(unitID)
    signed = 1
    y = spGetGroundHeight(x, z)
    while (y < 0) do
        float = 0
        notNiceDice = math.random(1, 4)
        if notNiceDice == 2 then float = math.random(2, 19) end
        x, _, z = spgetUnitPosition(unitID)
        signed = signed * -1
        y = spGetGroundHeight(x, z)
        rand = math.random(-1, 1)
        rand = rand * signed
        speed = 9.18
        if float ~= 0 then speed = 2.5 end
        Move(WaterPoint, y_axis, y * -1 + rand - 2 + float, speed)
        WaitForMove(WaterPoint, y_axis)
        Sleep(250)
    end
    Move(WaterPoint, y_axis, 0, 19.81)
    WaitForMove(WaterPoint, y_axis)
end

function pulsate()
    SetSignalMask(SIG_PULSE)
    while (true) do
        diceBeNice = math.random(0, 1)
        if diceBeNice == 1 then
            Move(pulsUp, y_axis, -2.5, 10.44)
            Move(pulsUp2, y_axis, 2.5, 10.44)
        else
            Move(pulsUp, y_axis, -2.5, 10.44)
            Move(pulsUp2, y_axis, 0, 10.44)
        end
        WaitForMove(pulsUp, y_axis)
        WaitForMove(pulsUp2, y_axis)
        Move(pulsUp, y_axis, 0, 10)
        Move(pulsUp2, y_axis, 0, 10)
        WaitForMove(pulsUp, y_axis)
        WaitForMove(pulsUp2, y_axis)
        Sleep(250)
    end
end

totalGrowthTime = 42000
ux, uy, uz = Spring.GetUnitPosition(unitID)
h = Spring.GetGroundHeight(ux, uz)
if h < 0 then
    totalGrowthTime = 25000
else
    totalGrowthTime = 42000
end

function growInStages()
    --Hide
    Hide(eggstage1)
    Hide(eggstage2)
    Hide(eggstage3a)
    Hide(eggstage3b)
    Hide(lilTig)
    Hide(pulsUp)
    Hide(pulsUp2)

    --spawn & HideThemAll
    Show(eggstage1)
    Spin(SpinPoint, y_axis, math.rad(14), 0.2)
    x = math.random(-22, 22)
    Spin(SpinPoint, x_axis, math.rad(x), 0.2)
    z = math.random(-22, 22)
    Spin(SpinPoint, z_axis, math.rad(z), 0.2)
    --ShowFirstEgg
    napple = math.ceil(totalGrowthTime / 3)
    Sleep(napple)

    Show(eggstage2)
    Hide(eggstage1)
    Show(pulsUp)
    Show(pulsUp2)
    StartThread(pulsate)

    --ShowSecondEgg(Pulsating) + Spin

    napple = math.ceil(totalGrowthTime / 3)
    Sleep(napple)
    Signal(SIG_PULSE)
    Move(pulsUp, y_axis, -4.5, 10.44)
    Move(pulsUp2, y_axis, 4.5, 10.44)
    WaitForMove(pulsUp, y_axis)
    WaitForMove(pulsUp2, y_axis)
    Hide(pulsUp)
    Hide(pulsUp2)
    Hide(eggstage2)
    Spin(lilTig, y_axis, math.rad(14), 0.2)
    x = math.random(-22, 22)
    Spin(lilTig, x_axis, math.rad(x), 0.2)
    z = math.random(-22, 22)
    Spin(lilTig, z_axis, math.rad(z), 0.2)

    Show(lilTig)


    --Show ThirdEgg (Pulsating) + Spin +InsideKicks into X/Z if skinfantry
    dice = math.random(0, 1)
    if dice == 0 then Show(eggstage3a) else Show(eggstage3b) end
    while (napple > 0) do




        Sleep(420)
        napple = napple - 420
    end

    --Release and Vannish
    x, y, z = Spring.GetUnitPosition(unitID)
    Spring.DestroyUnit(unitID, false, true)
    id = Spring.CreateUnit("jtiglil", x, y, z, 0, teamID)

    transferOrders(unitID, id)
    for i = 1, 12, 1 do
        EmitSfx(SpinPoint, 1024) -- fruchtwasser everywhere..
        Sleep(90)
    end
end

function script.Create()
    StartThread(getToWaterLevelPlusBouncing)
    StartThread(growInStages)
end