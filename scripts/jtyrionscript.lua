boolShowTrueColours = false

function checkYourself()
    while GG.Traitors == nil or GG.Traitors[unitID] == nil do
        Sleep(600)
    end

    local tID = GG.Traitors[unitID]
    local spUnitIsNotDead = Spring.Spring.GetUnitIsDead
    local spGetUnitPosition = Spring.GetUnitPosition
    local spMoveCtrlSetPhysics = Spring.MoveCtrl.SetPhysics

    Spring.MoveCtrl.Enable(unitID, true)
    teamID = Spring.GetUnitTeam(tID)
    while spUnitIsNotDead(tID) and boolShowTrueColours == false do
        x, y, z = spGetUnitPosition(tID)
        spMoveCtrlSetPhysics(tID, x, y + 80, z, 0, 0, 0, 0, 0, 0)

        Sleep(100)
    end

    if boolShowTrueColours == true and spUnitIsNotDead(tID) == true then
		spawnCEGatUnit(unitID, "jtyrion", 0, 25, 0)
        Spring.TransferUnit(tID, teamID, false)
    end

    Spring.DestroyUnit(unitID, true, true)
end




function script.Create()
    Spring.SetUnitNeutral(unitID, true)
    Spring.SetUnitNoSelect(unitID, false)
    Spring.SetUnitNoDraw(unitID, true)
    Spring.SetUnitNoMinimap(unitID, true)
    Spring.SetUnitBlocking(unitID, false, false, false)
    StartThread(checkYourself)
end

function script.Activate()
    boolShowTrueColours = true
    return 1
end



function script.Killed()
end