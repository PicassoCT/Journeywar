include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"


--unitPieces
local nanopiece = piece "nanopiece"
local center = piece "center"
local conBigFoot = piece "ConBigFoot"
local conbigfee1 = piece "conbigfee1"
local conbigfee0 = piece "conbigfee0"
local boolbuilding = false
SIG_BUILD = 2
local boolMoving = false


function moveStateCheck()
    while (true) do

        while (boolMoving == true) do
            Sleep(250)
            Show(conbigfee0)
            Hide(conbigfee1)
            Sleep(250)
            Show(conbigfee1)
            Hide(conbigfee0)
        end


        Sleep(150)
    end
end



function script.StartMoving()
    boolMoving = true
end

function script.StopMoving()

    boolMoving = false
end




function script.Create()
    Hide(conbigfee0)
    StartThread(moveStateCheck)
end

function script.Killed(recentdamage)
    createCorpseJUnitGeneric(recentdamage)
    return 1
end

function building()
    SetSignalMask(SIG_BUILD)
    while (boolbuilding == true) do
        Sleep(125)
        actualHealth = Spring.GetUnitHealth(unitID)
        if actualHealth == 1 then
            actualHealth = actualHealth - 1
            Spring.SetUnitNoSelect(unitID, true)
            --makes the Unit go home, to the place it was born- west Virginia
            Spring.SetUnitHealth(unitID, actualHealth)
        end
        actualHealth = actualHealth - 1
        Spring.SetUnitHealth(unitID, actualHealth)





        Sleep(125)
    end
end

function script.StopBuilding()
    boolbuilding = false
    Signal(SIG_BUILD)
    SetUnitValue(COB.INBUILDSTANCE, 0)
    Turn(center, y_axis, 0, 6)
    WaitForTurn(center, y_axis)
end

function script.StartBuilding(heading, pitch)
    Turn(center, y_axis, heading, 3)
    WaitForTurn(center, y_axis)
    boolbuilding = true
    Signal(SIG_BUILD)
    StartThread(building)

    SetUnitValue(COB.INBUILDSTANCE, 1)
end


Spring.SetUnitNanoPieces(unitID, { nanopiece })


--------BUILDING---------