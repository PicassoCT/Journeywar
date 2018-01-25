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
SIG_STOP= 4
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

function hunkerDown()
Signal(SIG_STOP)
SetSignalMask(SIG_STOP)
	setSpeedEnv(unitID,0.0)
	Move(center,y_axis,-7,12)
	Sleep(3000)
	Move(center,y_axis,0,12)
	setSpeedEnv(unitID,1.0)
	--set Last Command Active again
	
end

function script.HitByWeapon(x, z, weaponDefID, damage)
	StartThread(hunkerDown)
	return damage
end


function script.Create()
    Hide(conbigfee0)
    StartThread(moveStateCheck)
    StartThread(sexualHealing)
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


myTeamID = Spring.GetUnitTeam(unitID)
function sexualHealing()
    while select(5,Spring.GetUnitHealth(unitID)) < 1 do Sleep(100) end

    teamid = Spring.GetUnitTeam(unitID)
    conTypeTable = getConstructionUnitTypeTable()
    local ud = UnitDefs

    while true do
   
            while boolHealingActive == true do
                boolHealedOne = false
                x, y, z = Spring.GetUnitPosition(unitID)
                hp = Spring.GetUnitHealth(unitID)
                if hp then

                    T = getAllInCircle(x, z, 300, unitID, teamID)
                    T = process(T,
                        function(id)
                            if Spring.GetUnitTeam(id) == myTeamID then
                                return id
                            end
                        end)

                    hp = math.ceil(math.ceil(hp * 0.5) / #T)
                    hpcopy = hp
                    if #T > 0 then
                        for i = 1, #T do
                            if T[i] then
                                defID = Spring.GetUnitDefID(T[i])
                                if defID and ud[defID].isBuilding == false and not conTypeTable[defID] then
                                    p, maxhp, _, bP = Spring.GetUnitHealth(T[i])

                                    if bP and bP >= 1.0 and p and p < maxhp and maxhp > 400 then

                                        Spring.SetUnitHealth(T[i], p + hp)
                                        sx, sy, sz = Spring.GetUnitPosition(T[i])
                                        Spring.SpawnCEG("jhealjourney", sx, sy + 25, sz, 0, 1, 0, 0)
                                        if hpcopy - hp < 0 then
                                            Spring.DestroyUnit(unitID, false, true)
                                        else
                                            Spring.AddUnitDamage(unitID, hp)
                                            hpcopy = hpcopy - hp
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                Sleep(750)
        end
        Sleep(100)
    end
end
    boolHealingActive = false
function script.Activate()
    boolHealingActive = true
    return 1
end

function script.Deactivate()
    boolHealingActive = false
    return 0
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