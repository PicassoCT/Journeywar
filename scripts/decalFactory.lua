function waitForIt()
    Sleep(500)
    Spring.DestroyUnit(unitID, true, true)
end

function script.Create()
    StartThread(waitForIt)
end

function script.Killed()

    return 0
end




