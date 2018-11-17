include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"


eggStage3 = piece "eggSt3"
eggStage1 = piece "eggSt1"
eggStage2 = piece "eggSt2"
finalEgg0 = piece "finallEggX"
finalEggE = piece "finallEggE"
eggswim = piece "eggswim"


--theEggssAlgo
WaterPoint = piece "PushUpPoint"
SpinPoint = piece "SpinPoint"

allTheOtherKidsWithThePumpedUpKicks = {}
for i = 1, 5, 1 do

    allTheOtherKidsWithThePumpedUpKicks[i] = {}
    temPiece = "exTendril" .. i
    allTheOtherKidsWithThePumpedUpKicks[i][1] = piece(temPiece)
    allTheOtherKidsWithThePumpedUpKicks[i][2] = true
end
MaxDistance = 7.6
teamID = Spring.GetUnitTeam(unitID)

function exTend(speed, prevSleep, duration, nr)
    allTheOtherKidsWithThePumpedUpKicks[nr][2] = false
    if speed == 0 then speed = (2 * MaxDistance) / duration end
    Sleep(prevSleep)
    xRand = math.random(0, 350)
    yRand = math.random(0, 350)
    zRand = math.random(0, 350)
    Turn(allTheOtherKidsWithThePumpedUpKicks[nr][1], x_axis, math.rad(xRand), 0)
    Turn(allTheOtherKidsWithThePumpedUpKicks[nr][1], x_axis, math.rad(xRand), 0)
    Turn(allTheOtherKidsWithThePumpedUpKicks[nr][1], x_axis, math.rad(xRand), 0)
    Show(allTheOtherKidsWithThePumpedUpKicks[nr][1])
    Move(allTheOtherKidsWithThePumpedUpKicks[nr][1], y_axis, MaxDistance, speed / 2)
    WaitForMove(allTheOtherKidsWithThePumpedUpKicks[nr][1], y_axis)
    Move(allTheOtherKidsWithThePumpedUpKicks[nr][1], y_axis, 0, speed / 2)
    WaitForMove(allTheOtherKidsWithThePumpedUpKicks[nr][1], y_axis)
    Hide(allTheOtherKidsWithThePumpedUpKicks[nr][1])

    allTheOtherKidsWithThePumpedUpKicks[nr][2] = true
end


function getToWaterLevelPlusBouncing()
    local spGetUnitPosition = Spring.GetUnitPosition
    local spGetGroundHeight = Spring.GetGroundHeight

    x, ty, z = spGetUnitPosition(unitID)
    signed = 1
    y = spGetGroundHeight(x, z)
    while (y < 0) do
        x, _, z = spGetUnitPosition(unitID)
        signed = signed * -1
        y = spGetGroundHeight(x, z)
        rand = math.random(-1, 1)
        rand = rand * signed
        Move(WaterPoint, y_axis, y * -1 + rand - 2, 9.81)
        Sleep(15)
        WaitForMove(WaterPoint, y_axis)
    end
    Move(WaterPoint, y_axis, 0, 19.81)
    WaitForMove(WaterPoint, y_axis)
end

boolPulsate = true
function pulsate()
    while (boolPulsate == true) do
        Move(finalEgg0, y_axis, -2.5, 6.24)
        Move(finalEggE, y_axis, 2.5, 6.24)
        WaitForMove(finalEgg0, y_axis)
        WaitForMove(finalEggE, y_axis)
        Move(finalEgg0, y_axis, 0, 6.24)
        Move(finalEggE, y_axis, 0, 6.24)
        WaitForMove(finalEgg0, y_axis)
        WaitForMove(finalEggE, y_axis)
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
    for i = 1, table.getn(allTheOtherKidsWithThePumpedUpKicks), 1 do
        Hide(allTheOtherKidsWithThePumpedUpKicks[i][1])
    end
    Hide(eggStage3)
    Hide(eggStage1)
    Hide(eggStage2)
    Hide(finalEgg0)
    Hide(finalEggE)
    Hide(eggswim)

    --spawn & HideThemAll
    Show(eggStage1)
    Spin(SpinPoint, y_axis, math.rad(14), 0.2)
    x = math.random(-22, 22)
    Spin(SpinPoint, x_axis, math.rad(x), 0.2)
    z = math.random(-22, 22)
    Spin(SpinPoint, z_axis, math.rad(z), 0.2)
    --ShowFirstEgg
    napple = math.ceil(totalGrowthTime / 3)
    Sleep(napple)
    Hide(eggStage1)
    Show(eggStage2)
    Show(finalEgg0)
    Show(finalEggE)
    StartThread(pulsate)
    --ShowSecondEgg(Pulsating) + Spin

    napple = math.ceil(totalGrowthTime / 3)
    Sleep(napple)
    boolPulsate = false

    Spin(eggswim, y_axis, math.rad(12), 0.5)
    Sleep(200)
    Move(finalEgg0, y_axis, -2.5, 6.24)
    Move(finalEggE, y_axis, 2.5, 6.24)
    WaitForMove(finalEgg0, y_axis)
    WaitForMove(finalEggE, y_axis)
    Hide(eggStage2)
    Hide(finalEgg0)
    Hide(finalEggE)
    Show(eggStage3)
    Show(eggswim)
    --Show ThirdEgg (Pulsating) + Spin +InsideKicks into X/Z if skinfantry
    while (napple > 0) do
        start = math.random(1, 5)
        for nr = 1, 5, 1 do
            if allTheOtherKidsWithThePumpedUpKicks[nr][2] == true then
                speedRand = math.random(5, 10)
                StartThread(exTend, speedRand, 100, 0, start)
            end
        end
        Sleep(500)
        napple = napple - 500
    end

    --Release and Vannish
    x, y, z = Spring.GetUnitPosition(unitID)
    Explode(eggStage3, SFX.SHATTER + SFX.NO_HEATCLOUD)
    Spring.DestroyUnit(unitID, false, true)
    id = Spring.CreateUnit("jskinfantry", x, y, z, 0, teamID)

    transferOrders(unitID, id)
    for i = 1, 12, 1 do
        EmitSfx(SpinPoint, 1024) -- fruchtwasser everywhere..
        Sleep(90)
    end
end


function script.Create()
		for i=1, #allTheOtherKidsWithThePumpedUpKicks do
			if allTheOtherKidsWithThePumpedUpKicks[i][1] then
			Hide(allTheOtherKidsWithThePumpedUpKicks[i][1])
			end
		end
    StartThread(getToWaterLevelPlusBouncing)
    StartThread(growInStages)
end