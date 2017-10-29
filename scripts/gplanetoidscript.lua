include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}


center = piece "center"
orbit1 = piece "orbit1"
Planet = piece "Planet"
heightOverMap = 2400

function script.Create()
    Spring.SetUnitAlwaysVisible(unitID, true)
    Spring.SetUnitNeutral(unitID, true)

    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
    Spring.MoveCtrl.Enable(unitID, true)
    x, y, z = Spring.GetUnitPosition(unitID)
    Spring.MoveCtrl.SetPosition(unitID, x, heightOverMap, z)


    Moonvalue = math.random(3, 12) * randSign()

    process(TablesOfPiecesGroups["Moon"],
        function(id)

            Moonvalue = math.random(3, 12) * randSign()
            Spin(id, y_axis, math.rad(Moonvalue), 0)
        end)
    Spin(Planet, y_axis, math.rad(Moonvalue * -1), 0)
    orbitSpinY = math.random(-12, 12)
    Turn(orbit1, x_axis, math.rad(math.random(-12, 12)), 0)
    Turn(center, z_axis, math.rad(math.random(-72, 72)), 0)

    dirAction = randSign()

    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
    process(TablesOfPiecesGroups["ring"],
        function(id)
            Spin(id, y_axis, math.rad((math.random(10, 40) / 10) * dirAction), 0)
            Turn(id, x_axis, math.rad(math.random(-12, 12)), 0)
        end)


    Turn(TablesOfPiecesGroups["ring"][6], z_axis, math.rad(90), 0)
    StopSpin(TablesOfPiecesGroups["ring"][6], y_axis)
    --Spin(TablesOfPiecesGroups["ring"][6],y_axis,math.rad(-1*orbitSpinY))
    Spin(TablesOfPiecesGroups["ring"][6], x_axis, math.rad(math.random(2, 4) * randSign()), 0)
end

function script.Killed(recentDamage, _)

    return 1
end