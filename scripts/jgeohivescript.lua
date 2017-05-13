include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "createCorpse.lua"

hivePiece = nil
myDefID = Spring.GetUnitDefID(unitID)
jGeoHiveID = UnitDefNames["jgeohive"].id
gaiaTeamID = Spring.GetGaiaTeamID()

TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
SIG_HIVE = 2

boolHiveAttacked = false
function HiveAttacked()
    Signal(SIG_HIVE)
    SetSignalMask(SIG_HIVE)
    boolHiveAttacked = true
    Sleep(30000)
    boolHiveAttacked = false
end

function script.HitByWeapon(x, z, weaponDefID, damage)
    StartThread(HiveAttacked)
    return damage
end


function underground()
    hideT(TablesOfPiecesGroups["root"])
    WaitForMove(hivePiece, y_axis)
    showT(TablesOfPiecesGroups["root"])
    boolUndergroundCounter = 0
    for i = 1, #TablesOfPiecesGroups["root"] do
        pieceID = TablesOfPiecesGroups["sensor"][i]
        radVal = math.random(-360, 360)
        ux, uy, uz = Spring.GetUnitPosition(unitID)
        boolUnderground = false
        while boolUnderground == false or radVal > radVal + 360 do
            WTurn(TablesOfPiecesGroups["root"][i], y_axis, math.rad(radVal), 0)
            radVal = radVal + 5
            gh, py, boolUnderground = getGroundHeigthAtPiece(unitID, pieceID)
        end
        if boolUnderground == true then boolUndergroundCounter = boolUndergroundCounter + 1 end
    end

    if boolUndergroundCounter < 5 then hideT(TablesOfPiecesGroups["root"]) end
end

function setHivePiece()

    if Spring.GetUnitDefID(unitID) == UnitDefNames["jgeohive"].id then

        hivePiece = piece "jgeohive"
        Move(hivePiece, y_axis, -45, 0, true)
        Move(hivePiece, y_axis, 0, 3)
        StartThread(underground)
    end
    if Spring.GetUnitDefID(unitID) == UnitDefNames["gzombspa"].id then

        hivePiece = piece "center"
    end

    x = math.random(0, 360)

    Turn(hivePiece, y_axis, math.rad(x), 0)
end

function sanitizeCoords(x, y, z)
    return x, y, z
end

spawnCycleRestTime = 80000
howManyUnitsPerSpawnCycle = 5

monsterTable = {}
mapX, mapZ = Spring.GetMetalMapSize()
numX = mapX * 8
numZ = mapZ * 8

teamID = Spring.GetUnitTeam(unitID)
function spawner()

    repeat
        Sleep(100)
        hp, maxhp, _, _, bP = Spring.GetUnitHealth(unitID)
        bP = bP or 0
    until (bP >= 1 or hp == maxhp)


    local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy
    local spGetUnitPosition = Spring.GetUnitPosition
    local spSpawnCEG = Spring.SpawnCEG
    local spCreateUnit = Spring.CreateUnit
    local spSetUnitMoveGoal = Spring.SetUnitMoveGoal
    local spEmitSfx = EmitSfx
    local spSetUnitNoSelect = Spring.SetUnitNoSelect

    local x, y, z = Spring.GetUnitPosition(unitID)



    while (true) do
        --- -Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")
        Sleep(spawnCycleRestTime)
        enemyID = Spring.GetUnitNearestEnemy(unitID)

        if enemyID ~= nil then
            --EmitSfx(jgeohive,1024)
            ex, ey, ez = spGetUnitPosition(enemyID)
            if math.random(0, 1) == 1 then
                eteam = Spring.GetUnitTeam(enemyID)
                ex, ey, ez, boolValidStartPos = Spring.GetTeamStartPosition(eteam)
            end
            Spring.SetUnitBlocking(unitID, false)
            for i = 1, howManyUnitsPerSpawnCycle, 1 do
                spEmitSfx(hivePiece, 1025)
                spEmitSfx(hivePiece, 1025)
                randoval = math.random(-65, -45)
                bool = math.random(0, 1) == 1
                if bool == true then
                    randoval = randoval * -1
                end
                sigNum = randSign()

                spSpawnCEG("dirt", x + randoval, y, z + randoval, 0, 1, 0, 50, 0)
                dice = math.random(1, 4)
                spawnedUnit = 0
                if myDefID == jGeoHiveID then
                    if dice == 1 then
                        spawnedUnit = spCreateUnit("jhoneypot", x + randoval, y, z + (randoval * sigNum), 0, teamID)
                    elseif dice == 2 then
                        spawnedUnit = spCreateUnit("jbugcreeper", x + randoval, y, z + (randoval * sigNum), 0, teamID)
                    else --we addd the crab here
                        spawnedUnit = spCreateUnit("jcrabcreeper", x + randoval, y, z + (randoval * sigNum), 0, teamID)
                    end
                else
                    if dice == 2 then
                        spawnedUnit = spCreateUnit("gzombiehorse", x + randoval, y, z + (randoval * sigNum), 0, teamID)
                    else
                        spawnedUnit = spCreateUnit("zombie", x + randoval, y, z + (randoval * sigNum), 0, teamID)
                    end
                end

                if spawnedUnit and Spring.ValidUnitID(spawnedUnit) == true then
                    spSetUnitNoSelect(spawnedUnit, true)
                    if boolValidStartPos == true then
                        spSetUnitMoveGoal(spawnedUnit, ex, ey, ez)
                    end
                    table.insert(monsterTable, spawnedUnit)
                end


                Sleep(350)
                spEmitSfx(hivePiece, 1025)
                spEmitSfx(hivePiece, 1025)
            end

            Spring.SetUnitBlocking(unitID, true)
        end
        Sleep(10000)
    end
end


BuildUPTime = 900000
PEAKFADETIME = 900000
PeakTime = 850000
RandVAl = math.ceil(math.random(40000, 600000))
RELAXTIME = 60000 + RandVAl

totalTable = {
    ["BUILDUP"] = BuildUPTime,
    ["PEAKFADE"] = PeakTime,
    ["PEAK"] = PEAKFADETIME,
    ["RELAX"] = RELAXTIME
}

nextState = {
    ["BUILDUP"] = "PEAK",
    ["PEAKFADE"] = "RELAX",
    ["PEAK"] = "PEAKFADE",
    ["RELAX"] = "BUILDUP"
}

function NextState(nState, times)

    --Spring.Echo("CurrentState:"..nState.." in "..(times-totalTable[nState]).." next State:"..nextState[nState] )
    if nState == "BUILDUP" and times > BuildUPTime then
        times = 0; --Spring.Echo("hivePiece::Peak") ;
        return "PEAK", times, BuildUPTime
    end

    if nState == "PEAK" and times > PeakTime then
        times = 0;
        return "PEAKFADE", times, PeakTime
    end

    if nState == "PEAKFADE" and times > PEAKFADETIME then
        times = 0;
        return "RELAX", times, PEAKFADETIME
    end

    if nState == "RELAX" and times > RELAXTIME then
        times = 0;
        RELAXTIME = 60000 + math.ceil(math.random(4000, 60000))
        --	Spring.Echo("hivePiece::BUILDUP") ;
        return "BUILDUP", times, RELAXTIME
    end

    return nState, times, times / totalTable[nState]
end

maxTuple = {
    x = mapX / 2,
    z = mapZ / 2,
    val = 0
}
oldtime = -math.huge
function findBiggestCluster(team, times)

    if math.abs(times - oldtime) < 20000 then return maxTuple.x * 8, maxTuple.z * 8 end
    oldtime = times

    mapX, mapZ = Spring.GetMetalMapSize()
    local mapRepresentiv = makeTable(0, mapX, mapZ)
    teamUnits = Spring.GetTeamUnits(team)
    maxTuple = {
        x = mapX / 2,
        z = mapZ / 2,
        val = 0
    }
    if teamUnits then
        local spGetUnitPos = Spring.GetUnitPosition
        process(teamUnits,
            function(id)
                ix, _, iz = spGetUnitPos(id)
                ix, iz = math.ceil(ix / 8), math.ceil(iz / 8)
                if not mapRepresentiv[ix] then mapRepresentiv[ix] = {} end
                if not mapRepresentiv[ix][iz] then mapRepresentiv[ix][iz] = 0 end
                mapRepresentiv[ix][iz] = mapRepresentiv[ix][iz] + 1
            end)

        for i = 1, #mapRepresentiv do
            for j = 1, #mapRepresentiv[i] do
                if mapRepresentiv[i][j] > maxTuple.val then
                    maxTuple.val = mapRepresentiv[i][j]
                    maxTuple.x = i
                    maxTuple.z = j
                end
            end
        end
    end
    return maxTuple.x * 8, maxTuple.z * 8
end


ax, ay, az = Spring.GetUnitPosition(unitID)
--attack relentless the biggest cluster
function PEAK(monsterID, enemyID, Time, mteam, factor)
    rVal = math.random(16, 64)
    rx, rz = drehMatrix(0, rVal, 0, 0, math.cos(factor * 2 * math.pi + monsterID) * 4 * math.pi)
    if math.random(0, 2) == 1 then
        eteam = Spring.GetUnitTeam(enemyID)
        ex, ez = findBiggestCluster(eteam, Time)
        ex, ey, ez = sanitizeCoords(ex + rx, 0, ez + rz)
        return ex, 0, ez
    else

        ex, ey, ez = Spring.GetUnitPosition(enemyID)
        ex, ey, ez = sanitizeCoords(ex + rx, 0, ez + rz)
        return ex + rx, 0, ez + rz
    end
end

PEAKFADEHALF = PEAKFADETIME / 4

function PEAKFADE(monsterID, enemyID, Time, mteam, factor)
    if monsterID % math.random(12, 27) == 0 then
        ex, ey, ez = Spring.GetUnitPosition(enemyID)
        ex, ey, ez = sanitizeCoords(ex, ey, ez)
        return ex, ey, ez
    end

    if distanceUnitToUnit(monsterID, enemyID) < 1024 then
        ex, ey, ez = Spring.GetUnitPosition(enemyID)
        mx, my, mz = Spring.GetUnitPosition(monsterID)
        dx, dy, dz = mx - ex, my - ey, mz - ez
        dx, dy, dz = dx * math.pi, dy * math.pi, dz * math.pi
        ax, ay, az = sanitizeCoords(ex + dx, ey + dy, ez + dz)
        return ax, ay, az
    else
        mx, my, mz = Spring.GetTeamStartPosition(mteam)
        allyID = Spring.GetUnitNearestAlly(monsterID)
        allyID = allyID or monsterID
        ax, ay, az = Spring.GetUnitPosition(allyID)
        ax, az = ax - mx, az - mz
        zoomFactor = 1 - factor
        ax, az = ax * zoomFactor, az * zoomFactor
        px, pz = drehMatrix(ax, az, 0, 0, math.cos(7 * math.pi * factor) * 2 * math.pi)
        ex, ey, ez = sanitizeCoords(mx + px, y, mz + pz)
        return ex, ey, ez
    end
end


function BUILDUP(monsterID, enemyID, Time, mteam, factor)
    ex, ey, ez = Spring.GetUnitPosition(enemyID)

    if monsterID % math.random(22, 27) == 0 then

        ex, ey, ez = sanitizeCoords(ex, ey, ez)
        return ex, ey, ez
    end

    if distanceUnitToUnit(monsterID, enemyID) < 768 then
        return ex, ey, ez
    end

    allyID = Spring.GetUnitNearestAlly(enemyID)
    if not allyID or type(allyID) ~= "number" then return ex, ey, ez end

    ex, ey, ez = Spring.GetUnitPosition(allyID)
    mx, my, mz = Spring.GetTeamStartPosition(mteam)

    waveFactor = factor + math.sin(factor * math.pi * 8) / 5
    limitedFactor = math.max(0.25, math.min(0.55, waveFactor))
    vBlend = blendVector(limitedFactor, makeVector(ex, ey, ez), makeVector(mx, my, mz))
    randVal = math.random(96, 256)
    rx, rz = drehMatrix(0, randVal, 0, 0, math.sin(factor * 5 * math.pi) * 2 * math.pi + monsterID % (math.pi / 3))
    vBlend.x, vBlend.z = vBlend.x + rx, vBlend.z + rz

    dax, day, daz = sanitizeCoords(vBlend.x, vBlend.y, vBlend.z)

    return dax, day, daz
end

ux, uy, uz = Spring.GetUnitPosition(unitID)
function RELAX(monsterID, enemyID, Time, mteam, factor)
    if monsterID % math.random(45, 67) == 0 then
        ex, ey, ez = Spring.GetUnitPosition(enemyID)
        ex, ey, ez = sanitizeCoords(ex, ey, ez)
        return ex, ey, ez
    end

    mx, my, mz = Spring.GetTeamStartPosition(mteam)

    randVal = math.max(64, 512 * factor) + (monsterID % 25)
    rx, rz = drehMatrix(0, randVal, 0, 0, math.sin(factor * 5 * math.pi) * 2 * math.pi + (monsterID % math.pi))

    dax, day, daz = sanitizeCoords(mx + rx, my, mz + rz)
    return dax, day, daz
end

funcTable = {}

funcTable["PEAK"] = PEAK
funcTable["PEAKFADE"] = PEAKFADE
funcTable["BUILDUP"] = BUILDUP
funcTable["RELAX"] = RELAX
local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy
function getNearestEnemy(idID)
    if Spring.ValidUnitID(idID) == false then return end

    minDist = math.huge
    minDistID = math.huge

    local spGetUnitTeam = Spring.GetUnitTeam
    for _, id in ipairs(AllUnitsUpdated) do
        edTeam = spGetUnitTeam(id)
        if edTeam ~= teamID and edTeam ~= gaiaTeamID and id ~= idID then
            dist = distanceUnitToUnit(id, idID)

            if dist and id and dist + math.random(0, 30) < minDist then
                minDistID = id
                minDist = dist + math.random(0, 30)
            end
        end
    end

    if minDistID == math.huge then return Spring.GetUnitNearestEnemy(idID) end

    return minDistID
end

function handleHiveAttacks()
    boolStillAlive = true
    while boolHiveAttacked == true and boolStillAlive == true do
        lastAttacker = Spring.GetUnitLastAttacker(unitID)

        if lastAttacker and Spring.GetUnitIsDead(lastAttacker) == false then
            boolStillAlive = Spring.GetUnitIsDead(lastAttacker)
            ex, ey, ez = Spring.GetUnitPosition(lastAttacker)
            for num, monsterid in pairs(monsterTable) do
                if Spring.GetUnitIsDead(monsterid) == false then
                    Command(monsterid, "go", { x = ex + math.random(-25, 25), y = ey, z = ez + math.random(-25, 25) }, {})
                else
                    monsterTable[monsterid] = nil
                end
            end
        end
        Sleep(500)
    end
end

AllUnitsUpdated = {}
State = "RELAX"
function TargetOS()


    times = 0
    local spValidUnitID = Spring.GetUnitIsDead

    local spGetUnitPosition = Spring.GetUnitPosition
    local spSetUnitMoveGoal = Spring.SetUnitMoveGoal
    local lfuncTable = funcTable

    oldState = "RELAX"
    while (true) do
        handleHiveAttacks()
        Sleep(2500)
        times = times + 2500
        AllUnitsUpdated = Spring.GetAllUnits()

        if monsterTable and table.getn(monsterTable) > 0 then

            State, times, percent = NextState(State, math.ceil(times))
            if State ~= oldState then
                --Spring.Echo("jgeohive:Switching from "..oldState.." to "..State)
                oldState = State
            end

            for num, monsterid in pairs(monsterTable) do
                if monsterid and Spring.GetUnitIsDead(monsterid) == false then
                    enemyID = getNearestEnemy(monsterid)
                    if enemyID then
                        ex, ey, ez = lfuncTable[State](monsterid, enemyID, times, teamID, times / totalTable[State])
                        if ex then
                            --Spring.Echo("jgeohive:Sending".. monsterid.." to state pos")
                            --StartThread(markPosOnMap,ex,ey,ez,"greenlight")
                            Command(monsterid, "go", { x = ex, y = ey, z = ez }, {})
                        end
                    end
                end
            end
        end
    end
end

function aliveAndWell(id)
    boolExists = Spring.ValidUnitID(id)
    if boolExists and boolExists == true then
        boolAlive = Spring.GetUnitIsDead(id)
        if boolAlive and boolAlive == true then
            return true
        end
    end
    return false
end

function script.Create()
    setHivePiece()

    StartThread(spawner)
    StartThread(TargetOS)
end

function script.Killed()
    Move(hivePiece, y_axis, -25, 18)
    EmitSfx(hivePiece, 1024)
    WMove(hivePiece, y_axis, -25, 18)
    EmitSfx(hivePiece, 1024)
end