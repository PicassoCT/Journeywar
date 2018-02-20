include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_jw.lua"
include "createCorpse.lua"
include "lib_Build.lua"


--<CopyPasteTemplate for TerraFormingUnit>
--include "terraForm.lua"
--global Infomartion
boolUnitIsDigginDown = false
radiationRange = 60
local damagePerSecond = 12






--<CopyPasteTemplate for TerraFormingUnit>


local potato = piece "potato"

local dirtHolder = piece "dirtHolder"

local drillTreeDrill = piece "drillTreeDrill"
dirtPieces = {}
for i = 1, 9, 1 do
    dirtPieces[i] = {}
    dusty = "dirtPiece" .. i
    dirtPieces[i] = piece(dusty)
end

dirDirtEmitters = {}
for i = 1, 5, 1 do
    dirDirtEmitters[i] = {}
    dusty = "ddemit" .. i
    dirDirtEmitters[i] = piece(dusty)
end

local roTator = piece "roTator"
WEDEL = {}
for i = 1, 5, 1 do
    WEDEL[i] = {}
    wedelino = "wedel" .. i
    WEDEL[i] = piece(wedelino)
end

Liane = {}
for i = 1, 15, 1 do
    Liane[i] = {}
    cheetah = "Liane" .. i
    Liane[i] = piece(cheetah)
end

--OMG..23 Stones.. Free_Man_Masons everywhere. Got to hide under a rock till paranoia is gone!
Stone = {}
for i = 1, 23, 1 do
    Stone[i] = {}
    cheetah = "Stone" .. i
    Stone[i] = piece(cheetah)
end
dustEmit = {}
for i = 1, 13, 1 do
    dustEmit[i] = {}
    dustEmitter = "dustEmit" .. i
    dustEmit[i] = piece(dustEmitter)
end
rod1 = piece "rod1"
rod2 = piece "rod2"

dirt1 = piece "dirt1"
dirt2 = piece "dirt2"
SIG_WEDEL = 1
--Created

function Steam(idof)
    SetSignalMask(SIG_STEAM)
    dice = math.random(1, 10)
    if dice == 1 then
        Spring.PlaySoundFile("sounds/cgama/steamone.wav", 0.5)
    elseif dice == 2 then
        Spring.PlaySoundFile("sounds/cgama/steamtwo.wav", 0.5)
    elseif dice == 3 then
        Spring.PlaySoundFile("sounds/cgama/steamthree.wav", 0.5)
    elseif dice == 4 then
        Spring.PlaySoundFile("sounds/cgama/steamfour.wav", 0.5)
    end

    randDelay = math.random(50, 950)
    Sleep(randDelay)
    x, y, z = Spring.GetUnitPosition(idof)
    if x ~= nil then
        rando = math.random(2, 4)
        for i = 1, rando, 1 do
            Spring.SpawnCEG("gamasteam", x, y + 4 + i, z, 0, 1, 0, 50, 0)
        end
    end
end

function transFormTree(treeID)
    teamID = Spring.GetUnitTeam(treeID)
    x, y, z = Spring.GetUnitPosition(treeID)
    Spring.CreateUnit("jtree2activate", x, y, z, 0, teamID)
    Spring.DestroyUnit(treeID, false, true)
end

function gamaDamage()
    HitPointsReduce = 5
    selectRange = 260
    SetSignalMask(SIG_GAMA)
    CuredByRadiationUnitTypes = {
        UnitDefNames[""]
    }

    local spGetUnitPosition = Spring.GetUnitPosition
    local spGetUnitDefID = Spring.GetUnitDefID
    local spGetUnitsInCylinder = Spring.GetUnitsInCylinder
    local spSetUnitHealth = Spring.SetUnitHealth
    local spGetUnitHealth = Spring.GetUnitHealth
    local ltransformTree = transFormTree
    local lsteam = Steam
    radiationResistantUnitTypes = getRadiationResistantUnitTypeTable()

    while (true) do

        piecePosX, piecePosY, piecePosZ = spGetUnitPosition(unitID)
        proChoice = {}
        proChoice = spGetUnitsInCylinder(piecePosX, piecePosZ, selectRange)

        process(proChoice,
            function(id)
                if id then
                    defID = Spring.GetUnitDefID(id)
                    if radiationResistantUnitTypes[defID] then
                        if defID == UnitDefNames["jtree2"].id then
                            ltransformTree(id)
                        end
                        if defID == UnitDefNames["jtree2activate"].id then
                            tempHP = Spring.GetUnitHealth(id)
                            tempHP = tempHP + HitPointsReduce
                            Spring.SetUnitHealth(id, tempHP)
                        end

                    else
                        StartThread(lsteam, id)
                        Spring.AddUnitDamage(id, HitPointsReduce)
                    end
                end
            end)
        Sleep(1000)
    end
end




function createExtrema()

    emin, emax = Spring.GetGroundExtremes()
    if emin and emax then
        GG.Extrema = (emax + math.abs(emin) + 100)
    else
        GG.Extrema = 250
    end
end


function thisIsTheEnd()
    x = -9999
    y = -9999
    z = -9999

    Sleep(1000)

    local spGetUnitPosition = Spring.GetUnitPosition
    local spGetGroundHeight = Spring.GetGroundHeight

    x, y, z = Spring.GetUnitPosition(unitID)
    --- -Spring.Echo("x:",x)
    while y == nil do
        Sleep(500)
        x, y, z = Spring.GetUnitPosition(unitID)
        --- -Spring.Echo("x:",x)
    end

    if GG.Extrema == nil then
        createExtrema()
    end


    while ((not GG.Extrema or not y) or y < GG.Extrema) do
        if x ~= nil and z ~= nil then
            y = spGetGroundHeight(x, z)
        else
            x, y, z = spGetUnitPosition(unitID)
        end
        Sleep(3000)
        if not GG.Extrema then createExtrema() end
    end
    endOfTimes()
    overTime = math.random(1000, 50000)
    Sleep(overTime)
    Spring.DestroyUnit(unitID, true, false)
end

function script.Killed(recentDamage, maxHealth)
    for i = 1, 13, 1 do
        Explode(dustEmit[i], SFX.FIRE + SFX.FALL)
    end
    for i = 1, table.getn(Liane), 1 do
        Explode(Liane[i], SFX.FIRE + SFX.FALL)
        Hide(Liane[i])
    end
    Sleep(400)

    Explode(potato, SFX.FALL + SFX.NO_HEATCLOUD)
    Hide(potato)
    createCorpseJBuilding(unitID, recentDamage)
end

function radiation()
    x, y, z = Spring.GetUnitPosition(unitID)
    local spGetUnitHealth = Spring.GetUnitHealth
    local spSetUnitHealth = Spring.SetUnitHealth
    while (true) do
        UnitsTable = {}
        UnitsTable = getAllInCircle(x, z, radiationRange, unitID)

        if UnitsTable ~= nil and table.getn(UnitsTable) ~= 0 then

            for i = 1, table.getn(UnitsTable), 1 do
                tempHealth = spGetUnitHealth(UnitsTable[i])
                tempHealth = tempHealth - damagePerSecond
                spSetUnitHealth(UnitsTable[i], tempHealth)
            end
        end
        Sleep(1000)
    end
end

function ThisIsNotADrill()
    while (true) do
        Move(drillTreeDrill, y_axis, 0, 0)
        Move(drillTreeDrill, y_axis, -19, 1.9)
        WaitForMove(drillTreeDrill, y_axis)
    end
end

function geigerCounter()
    local spPlaySoundFile = Spring.PlaySoundFile
    while (true) do
        dice = math.random(0, 2)
        if dice == 0 then
            spPlaySoundFile("sounds/jDrillTree/jDrillTree.wav")
            Sleep(10500)
        elseif dice == 1 then
            spPlaySoundFile("sounds/jDrillTree/jDrillTree2.wav")
            Sleep(31500)
        else
            spPlaySoundFile("sounds/jDrillTree/jDrillTree3.wav")
            Sleep(35000)
        end
    end
end

function playingWithDirt()
    while (true) do
        Move(dirt1, y_axis, -2, 1.5)
        Move(dirt2, y_axis, 0, 1.5)
        WaitForMove(dirt1, y_axis)
        WaitForMove(dirt2, y_axis)
        Move(dirt1, y_axis, -17, 1.5)
        WaitForMove(dirt1, y_axis)
        WaitForMove(dirt2, y_axis)
        Move(dirt2, y_axis, -10, 1.5)
        Move(dirt1, y_axis, -8, 1.5)
        WaitForMove(dirt1, y_axis)
        WaitForMove(dirt2, y_axis)
    end
end

function pressen()
    while (true) do
        for i = 1, 9, 1 do
            if math.random(0, 1) == 1 then
                Move(dirtPieces[i], y_axis, -11, 0.1)
            end
        end
        Sleep(5200)

        for i = 1, 9, 1 do
            if math.random(0, 1) == 1 then
                Show(dirtPieces[i])
            else
                Hide(dirtPieces[i])
            end
        end
        for i = 1, 9, 1 do
            if math.random(0, 1) == 0 then
                Move(dirtPieces[i], y_axis, 0, 2.9)
            end
        end
        Sleep(5200)
    end
end

function workInProgress()
    Spin(roTator, y_axis, math.rad(40), 9)
    Spin(drillTreeDrill, y_axis, math.rad(40), 9)
    StartThread(playingWithDirt)
    StartThread(ThisIsNotADrill)
    Signal(SIG_WEDEL)
    for i = 1, 5, 1 do
        Turn(WEDEL[i], x_axis, math.rad(0), 0.2)
        Turn(WEDEL[i], y_axis, math.rad(0), 0.2)
        Turn(WEDEL[i], z_axis, math.rad(0), 0.2)
    end

    StartThread(pressen)
    StartThread(geigerCounter)

    local lEmitSfx = EmitSfx
    local lExplode = Explode
    while (true) do
        boolWedelOn = false
        for i = 1, 9, 1 do
            zork = math.random(1.3, 3)
            Move(dirtPieces[i], y_axis, 0, zork)
        end

        Sleep(58)
        for i = 1, table.getn(dirDirtEmitters), 1 do
            lEmitSfx(dirDirtEmitters[i], 1026)
        end

        dice = math.random(0, 1)
        if dice == 1 then
            lExplode(rod1, SFX.FALL + SFX.NO_HEATCLOUD)
            x = math.random(21, 23)
            lExplode(Stone[x], SFX.FALL + SFX.NO_HEATCLOUD)

            Sleep(414)

            x = math.random(21, 23)
            lExplode(Stone[x], SFX.FALL + SFX.NO_HEATCLOUD)

            Sleep(214)
            for i = 1, table.getn(dirDirtEmitters), 1 do
                lEmitSfx(dirDirtEmitters[i], 1026)
            end


            x = math.random(21, 23)
            lExplode(Stone[x], SFX.FALL + SFX.NO_HEATCLOUD)
            Sleep(314)

            x = math.random(21, 23)
            lExplode(Stone[x], SFX.FALL + SFX.NO_HEATCLOUD)
        else
            for i = 1, table.getn(dirDirtEmitters), 1 do
                lEmitSfx(dirDirtEmitters[i], 1026)
            end
            Sleep(100)
        end

        lExplode(rod2, SFX.FALL + SFX.NO_HEATCLOUD)
    end
end

function emitRandomRadiation()
    local lEmitSfx = EmitSfx
    while (true) do
        lEmitSfx(drillTreeDrill, 1025)
        naptime = math.random(100, 1200)
        Sleep(naptime)
    end
end

function script.Activate()
    return 1
end

function script.Deactivate()

    return 0
end

boolWedelOn = true

function wedelWave()
    SetSignalMask(SIG_WEDEL)
    x = math.random(-5, 5)
    y = math.random(-8, 8)
    z = math.random(-12, 6)
    while (x ^ 2 > 0.1 or y ^ 2 > 0.1 or z ^ 2 > 0.1 and boolWedelOn == true) do
        for i = 1, 5, 1 do
            Turn(WEDEL[i], x_axis, math.rad(x), 0.02)
            Turn(WEDEL[i], y_axis, math.rad(y), 0.02)
            Turn(WEDEL[i], z_axis, math.rad(z + math.random(0, 4)), 0.02)
        end
        WaitForTurn(WEDEL[5], x_axis)
        Sleep(40)
        x = -0.5 * x
        y = -0.5 * y
        z = -0.5 * z
        for i = 1, 5, 1 do
            Turn(WEDEL[i], x_axis, math.rad(x), 0.02)
            Turn(WEDEL[i], y_axis, math.rad(y), 0.02)
            Turn(WEDEL[i], z_axis, math.rad(z + math.random(0, 4)), 0.02)
        end
        WaitForTurn(WEDEL[5], x_axis)
        Sleep(40)
        for i = 1, 5, 1 do
            Turn(WEDEL[i], x_axis, math.rad(0), 0.02)
            Turn(WEDEL[i], y_axis, math.rad(0), 0.02)
            Turn(WEDEL[i], z_axis, math.rad(0), 0.02)
        end
        WaitForTurn(WEDEL[5], x_axis)
    end
    for i = 1, 5, 1 do
        Turn(WEDEL[i], x_axis, math.rad(0), 0.02)
        Turn(WEDEL[i], y_axis, math.rad(0), 0.02)
        Turn(WEDEL[i], z_axis, math.rad(0), 0.02)
    end
end

boolenDust = true
function dustInTheWind()
    while (boolenDust == true) do
        for i = 6, 13, 1 do
            EmitSfx(dustEmit[i], 1024)
        end
        Sleep(250)
    end
end

function script.Create()
    StartThread(thisIsTheEnd)

    for i = 1, table.getn(dirDirtEmitters), 1 do
        Hide(dirDirtEmitters[i])
    end

    for i = 1, 9, 1 do
        Hide(dirtPieces[i])
    end
    Move(potato, y_axis, -96, 0)
    Move(dirt1, y_axis, -10, 0)
    Move(dirt2, y_axis, -10, 0)
    Hide(rod1)
    Hide(rod2)
    for i = 1, 23, 1 do
        Hide(Stone[i])
    end
    Move(dirt1, y_axis, 0, 1.5)
    Move(dirt2, y_axis, 0, 1.5)
    Sleep(800)
    Move(potato, y_axis, -87, 0.9)
    WaitForMove(potato, y_axis)
    Sleep(1200)
    Move(dirt1, y_axis, -10, 0)
    Move(dirt2, y_axis, -10, 0)
    Move(potato, y_axis, -67, 0.9)
    StartThread(dustInTheWind)
    StartThread(wedelWave)
    WaitForMove(potato, y_axis)
    Sleep(1200)
    Move(potato, y_axis, -32, 1.2)
    StartThread(wedelWave)

    WaitForMove(potato, y_axis)
    Sleep(1200)
    Move(potato, y_axis, 0, 1.2)
    StartThread(wedelWave)

    WaitForMove(potato, y_axis)
    boolenDust = false
    Sleep(1200)
    StartThread(workInProgress)
    StartThread(gamaDamage)
    StartThread(emitRandomRadiation)
end

function endOfTimes()
    x, y, z = Spring.GetUnitPosition(unitID)
    gaiaTeamId = Spring.GetGaiaTeamID()
    Spring.CreateUnit("gVolcano", x, y, z, 0, gaiaTeamId)
end