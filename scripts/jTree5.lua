include "createCorpse.lua"
include "lib_OS.lua"
include "lib_jw.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

--Skyhooktree
-- This tree generates Energy under normal Circumstances.. upon Attack it consumes Energy and
-- inverts Gravity in a Cylinder around the tree

--Config
ActiveOnAttackTime = 15000
EnergyCostSkyHook = 25
EnergyGainedDuringPeace = 10
RangeSkyHook = 450
--/Config
treebasis = piece "treebasis"
center = piece "center"
treetoproto = piece "treetoproto"
treerotatestump = piece "LowStem"
counterrotatestump = piece "UpStem"
baumkrone = treetoproto
rooter = piece "rooter"

oldDeg = {}
function diceNewDeg(saveKey, upValue, margin)
    if not oldDeg[saveKey] then oldDeg[saveKey] = 0.0 end
    temp = 0.0
    if margin > 0 then
        temp = math.random((margin * -1), margin)
    else
        temp = math.random(margin, -1 * margin)
    end
    oldDeg[saveKey] = oldDeg[saveKey] + (upValue + temp)
    echo("j5Tree" .. oldDeg[saveKey])
    return oldDeg[saveKey]
end


function aListOfRandom(nrOfElements)
    tempList = {}
    for i = 1, nrOfElements, 1 do
        tempList[i] = i
    end
    tempList = shuffle(tempList)
    return tempList
end

function TurnRootRandom()

    --if a tree is drunk in the woods and falls down
    randoValX = math.random(-22, 22)

    randoValZ = math.random(-55, -11) * randSign()

    --	Turn(treerotatestump,y_axis,math.rad(randoValY),0)
    Turn(rooter, z_axis, math.rad(-1 * randoValZ), 0)
    Turn(treerotatestump, z_axis, math.rad(randoValZ), 0)

    -- getting the baumkrone straighted
    percentage = math.random(1, 99) / 100
    Turn(counterrotatestump, z_axis, math.rad(-1 * randoValZ * (percentage)), 0)

    Turn(treetoproto, x_axis, math.rad(-1 * randoValX * (1 - percentage)), 0)
    offset = math.random(-10, 10)
    Turn(treetoproto, z_axis, math.rad(-1 * randoValZ * (1 - percentage) + offset), 0)
end

function createRoot()
    rootOffset = 0

    process(TableOfPieceGroups["Root"],
        function(id)
            offsetVal = math.random(360 / 12, 360 / 4)
            rootOffset = rootOffset + offsetVal
            Turn(id, y_axis, math.rad(rootOffset), 0)
        end)
end

treeFormVal = math.random(-9, 20)
function createTreeTop()

    rotationValue = {}
    index = 1
    for i = 1, 24 do
        rotationValue[#rotationValue + 1] = diceNewDeg("a", 360 / 12, 6.0)
    end
    rotationValue = shuffleT(rotationValue)
    boolSinus = math.random(0, 1) == 1
    currKey, value = getNextKey(rotationValue, nil, true)

    process(TableOfPieceGroups["rooftop"],
        function(id)
            if boolSinus == false then
                Turn(id, z_axis, math.rad(math.random(-10, 10)), 0)
                currKey, value = getNextKey(rotationValue, currKey)
                if not value then value = math.random(-360, 360) end
                Turn(id, y_axis, math.rad(value), 0)
            else
                factor = math.sin(((index / 12) * 2 * math.pi)) * 10
                Turn(id, z_axis, math.rad(factor), 0)
                rotVal = diceNewDeg("b", 360 / 12, 6)
                Turn(id, y_axis, math.rad(rotVal), 0)
            end

            index = index + 1
        end)

    process(TableOfPieceGroups["TreeCarry"],
        function(id)
            Turn(id, y_axis, math.rad(math.random(-15, 15)), 0)
            Turn(id, z_axis, math.rad(treeFormVal + math.random(-5, 5)), 0)
        end)
    process(TableOfPieceGroups["TreeMid"],
        function(id)
            Turn(id, y_axis, math.rad(math.random(-15, 15)), 0)
            Turn(id, z_axis, math.rad(math.random(-5, 5)), 0)
        end)

    process(TableOfPieceGroups["TreeUp"],
        function(id)
            Turn(id, y_axis, math.rad(math.random(-15, 15)), 0)
            Turn(id, z_axis, math.rad(math.random(-5, 5)), 0)
        end)
    process(TableOfPieceGroups["TreeTop"],
        function(id)
            Turn(id, z_axis, math.rad(treeFormVal + math.random(-3, 3)), 0)
        end)
end

skyhook = piece "skyhook"
function dropLianes(boolUp, speed)
    if boolUp == true then
        boolXAxis = maRa()

        process(TableOfPieceGroups["Liane"],
            function(id)
                xs, ys, zs = Spring.GetUnitPieceCollisionVolumeData(unitID, id)
                Spin(id, y_axis, math.rad(math.random(-4.2, 4.2)), 0)
                Move(id, y_axis, ys, 450)
            end)

        process(TableOfPieceGroups["TreeTop"],
            function(id)
                Turn(id, z_axis, math.rad(30), speed)
            end)
        process(TableOfPieceGroups["TreeCarry"],
            function(id)
                Turn(id, z_axis, math.rad(30), speed)
            end)

    else

        process(TableOfPieceGroups["Liane"],
            function(id)
                Spin(id, y_axis, math.rad(math.random(-4.2, 4.2)), 0)
                Move(id, y_axis, 0, 650)
            end)

        process(TableOfPieceGroups["TreeTop"],
            function(id)
                Turn(id, z_axis, math.rad(treeFormVal + math.random(-3, 3)), speed)
            end)

        process(TableOfPieceGroups["TreeCarry"],
            function(id)
                Turn(id, y_axis, math.rad(math.random(-15, 15)), speed)
                Turn(id, z_axis, math.rad(treeFormVal + math.random(-5, 5)), speed)
            end)
    end

    process(TableOfPieceGroups["Liane"],
        function(id)
            WaitForTurns(id)
            if maRa() == true then
                Hide(id)
            else
                Show(id)
            end
        end)
end

function createLiane()
    Sleep(1000)

    process(TableOfPieceGroups["rot"],
        function(id)
            val = diceNewDeg("c", 360 / 26, 6)
            Turn(id, y_axis, math.rad(val), 0)
        end)
    dropLianes(false, 0)
end

flyingUnits = getAirUnitTypeTable(UnitDefNames)
x, y, z = Spring.GetUnitPosition(unitID)

function fallingOff()
    local spGetUnitPosition = Spring.GetUnitPosition
    exemptUnits = getExemptFromLethalEffectsUnitTypeTable(UnitDefNames)
    gravResistantUnits = getGravityChaneReistantUnitTypeTable(UnitDefNames)

    T = getAllInCircle(x, z, RangeSkyHook, unitID)

    process(T,
        function(id)
            idDefID = Spring.GetUnitDefID(id)

            --filter out imobile Units
            if flyingUnits[idDefID] then return nil end
            if UnitDefs[idDefID].isImmobile == true then return nil end
            if UnitDefs[idDefID].isAirUnit == true then return nil end
            if gravResistantUnits[idDefID] then return nil end
            if exemptUnits[idDefID] then return nil end

            return id
        end,
        function(id)
            StartThread(flyingUnit, id)
        end)
end

--flyingFeatures

--flyingProjectiles

maxHeigth = 950
function nearUnit()
end

function flyingUnit(id)
    ox, oy, oz = Spring.GetUnitPosition(unitID)
    flyingUnits[id] = id
    Spring.MoveCtrl.Enable(id)
    Spring.MoveCtrl.SetNoBlocking(id, true)
    orgX, _, orgZ = Spring.GetUnitDirection(id)
    speed = 0
    cosvalue = math.random(1, 150) / 1000
    personalOffset = math.random(0, 50)
    ux, uy, uz = Spring.GetUnitPosition(id)
    sindex = 0
    cosdex = math.pi / 2
    boolNearUnit = true

    while uy < oy + maxHeigth and boolNearUnit == true do
        stunUnit(id, math.pi)
        ux, uy, uz = Spring.GetUnitPosition(id)
        if x then
            boolNearUnit = math.sqrt((ox - ux) ^ 2 + (oz - uz) ^ 2) < RangeSkyHook
            gh = Spring.GetGroundHeight(ux, uz)
            uy = uy + speed
            Spring.MoveCtrl.SetPosition(id, ux + orgX * 5, uy + personalOffset, uz + orgZ * 5)
            rx, ry, rz = Spring.GetUnitRotation(id)
            Spring.MoveCtrl.SetRotation(id, math.cos(-cosdex), math.sin(sindex), math.cos(cosdex))
            ssindex = sindex + 0.001
            cosdex = cosdex + cosvalue
        end
        speed = math.min(55, speed + 0.981)
        Sleep(100)
    end

    boolNearUnit = true

    while boolGravityOff == true and boolNearUnit == true do

        Spring.MoveCtrl.SetGravity(id, 0)
        ux, uy, uz = Spring.GetUnitPosition(id)
        if ux then
            boolNearUnit = math.sqrt((ox - ux) ^ 2 + (oz - uz) ^ 2) < RangeSkyHook
            Spring.MoveCtrl.SetPosition(id, ux + orgX * 1.5, uy, uz + orgZ * 1.5)
        end
        Sleep(100)
    end

    for i = 1, 15 do
        Spring.MoveCtrl.SetGravity(id, i / 15)
        Sleep(100)
    end

    --StartEventStream	fallingDown()
    Spring.MoveCtrl.SetGravity(id, 1)
    Spring.MoveCtrl.SetRotation(id, 0, 0, 0)
    Spring.MoveCtrl.SetNoBlocking(id, false)
    Spring.MoveCtrl.Disable(id)


    flyingUnits[id] = nil
end

SIG_DEACTIVATE = 2
function delayedDeactivation()
    Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 1)
    Signal(SIG_DEACTIVATE)
    SetSignalMask(SIG_DEACTIVATE)
    Sleep(ActiveOnAttackTime)
    Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 0)
end


function script.HitByWeapon(x, z, weaponDefID, damage)
    StartThread(delayedDeactivation)
    return damage
end



function consumeEnergy()

    boolHadEnough = Spring.UseUnitResource(unitID, "e", EnergyCostSkyHook)
    return boolHadEnough or false
end

function giveEnergy()
    Spring.AddUnitResource(unitID, "e", EnergyGainedDuringPeace)
end

function invertGravityLoop()
    Sleep(1500)
    while true do
        if boolGravityOff == false then
            StartThread(dropLianes, false, 4.2)
            Sleep(500)
            while boolGravityOff == false do
                giveEnergy()
                Sleep(100)
            end
        end

        if boolGravityOff == true then
            StartThread(dropLianes, true, 4.2)
            while boolGravityOff == true do
                if consumeEnergy() == true then
                    fallingOff()
                end
                Sleep(100)
            end
        end

        Sleep(500)
    end
end

function invertGravitySoundLoop()
    Sleep(1500)
    while true do
        if boolGravityOff == false then
            Sleep(500)
            while boolGravityOff == false do
                Sleep(100)
            end
        end

        if boolGravityOff == true then

            Spring.PlaySoundFile("sounds/jSkyhooktree/GravityOff.ogg", 1.0)
            Sleep(15000)
            while boolGravityOff == true do


                index = math.random(1, 2)
                if boolGravityOff == true then
                    Spring.PlaySoundFile("sounds/jSkyhooktree/GravityLoop" .. index .. ".ogg", 1.0)
                    Sleep(25000)
                end
            end

            Spring.PlaySoundFile("sounds/jSkyhooktree/GravityOff.ogg", 1.0)
            Sleep(5000)
        end

        Sleep(500)
    end
end

function buildATree()

    TurnRootRandom()
    createTreeTop()
    createRoot()
    --centerturn
    createLiane()
    randoMarlo = math.random(0, 360)
    Turn(center, y_axis, math.rad(randoMarlo))
end

pieceTable = generatepiecesTableAndArrayCode(unitID, false)
TableOfPieceGroups = {}
root = {}
function script.Create()
    TableOfPieceGroups = makePiecesTablesByNameGroups(false, true)
    resetT(TableOfPieceGroups)
    root = TableOfPieceGroups["Root"]

    teamID = Spring.GetUnitTeam(unitID)
    x, y, z = Spring.GetUnitPosition(unitID)
    if math.random(0, 1) == 1 then
        GG.UnitsToSpawn:PushCreateUnit("gtreeplate", x, y, z, 0, teamID)
    else
        GG.UnitsToSpawn:PushCreateUnit("gtreeplate2", x, y, z, 0, teamID)
    end


    StartThread(buildATree)
    StartThread(invertGravityLoop)
    StartThread(invertGravitySoundLoop)
end

function dusty(x)
    for i = 1, x, 1 do
        EmitSfx(root[(i % (table.getn(root) - 1)) + 1], 1024)
        EmitSfx(baumkrone, 1028) --leaves
        Sleep(90)
    end
end


function dusty2(x)
    for i = 1, x, 1 do
        EmitSfx(root[(i % (table.getn(root) - 1)) + 1], 1024)
        EmitSfx(baumkrone, 1024)
        EmitSfx(baumkrone, 1028)
        EmitSfx(baumkrone, 1028)


        Sleep(90)
    end
end

function fire(x)
    for i = 1, x, 1 do
        EmitSfx(root[(i % (table.getn(root) - 1)) + 1], 1024)
        EmitSfx(baumkrone, 1027)
        EmitSfx(baumkrone, 1028)
        EmitSfx(baumkrone, 1025)
        if i % 12 == 0 then
            EmitSfx(baumkrone, 1026)
        end


        Sleep(90)
    end

    Sleep(300)
    EmitSfx(baumkrone, 1026)
end

function fallingProcess(evtID, frame, persPack, startFrame)
    --> EventStreamify
    totalTimeRunning = frame - startFrame
    i = math.ceil(totalTimeRunning / 100)
    if i < 15 then
        Spring.MoveCtrl.SetGravity(persPack.id, i / 15)
        return frame + 100, persPack
    end

    --StartEventStream	fallingDown()
    Spring.MoveCtrl.SetGravity(persPack.id, 1)
    Spring.MoveCtrl.SetRotation(persPack.id, 0, 0, 0)
    Spring.MoveCtrl.SetNoBlocking(persPack.id, false)
    Spring.MoveCtrl.Disable(persPack.id)
end


function script.Killed(recentdamage, _)

    for id, ready in pairs(flyingUnits) do
        if ready then
            persPack = { id = id }
            GG.EventStream:CreateEvent(fallingProcess,
                persPack,
                Spring.GetGameFrame() + 1)
        end
    end

    Spring.PlaySoundFile("sounds/jEtree/tree.wav")
    Sleep(2000)
    Turn(treerotatestump, x_axis, math.rad(0), 2)
    Turn(treerotatestump, y_axis, math.rad(0), 2)
    Turn(treerotatestump, z_axis, math.rad(0), 2)
    if recentdamage > 12 then
        StartThread(fire, 33)
        StartThread(dusty, 33)
    else
        StartThread(dusty, 33)
    end


    Turn(center, z_axis, math.rad(30), 0.3)
    Turn(baumkrone, z_axis, math.rad(-30), 2)
    WaitForTurn(center, z_axis)
    Turn(center, z_axis, math.rad(60), 1)
    Turn(baumkrone, z_axis, math.rad(-70), 2)

    Turn(baumkrone, z_axis, math.rad(-65), 2)
    WaitForTurn(center, z_axis)
    Turn(center, z_axis, math.rad(65), 2.2)
    Turn(baumkrone, z_axis, math.rad(-65), 6)
    WaitForTurn(center, z_axis)
    Turn(baumkrone, z_axis, math.rad(-78), 6)
    Turn(center, z_axis, math.rad(89), 6)

    if recentdamage > 12 then
        StartThread(fire, 48)
    else
        StartThread(dusty2, 11)
    end
    WaitForTurn(center, x_axis)

    EmitSfx(baumkrone, 1024)
    for i = 1, 9, 1 do
        Turn(baumkrone, z_axis, math.rad(-78 + (3 - (i / 2))), 0.9 * (1 / i))
        WaitForTurn(baumkrone, z_axis)
        Turn(baumkrone, z_axis, math.rad(-78 - (3.2 - (i / 3))), 0.9 * (1 / i))
        WaitForTurn(baumkrone, z_axis)
    end
    --emit various particles+sound

    Sleep(4500)
    Move(center, y_axis, -32, 3.141) --circle
    WaitForMove(center, y_axis)
    createCorpseJBuilding(unitID, recentDamage)
    return 1
end


boolGravityOff = false

function script.Activate()
    boolGravityOff = true
    return 1
end

function script.Deactivate()
    boolGravityOff = false

    return 0
end