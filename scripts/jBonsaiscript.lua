include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

function script.HitByWeapon(x, z, weaponDefID, damage)
    return damage
end

center = piece "center"
Tree22 = piece "Tree22"
wheelPivot = piece "wheelPivot"
waterwheel = piece "waterwheel"
WaterPlan0 = piece "WaterPlan0"
WaterPlane = piece "WaterPlane"
DryBasin = piece "DryBasin"
BasinFarnDry = piece "BasinFarnDry"
Basin = piece "Basin"
BasinFarn = piece "BasinFarn"
FlucWheel = piece "FlucWheel"
foamsphere1 = piece "foamsphere1"
foamsphere2 = piece "foamsphere2"
foamsphere3 = piece "foamsphere3"
rooftop = piece "rooftop"
spherespin = piece "spherespin"

g_AddOnRate = 0.005
roofPieceTable = {}

rval = function()
    val = math.random(-35, 35)
    if val == 0 then return 42 end
    return val
end

function emitSound()
    unitDefID = Spring.GetUnitDefID(unitID)
    while true do

        while boolWaterSpilling == true do
            modulation = math.random(0.5, 1)
            StartThread(PlaySoundByUnitDefID, unitDefID, "sounds/jBonsai/jBonsaiWater.ogg", modulation, 7500, 1)

            Sleep(50)
        end
        Sleep(150)
    end
end

function foamspheres()
    yval = math.random(-5, -0.5)
    Move(foamsphere1, y_axis, yval, 2.95)
    yval = math.random(-5, -0.5)
    Move(foamsphere2, y_axis, yval, 2.95)
    yval = math.random(-5, -0.5)
    Move(foamsphere3, y_axis, yval, 2.95)

    Spin(spherespin, y_axis, rval() / math.random(1, 10), 0)
    Spin(foamsphere3, z_axis, rval(), 0)
    Spin(foamsphere2, z_axis, rval(), 0)
    Spin(foamsphere1, z_axis, rval(), 0)
    Spin(foamsphere3, y_axis, rval(), 0)
    Spin(foamsphere2, y_axis, rval(), 0)
    Spin(foamsphere1, y_axis, rval(), 0)
end

SIG_WATER = 2
boolWaterWheelDone = false
function waterWheel()
    boolWaterWheelDone = false
    showWaterWheels()
    Spin(FlucWheel, z_axis, math.rad(-65), 0)
    Spin(waterwheel, z_axis, math.rad(-65), 0)

    StartThread(circulOS, TablesOfPiecesGroups["WatWhe"], wheelPivot, z_axis, -65, 10, 3, "waterWheel" .. unitID)



    while boolWaterSpilling == true do
        foamspheres()

        val = math.random(-75, 75)
        Spin(WaterPlan0, y_axis, math.rad(val), 0)
        val = math.random(-75, 75)
        Spin(WaterPlane, y_axis, math.rad(val), 0)
        speed = math.random(7, 12.5) / 10
        Move(WaterPlan0, y_axis, -1.5, speed)
        Move(WaterPlane, y_axis, -1.5, speed)

        Sleep(2000)
        speed = math.random(7, 12.5) / 10
        if math.random(0, 1) == 1 then
            Show(WaterPlan0)
            Hide(WaterPlane)

            Move(WaterPlan0, y_axis, 0.5, speed)

        else
            Hide(WaterPlan0)
            Show(WaterPlane)
            Move(WaterPlane, y_axis, 0.5, speed)
        end

        Sleep(2000)
    end
    GG.OsKeys["waterWheel" .. unitID] = false
    hideWaterWheels()
    while GG.OsKeys["waterWheel" .. unitID] == false do
        Sleep(100)
    end
    boolWaterWheelDone = true
end

basinpillar = piece "basinpillar"
Basin = piece "Basin"

function showWaterWheels()
    Hide(DryBasin)
    Hide(BasinFarnDry)
    Show(BasinFarn)
    Show(Basin)
	 process(TablesOfPiecesGroups["Tree"],
			function(id) 
				StartThread(delayedShow, id, math.random(500, 3500))
			end
			)
    Sleep(500)
    Show(waterwheel)
    Show(WaterPlan0)
    Show(WaterPlane)
    Show(waterwheel)
    if maRa() == true then Show(FlucWheel) end
    Show(foamsphere1)
    Show(foamsphere2)
    Show(foamsphere3)
end

function hideWaterWheels()
    hideT(TablesOfPiecesGroups["WatWhe"])
    Hide(waterwheel)

    Hide(FlucWheel)
    Hide(foamsphere1)
    Hide(foamsphere2)
    Hide(foamsphere3)
	 process(TablesOfPiecesGroups["Tree"],
			function(id) 
				StartThread(delayedHide, id, math.random(500,3500))
			end
			)
    Hide(waterwheel)
    Hide(Basin)
    Show(DryBasin)
    Sleep(550)
    Hide(WaterPlan0)
    Hide(WaterPlane)

    Show(BasinFarnDry)
    Hide(BasinFarn)
end

boolWaterSpilling = true

bonsaiPieces = {}
endPieces = {}
baseShapeTable = {}
Piece_EndPieceMap = {}



function script.Create()
    allreadyInsertedPieces = {}
    --generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
    resetT(TablesOfPiecesGroups["bP"])
    resetT(TablesOfPiecesGroups["Tree"])
    hideT(TablesOfPiecesGroups["bP"])
    Turn(center, y_axis, math.rad(0), 0)
    Show(basinpillar)
    reset(wheelPivot)
    reset(FlucWheel)

    for i = 1, 9, 1 do
        for k = 1, 10, 1 do
            if (((i - 1) * 10) + k) < 98 then
                pieceName = "bP" .. (((i - 1) * 10) + k)
                pieceName = piece(pieceName)
                bonsaiPieces[#bonsaiPieces + 1] = { Piece = pieceName }
                --EndPiece
                endPieceName = "E" .. (((i - 1) * 10) + k)
                endPieces[#endPieces + 1] = piece(endPieceName)

                Piece_EndPieceMap[pieceName] = endPieces[#endPieces]
            end
        end
    end
    StartThread(emitSound)
    StartThread(addWaterLvl)

    StartThread(waterWheel)
    StartThread(showWaterWheels)


    sizeX, sizeY, sizeZ = 8, 3, 8
    baseShapeTable = createBaseShapeTable(sizeX, sizeY, sizeZ, 30)

    StartThread(buildBonsai, baseShapeTable, sizeX, sizeZ, sizeY, endPieces)
end

function createBaseShapeTable(sizeX, sizeY, sizeZ, piecenumber)
    overhanglikelihoodMax = math.random(0.1, 1)
    backTracklikelihoodMax = math.random(0.05, 1)
    riftliklihoodmax = math.random(1, 30) / 10 --
    baseRotLikelikhoodMax = math.random(1, 95) / 100 --


    radiusA, radiusB = sizeX / 2, math.random(sizeZ / 8, sizeZ / 2)
    y = 1
    for x = 1, sizeX, 1 do
        for z = 1, sizeZ, 1 do
            if not baseShapeTable[x] then baseShapeTable[x] = {} end
            if not baseShapeTable[x][z] then baseShapeTable[x][z] = {} end
            if not baseShapeTable[x][z][y] then baseShapeTable[x][z][y] = {} end

            baseShapeTable[x][z][y] = true
            if math.sqrt((x - sizeX / 2) ^ 2 + (z - sizeZ / 2) ^ 2) > radiusA then baseShapeTable[x][z][y] = false end
            if dist(x, 0, z, 1, 0, sizeZ) < radiusB then baseShapeTable[x][z][y] = false end

            if baseShapeTable[x][z][y] == true then
                piecenumber = piecenumber - 1
            end
        end
    end


    for y = 2, sizeY, 1 do
        for x = 1, sizeX, 1 do
            for z = 1, sizeZ, 1 do
                if not baseShapeTable[x] then baseShapeTable[x] = {} end
                if not baseShapeTable[x][z] then baseShapeTable[x][z] = {} end
                if not baseShapeTable[x][z][y] then baseShapeTable[x][z][y] = {} end
                baseShapeTable[x][z][y] = false
                --if below is ground
                if baseShapeTable[x][z][y - 1] == true then

                    baseShapeTable[x][z][y] = riftliklihoodmax > math.random(0.1, 1)

                else --nothing below
                    --sidetracking
                    if overhanglikelihoodMax > math.random(0.1, 1) and checksides(baseShapeTable, x, z) == true then
                        baseShapeTable[x][z][y] = true
                        piecenumber = piecenumber - 1
                    end
                    --downtracking
                    yIndex = y - 1
                    while backTracklikelihoodMax > math.random(0.75, 1) and piecenumber > 0 and baseShapeTable[x][z][yIndex] and baseShapeTable[x][z][yIndex] == false do
                        yIndex = yIndex - 1
                        baseShapeTable[x][z][yIndex] = true
                        piecenumber = piecenumber - 1
                    end
                end
            end
        end
    end
    -- printBaseT(baseShapeTable, sizeY, sizeX, sizeZ)
    return baseShapeTable
end

function printBaseT(baseShapeTable, sizeY, sizeX, sizeZ)
    for y = 1, sizeY, 1 do
        echo("==============================================")
        for x = 1, sizeX, 1 do
            line = ""
            for z = 1, sizeZ, 1 do
                t = ""
                if baseShapeTable[x][z][y] == true then t = "T" else t = " " end
                line = line .. t
            end
            echo(line)
        end
        echo("==============================================")
    end
end

function checksides(baseShapeTable, x, z)
    return ((baseShapeTable[x - 1] and baseShapeTable[x - 1][z + 1] and baseShapeTable[x - 1][z + 1] == true) or
            (baseShapeTable[x] and baseShapeTable[x][z + 1] and baseShapeTable[x][z + 1] == true) or
            (baseShapeTable[x + 1] and baseShapeTable[x + 1][z + 1] and baseShapeTable[x + 1][z + 1] == true) or
            (baseShapeTable[x + 1] and baseShapeTable[x + 1][z] and baseShapeTable[x + 1][z] == true) or
            (baseShapeTable[x + 1] and baseShapeTable[x + 1][z - 1] and baseShapeTable[x + 1][z - 1] == true) or
            (baseShapeTable[x] and baseShapeTable[x][z - 1] and baseShapeTable[x][z - 1] == true) or
            (baseShapeTable[x - 1] and baseShapeTable[x - 1][z - 1] and baseShapeTable[x - 1][z - 1] == true))
end

function script.Killed(recentDamage, _)

    createCorpseJBuilding(recentDamage)
    return 1
end

function getClosestDirection(directionTable, i, j)
    dirIndex = 1
    lastDist = math.huge
    for i = 1, #directionTable do
        local dx = directionTable[i]
        if dist(i, dx.x, j, dx.z) < lastDist then dirIndex = i; lastDist = dist(i, dx.x, j, dx.z) end
    end

    return directionTable[dirIndex].direction, directionTable[dirIndex].angular
end

function getHeightGradient(sizeX, sizeZ, maxHeight)
    heightGradient = makeTable(0, sizeX)
    fractionHeight = maxHeight / sizeX
    if math.random(0, 5) == 2 then
        for i = 0, sizeX, 1 do
            heightGradient[i] = i * fractionHeight - 45
        end
    else
        for i = 0, sizeX, 1 do
            heightGradient[sizeX - i] = i * fractionHeight - 45
        end
    end
    return heightGradient
end

allreadyInsertedPieces = {}
function getBonsaiPiece(y, sizeY)

    for j = 1, #bonsaiPieces, 1 do
        v = bonsaiPieces[j]
        if not allreadyInsertedPieces[v.Piece] then
            allreadyInsertedPieces[v.Piece] = true
            _, height, _ = Spring.GetUnitPieceCollisionVolumeData(unitID, v.Piece)
            return v.Piece, height / 2
        end
    end

    return nil
end

function placeLayerPiece(x, z, y, heightGradient)

    --get the heightOffset

    P, _ = getBonsaiPiece(y, sizeY)
    if not P then
        if baseShapeTable[x][z][y - 1] and baseShapeTable[x][z][y - 1] == true and predecessorTable[x][z][y - 1] then
            roofPieceTable[#roofPieceTable + 1] = predecessorTable[x][z][y - 1]
        end

        return
    end

    bx, boldHght, bz = getPieceVolume(P)
    heightOffset = heightGradient[x] + cliffFactor * (math.random(-boldHght / 4, boldHght / 4))

    bonsaiTable[x][z][y] = { Height = heightOffset, BoolGround = true, Piece = P }

    predecessorTable = safeAccessTable(predecessorTable, x, z, y)
    predecessorTable[x][z][y] = Piece_EndPieceMap[P]

    if baseShapeTable[x][z][y] == true and (not baseShapeTable[x][z][y + 1] or baseShapeTable[x][z][y + 1] == false) and Piece_EndPieceMap[P] then
        roofPieceTable[#roofPieceTable + 1] = Piece_EndPieceMap[P]
    end

    Show(P)

    if y == 1 then
        tx, ty, tz = 15 * x, -10 + heightOffset, 15 * z
    else
        tx, ty, tz = 15 * x, y * 25 + math.abs(heightOffset), 15 * z
    end

    --has predecessor
    if baseShapeTable[x][z][y - 1] and predecessorTable[x][z][y - 1] and baseShapeTable[x][z][y - 1] == true then
        tx, ty, tz = Spring.GetUnitPiecePosition(unitID, predecessorTable[x][z][y - 1])
    end
    MovePieceToPos(P, -tx, ty, tz, 0, true)

    --place a bolder a the predecessorpiece
    dir, angular = getClosestDirection(directionTable, x, z)
    dir = dir + math.random(-15, 15)
    --Turn Boulder towards dir
    Turn(P, y_axis, math.rad(dir), 0)
    Turn(P, x_axis, math.rad(angular), 0, true)
    WaitForTurns(P)
end



function getCollissionOffset(piece)
    vx, vy, vz = Spring.GetUnitPieceCollisionVolumeData(unitID, piece)
    px, py, pz = Spring.GetUnitPiecePosition(unitID, piece)

    _, _, _, dx, dy, dz = Spring.GetUnitPiecePosDir(unitID, piece)

    --default it on nil
    px, py, pz = px or 0, py or 0, pz or 0
    vx, vy, vz = vx or 10, vy or 50, vz or 10
    dx, dy, dz = dx or 0, dy or 1, dz or 0

    local vec = makeVector(dx, dy, dz)
    vec = normVector(vec)
    px, py, pz = px + vec.x * vx, py + vec.y * vy, pz + vec.z * vz

    return px, py, pz
end

function initPiece(id, x, y, z, mx, my, mz, speed)
    tP(id, x, y, z, speed)
    Show(id)
    Sleep(1)
end


function makeDrectionTable()
    directionTable = {}
    for i = 1, 3 do
        radoAnguVal = math.random(-40, 40)
        directionTable[i] = {
            x = math.ceil(1, sizeX),
            z = math.ceil(1, sizeZ),
            direction = math.random(0, 360),
            angular = radoAnguVal
        }
    end
    return directionTable
end

function getPieceVolume(PieceID)
    vx, vy, vz = Spring.GetUnitPieceCollisionVolumeData(unitID, PieceID)
    sx, sy, sz = getCollissionOffset(PieceID)
    bx, boldHght, bz = math.max(vx, sz) * 0.75, math.abs(sy - vy), math.abs(vz, sz) * 0.75
    return bx, boldHght, bz
end

bonsaiTable = {}
predecessorTable = {}
directionTable = {}
--bonsaiPieces must be a objecttable containing layers of tables, containing a table with a piece and a Sensory
function buildBonsai(baseShapeTable, sizeX, sizeZ, sizeY)

    --bonsaiTable[x][z][1]={height, BoolGround, piece, Sensory}
    defaultTable = { height = 0, BoolGround = false, Piece = -math.huge }
    bonsaiTable = makeTable(defaultTable, sizeX, sizeZ, sizeY)

    --layers of stone in the bonsai
    numberOfDirections = math.ceil(math.random(1, 3))
    directionTable = makeDrectionTable()
    cliffFactor = math.random(0.01, 0.399)

    maxHeight = math.random(10, 120)
    heightGradient = getHeightGradient(sizeX, sizeZ, maxHeight)


    for y = 1, sizeY, 1 do
        for x = 1, sizeX, 1 do
            for z = 1, sizeZ, 1 do
                if baseShapeTable[x][z][1] == true then

                    placeLayerPiece(x, z, y, heightGradient)
                end
            end
        end
    end

    setBonsai()


	 setTrees()

    setCenter()

end


function setBonsai()
    resetT(TablesOfPiecesGroups["B"], 0)
    WaitForTurns(TablesOfPiecesGroups["B"])
    buildLTree(Tree22, 7, "Bonsai", "B")
    if roofPieceTable[roofPieceToBonsai] then
        movePieceToPiece(unitID, Tree22, roofPieceTable[roofPieceToBonsai], 0)
    else
        Move(Tree22, y_axis, 45, 0)
    end
end

function setTrees()
	allreadyInserted={}
	table.insert(roofPieceTable,rooftop)
    for i = #roofPieceTable, 1, -1 do
        for k, v in pairs((TablesOfPiecesGroups["Tree"])) do
            if math.random(0, 1) == 1 and not allreadyInserted[TablesOfPiecesGroups["Tree"][k]] then
                movePieceToPiece(unitID, v, roofPieceTable[i], 0)
                Show(v)
					  allreadyInserted[TablesOfPiecesGroups["Tree"][k]]=true
                break
            end
        end
    end
end

function setCenter()

    val = math.random(-360, 360)
    Turn(center, y_axis, math.rad(val), 0)
end

function getMapHeightDependantWaterlevel()
    minExtreme, maxExtreme = Spring.GetGroundExtremes()

    if minExtreme - 70 < 0 then
        return 0.0005
    else
        x = math.log(i) / 3
        return math.min(3, math.max(x, 0.0005))
    end
end

function addWaterLvl()
    Sleep(100)
    while (true) do


        g_AddOnRate = getMapHeightDependantWaterlevel()

        if GG.addWaterLevel ~= nil and boolWaterSpilling == true then

            GG.addWaterLevel = GG.addWaterLevel + g_AddOnRate
            Sleep(1000)

        else
            Sleep(1000)
        end
    end
end

function script.Activate()
    if boolWaterWheelDone == true then
        boolWaterSpilling = true
        StartThread(waterWheel)
    end

    return 1
end


function script.Deactivate()
    boolWaterSpilling = false
    return 0
end

--- -aimining & fire weapon
function script.AimFromWeapon1()
    return center
end



function script.QueryWeapon1()
    return center
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return true
end


function script.FireWeapon1()

    return true
end