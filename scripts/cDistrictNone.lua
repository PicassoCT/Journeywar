include "createCorpse.lua"
include "lib_jw.lua"
--<pieces>


nrOfhouses = 35
housecoords = {}
house = {}
for i = 1, nrOfhouses, 1 do
    house[i] = {}
    portalSX = "house" .. i
    house[i] = piece(portalSX)
    emitX, _, emitZ, _, _, _ = Spring.GetUnitPiecePosDir(unitID, house[i])




    housecoords[i] = {}
    housecoords[i][1] = emitX
    housecoords[i][2] = emitZ
end

repcoords = {}
replicPoints = {}
for i = 1, 8, 1 do
    replicPoints[i] = {}
    portalSX = "replicPoint" .. i
    replicPoints[i] = piece(portalSX)
    emitX, _, emitZ, _, _, _ = Spring.GetUnitPiecePosDir(unitID, replicPoints[i])

    repcoords[i] = {}
    repcoords[i][1] = emitX
    repcoords[i][2] = emitZ
end


rotor = piece "rotor"
slumbody = piece "buibaislum"
bridgeOverTroubledHood = piece "bridgeout"
bridgeTurnerKid = piece "turnerkid"
bridgeExp1 = piece "bridgeexp"
bridgeExp2 = piece "bridgeexpa"
bridgeTop = piece "lowuptow"
bridegPentHouse = piece "penthouse"

houseHeap1 = piece "rapidGrowt"
houseHeap2 = piece "rapidGrow0"
--</pieces>
--<localVars>
unifiedBuildSpeed = 4
maxHealth = Spring.GetUnitHealth(unitID)
teamID = Spring.GetUnitTeam(unitID)
x, y, z = Spring.GetUnitPosition(unitID)
metallStored = 0
metallCost = 1800
energyStored = 0
energyCost = 1800
boolCharged = false
boolAnimationDone = false
SIG_DAMAGE = 1
--</localVars>

--initliazer
function setUp()

    Hide(bridgeOverTroubledHood)

    Hide(bridgeExp1)
    Hide(bridgeExp2)
    Hide(bridgeTop)
    Hide(bridegPentHouse)
    Turn(bridgeOverTroubledHood, z_axis, math.rad(200), 0)

    Hide(houseHeap1)
    Move(houseHeap1, y_axis, -42, 0)
    Hide(houseHeap2)
    Move(houseHeap2, y_axis, -42, 0)
    Spin(rotor, x_axis, math.rad(25), 7)
    Turn(rotor, y_axis, math.rad(-45), 0)
    for i = 1, nrOfhouses, 1 do
        Move(house[i], y_axis, -5, 0)
        Hide(house[i])
    end
    Move(slumbody, y_axis, -25, 0)
end

upBuildTemp = 0
function buildItUp()
    Hide(rotor)
    Move(slumbody, y_axis, 0, 1.4)
    WaitForMove(slumbody, y_axis)
    Show(rotor)
    for i = 1, nrOfhouses, 1 do
        Show(house[i])
        Move(house[i], y_axis, 0, unifiedBuildSpeed)
        WaitForMove(house[i], y_axis)
        Sleep(1000)
    end
end

myTeamID = Spring.GetUnitTeam(unitID)
function getLowestDamageTeam()
    lowestValue = math.huge
    lowestTeam = myTeamID
    for team, accuDamage in pairs(accumulatedDamageByTeam) do
        if accuDamage < lowestValue then lowestTeam = team; lowestValue = accuDamage end
    end
    return lowestTeam
end


gaiaTeam = Spring.GetGaiaTeamID()
accumulatedDamageByTeam = { [myTeamID] = 0, [gaiaTeam] = 0 }

healthAtLastAttack = Spring.GetUnitHealth(unitID)
totalDamage = 0

x, y, z = Spring.GetUnitPosition(unitID)
priceOfAEnemy = 250
function script.HitByWeapon(x, z, weaponDefID, damage)
    lastAttackerID = Spring.GetUnitLastAttacker(unitID)
    if lastAttackerID then
        lastAttackerTeam = Spring.GetUnitTeam(lastAttackerID)
        if lastAttackerTeam then
            hp = Spring.GetUnitHealth(unitID)
            if hp < healthAtLastAttack then
                if not accumulatedDamageByTeam[lastAttackerTeam] then accumulatedDamageByTeam[lastAttackerTeam] = 0 end
                accumulatedDamageByTeam[lastAttackerTeam] = accumulatedDamageByTeam[lastAttackerTeam] + (healthAtLastAttack - hp)
                totalDamage = totalDamage + (healthAtLastAttack - hp)
                if totalDamage > priceOfAEnemy then
                    spawnTeamID = getLowestDamageTeam()
                    for i = 0, totalDamage, priceOfAEnemy do
                        GG.UnitsToSpawn:PushCreateUnit("jresistancewarrior", x + math.random(25, 50) * randSign(), y, z + math.random(25, 50) * randSign(), 1, spawnTeamID)
                    end
                    totalDamage = 0
                end
            else
                healthAtLastAttack = hp
            end
        end
    end


    return damage
end


energyConsumedPerSecond = 15
metallConsumedPerSecond = 15
function charged()
    --get metall
    boolMetallUsed = Spring.UseUnitResource(unitID, "m", metallConsumedPerSecond)
    if boolMetallUsed == true then
        metallStored = metallConsumedPerSecond + metallStored
    end
    --get energy
    boolEnergyUsed = Spring.UseUnitResource(unitID, "e", energyConsumedPerSecond)
    if boolEnergyUsed == true then
        energyStored = energyConsumedPerSecond + energyStored
    end
    --if both
    if energyStored > energyCost and metallStored > metallCost then
        return true
    else
        return false
    end
end



range = 75
function getFreeSpot()
    boolFoundSomething = false
    unitTable = {}
    pointsTable = {}

    local spGetUnitsInCylinder = Spring.GetUnitsInCylinder


    for i = 1, table.getn(replicPoints), 1 do

        unitTable = spGetUnitsInCylinder(repcoords[i][1], repcoords[i][2], range)


        if unitTable == nil or table.getn(unitTable) == 0 then
            table.insert(pointsTable, i)
            boolFoundSomething = true
        end
    end


    if boolFoundSomething == true then
        max = table.getn(pointsTable)
        xi = math.random(1, max)

        return pointsTable[xi]

    else
        return nil
    end
end


function buildAnimation(pointOfBuilding)
    Move(bridgeTop, y_axis, -11, 0)
    Move(bridegPentHouse, y_axis, -24, 0)
    degree = pointOfBuilding * -45
    Turn(bridgeTurnerKid, y_axis, math.rad(degree), 0)
    Turn(bridgeOverTroubledHood, z_axis, math.rad(0), 0.1)
    Show(bridgeOverTroubledHood)
    while true == Spring.UnitScript.IsInMove(bridgeOverTroubledHood, z_axis) do
        EmitSfx(bridgeTurnerKid, 1027)
        Sleep(50)
    end

    Move(bridgeTop, y_axis, 0, 0.5)
    Show(bridgeTop)
    WaitForMove(bridgeTop, y_axis)
    Move(bridegPentHouse, y_axis, 0, 0.5)
    Show(bridegPentHouse)
    Show(bridgeExp1)
    Move(bridgeExp1, z_axis, -13, 0.5)
    Show(bridgeExp2)
    Move(bridgeExp2, z_axis, 13, 0.5)
    WaitForMove(bridegPentHouse, y_axis)


    boolAnimationDone = true
end


function OS_LOOP()
    boolBuildIt = false
    while (true) do
        boolCharged = charged()
        if boolCharged == true then
            Show(houseHeap1)
            Show(houseHeap2)
            Move(houseHeap1, y_axis, 0, unifiedBuildSpeed)
            Move(houseHeap2, y_axis, 0, unifiedBuildSpeed)
            WaitForMove(houseHeap2, y_axis)
            WaitForMove(houseHeap1, y_axis)

            --ey, Yo, reSettin but neva forgettin
            energyStored = 0
            metallStored = 0
            boolCharged = false
            --checking out the neighbourhood

            while (boolBuildIt == false) do
                --checkthe Freespots for freedom
                returnFreeSpot = getFreeSpot()

                if returnFreeSpot == nil then
                    --Spring.Echo("NoSpotFound")
                    boolBuildIt = false
                else
                    --Spring.Echo("SpotOn Found")
                    boolAnimationDone = false
                    StartThread(buildAnimation, returnFreeSpot)
                    while (boolAnimationDone == false) do
                        Sleep(400)
                    end

                    Spring.CreateUnit("cDistrictNone", repcoords[returnFreeSpot][1], y, repcoords[returnFreeSpot][2], 0, math.max(teamID, -1))
                    boolBuildIt = true
                end


                Sleep(100)
            end
        end
        Sleep(1000)
    end
end

function damaged(nrOfFires)
    SetSignalMask(SIG_DAMAGE)
    Timer = math.random(450, 800)
    while (true and Timer > 0) do
        for i = 1, nrOfFires, 1 do
            EmitSfx(house[i], 1025)
            ma = math.random(0, 1)
            if ma == 1 then
                EmitSfx(house[i], 1026)
            else
                Sleep(5)
                EmitSfx(house[i], 1025)
            end
        end
        Sleep(50)
        Timer = Timer - 5
    end
end


function damageWatcher()
    currentHealth = Spring.GetUnitHealth(unitID)
    healthOfOld = currentHealth
    local spGetUnitHealth = Spring.GetUnitHealth

    while (true) do
        currentHealth = spGetUnitHealth(unitID)


        if currentHealth < healthOfOld then
            Signal(SIG_DAMAGE)
            resUlt = (((currentHealth / (maxHealth)) * -1) + 1) * 4
            StartThread(damaged, resUlt)


            if math.random(0, 1) == 1 then
                rVal = math.random(1, 8)
                if replicPoints[rVal] and replicPoints[rVal][1] and replicPoints[rVal][2] then
                    heapID = Spring.CreateUnit("gCiVillian", replicPoints[rVal][1], y, replicPoints[rVal][2], teamID)
                end
            end
        end

        Sleep(1000)
        healthOfOld = currentHealth
    end
end

function script.Create()
    Spring.SetUnitBlocking(unitID, false)
    setUp()
    StartThread(buildItUp)
    StartThread(OS_LOOP)
    StartThread(damageWatcher)
end

function script.Killed(recentDamage, _)
    --spawnARewarder
    spx, spy, spz = Spring.GetUnitPosition(unitID)

    createRewardEvent(teamid, 125, 125)
    createCorpseCBuilding(unitID, recentDamage)


    return 1
end