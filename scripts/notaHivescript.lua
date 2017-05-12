include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

TablesOfPiecesGroups = {}

-- hair[16] = hair16 Piecenumber: 18
spire = {}

for i = 1, 35, 1 do
    name = "spire0" .. i
    spire[i] = piece(name)
end

function script.HitByWeapon(x, z, weaponDefID, damage)
end

buidSpot = piece "buidSpot"
spotRotator = piece "spotRotator"
center = piece "center"

function script.Create()
    --generatepiecesTableAndArrayCode(unitID,true)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)

    for i = 1, #TablesOfPiecesGroups["rE"], 1 do

        Turn(TablesOfPiecesGroups["rE"][i], y_axis, math.rad(i * (360 / 16)), 0)
        Hide(TablesOfPiecesGroups["rC"][i])
    end

    offset = math.random(-5, 15)
    for i = 1, #TablesOfPiecesGroups["hair"], 1 do
        Turn(TablesOfPiecesGroups["hair"][i], y_axis, math.rad(i * 25) + offset, 0)
    end

    StartThread(placePillars)

    StartThread(test)
end

yOffset = 8
function placePillars()

    resetT(spire)
    randLim = math.ceil(math.random(6, 12))
    positions = {}
    prevDeg = 180
    for i = 1, randLim, 1 do
        degDice = prevDeg + math.random(10, 36)
        prevDeg = degDice
        Turn(spotRotator, y_axis, math.rad(degDice), 0, true)
        WaitForTurn(spotRotator, y_axis)
        x, y, z = Spring.GetUnitPiecePosition(unitID, buidSpot)
        positions[#positions + 1] = makeVector(x, y, z)
        positions[#positions].degs = degDice + 90
        positions[#positions].counter = 1
    end


    for i = 1, #spire, 1 do

        dice = math.random(1, #positions)
        breakOut = 0
        while positions[dice].counter > 6 and breakOut < 5 do
            dice = math.random(1, #positions)
            breakOut = breakOut + 1
        end
        MovePieceToPos(spire[i], positions[dice].x, positions[dice].y, positions[dice].z, 0)
        Turn(spire[i], y_axis, math.rad(positions[dice].degs * -1), 0)
        Sleep(1)
        positions[dice].y = positions[dice].y + yOffset
        positions[dice].counter = positions[dice].counter + 1
    end
end

Egg = piece "Egg"
PI2 = 3.14159 * 2
MPI2 = PI2 * -1
function putTheLotionInTheBasket()
    --preparations
    Hide(Egg)
    local QAss = TablesOfPiecesGroups["QAss"]
    resetT(QAss)
    hideT(TablesOfPiecesGroups["QAss"])
    Turn(QAss[1], x_axis, math.rad(-90), 0)
    Move(QAss[1], z_axis, 10, 0)
    Show(QAss[1])
    WMove(QAss[1], z_axis, 0, 0.5)
    WTurn(QAss[1], x_axis, math.rad(0), 0.15)
    WMove(QAss[1], y_axis, -2, 0.3)
    Show(Egg)
    showT(QAss)
    WMove(QAss[2], y_axis, -20, 0)
    for i = -16, 0, 2 do
        Move(QAss[1], y_axis, 0, 3.5)
        WMove(QAss[2], y_axis, i, 1.25)
        WMove(QAss[1], y_axis, -3, 3.5)
    end
    WMove(QAss[1], y_axis, 0, 3.5)
    WMove(Egg, y_axis, 2, 0.1)
    Sleep(5000)
    ranVal = math.random(MPI2, PI2)
    WTurn(QAss[2], y_axis, ranVal, 0.05)
    WTurn(QAss[2], x_axis, math.rad(20), 0.15)
    WTurn(QAss[3], x_axis, math.rad(20), 0.15)
    WTurn(QAss[4], x_axis, math.rad(30), 0.15)
    Sleep(5000)
    Hide(Egg)
    Turn(QAss[2], y_axis, 0, 0.05)
    Turn(QAss[2], x_axis, math.rad(0), 0.15)
    Turn(QAss[3], x_axis, math.rad(0), 0.15)
    WTurn(QAss[4], x_axis, math.rad(0), 0.15)
    WaitForTurns(QAss)
    for i = 0, -16, -2 do
        Move(QAss[1], y_axis, 0, 3.5)
        WMove(QAss[2], y_axis, i, 1.25)
        WMove(QAss[1], y_axis, -3, 3.5)
    end
    hideT(QAss)
    Show(QAss[1])
    WMove(QAss[1], y_axis, -2, 0.3)
    WTurn(QAss[1], x_axis, math.rad(0), 0.15)
    WMove(QAss[1], z_axis, 0, 0.5)
    Turn(QAss[1], x_axis, math.rad(-90), 0.3)
    Move(QAss[1], z_axis, 10, 1)
end

function test()
    percent = 1
    while true do
        putTheLotionInTheBasket()
        proGress(percent)
        percent = ((percent + 1)) % #TablesOfPiecesGroups["rE"]
    end
end


function proGress(percent)
    for i = 1, #TablesOfPiecesGroups["rE"], 1 do
    end

    for i = 1, #TablesOfPiecesGroups["rE"], 1 do
        if TablesOfPiecesGroups["rC"][i] then
            if i < percent then
                Show(TablesOfPiecesGroups["rC"][i])
                Hide(TablesOfPiecesGroups["rE"][i])
            else
                Show(TablesOfPiecesGroups["rE"][i])
                Hide(TablesOfPiecesGroups["rC"][i])
            end
        end
    end
end

function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
    return 1
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return center
end



function script.QueryWeapon1()
    return center
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return true
end


function script.FireWeapon1()

    return true
end



function script.StartMoving()
end

function script.StopMoving()
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

Spring.SetUnitNanoPieces(unitID, { center })