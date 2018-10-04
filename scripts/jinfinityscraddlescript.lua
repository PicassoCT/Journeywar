include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

solarTable = {}
solar03 = piece "solar03"

solarTable[#solarTable + 1] = solar03
solar04 = piece "solar04"

solarTable[#solarTable + 1] = solar04
solar01 = piece "solar01"

solarTable[#solarTable + 1] = solar01
solar02 = piece "solar02"

solarTable[#solarTable + 1] = solar02
Line039 = piece "Line039"

solarTable[#solarTable + 1] = Line039
solar05 = piece "solar05"

solarTable[#solarTable + 1] = solar05
solar06 = piece "solar06"

solarTable[#solarTable + 1] = solar06
solar07 = piece "solar07"

solarTable[#solarTable + 1] = solar07
solar08 = piece "solar08"

solarTable[#solarTable + 1] = solar08

solar09 = piece "solar09"

solarTable[#solarTable + 1] = solar09
solar010 = piece "solar010"

solarTable[#solarTable + 1] = solar010
solar011 = piece "solar011"

solarTable[#solarTable + 1] = solar011
solar012 = piece "solar012"

solarTable[#solarTable + 1] = solar012


solar013 = piece "solar013"

solarTable[#solarTable + 1] = solar013
solar014 = piece "solar014"

solarTable[#solarTable + 1] = solar014
solar015 = piece "solar015"

solarTable[#solarTable + 1] = solar015
solar016 = piece "solar016"

solarTable[#solarTable + 1] = solar016

piecesTable = {}
center = piece "center"

piecesTable[#piecesTable + 1] = center
jinfcraddle = piece "jinfcraddle"

piecesTable[#piecesTable + 1] = jinfcraddle
Circle081 = piece "Circle081"

piecesTable[#piecesTable + 1] = Circle081
Object009 = piece "Object009"

piecesTable[#piecesTable + 1] = Object009
Object004 = piece "Object004"

piecesTable[#piecesTable + 1] = Object004
Object001 = piece "Object001"

piecesTable[#piecesTable + 1] = Object001
Circle082 = piece "Circle082"

piecesTable[#piecesTable + 1] = Circle082
Object010 = piece "Object010"

piecesTable[#piecesTable + 1] = Object010
Object011 = piece "Object011"

piecesTable[#piecesTable + 1] = Object011
Object012 = piece "Object012"

piecesTable[#piecesTable + 1] = Object012
Line007 = piece "Line007"

piecesTable[#piecesTable + 1] = Line007
Line013 = piece "Line013"

piecesTable[#piecesTable + 1] = Line013

Egg = piece "Egg"

piecesTable[#piecesTable + 1] = Egg
Jet1 = piece "Jet1"

piecesTable[#piecesTable + 1] = Jet1
Jet2 = piece "Jet2"

piecesTable[#piecesTable + 1] = Jet2
Line040 = piece "Line040"

piecesTable[#piecesTable + 1] = Line040
Line041 = piece "Line041"

piecesTable[#piecesTable + 1] = Line041

solar03 = piece "solar03"

piecesTable[#piecesTable + 1] = solar03
solar04 = piece "solar04"

piecesTable[#piecesTable + 1] = solar04
solar01 = piece "solar01"

piecesTable[#piecesTable + 1] = solar01
solar02 = piece "solar02"

piecesTable[#piecesTable + 1] = solar02
Line039 = piece "Line039"

piecesTable[#piecesTable + 1] = Line039
solar05 = piece "solar05"

piecesTable[#piecesTable + 1] = solar05
solar06 = piece "solar06"

piecesTable[#piecesTable + 1] = solar06
solar07 = piece "solar07"

piecesTable[#piecesTable + 1] = solar07
solar08 = piece "solar08"

piecesTable[#piecesTable + 1] = solar08

solar09 = piece "solar09"

piecesTable[#piecesTable + 1] = solar09
solar010 = piece "solar010"

piecesTable[#piecesTable + 1] = solar010
solar011 = piece "solar011"

piecesTable[#piecesTable + 1] = solar011
solar012 = piece "solar012"

piecesTable[#piecesTable + 1] = solar012


solar013 = piece "solar013"

piecesTable[#piecesTable + 1] = solar013
solar014 = piece "solar014"

piecesTable[#piecesTable + 1] = solar014
solar015 = piece "solar015"

piecesTable[#piecesTable + 1] = solar015
solar016 = piece "solar016"

piecesTable[#piecesTable + 1] = solar016

navel = piece "navel"

Line042 = piece "Line042"

piecesTable[#piecesTable + 1] = Line042

piecesTable[#piecesTable + 1] = navel
SIG_FOLD = 2
SIG_UNFOLD = 4
emitIt = {}
for i = 1, 9, 1 do
    emitIt[i] = {}
    stone = "nano" .. i
    emitIt[i] = piece(stone)
end

buildspot = Egg
function script.Create()
    Spring.SetUnitNanoPieces(unitID, emitIt)
    StartThread(keepAtSeaLevel)
    StartThread(stateChanger)
    StartThread(buildLoop)
end

function script.Killed(recentDamage, _)

    createCorpseJBuilding(unitID, recentDamage)
    return 1
end


function keepAtSeaLevel()

    while true do
        x, y, z = Spring.GetUnitPiecePosDir(unitID, center)
        speed = math.max(math.abs(y) / 3, 0.1)
        Move(center, y_axis, y * -1 + 80, speed)
        Sleep(1000)
    end
end

function createEgg(buildspot)
    --Animation
    teamid = Spring.GetUnitTeam(unitID)
    x, y, z = Spring.GetUnitPiecePosDir(unitID, buildspot)
    id = Spring.CreateUnit("jspacebornembryo", x, y, z, 1, teamid)
    Spring.AttachUnit(unitID, id, Egg)
    return id
end

function build(buildID)

    health, maxHealth, paralyzeDamage, captureProgress, buildProgress = Spring.GetUnitHealth(buildID)
    eggID = createEgg(buildspot)
    Spring.SetUnitAlwaysVisible(buildID, false)

    while Spring.ValidUnitID(buildID) == true and Spring.GetUnitIsDead(buildID) == false and buildProgress < 1.0 do
        health, maxHealth, paralyzeDamage, captureProgress, buildProgress = Spring.GetUnitHealth(buildID)

        hp = math.max(1, math.ceil(buildProgress * 100))
        if Spring.GetUnitIsDead(eggID) == true then
            eggID = createConcon(buildspot)
        end
        Spring.SetUnitHealth(eggID, hp)


        Sleep(100)
    end
    Spring.SetUnitAlwaysVisible(buildID, true)
    Spring.DestroyUnit(concoonID, true, false)
end

function buildLoop()

    while true do
        buildID = Spring.GetUnitIsBuilding(unitID)

        if builID then
            build(builID)
        end
        Sleep(500)
    end
end

boolMovementInProgress = false
function fold(speed)
    Signal(SIG_FOLD)
    SetSignalMask(SIG_FOLD)
    boolMovementInProgress = true
    Turn(Circle081, x_axis, math.rad(-90), speed)
    WTurn(Circle082, x_axis, math.rad(90), speed)
    hideT(solarTable)
    Turn(Line041, x_axis, math.rad(-76), speed)
    Turn(Line042, x_axis, math.rad(76), speed)
    Turn(Line039, x_axis, math.rad(58), speed)
    Turn(Line013, x_axis, math.rad(-58), speed)

    Turn(Line040, z_axis, math.rad(95), speed)
    WTurn(Line007, z_axis, math.rad(-95), speed)
    boolMovementInProgress = false
end

function unfold(speed)

    Signal(SIG_UNFOLD)
    SetSignalMask(SIG_UNFOLD)
    boolMovementInProgress = true
    Turn(Line040, z_axis, math.rad(0), speed)
    WTurn(Line007, z_axis, math.rad(0), speed)

    Turn(Line041, x_axis, math.rad(0), speed)
    Turn(Line042, x_axis, math.rad(0), speed)
    Turn(Line039, x_axis, math.rad(0), speed)
    WTurn(Line013, x_axis, math.rad(0), speed)

    showT(solarTable)
    Turn(Circle081, x_axis, math.rad(0), speed)
    WTurn(Circle082, x_axis, math.rad(0), speed)

    boolMovementInProgress = false
end

boolUnfold = true
boolOldFoldState = false
function stateChanger()
    while true do

        if boolUnfold ~= boolOldFoldState then
            Signal(SIG_FOLD)
            Signal(SIG_UNFOLD)
            if boolUnfold == true then
                StartThread(unfold, 1.75)
            else
                StartThread(fold, 1.75)
            end
            boolUnfold = boolOldFoldState
        end
        Sleep(100)
    end
end

function script.Activate()
    boolUnfold = true
    SetUnitValue(COB.YARD_OPEN, 1)
    SetUnitValue(COB.INBUILDSTANCE, 1)
    SetUnitValue(COB.BUGGER_OFF, 1)
    return 1
end

function script.Deactivate()
    boolUnfold = false
    StartThread(fold, 1.75)
    SetUnitValue(COB.YARD_OPEN, 0)
    SetUnitValue(COB.INBUILDSTANCE, 0)
    SetUnitValue(COB.BUGGER_OFF, 0)
    return 0
end

function script.QueryBuildInfo()
    return buildspot
end

Spring.SetUnitNanoPieces(unitID, { buildspot })