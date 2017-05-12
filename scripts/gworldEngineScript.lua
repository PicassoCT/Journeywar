include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}


Hood = piece "Hood"
Leg1 = piece "Leg1"
Leg2 = piece "Leg2"
Leg3 = piece "Leg3"
Pump2 = piece "Pump2"
Pump3 = piece "Pump3"
Pump1 = piece "Pump1"
center = piece "center"
body = piece "body"
DeathStick = piece "DeathStick"

function makePieceMap(unitID)
    List = Spring.GetUnitPieceMap(unitID)
    return List or {}
end

function OrbitalDrop()
    Turn(center, x_axis, math.rad(19), 0)
    vak = math.random(0, 360)
    Turn(center, y_axis, math.rad(vak), 0)

    Turn(Leg1, z_axis, math.rad(0), 0)
    Turn(Leg3, z_axis, math.rad(0), 0)
    Turn(Leg2, z_axis, math.rad(0), 0)
    Move(body, y_axis, 9000, 0, true)

    Sleep(10)
    Spin(body, y_axis, math.rad(-120), 0)
    Turn(center, x_axis, math.rad(0), 0.04)
    showT(TablesOfPiecesGroups)

    Move(body, y_axis, 900, 90 * 5)
    WaitForMove(body, y_axis)
    StopSpin(body, y_axis, math.rad(0.4))
    for i = 900, 100, -100 do
        speed = 10 * math.max(1, i / 100) * 5
        Move(body, y_axis, i, speed)
        WaitForMove(body, y_axis)
    end

    Turn(Leg1, z_axis, math.rad(-45), 3.5)
    Turn(Leg3, z_axis, math.rad(-45), 3.5)
    Turn(Leg2, z_axis, math.rad(-45), 3.5)
    Move(body, y_axis, -20, 50)
    WaitForMove(body, y_axis)
    Move(DeathStick, y_axis, -75, 70)
    for i = 1, 6, 1 do
        spawnCEGatUnit(unitID, "factory_explosion", math.random(-120, 120), math.random(-120, 120), math.random(-120, 120))
    end
    HumpingTheGround()
end

function laserBeam()
    x, y, z = Spring.GetUnitPiecePosition(unitID, DeathStick)
    while true do
        Spring.SpawnCEG("railgunceg", x, y, z, 0, -1, 0, 50, 0)
        Sleep(150)
    end
end

function HumpingTheGround()
    WaitForMove(DeathStick, y_axis)
    StartThread(laserBeam)
    while true do

        Sleep(500)
        Move(Pump1, y_axis, 15, 5)
        Move(Pump2, y_axis, 0, 5)
        Move(Pump3, y_axis, 15, 5)
        Move(DeathStick, y_axis, 0, 35)
        Move(body, y_axis, -20, 12)
        Turn(Leg1, z_axis, math.rad(-45), 0.25)
        Turn(Leg3, z_axis, math.rad(-45), 0.25)
        Turn(Leg2, z_axis, math.rad(-45), 0.25)

        WaitForMove(DeathStick, y_axis)
        Sleep(500)
        Move(Pump1, y_axis, 0, 5)
        Move(Pump2, y_axis, 15, 5)
        Move(Pump3, y_axis, 0, 5)
        Sleep(500)
        Move(DeathStick, y_axis, -75, 70)
        Move(body, y_axis, -25, 12)
        Turn(Leg1, z_axis, math.rad(-47.5), 0.25)
        Turn(Leg3, z_axis, math.rad(-47.5), 0.25)
        Turn(Leg2, z_axis, math.rad(-47.5), 0.25)
        WaitForMove(DeathStick, y_axis)
    end
end

function spawnCEGatUnit(unitID, cegname, xoffset, yoffset, zoffset)
    x, y, z = Spring.GetUnitPosition(unitID)
    if xoffset then
        Spring.SpawnCEG(cegname, x + xoffset, y + yoffset, z + zoffset, 0, 1, 0, 50, 0)
    else
        Spring.SpawnCEG(cegname, x, y, z, 0, 1, 0, 50, 0)
    end
end

function script.Create()
    TablesOfPiecesGroups = makePieceMap(unitID)
    hideT(TablesOfPiecesGroups)
    resetT(TablesOfPiecesGroups, 0)
    Turn(Leg3, y_axis, math.rad(120), 0)
    Turn(Leg2, y_axis, math.rad(240), 0)

    StartThread(dropTester)
end

function dropTester()

    while true do
        OrbitalDrop()

        Sleep(5000)
    end
end

function script.Killed(recentDamage, _)

    return 1
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

