include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


scumslum = piece "scumslum"
scumslum2 = piece "scumslum2"
scumslum3 = piece "scumslum3"
local explodeemit0 = piece "explodeemit0"
local explodeemit1 = piece "explodeemit1"
local explodeemit2 = piece "explodeemit2"
local explodeemit3 = piece "explodeemit3"
local explodeemit4 = piece "explodeemit4"
local explodeemit5 = piece "explodeemit5"
local gangstaturner1 = piece "gangstaturner1"
local gangstaturner2 = piece "gangstaturner2"
local gangstaturner3 = piece "gangstaturner3"
teamID = Spring.GetUnitTeam(unitID)
slumTable = {
    [1] = scumslum,
    [2] = scumslum2,
    [3] = scumslum3
}


local scgangsta = piece "scgangsta"
local scgangsta2 = piece "scgangsta2"
local scgangsta3 = piece "scgangsta3"
gangstArray = {}
table.insert(gangstArray, scgangsta)

table.insert(gangstArray, scgangsta2)

table.insert(gangstArray, scgangsta3)

Foundation = piece "Foundation"
local damageAccumulated = 0
ratio = 4



mratio = 1 / ((UnitDefNames["cscumslum"].metalCost / ratio) / (UnitDefNames["gcivillian"].metalCost / 2))
eratio = 1 / ((UnitDefNames["cscumslum"].energyCost / ratio) / (UnitDefNames["gcivillian"].energyCost / 2))


hp, maxhp = Spring.GetUnitHealth(unitID)
ratioDamage = math.abs(maxhp * ((mratio + eratio) / 2))
--gcivillian
--metalCost = 250,
--energyCost = 750,

function script.HitByWeapon(x, z, weaponDefID, damage)
    damageAccumulated = damageAccumulated + damage
    if damageAccumulated > ratioDamage then
        laID = Spring.GetUnitLastAttacker(unitID)
        valID = Spring.GetUnitIsDead(laID)
        px, pz = 0, 0
        if valID and valID == true then
            px, _, pz = Spring.GetUnitPosition(laID)
        else
            px, _, pz = Spring.GetUnitPosition(unitID)
            px, pz = px + (x * -35), pz + (z * -35)
        end
        id = Spring.CreateUnit("gcivillian", px, 0, pz, 0, teamID)
        if id then
            Spring.SetUnitNoSelect(id, true)
        end
    end

    return damage
end

windowTable = {}
function buildSlum()
    if maRa() == true then Turn(Foundation, x_axis, math.rad(180), 0)
        if maRa() == true then
            Turn(Foundation, x_axis, math.rad(180 + math.random(-1, 1)), 0)
        end
    end

    hideT(PieceGroups["Rectangl"])
    hideT(slumTable)
    if math.random(0, 1) == 1 then
        Show(scumslum)
        StartThread(nightLights)
    else
        boolAtLeastOne = false

        for i = 1, #slumTable do
            if maRa() == true then
                Show(slumTable[i])
                boolAtLeastOne = true
                if i > 1 and maRa() == true then Turn(slumTable[i], y_axis, math.rad(math.ceil(math.random(1, 8)) * 90), 0) end
            end
        end
        if boolAtLeastOne == false then Show(scumslum); StartThread(nightLights) end
    end
end

function getRandomizedLightTimeTable()
    retTable = {}
    for times = 0, 9, 1 do
        if times < 4 then retTable[times] = 0 else
            retTable[times] = math.random(1, times - 3) * 3
        end
    end
    for times = 17, 20, 1 do
        retTable[times] = math.random(2, 8)
    end

    for times = 21, 22, 1 do
        retTable[times] = math.random(8, 10)
    end

    for times = 23, 24, 1 do
        retTable[times] = math.random(2, 6)
    end
    return retTable
end

function randDelayedShow(timew, pieces)
    Sleep(timew)
    Show(pieces)
end

function randDelayedHide(timew, pieces)
    Sleep(timew)
    Hide(pieces)
end

nightLightTable = {}
function nightLights()
    hours, minutes, seconds = getDayTime()
    oldhours = hours + 1
    while true do
        hours, minutes, seconds = getDayTime()

        if oldhours > hours then
            hideT(PieceGroups["Rectangl"])
            --reinitialize ShowTable
            for window = 1, table.getn(PieceGroups["Rectangl"]), 1 do
                nightLightTable[window] = {}
                nightLightTable[window] = getRandomizedLightTimeTable()
            end
        end
        oldhours = hours


        if hours > 17 or hours < 8 then
            for window = 1, #PieceGroups["Rectangl"], 1 do
                if nightLightTable[window] and nightLightTable[window][hours] and PieceGroups["Rectangl"][window] then
                    if math.random(0, nightLightTable[window][hours]) > 3 then
                        StartThread(randDelayedShow, math.random(1, 7000), PieceGroups["Rectangl"][window])
                    else
                        StartThread(randDelayedHide, math.random(1, 7000), PieceGroups["Rectangl"][window])
                    end
                end
            end
        else
            hideT(PieceGroups["Rectangl"])
        end

        Sleep(25000)
    end
end

function showGangsta()
    Hide(scgangsta)
    Hide(scgangsta2)
    Hide(scgangsta3)
    rand = math.random(1, 3)
    for i = 1, rand, 1 do
        Show(gangstArray[i])
    end
end

function moveGansta(number, turner, ganstapiece, currentheading3)
    if ganstaTable[number] == true then return end

    ganstaTable[number] = true

    cripWalkSpeed3 = math.random(4, 8)
    distance3 = math.random(26, 84)

    if currentheading3 > 0 and currentheading3 < 95 then
        currentheading3 = 95
    end

    Turn(ganstapiece, y_axis, math.rad(90), 12)
    Turn(turner, y_axis, math.rad(currentheading3), 6)
    WaitForTurn(turner, y_axis)
    Turn(ganstapiece, y_axis, math.rad(0), 12)
    WaitForTurn(ganstapiece, y_axis)


    distValue = 0
    boolOnGround = true
    while distValue < distance3 and boolOnGround == true do
        distValue = distValue + 3
        Move(ganstapiece, x_axis, distValue, cripWalkSpeed3)
        WaitForMove(ganstapiece, x_axis)
        boolOnGround = onGround(ganstapiece)
    end

    Turn(ganstapiece, y_axis, math.rad(180), 12)
    WaitForTurn(ganstapiece, y_axis)
    Move(ganstapiece, x_axis, 0, cripWalkSpeed3)
    WaitForMove(ganstapiece, x_axis)

    ganstaTable[number] = false
end


function onGround(piecename)
    px, py, pz = Spring.GetUnitPiecePosDir(unitID, piecename)
    gh = Spring.GetGroundHeight(px, pz)
    return math.abs(py - gh) < 15
end



function breakdance()
    Turn(scgangsta3, z_axis, math.rad(90), 12)
    Turn(scgangsta3, x_axis, math.rad(270), 12)
    WaitForTurn(scgangsta3, z_axis)
    rundmc = math.random(-1, 1)
    if rundmc == 0 then
        rundmc = 1
    end
    Spin(scgangsta3, y_axis, 12, 1.2)

    Sleep(6000)
    Turn(scgangsta3, x_axis, math.rad(0), 22)
    Turn(scgangsta3, z_axis, math.rad(180), 12)
    StopSpin(scgangsta3, y_axis)
    Spin(scgangsta3, x_axis, (15 * rundmc), 1.2)
    Sleep(6000)
    StopSpin(scgangsta3, x_axis)
    Turn(scgangsta3, x_axis, math.rad(0), 22)
    Turn(scgangsta3, y_axis, math.rad(0), 22)
    Turn(scgangsta3, z_axis, math.rad(0), 22)
    Sleep(2000)
end

ganstaTable = {}
for i = 1, 3 do
    ganstaTable[i] = false
end

function gangstaIdling()

    local moveOnTheTurf1 = 0
    local moveOnTheTurf2 = 0
    local moveOnTheTurf3 = 0

    while (true) do


        Sleep(350)
        xOr = math.random(0, 4)
        --one, two , or all three got to move
        if xOr == 0 then
            StartThread(moveGansta, 1, gangstaturner1, scgangsta, math.random(85, 330))
            --one moves
        end
        if xOr == 1 then
            --two moves
            StartThread(moveGansta, 2, gangstaturner2, scgangsta2, math.random(-89, 208))
            StartThread(moveGansta, 1, gangstaturner1, scgangsta, math.random(85, 330))
        end
        if xOr == 2 then
            --three move
            StartThread(moveGansta, 3, gangstaturner3, scgangsta3, math.random(52, 277))
            StartThread(moveGansta, 2, gangstaturner2, scgangsta2, math.random(-89, 208))
            StartThread(moveGansta, 1, gangstaturner1, scgangsta, math.random(85, 330))
        end
        if xOr == 3 or xOr == 4 then
            boolGanstaWalk = false
            for i = 1, 3 do
                if ganstaTable[i] == true then boolGanstaWalk = false end
            end
            if boolGanstaWalk == true then
                breakdance()
            end
        end
    end
end

upgradetime = 6 * 60 * 1000
function upgraDDe()
    Sleep(upgradetime)

    if not GG.ScumSlumUpgrade then GG.ScumSlumUpgrade = {} end
    while not GG.ScumSlumUpgrade[unitID] do
        Sleep(500)
    end
    Spring.SetUnitResourcing(unitID, "ume", 68)
end

function script.Create()
    PieceGroups = getPieceTableByNameGroups(false, true)
    buildSlum()
    --<buildanimationscript>
    x, y, z = Spring.GetUnitPosition(unitID)


    if GG.UnitsToSpawn == nil then GG.UnitsToSpawn = {} end
    GG.UnitsToSpawn:PushCreateUnit("cbuildanimation", x, y, z, 0, teamID)

    --</buildanimationscript>

    showGangsta()
    StartThread(gangstaIdling)
    StartThread(upgraDDe)
end

function script.Killed(recentDamage, maxHealth)

    sleepRand = math.random(200, 1250)
    Sleep(sleepRand)
    Explode(explodeemit0, SFX.FIRE)
    sleepRand = math.random(200, 1250)
    Sleep(sleepRand)
    Explode(explodeemit1, SFX.FIRE)
    sleepRand = math.random(200, 1250)
    Sleep(sleepRand)
    Explode(explodeemit2, SFX.FIRE)
    sleepRand = math.random(200, 1250)
    Sleep(sleepRand)
    Explode(explodeemit3, SFX.FIRE)
    sleepRand = math.random(200, 1250)
    Sleep(sleepRand)
    Explode(explodeemit4, SFX.FIRE)
    sleepRand = math.random(200, 1250)
    Sleep(sleepRand)
    Explode(explodeemit5, SFX.FIRE)
    local xturn = math.random(0, 8)
    local zturn = math.random(0, 8)
    local yturn = math.random(0, 3)
    Sleep(1200)
    local unitx, unity, unitz = Spring.GetUnitBasePosition(unitID)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    Sleep(50)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    Turn(scumslum, y_axis, math.rad(yturn), 0.25)
    Turn(scumslum, x_axis, math.rad(xturn), 0.25)
    Turn(scumslum, z_axis, math.rad(zturn), 0.25)
    Move(scumslum, y_axis, -10.7, 12)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    WaitForMove(scumslum, y_axis)
    Move(scumslum, y_axis, -24.7, 18)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    WaitForMove(scumslum, y_axis)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    Move(scumslum, y_axis, -59.7, 42)
    WaitForMove(scumslum, y_axis)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    Move(scumslum, y_axis, -109.7, 42)
    WaitForMove(scumslum, y_axis)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)

    createCorpseCBuilding(unitID, recentDamage)
    Sleep(10)
    return 0
end