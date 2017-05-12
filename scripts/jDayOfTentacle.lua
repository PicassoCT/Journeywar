--Day of the Tentacles
analTentacle = piece "analTentacle"

local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
stoRed = {}
storeMax = 5
currentlyStored = 1
for i = 1, 5, 1 do
    stoRed[i] = {}
    temp = "storePoint" .. i
    stoRed[i] = piece(temp)
end
boolTentacleBusy = false
function hawoDat(id)
    --bring in the tentacle
    while boolTentacleBusy == true do
        Sleep(50) --busywaiting
    end
    boolTentacleBusy = true
    --Tentacle Grab Animation()
    AttachUnit(id, analTentacle)
    LaPlace = math.random(0, 1)
    if LaPlace == 1 then
        --throwThatGuy High Up in the Air()
    else
        Spring.SetUnitNoSelect(id)
        --bring your food to safety()
    end
    retractTenctacle()
    DropUnit(id)
    if currentlyStored < storeMax then
        AttachUnit(id, stoRed[currentlyStored])
        currentlyStored = currentlyStored + 1
    end
    boolTentacleBusy = false
end


function moveInItterationsToward(tgx, tgy, tgz, id)
    cx, cy, cz = nil
    local spValidUnitID = Spring.ValidUnitID

    while (cx == nil and spValidUnitID(id) == true) do
        cx, cy, cz = Spring.GetUnitPosition(id)
        Sleep(10)
    end
    if spValidUnitID(id) == true then
        percentage = 0.01
        expo = 1
        while (cx ~= tgx and cy ~= tgy and cz ~= tgz) do
            cx = percentage * cx + (1 - percentage) * tgx
            cy = percentage * cy + (1 - percentage) * tgy
            cz = percentage * cz + (1 - percentage) * tgz
            Sleep(50)
            if percentage < 0.5 then
                percentage = percentage + 0.01
            else
                temp = percentage * 100
                temp = (temp * temp) / 2000
                percentage = (percentage + temp) % 1
            end
        end
    end
    if spValidUnitID(id) == true then
        StartThread(hawoDat, id)
    end
end


function script.TransportDrop(passengerID, x, y, z)
end

catchRange = 88
myPersonlVictimList = {}
function allreadyKilledIt(tableToCheck)
    for i = 1, table.getn(tableToCheck), 1 do
        if myPersonlVictimList[tableToCheck[i]] == true then tableToCheck[i] = nil else
            myPersonlVictimList[tableToCheck[i]] = true
        end
    end
    return tableToCheck
end

function gotoCatchThemAll()
    local spGetUnitsInSphere = Spring.GetUnitsInSphere
    local x, y, z = Spring.GetUnitPosition(unitid) -- getting the units position
    local spValidUnitID = Spring.ValidUnitID

    while (true) do
        nowWhatDoWeHaveHere = {}
        nowWhatDoWeHaveHere = spGetUnitsInSphere(x, y, z, catchRange)
        if nowWhatDoWeHaveHere ~= nil then
            table.remove(nowWhatDoWeHaveHere, unitid)
            if table.getn(nowWhatDoWeHaveHere) ~= 0 then
                nowWhatDoWeHaveHere = allreadyKilledIt(nowWhatDoWeHaveHere)
                for i = 1, table.getn(nowWhatDoWeHaveHere), 1 do
                    if nowWhatDoWeHaveHere[i] ~= nil and spValidUnitID(nowWhatDoWeHaveHere[i]) == true then
                        StartThread(moveInItterationsToward, x, y, z, nowWhatDoWeHaveHere[i])
                    end
                end
            end
        end
        Sleep(50)
    end
end


function script.TransportPickup(passengerID)
end

function script.create()
    Spring.SetUnitNoSelect(unitid) --unsynced callin
    StartThread(gotoCatchThemAll)
end