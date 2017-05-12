include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}
_, heightOfAsteroidsOverMap = Spring.GetGroundExtremes()
degreeOfAsteroidBelt = 80

function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"


function script.Create()
    Spring.SetUnitAlwaysVisible(unitID, true)
    Spring.SetUnitNeutral(unitID, true)

    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
    Spring.MoveCtrl.Enable(unitID, true)
    x, y, z = Spring.GetUnitPosition(unitID)
    Spring.MoveCtrl.SetPosition(unitID, x, heightOfAsteroidsOverMap + math.random(600, 750), z)
    Turn(center, y_axis, math.rad(degreeOfAsteroidBelt), 0)
    StartThread(releaseAnimationThreads)
end

collidePositions = {}
boolFirst = true

function collider(pieceID)
    if boolFirst == true then StartThread(collideComparer); boolFirst = false end
    while true do
        Sleep(500)

        x, y, z = Spring.GetUnitPiecePosition(unitID, pieceID)
        collidePositions[pieceID] = { x = x, y = y, z = z, pieceID = pieceID }
    end
end

function collideComparer()
    while true do
        Sleep(500)
        for idA, cometA in pairs(collidePositions) do
            for idB, cometB in pairs(collidePositions) do

                if idA ~= idB and distance(cometA.x, cometA.y, cometA.z, cometB.x, cometB.y, cometB.z) < 150 then

                    rVal = math.random(15, 42)
                    Spin(idA, z_axis, math.rad(rVal), 0.1)
                    Spin(idB, z_axis, math.rad(rVal * -1), 0.1)
                    rVec = randVec()
                    Spring.Echo("CometCollission _y:" .. rVec.y * 100 .. " / CometCollission _x:" .. rVec.x * 30)
                    Move(cometA.pieceID, x_axis, cometA.x + rVec.x * 30, 12.5)
                    Move(cometA.pieceID, y_axis, cometA.y + rVec.y * 100, 12.5)
                    Move(cometB.pieceID, x_axis, cometB.x + rVec.x * -30, 12.5)
                    Move(cometB.pieceID, y_axis, cometB.y + rVec.y * -100, 12.5)
                    WaitForMove(cometA.pieceID, x_axis); WaitForMove(cometA.pieceID, y_axis)
                    WaitForMove(cometB.pieceID, x_axis); WaitForMove(cometB.pieceID, y_axis)

                    echo("Collission Completed")
                end
            end
        end
    end
end

function loopMovement(pieceID, offset, speed, delay, startOffset)

    --First move
    randStartValue = math.random(0, 100) / 100 * randSign()
    Move(pieceID, z_axis, (-1 * offset - startOffset) * randStartValue, 0)
    WaitForMove(pieceID, z_axis)

    while true do

        Move(pieceID, z_axis, offset + startOffset, speed)
        WaitForMove(pieceID, z_axis)
        Sleep(delay)
        Move(pieceID, z_axis, -1 * offset - startOffset, 0)

        Sleep(10)
    end
end

function releaseAnimationThreads()
    asteroid = TablesOfPiecesGroups["asteroid"]
    bolderorbit = TablesOfPiecesGroups["boldorbit"]
    bolder = TablesOfPiecesGroups["bolder"]
    orbit = TablesOfPiecesGroups["orbit"]
    process(asteroid,
        function(id)
            --asteroid shown or hidden
            if math.random(0, 1) == 1 then
                Show(id)
                StartThread(collider, id)
            else
                Hide(id)
            end

            --Position
            yOffset = math.random(0, 150)
            Move(id, y_axis, yOffset, 0)

            --Movement
            offset = 2800
            speed = math.random(7, 14)
            delay = math.random(100, 8000)
            startOffset = math.random(-600, 600)
            StartThread(loopMovement, id, offset, speed, delay, startOffset)

            --Spin
            Spin(id, y_axis, math.rad(math.random(5, 42) * randSign()), 0.1)
            if maRa() == true then
                Spin(id, z_axis, math.rad(math.random(-42, 42)), 0.1)
            else
                Spin(id, z_axis, math.rad(math.random(-4, 4)), 0.1)
            end
        end)

    process(bolderorbit,
        function(id)
            Move(id, x_axis, math.random(0, 50), 0)
            Spin(id, y_axis, math.rad(math.random(-42, 42)), 0)
        end)

    process(bolder,
        function(id)
            Spin(id, y_axis, math.rad(math.random(-42, 42)), 0)
        end)

    process(orbit,
        function(id)
            Move(id, x_axis, math.random(-200, 200), 0)
            Move(id, z_axis, math.random(-400, 400), 0)
        end)
    if math.random(0, 3) ~= 1 then
        Hide(asteroid[13])
        Hide(asteroid[15])
        hideT(bolder)
    end
end

function script.Killed(recentDamage, _)


    return 1
end