include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

piecesTable = {}
FlokCenter = piece "FlokCenter"
piecesTable[#piecesTable + 1] = FlokCenter
aimpiece= FlokCenter

bigRot1 = piece "bigRot1"
piecesTable[#piecesTable + 1] = bigRot1
smallRot1 = piece "smallRot1"
piecesTable[#piecesTable + 1] = smallRot1
cent1 = piece "cent1"
piecesTable[#piecesTable + 1] = cent1
Fly1 = piece "Fly1"
piecesTable[#piecesTable + 1] = Fly1
LW1 = piece "LW1"
piecesTable[#piecesTable + 1] = LW1
RW1 = piece "RW1"
piecesTable[#piecesTable + 1] = RW1
Land1 = piece "Land1"
piecesTable[#piecesTable + 1] = Land1
L11 = piece "L11"
piecesTable[#piecesTable + 1] = L11
L12 = piece "L12"
piecesTable[#piecesTable + 1] = L12
bigRot2 = piece "bigRot2"
piecesTable[#piecesTable + 1] = bigRot2
smallRot2 = piece "smallRot2"
piecesTable[#piecesTable + 1] = smallRot2
cent2 = piece "cent2"
piecesTable[#piecesTable + 1] = cent2
Fly2 = piece "Fly2"
piecesTable[#piecesTable + 1] = Fly2
LW2 = piece "LW2"
piecesTable[#piecesTable + 1] = LW2
RW2 = piece "RW2"
piecesTable[#piecesTable + 1] = RW2
Land2 = piece "Land2"
piecesTable[#piecesTable + 1] = Land2
L21 = piece "L21"
piecesTable[#piecesTable + 1] = L21
L22 = piece "L22"
piecesTable[#piecesTable + 1] = L22
bigRot3 = piece "bigRot3"
piecesTable[#piecesTable + 1] = bigRot3
smallRot3 = piece "smallRot3"
piecesTable[#piecesTable + 1] = smallRot3
cent3 = piece "cent3"
piecesTable[#piecesTable + 1] = cent3
Fly3 = piece "Fly3"
piecesTable[#piecesTable + 1] = Fly3
LW3 = piece "LW3"
piecesTable[#piecesTable + 1] = LW3
RW3 = piece "RW3"
piecesTable[#piecesTable + 1] = RW3
Land3 = piece "Land3"
piecesTable[#piecesTable + 1] = Land3
L31 = piece "L31"
piecesTable[#piecesTable + 1] = L31
L32 = piece "L32"
piecesTable[#piecesTable + 1] = L32
bigRot4 = piece "bigRot4"
piecesTable[#piecesTable + 1] = bigRot4
smallRot4 = piece "smallRot4"
piecesTable[#piecesTable + 1] = smallRot4
cent4 = piece "cent4"
piecesTable[#piecesTable + 1] = cent4
Fly4 = piece "Fly4"
piecesTable[#piecesTable + 1] = Fly4
LW4 = piece "LW4"
piecesTable[#piecesTable + 1] = LW4
RW4 = piece "RW4"
piecesTable[#piecesTable + 1] = RW4
Land4 = piece "Land4"
piecesTable[#piecesTable + 1] = Land4
L41 = piece "L41"
piecesTable[#piecesTable + 1] = L41
L42 = piece "L42"
piecesTable[#piecesTable + 1] = L42

--Bird, Bird, Bird is the word
local Birds = {}
local numberOfBirds = 7
for i = 1, numberOfBirds, 1 do
    t = "Land" .. i
    LandPiece = piece(t)
    t = "L" .. i .. "1"
    LFoot = piece(t)
    t = "L" .. i .. "2"
    RFoot = piece(t)
    Hand = {
        [1] = LandPiece,
        [2] = LFoot,
        [3] = RFoot
    }
    t = "Fly" .. i
    AirPiece = piece(t)
    t = "RW" .. i
    LWing = piece(t)
    t = "LW" .. i
    RWing = piece(t)

    hAir = {
        [1] = AirPiece,
        [2] = LWing,
        [3] = RWing
    }
    t = "cent" .. i
    Center = piece(t)
    t = "smallRot" .. i
    smallRot = piece(t)
    t = "bigRot" .. i
    bigRot = piece(t)

    Birds[i] = {
        Land = Hand,
        Air = hAir,
        Center = Center,
        sRot = smallRot,
        bRot = bigRot,
        boolAnimating = false,
        boolFlying = false,
        boolStillActive = true
    }
end

function HideBird(nr)
    Hide(Birds[nr].Air[1])
    Hide(Birds[nr].Air[2])
    Hide(Birds[nr].Air[3])

    Hide(Birds[nr].Land[1])
    Hide(Birds[nr].Land[2])
    Hide(Birds[nr].Land[3])
end

teamid = Spring.GetUnitTeam(unitID)

function showLand(nr)
    if Birds[nr].boolStillActive == true then
        Show(Birds[nr].Land[1])
        Show(Birds[nr].Land[2])
        Show(Birds[nr].Land[3])
        Hide(Birds[nr].Air[1])
        Hide(Birds[nr].Air[2])
        Hide(Birds[nr].Air[3])
    end
end

function constantTestClap()

    showAir(2)
    while true do

        mrval = math.random(-15, -5)
        prval = math.random(12, 22)
        ClapWings(2, mrval, 0.9, prval, 82, true)
        Sleep(3000)
    end
end

function showAir(nr)
    if Birds[nr].boolStillActive == true then
        Hide(Birds[nr].Land[1])
        Hide(Birds[nr].Land[2])
        Hide(Birds[nr].Land[3])
        Show(Birds[nr].Air[1])
        Show(Birds[nr].Air[2])
        Show(Birds[nr].Air[3])
    end
end

local SIG_ENERGY = 1
local SIG_METAL = 2
local SIG_LAND = 4
local SIG_AIR = 8
local SIG_WING1 = 16
local SIG_WING2 = 32
local SIG_WING3 = 64
local SIG_WING4 = 128

local boolStationary = true

function consumeEnergy()
    SetSignalMask(SIG_ENERGY)
    Signal(SIG_METAL)
    while true do
        Sleep(1000)
        Spring.UseTeamResource(teamid, "energy", 5)
    end
end

function produceMetall()
    SetSignalMask(SIG_METAL)
    Signal(SIG_ENERGY)
    while true do
        Sleep(5000)
        Spring.AddTeamResource(teamid, "metal", 1)
    end
end

function posBools()
    ox, oy, oz = Spring.GetUnitPosition(unitID)
    x, y, z = ox, oy, oz
    local spGetUnitPos = Spring.GetUnitPosition
    local spGetUnitPiecePosDir = Spring.GetUnitPiecePosDir
    while true do
        x, y, z = spGetUnitPos(unitID)
        if (math.abs(math.abs(ox - x) + math.abs(oy - y) + math.abs(oz - z)) < 10) then
            boolStationary = true
        else
            boolStationary = false
        end

        for i = 1, numberOfBirds, 1 do
            px, py, pz, _, _, _ = spGetUnitPiecePosDir(unitID, Birds[i].Air[1])
            h = Spring.GetGroundHeight(px, pz)
            if (py - h > 21) then
                Birds[i].boolFlying = true
            else
                Birds[i].boolFlying = false
            end
        end

        ox, oy, oz = x, y, z
        Sleep(200)
    end
end


_, baseHealth = Spring.GetUnitHealth(unitID)
quater = math.ceil(baseHealth / 4)
half = math.ceil(baseHealth / (numberOfBirds/2))

thirthyfour = baseHealth * 0.75
aerodynamicHoles = baseHealth / 12
nextBigBarrier = baseHealth
Barriers = {
    [1] = quater,
    [2] = half,
    [3] = thirthyfour,
    [4] = baseHealth,
}
function BirdDropping(nr)
    Birds[nr].boolStillActive = false
    HideBird(nr)
    Explode(Birds[nr].Land[1], SFX.FALL + SFX.NO_HEATCLOUD)
    EmitSfx(Birds[nr].Land[1], 1025)
    EmitSfx(Birds[nr].Land[1], 1024)
    EmitSfx(Birds[nr].Land[1], 1024)
end


leftBirds= numberOfBirds
function script.HitByWeapon(x, z, weaponDefID, damage)
    hp,maxHp = Spring.GetUnitHealth(unitID)
	futureHP= hp - damage
	futureHP= math.max((futureHP/maxHp)*numberOfBirds,2)
	leftBirds= futureHP
    if hp and damage and futureHP then
		for hideIndex= numberOfBirds, futureHP do
			if Birds[hideIndex].boolStillActive== true then
		        StartThread(BirdDropping, hideIndex)
			end
		end
    end

    return damage
end

function birdOS(nr)

    while true do
        --idling
        if nr == 1 then StartThread(produceMetall) end
        idle(nr)

        --Starting
        if nr == 1 then StartThread(consumeEnergy) end
        Starting(nr)
        --Flying

        Fly(nr)
        --Landing
        Landing(nr)
        Sleep(150)
    end
end

function Starting(nr)
    LiftOff(nr)
    showAir(nr)
end

function script.Activate()
    return 1
end

function script.Deactivate()
    return 0
end

function Fly(nr)

    Sleep(150)

    while Birds[nr].boolFlying == true do
        mrval = math.random(-15, -5)
        prval = math.random(12, 22)
        ClapWings(nr, prval, 1, mrval, 1, true)
        Turn(Birds[nr].Air[2], z_axis, math.rad(0), 0.9)
        Turn(Birds[nr].Air[3], z_axis, math.rad(0), 0.9)
        Sleep(900)
    end
    --ReAlign(nr,false)
end



function script.StartMoving()
end

function script.StopMoving()
end


function ClapWings(nr, degreeEnd, Speed, degreeStart)




    Move(Birds[nr].Air[1], y_axis, -3, 1.8)

    -- if degreeStart then
    --UpStage
    Turn(Birds[nr].Air[2], z_axis, math.rad(degreeStart), Speed)
    Turn(Birds[nr].Air[3], z_axis, math.rad(-360 - degreeStart), Speed)
    WaitForTurn(Birds[nr].Air[2], z_axis)
    WaitForTurn(Birds[nr].Air[3], z_axis)

    Move(Birds[nr].Air[1], y_axis, 0, 1)
    -- end
    -- Move(Birds[nr].Air[1],y_axis,3.5,1)

    Turn(Birds[nr].Air[2], z_axis, math.rad(degreeEnd), Speed)
    Turn(Birds[nr].Air[3], z_axis, math.rad(360 - degreeEnd), Speed)
    WaitForTurn(Birds[nr].Air[2], z_axis)
    WaitForTurn(Birds[nr].Air[3], z_axis)
end

function LandingAnimation(nr)
    if Birds[nr].boolStillActive == true then
        if Birds[nr].boolAnimating == true then return else Birds[nr].boolAnimating = true end
        Show(Birds[nr].Land[1])
        Show(Birds[nr].Land[2])
        Show(Birds[nr].Land[3])
        Hide(Birds[nr].Air[1])
        Turn(Birds[nr].Land[3], x_axis, math.rad(60), 3)
        Turn(Birds[nr].Land[2], x_axis, math.rad(60), 3)
        Turn(Birds[nr].Land[1], x_axis, math.rad(-60), 3)
        Turn(Birds[nr].Air[1], x_axis, math.rad(-60), 3)


        for i = 1, 10, 1 do
            ClapWings(nr, (9 - i) * 10, 5000 - i * 3, (9 - i) * -10)
        end
        Turn(Birds[nr].Air[1], x_axis, math.rad(0), 3)
        showLand(nr)

        Birds[nr].boolAnimating = false
    end
end

function Landing(i)

    Sleep(350)

    while Birds[i].boolFlying == true do
        Sleep(200)
    end

    LandingAnimation(i)
end

local unitdef = Spring.GetUnitDefID(unitID)
function LiftOff(nr)
    PlaySoundByUnitDefID(unitdef, "sounds/jwatchbird/Raven.ogg", 1, 2000, 2)

    if Birds[nr].boolStillActive == true then
        Turn(Birds[nr].Land[3], x_axis, math.rad(60), 3)
        Turn(Birds[nr].Land[2], x_axis, math.rad(60), 3)
        Turn(Birds[nr].Air[1], x_axis, math.rad(-60), 3)
        Turn(Birds[nr].Land[1], x_axis, math.rad(-60), 3)
        Turn(Birds[nr].Land[1], y_axis, math.rad(0), 25)
        Show(Birds[nr].Air[2])
        Show(Birds[nr].Air[3])

        for i = 1, 10, 1 do
            ClapWings(nr, 90 - i * 7, math.min(120, i * 15), -90 - (i * -7))
        end
        Turn(Birds[nr].Air[1], x_axis, math.rad(0), 3)
    end
end

function idle(nr)
    while boolStationary == true and Birds[nr].boolFlying == false do


        Turn(Birds[nr].Land[3], x_axis, math.rad(-45), 4)
        Turn(Birds[nr].Land[2], x_axis, math.rad(-45), 4)
        Turn(Birds[nr].Land[1], x_axis, math.rad(45), 4)
        if boolStationary == true and Birds[nr].boolFlying == false then
            Sleep(800)
        end
        Turn(Birds[nr].Land[3], x_axis, math.rad(25), 2)
        Turn(Birds[nr].Land[2], x_axis, math.rad(25), 2)
        Turn(Birds[nr].Land[1], x_axis, math.rad(-25), 2)
        if boolStationary == true and Birds[nr].boolFlying == false then
            Sleep(700)
        end
        Turn(Birds[nr].Land[3], x_axis, math.rad(0), 0.5)
        Turn(Birds[nr].Land[2], x_axis, math.rad(0), 0.5)
        Turn(Birds[nr].Land[1], x_axis, math.rad(0), 0.5)

        d = math.random(0, 360)
        Turn(Birds[nr].Land[1], y_axis, math.rad(d), 2)
        WaitForTurn(Birds[nr].Land[1], y_axis)
        x = math.random(0, 600)
        while boolStationary == true and Birds[nr].boolFlying == false and x < 5000 do
            Sleep(100)
            x = x + 100
        end
    end
end

function recoverInWater()
	while true  do
	Sleep(3000)
		if boolFlying == false then
		x,y,z= Spring.GetUnitPosition(unitID)

			if y < 0 then 
				for nr =1, numberOfBirds do
				  if   Birds[nr].boolStillActive == false then
					leftBirds=leftBirds+1
					Birds[nr].boolStillActive = true 
					showLand(nr)
					break
				  end  
				end
			end
		end
	end
end


function ReAlign(i, boolOnTheFly)
    StopSpin(Birds[i].bRot, y_axis)
    StopSpin(Birds[i].sRot, y_axis)
    Speed = 3.3
    if boolOnTheFly and boolOnTheFly == false then
        Speed = 1.2
    end
    _, ry, _ = Spring.UnitScript.GetPieceRotation(Birds[i].sRot)
    _, by, _ = Spring.UnitScript.GetPieceRotation(Birds[i].bRot)


    if by and (math.deg(by) + 360) % 360 > 180 then
        Turn(Birds[i].bRot, y_axis, math.rad(0), Speed)
    else
        Turn(Birds[i].bRot, y_axis, math.rad(179), Speed)
        WaitForTurn(Birds[i].bRot, y_axis)
        Turn(Birds[i].bRot, y_axis, math.rad(181), Speed)
        WaitForTurn(Birds[i].bRot, y_axis)
        Turn(Birds[i].bRot, y_axis, math.rad(360), Speed)
        WaitForTurn(Birds[i].bRot, y_axis)
    end

    if ry and (math.deg(ry) + 360) % 360 > 180 then
        Turn(Birds[i].sRot, y_axis, math.rad(0), Speed)
    else
        Turn(Birds[i].sRot, y_axis, math.rad(179), Speed)
        WaitForTurn(Birds[i].sRot, y_axis)
        Turn(Birds[i].sRot, y_axis, math.rad(181), Speed)
        WaitForTurn(Birds[i].sRot, y_axis)
        Turn(Birds[i].sRot, y_axis, math.rad(0), Speed)
        WaitForTurn(Birds[i].sRot, y_axis)
    end
end

function script.Create()
    for i = 1, #piecesTable, 1 do
        Hide(piecesTable[i])
    end
    for i = 1, #Birds, 1 do
        showLand(i)
    end

    StartThread(posBools)
    StartThread(thisShitWontFly)
    StartThread(recoverInWater)
    for i = 1, numberOfBirds, 1 do
        StartThread(birdOS, i)
    end
end

function thisShitWontFly()
    local defid = Spring.GetUnitDefID(unitID)

    while true do

        while boolOnTheFly == true do
            x, y, z = spGetUnitPos(unitID)
            ed = spGetUnitNearestEnemy(unitID)
            if ed then
                ex, ey, ez = spGetUnitPos(ed)
                ex, ey, ez = ex - x, ey - y, ez - z
                dist = math.sqrt(ex * ex + ey * ey + ez * ez)
                if dist < 1024 then PlaySoundByUnitDefID(defid, "sounds/jwatchbird/Falcon.wav", 1.0, 20000, 2) end
            end
            Sleep(1000)
        end
        Sleep(1000)
    end
end

function script.Killed()

    return 1
end



--- -aimining & fire weapon 
function script.AimFromWeapon1()
    return aimpiece
end

function script.QueryWeapon1()
    return aimpiece
end



function script.AimWeapon1(Heading, pitch)

	return leftBirds > 1
end

function script.FireWeapon1()

	 for i = numberOfBirds, 2,-1 do
		if birds[i].boolStillActive== true then
			leftBirds= leftBirds-1
			birds[i].boolStillActive=false
			HideBird(i)
			break
		end
    end
    return true
end