include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"
include "lib_jw.lua"


center = piece "center"
emitfire = piece "emitfire"
teamID = Spring.GetGaiaTeamID()
sl01 = piece "sl01"
sl02 = piece "sl02"
sl03 = piece "sl03"
base01 = piece "base01"
base02 = piece "base02"
base03 = piece "base03"
corpserotator = piece "corpserotator"

local spCEG = Spring.SpawnCEG

explo = {}
for i = 1, 6, 1 do
    explo[i] = {}
    Emiters = "explo" .. i
    explo[i] = piece(Emiters)
end
empty = {}
for i = 1, 6, 1 do
    empty[i] = {}
    Emiters = "e" .. i
    empty[i] = piece(Emiters)
end



local theflames = {}
fackelrotator = piece "fackelrotator"
fackelcenter = piece "fackelcenter"
fackelmain = piece "fackelmain"
theflames[1] = fackelmain
fackelarm1 = piece "fackelarm"
theflames[2] = fackelarm1
fackelarm2 = piece "fackelarm2"
theflames[3] = fackelarm2
fackelleg1 = piece "fackelleg1"
theflames[4] = fackelleg1
fackelleg2 = piece "fackelleg2"
theflames[5] = fackelleg2
faemit1 = piece "faemit1"
theflames[6] = faemit1

faemit2 = piece "faemit2"
faemit3 = piece "faemit3"
theflames[7] = faemit2
theflames[8] = faemit3
sohotdog = piece "sohotdog"
LifeTime = 300000 -- 5 minutes
mainDebris = {}
for i = 1, 24, 1 do
    mainDebris[i] = {}
    Emiters = "mdB" .. i
    mainDebris[i] = piece(Emiters)
end

schlacke = {}
for i = 1, 21, 1 do
    schlacke[i] = {}
    Emiters = "ausl" .. i
    schlacke[i] = piece(Emiters)
end


debris = {}
for i = 1, 11, 1 do
    debris[i] = {}
    Emiters = "deb" .. i
    debris[i] = piece(Emiters)
end

SIG_DEATH = 32
stmax = 20
function turnEmitorToTheWind()
    dx, dy, dz, strength = Spring.GetWind()
    stmax = math.min(strength, stmax)
    dx = dx * -1
    dz = dz * -1
    dx = dx / (math.abs(dx) + math.abs(dz))
    dz = dz / (math.abs(dx) + math.abs(dz))

    strength = (strength / math.abs(strength)) * ((strength / stmax) * 35)

    Turn(emitfire, x_axis, math.rad(strength), 10)
    degreeToTurn = math.atan2(dx, dz)
    Turn(emitfire, y_axis, math.rad(degreeToTurn), 2.5)
end


function contemplateOrigin()
    boolPositionUnchanged = true
    xo, yo, zo = Spring.GetUnitPosition(unitID)
    while (boolPositionUnchanged == true) do
        x, y, z = Spring.GetUnitPosition(unitID)
        if x ~= xo and z ~= zo then
            boolPositionUnchanged = false
            for i = 1, table.getn(debris), 1 do
                Hide(debris[i])
            end
            Signal(SIG_DEATH)
        end
        Sleep(2000)
    end
end



function onFireUpInHere()
    for i = 1, table.getn(theflames), 1 do
        randoVal = math.random(10, 60)
        Sleep(randoVal)
        EmitSfx(theflames[i], 1029)
        EmitSfx(theflames[i], 1030)
    end
end

function goDieInAFire()
    for i = 1, table.getn(theflames), 1 do
        Hide(theflames[i])
    end
    dice = math.random(0, 7)

    if dice == 7 then
        Spring.PlaySoundFile("sounds/cVehicCorpse/allforthegoodofthecountry.wav")
        for i = 1, table.getn(theflames), 1 do
            Show(theflames[i])
        end
        dirAction = math.random(0, 360)
        dirDistance = math.random(35, 78)
        Turn(fackelrotator, y_axis, math.rad(dirAction), 0)
        Move(fackelcenter, z_axis, dirDistance, 13)
        Turn(fackelmain, x_axis, math.rad(19), 4)
        while (true == Spring.UnitScript.IsInMove(fackelcenter, z_axis)) do

            Sleep(300)
            Turn(fackelmain, x_axis, math.rad(15), 4)
            Turn(sohotdog, y_axis, math.rad(4), 3)
            Turn(fackelleg1, x_axis, math.rad(26), 18)
            Turn(fackelleg2, x_axis, math.rad(-39), 28)
            Turn(fackelarm1, x_axis, math.rad(-43), 32)
            Turn(fackelarm2, x_axis, math.rad(35), 32)
            StartThread(onFireUpInHere)

            Sleep(300)
            Turn(fackelmain, x_axis, math.rad(19), 4)
            Turn(sohotdog, y_axis, math.rad(-4), 3)
            Turn(fackelleg1, x_axis, math.rad(-47), 32)
            Turn(fackelleg2, x_axis, math.rad(13), 12)

            Turn(fackelarm1, x_axis, math.rad(52), 32)
            Turn(fackelarm2, x_axis, math.rad(-25), 32)
            StartThread(onFireUpInHere)
        end
        Turn(fackelcenter, z_axis, math.rad(-93), 45)
        StartThread(onFireUpInHere)
        Move(fackelcenter, y_axis, -3, 0)
        WaitForTurn(fackelcenter, z_axis)
        howlong = math.random(4, 12)
        for i = 1, howlong, 1 do
            StartThread(onFireUpInHere)
            Turn(fackelmain, y_axis, math.rad(62), 16)
            Move(fackelcenter, z_axis, dirDistance + 5, 14)
            Turn(fackelleg1, x_axis, math.rad(-47), 32)
            Turn(fackelleg2, x_axis, math.rad(13), 12)
            randx = math.random(-15, 15)
            Turn(fackelleg1, x_axis, math.rad(randx), 32)
            randx = math.random(-15, 15)
            Turn(fackelleg2, x_axis, math.rad(randx), 12)
            WaitForTurn(fackelmain, y_axis)
            Sleep(150)
            StartThread(onFireUpInHere)
            Turn(fackelmain, y_axis, math.rad(-62), 16)
            Move(fackelcenter, z_axis, dirDistance - 5, 14)
            Turn(fackelleg1, x_axis, math.rad(-47), 32)
            Turn(fackelleg2, x_axis, math.rad(13), 12)
            randx = math.random(-15, 15)
            Turn(fackelleg1, x_axis, math.rad(randx), 32)
            randx = math.random(-15, 15)
            Turn(fackelleg2, x_axis, math.rad(randx), 12)
            WaitForTurn(fackelmain, y_axis)
            Sleep(150)
        end
        for i = 1, table.getn(theflames), 1 do
            randoVal = math.random(10, 60)
            Sleep(randoVal)
            EmitSfx(theflames[i], 1030)
            Hide(theflames[i])
        end
        x, y, z, _, _, _ = Spring.GetUnitPiecePosDir(unitID, fackelmain)
        Spring.CreateFeature("cInfantryCorpse", x, y, z)
        --[,number heading [, number AllyTeamID ]] ) -> number featureID

        --wiggle on the floor
        for i = 1, 140, 1 do

            randoVal = math.random(10, 60)
            Sleep(randoVal)
            EmitSfx(fackelmain, 1027)

            Sleep(100)
        end
    end
end

--scrapMain=piece "scrapMain"
function diceHide(piecename)
    i = math.random(0, 1)
    if i == 1 then
        Hide(piecename)
    else
        Show(piecename)
    end
end


function Schlackung()
    Hide(sl02)
    Hide(sl03)
    Show(sl01)
    for i = 1, table.getn(schlacke) - 1, 2 do
        rand = math.random(0, 360)
        Turn(schlacke[i], y_axis, math.rad(rand), 0)
        Turn(schlacke[i + 1], y_axis, math.rad(rand), 0)
        Show(schlacke[i])
        Hide(schlacke[i + 1])
    end
end

function entSchlackung()
    Hide(sl01)
    Show(sl02)
    for i = 2, table.getn(schlacke) - 1, 2 do
        Show(schlacke[i])
        Hide(schlacke[i - 1])
    end
end



function hideAndSeek()

    for i = 1, table.getn(debris), 1 do
        --diceHide(debris[i])
        randdeg = math.random(0, 360)
        Turn(debris[i], y_axis, math.rad(randdeg), 0)
        m = math.random(-5, 60)
        Move(debris[i], x_axis, m, 0)
    end

    for i = 1, 12, 1 do
        Show(mainDebris[i])

        randdeg = math.random(0, 360)
        Turn(mainDebris[i], y_axis, math.rad(randdeg), 0)
        d = i + 12
        Turn(mainDebris[d], y_axis, math.rad(randdeg), 0)
        m = math.random(-5, 20)

        Move(mainDebris[i], x_axis, m, 0)
        Move(mainDebris[i], y_axis, -42, 0.3)
        Move(mainDebris[d], x_axis, m, 0)
        Move(mainDebris[d], y_axis, -12, 0)
        Move(mainDebris[d], y_axis, 0, 0.9)
    end
    for i = 12, 24, 1 do
        Show(mainDebris[i])
    end
end


function TimeOfMyLife()
    SetSignalMask(SIG_DEATH)
    Sleep(240000)
    Move(center, y_axis, -30, 3)
    WaitForMove(center, y_axis)
    Spring.DestroyUnit(unitID, false, false)
end

function script.Killed()

    return 1
end

-- "custom:330rlexplode",1024
-- "custom:flames",
-- "custom:glowsmoke",
-- "custom:blackerThenSmoke",
-- "custom:LightUponSmoke",
-- "custom:vortflames",--1029
-- "custom:volcanolightsmall",--1030
-- "custom:cburningwreckage",--1031


function onFire(times, endtimes)
    Time = math.ceil(math.random(100, 160))
    StartThread(dustCloudPostExplosion, unitID, 1, Time, 50, 0, 1, 0)
    Schlackung()
    --turnEmitorToTheWind()
    Hide(base02)
    Hide(base03)
    for i = 1, 3 do
        EmitSfx(emitfire, 1024)
        Sleep(90)
    end
    x, y, z = Spring.GetUnitPiecePosDir(unitID, emitfire)
    for i = 1, times, 1 do
        if i < endtimes then
            Show(base01)

            EmitSfx(emitfire, 1025)
            EmitSfx(emitfire, 1028)
            EmitSfx(emitfire, 1026)
            randpiece = math.random(1, 21)
            EmitSfx(schlacke[randpiece], 1031)
        else

            Hide(base01)
            Show(base02)
            EmitSfx(emitfire, 1028)
        end
        --turnEmitorToTheWind()
        Sleep(200)
    end
    Hide(base01)
    Hide(base02)
    Show(base03)
    entSchlackung()
    Sleep(4000)
    Hide(sl02)
    Show(sl03)

    for i = 1, 12, 1 do
        Hide(mainDebris[i])
    end
    Hide(debris[5])
end


function script.Create()
		Spring.SetUnitNeutral(unitID, true)
    if getUnitGroundHeigth(unitID) > -5 then
        if math.random(0, 1) == 1 then

            for i = 1, 6, 1 do
                Explode(explo[i], SFX.FIRE + SFX.FALL)
                --StartThread(PseudoPhysix,explo[i],empty[i], math.random(5,10), nil)
                Hide(explo[i])
            end

        else
            for i = 1, 6, 1 do
                Hide(explo[i])
            end
        end


        x = math.random(0, 360)
        EmitSfx(emitfire, 1024)
        Turn(corpserotator, y_axis, math.rad(x), 0)

        fireTime = math.random(40, 360)
        endTimes = math.random(0, 500)
        StartThread(onFire, fireTime, endTimes)
        StartThread(goDieInAFire)
    end

    hideAndSeek()
    StartThread(TimeOfMyLife)
    StartThread(contemplateOrigin)
end