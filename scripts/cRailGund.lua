--RailGundTurretScript

local cRailGTripod = piece "cRailGTripod"
local cRailG = piece "cRailG"
local shotEmit = piece "shotEmit"
local cool1 = piece "cool1"
local cool2 = piece "cool2"
local cool3 = piece "cool3"
local range = 650

emitArray = {}
local cSparkEmit11 = piece "cSparkEmit11"
table.insert(emitArray, 1, cSparkEmit11)
local cSparkEmit12 = piece "cSparkEmit12"
table.insert(emitArray, 2, cSparkEmit12)
local cSparkEmit21 = piece "cSparkEmit21"
table.insert(emitArray, 3, cSparkEmit21)
local cSparkEmit22 = piece "cSparkEmit22"
table.insert(emitArray, 4, cSparkEmit22)
local cSparkEmit31 = piece "cSparkEmit31"
table.insert(emitArray, 5, cSparkEmit31)
local cSparkEmit32 = piece "cSparkEmit32"
table.insert(emitArray, 6, cSparkEmit32)
local cSparkEmit41 = piece "cSparkEmit41"
table.insert(emitArray, 7, cSparkEmit41)
local cSparkEmit42 = piece "cSparkEmit42"
table.insert(emitArray, 8, cSparkEmit42)
local cSparkEmit51 = piece "cSparkEmit51"
table.insert(emitArray, 9, cSparkEmit51)
local cSparkEmit52 = piece "cSparkEmit52"
table.insert(emitArray, 10, cSparkEmit52)
local cSparkEmit61 = piece "cSparkEmit61"
table.insert(emitArray, 11, cSparkEmit61)
local cSparkEmit62 = piece "cSparkEmit62"
table.insert(emitArray, 12, cSparkEmit62)
local cSparkEmit71 = piece "cSparkEmit71"
table.insert(emitArray, 13, cSparkEmit71)
local cSparkEmit72 = piece "cSparkEmit72"
table.insert(emitArray, 14, cSparkEmit72)
local cSparkEmit81 = piece "cSparkEmit81"
table.insert(emitArray, 15, cSparkEmit81)
local cSparkEmit82 = piece "cSparkEmit82"
table.insert(emitArray, 16, cSparkEmit82)
local cSparkEmit91 = piece "cSparkEmit91"
table.insert(emitArray, 17, cSparkEmit91)
local cSparkEmit92 = piece "cSparkEmit92"
table.insert(emitArray, 18, cSparkEmit92)
nrOfParticles = 4

local gHeading = 0
local gPitch = 0
local elementsInTable = 0
local boolRailGunTerraForm = false

particleTable = {}
for x = 1, nrOfParticles, 1 do
    partTesticle = {}
    for i = 1, 4, 1 do
        tempString = "particle" .. x
        tempString = tempString .. i
        tempPiece = piece(tempString)
        table.insert(partTesticle, i, tempPiece)
    end
    table.insert(particleTable, x, partTesticle)
end
local unitPosX = 0
local unitPosY = 0
local unitPosZ = 0
unitPosX, unitPosY, unitPosZ = Spring.GetUnitPosition(unitID)
local boolReload = true

--This table stores the points that are yet to be terraformed. it does this as a Array[i] were the first value represents the x, the second the z, and the third the y coord.
local terraFormTable = {}
--function: get line



--function: CaveInLoop



function sparkEmit()
    for a = 1, 17, 2 do

        EmitSfx(emitArray[a], 1026)

        EmitSfx(emitArray[a + 1], 1026)
        Sleep(122)
    end

    return
end


function addShotIntersectedPoints()
    --calculate the equation of the line

    slope = math.tan(math.deg(gHeading))

    --Spring.Echo("AddingaPoint",slope)

    x, z, zOfOld = 0
    for i = 15, range, 1 do
        --calc point
        x = i + unitPosX
        z = (slope * x) + unitPosZ
        --modulu -if != yOfOld
        if zOfOld ~= (z - (z % 1)) then
            --getHeight add set point if height > unitPosX
            y = Spring.GetGroundHeight(x, z)
            if y > unitPosY then
                tempTable = {}
                --add unitPosition
                tempTable[1] = x
                tempTable[2] = z
                tempTable[3] = y
                table.insert(terraFormTable, elementsInTable + 1, tempTable)
                elementsInTable = elementsInTable + 1

                --yOfOld =y
            end
            zOfOld = z
        end
    end
end





--get the terraininfo along the line











--- AIMING & SHOOTING---
----------------------------------------- WEAPON ONE ----------------------------
function script.AimFromWeapon1()
    return shotEmit
end

function script.QueryWeapon1()
    return shotEmit
end

function pitchInRange(pitch)
    if pitch > 12 then
        return false
    end
    if pitch < -12 then
        return false
    end
    return true
end

function script.AimWeapon1(heading, pitch)
    if boolReload == true and pitchInRange(pitch) then

        Turn(cRailG, y_axis, heading, 0.4)
        Turn(cRailG, x_axis, -pitch, 1.3)
        WaitForTurn(cRailG, y_axis)
        WaitForTurn(cRailG, x_axis)
        Spring.PlaySoundFile("sounds/cRailgun/railGun.wav")
        sparkEmit()
        gHeading = heading
        gPitch = pitch


        return true
    else
        Turn(cRailG, y_axis, heading, 0.4)
        --Turn(cRailG,x_axis, - pitch, 1.3)


        return false
    end
end


function waitThread()
    Sleep(12000)
    boolReload = true
end

function itsCoolMan()
    for i = 0, 12, 1 do
        EmitSfx(cool1, 1027)
        EmitSfx(cool2, 1027)
        EmitSfx(cool3, 1027)
        Sleep(100)
    end
end

function script.FireWeapon1()
    boolReload = false
    StartThread(waitThread)
    if boolRailGunTerraForm == true then
        addShotIntersectedPoints()
    end
    Sleep(800)
    Spring.PlaySoundFile("sounds/cRailgun/railGunReCharge.wav")
    StartThread(itsCoolMan)
end

function script.Create()
    --<buildanimationscript>
    x, y, z = Spring.GetUnitPosition(unitID)
    teamID = Spring.GetUnitTeam(unitID)
    GG.UnitsToSpawn:PushCreateUnit("cbuildanimation", x, y, z, 0, teamID)

    --</buildanimationscript>

    for x = 1, nrOfParticles, 1 do
        for i = 1, 4, 1 do
            Hide(particleTable[x][i])
        end
    end
    unitPosX, unitPosY, unitPosZ = Spring.GetUnitPosition(unitID)
end


function script.Killed(recentDamage, maxHealth)
    Explode(cRailGTripod, SFX.FIRE + SFX.FALL)
    Explode(cRailG, SFX.FIRE + SFX.FALL)
    Spring.PlaySoundFile("sounds/cHopper/detonation.wav")
    return 1
end