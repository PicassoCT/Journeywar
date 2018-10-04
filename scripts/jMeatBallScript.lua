include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"


center = piece "center"


function script.Create()
	 Spring.SetUnitNeutral(unitID, true)
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
    Meat = TablesOfPiecesGroups["Meat"]
    for i = 1, #Meat do
        moveUnitPieceToGroundPos(unitID, Meat[i], math.random(-40, 40), math.random(-40, 40), 6, math.random(0, 10))
    end
    turnTableRand(Meat, y_axis, 360, -360, 0, false)
    turnTableRand(Meat, x_axis, 360, -360, 0, false)

    StartThread(TimeOfMyLife)
    StartThread(contemplateOrigin)
end

SIG_DEATH = 2

function contemplateOrigin()
    boolPositionUnchanged = true
    xo, yo, zo = Spring.GetUnitPosition(unitID)
    while (boolPositionUnchanged == true) do
        x, y, z = Spring.GetUnitPosition(unitID)
        if x ~= xo and z ~= zo then
            boolPositionUnchanged = false
            Signal(SIG_DEATH)
            Sleep(100)
            Move(center, y_axis, 0, 0)
        end
        Sleep(2000)
    end
end

function TimeOfMyLife()
    SetSignalMask(SIG_DEATH)
    Sleep(240000)
    Move(center, y_axis, -30, 3)
    WaitForMove(center, y_axis)
    Spring.DestroyUnit(unitID, false, false)
end



function script.Killed(recentDamage, _)

    return 1
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
