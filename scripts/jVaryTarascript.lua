include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
SIG_ATTACKED = 2
SIG_DELAYEDSTOP = 4
RAM_DAMAGE = 250

center = piece "center"
piecesTable = {}
currentPiece = 1

varyTaraID = UnitDefNames["jvaryavatara"].id
nrNeeded = tonumber(UnitDefs[varyTaraID].customParams.varyfooneeded)
-- piece -->AttachPoint
AttachPoints = {}

--unitID-->piece
if not GG.BoundVaryFoos then GG.BoundVaryFoos = {} end

boolUnderAttack = false

function script.HitByWeapon(x, z, weaponDefID, damage)
    boolUnderAttack = true
    Signal(SIG_ATTACKED)
    StartThread(resetAttack)
    hp, maxhp = Spring.GetUnitHealth(unitID)
    if hp / maxhp < 0.25 and math.random(0, 1) == 1 then
        teamID = Spring.GetUnitTeam(unitID)
        for i = 1, 0.25 * nrNeeded, 1 do
            if AttachPoints[i] then
                x, y, z = spGetUnitPiecePosDir(unitID, AttachPoints[i])
                if x then
                    GG.UnitsToSpawn:PushCreateUnit("jvaryfoo", x, y, z, 0, teamID)
                end
            end
        end
    end
end

boolBuildEnded = false

AttachedUnits = {}
function partOfShipPartOfCrew(point, VaryFooID)
    Spring.SetUnitNeutral(VaryFooID, true)
    Spring.UnitScript.AttachUnit(point, VaryFooID)
    AttachedUnits[VaryFooID] = true



    while boolBuildEnded == false and Spring.GetUnitIsDead(VaryFooID) == false do
        tx, ty, tz = Spring.GetUnitDirection(VaryFooID)

        roX, roY, roZ = tx + math.random(-100, 100) / 1000, ty + math.random(-100, 100) / 1000, tz + math.random(-100, 100) / 1000
        Spring.SetUnitDirection(VaryFooID, roX, roY, roZ)
        Sleep(500)
    end

    if boolBuildEnded == false and Spring.GetUnitIsDead(VaryFooID) == false then

        Spring.UnitScript.DropUnit(VaryFooID)
        AttachedUnits[VaryFooID] = nil
    end
end

nrAdded = 0



function buildMoma(varyFooos)


    frame = Spring.GetGameFrame()
    x, y, z = Spring.GetUnitPiecePosDir(unitID, center)
    for i = #varyFooos, 1, -1 do
        if varyFooos[i] then
            if Spring.ValidUnitID(varyFooos[i]) == false or Spring.GetUnitIsDead(varyFooos[i]) == true then
                table.remove(varyFooos, i)
            else
                indexP = (indexP % #AttachPoints) + 1
                distanced = distanceUnitToUnit(unitID, varyFooos[i])
                if distanced < 75 and not AttachedUnits[varyFooos[i]] then --integrate it into the Avatara
                    nrAdded = nrAdded + 1
                    StartThread(partOfShipPartOfCrew, AttachPoints[indexP], varyFooos[i])

                else
                    ox, oz = RotationMatrice(0, 50 + (varyFooos[i] % 120), ((varyFooos[i] * 150) % 3000) + frame / 64)
                    Spring.SetUnitMoveGoal(varyFooos[i], x + ox, y, z + oz)
                end
            end
        end
    end
end

function defendMoma(varyFooos)
    for k, v in ipairs(AttachedUnits) do
        Spring.UnitScript.DropUnit(k)
        AttachedUnits[k] = nil
    end
    nrAdded = 0

    ed = getNearestGroundEnemy(unitID, UnitDefs)
    if ed then
        ax, ay, az = Spring.GetUnitPosition(ed)
        for i = 1, #varyFooos do
            Spring.SetUnitMoveGoal(allVaryFoos[i], ax, ay, az)
        end
    end
end

function spinTentacles()
    tentacles = nameGroupT["tentacle"]
    while true do
        randVal = math.random(500, 2000)
        Sleep(randVal)
        speed = math.random(2, 35) / 10
        spinT(tentacles, y_axis, speed, -42, 42)
    end
end

function filterNonVaryfoos(id)
    if Spring.GetUnitDefID(id) == VaryFooDefID then
        return id
    end
end

VaryFooDefID = UnitDefNames["jvaryfoo"].id

nameGroupT = makePiecesTablesByNameGroups(false, true)
function raiseAvatara()
    StartThread(spinTentacles)

    hideT(piecesTable)
    frame = Spring.GetGameFrame()
    minMergeTimeComplete = frame + 2048

    indexP = 1
    setSpeedEnv(unitID, 0, UnitDefs)
    DistanceDown = -150
    Move(center, y_axis, DistanceDown, 0, true)
    while nrAdded < nrNeeded do

        Move(center, y_axis, math.min(0, DistanceDown * (1 - (nrAdded / nrNeeded))), 7.5)
        --check VaryFoos around you
        ux, uy, uz = Spring.GetUnitPosition(unitID)
        units = getAllInCircle(ux, uz, 300)
        if units then
            allVaryFoos = process(units,
                filterNonVaryfoos)
            echo("jvaryavatara::nrNeeded" .. nrNeeded .. " / nrAdded" .. nrAdded .. " / NrOfFoos" .. #units)
            if boolUnderAttack == true then
                --defend moma
                defendMoma(allVaryFoos)
                hideT(piecesTable)
            else --build on
                --get nextPiece above ground
                buildMoma(allVaryFoos)
            end
        end
        Sleep(350)
    end
    Move(center, y_axis, 0, 2.5)
    times = math.ceil(9000 / #piecesTable)

    for i = 1, #piecesTable do
        Show(piecesTable[i])
        Sleep(times)
    end

    Sleep(9000)
    WMove(center, y_axis, 0, 2.5)
    for k, v in pairs(AttachedUnits) do
        Spring.DestroyUnit(k, false, true)
    end
    boolBuildEnded = true
    Move(center, y_axis, 0, 12)
    showT(piecesTable)
    setSpeedEnv(unitID, 1, UnitDefs)
    StartThread(moveAble)
end

boolAimingAndFiringWeapon2 = false
function moveAble()
    while true do
        while boolMoving == true do
            moveAnimation()
        end

        if boolNotAiming == true then
            StandingAnimation()
        end
        Sleep(200)
    end
end

walkSpeed = 0.25
function push(num, index)

    legPairsDone[index] = false
    val = math.random(20, 35)
    Turn(nameGroupT["FrontF"][num], x_axis, math.rad(val), walkSpeed)
    Turn(nameGroupT["FrontF"][num + 1], x_axis, math.rad(-1 * val), walkSpeed)
    WaitForTurn(nameGroupT["FrontF"][num + 1], x_axis)
    WaitForTurn(nameGroupT["FrontF"][num], x_axis)
    legPairsDone[index] = true
end

function stabilize(num, index)

    legPairsDone[index] = false
    Turn(nameGroupT["FrontF"][num], x_axis, math.rad(0), walkSpeed)
    Turn(nameGroupT["FrontF"][num + 1], x_axis, math.rad(0), walkSpeed)
    WaitForTurn(nameGroupT["FrontF"][num + 1], x_axis)
    WaitForTurn(nameGroupT["FrontF"][num], x_axis)

    legPairsDone[index] = true
end

function bringfront(num, index)

    legPairsDone[index] = false
    val = math.random(10, 20)
    Turn(nameGroupT["FrontF"][num], x_axis, math.rad(val * -1), 1)
    Turn(nameGroupT["FrontF"][num + 1], x_axis, math.rad(-1 * val / 2), 1)
    WaitForTurn(nameGroupT["FrontF"][num + 1], x_axis)
    WaitForTurn(nameGroupT["FrontF"][num], x_axis)
    Turn(nameGroupT["FrontF"][num], x_axis, math.rad(val * -1), walkSpeed)
    Turn(nameGroupT["FrontF"][num + 1], x_axis, math.rad(val), walkSpeed)

    WaitForTurn(nameGroupT["FrontF"][num + 1], x_axis)
    WaitForTurn(nameGroupT["FrontF"][num], x_axis)
    legPairsDone[index] = true
end

legPairs = {
    [1] = 1,
    [2] = 2,
    [3] = 2,
    [4] = 3,
    [5] = 3,
    [6] = 1
}

legPairsDone = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true
}

walkFunctions = {
    [1] = bringfront,
    [2] = stabilize,
    [3] = push
}

function moveAnimation()
    echoT(legPairs)
    resetT(nameGroupT["Body"], 5)
    for i = 1, #legPairsDone do
        if legPairsDone[i] == true then
            legPairs[i] = (legPairs[i] % 3) + 1
            num = ((i - 1) * 2) + 1
            StartThread(walkFunctions[legPairs[i]], num, i)
        end
        Sleep(100)
    end
end

function StandingAnimation()
    resetT(nameGroupT["Body"], 5)
    resetT(nameGroupT["FrontF"], 5)
end

function resetAttack()
    SetSignalMask(SIG_ATTACKED)
    Sleep(10000)
    boolUnderAttack = false
end

function script.Create()
    spinT(AttachPoints, y_axis, 4.2, -42, 42)

    piecesTable = generatepiecesTableAndArrayCode(unitID)
    AttachPoints = piecesTable
    hideT(piecesTable)
    StartThread(raiseAvatara)
end



function script.Killed(recentDamage, _)

    createCorpseJUnitGeneric(recentDamage)
    return 1
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return center
end


pods = nameGroupT["Pod"]
indexPod = 1
function script.QueryWeapon1()
    return pods[indexPod]
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy´
    return true
end

function delayedRegrowth(number)
    Hide(pods[number])
    Sleep(4500)
    Show(pods[number])
end

function script.FireWeapon1()
    StartThread(delayedRegrowth, indexPod)

    indexPod = (indexPod % #pods) + 1
    return true
end

aimspot = piece "aimspot"
function script.QueryWeapon2()
    return aimspot
end

boolReadyAim = true
function takeUpArms(pitch)
    boolNotAiming = false
    Turn(nameGroupT["Body"][3], x_axis, math.rad(-41), 7)
    Turn(nameGroupT["Body"][2], x_axis, math.rad(-32), 7)

    Turn(nameGroupT["FrontF"][2], x_axis, math.rad(42), 7)
    Turn(nameGroupT["FrontF"][4], x_axis, math.rad(42), 7)

    Turn(AimArmTable[2], x_axis, math.rad(-35), 12)
    Turn(AimArmTable[1], x_axis, math.rad(110) + pitch, 12)

    Turn(AimArmTable[4], x_axis, math.rad(-35), 12)
    WTurn(AimArmTable[3], x_axis, math.rad(110) + pitch, 12)
end



AimArmTable = nameGroupT["AimArmF"]
function script.AimWeapon2(Heading, pitch)
    if boolReadyAim == true then
        WTurn(center, y_axis, Heading, 5)
        takeUpArms(-1 * pitch)

        return true
    else
        return false
    end
end

boolNotAiming = true
function fireAnimation(readyAim)
    boolReadyAim = false
    moveT(nameGroupT["chain"], z_axis, 75, 220)
    unitsAffected = getAllNearPiece(unitID, nameGroupT["ram"][1], 50)
    process(unitsAffected,
        function(id)
            Spring.AddUnitDamage(id, RAM_DAMAGE)
        end)
    EmitSfx(nameGroupT["ram"][1], 1024)
    EmitSfx(nameGroupT["ram"][2], 1024)
    Sleep(3200)
    if readyAim == true then
        resetT(nameGroupT["chain"], 235, true)
        resetT(AimArmTable, 4, true)
        boolReadyAim = true
    end
    WTurn(center, y_axis, 0, 5)
end

function delayedAimReset()
    Signal(SIG_DELAYEDAIMRESET)
    SetSignalMask(SIG_DELAYEDAIMRESET)
    Sleep(9000)
    boolNotAiming = true
end

function script.FireWeapon2()
    StartThread(fireAnimation, true)
    StartThread(delayedAimReset)
    return true
end


boolMoving = false
function script.StartMoving()
    Signal(SIG_DELAYEDSTOP)
    boolMoving = true
end

function DelayedStop()
    Signal(SIG_DELAYEDSTOP)
    SetSignalMask(SIG_DELAYEDSTOP)
    Sleep(4500)
    boolMoving = false
end

function script.StopMoving()
    StartThread(DelayedStop)
end

function script.Activate()

    return 1
end

function script.Deactivate()

    return 0
end