rewardcylcles = 25
teamId = Spring.GetUnitTeam(unitID)
returnOfInvestmentM = 100
returnOfInvestmentE = 100

function decayReward()

    fib1 = 1
    fib2 = 1
    for i = 1, rewardcylcles, 1 do
        temp = fib1 + fib2
        fib1 = fib2
        fib = temp
        returnOfInvestmentM = returnOfInvestmentM - temp
        returnOfInvestmentE = returnOfInvestmentE - temp
        Sleep(2000)
        Spring.AddTeamResource(teamId, "metal", returnOfInvestmentM)
        Spring.AddTeamResource(teamId, "energy", returnOfInvestmentE)
        Sleep(1000)
        Spring.AddTeamResource(teamId, "metal", returnOfInvestmentM)
        Spring.AddTeamResource(teamId, "energy", returnOfInvestmentE)
        Sleep(1000)
        Spring.AddTeamResource(teamId, "metal", returnOfInvestmentM)
        Spring.AddTeamResource(teamId, "energy", returnOfInvestmentE)
        Sleep(1000)
    end

    Spring.DestroyUnit(unitID, false, false)
end


function script.Create()
    Spring.SetUnitBlocking(unitID, false)
    Spring.SetUnitNoDraw(unitID, true)
    --Spring.SetUnitNeutral(unitID)
    Spring.SetUnitNoSelect(unitID, true)
    StartThread(decayReward)
end

function script.Killed()
    return 1
end




