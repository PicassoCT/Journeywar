piecesTable = {}
deathpivot = piece "deathpivot"

piecesTable[#piecesTable + 1] = deathpivot
Body = piece "Body"

piecesTable[#piecesTable + 1] = Body
AL = piece "AL"

piecesTable[#piecesTable + 1] = AL
Weapon2 = piece "Weapon2"

piecesTable[#piecesTable + 1] = Weapon2
podturret4 = piece "podturret4"

piecesTable[#piecesTable + 1] = podturret4
Weapon4 = piece "Weapon4"

piecesTable[#piecesTable + 1] = Weapon4
AUL = piece "AUL"

piecesTable[#piecesTable + 1] = AUL
Shield2 = piece "Shield2"

piecesTable[#piecesTable + 1] = Shield2
podturret3 = piece "podturret3"

piecesTable[#piecesTable + 1] = podturret3
Weapon6 = piece "Weapon6"

piecesTable[#piecesTable + 1] = Weapon6
AR = piece "AR"

piecesTable[#piecesTable + 1] = AR
Weapon1 = piece "Weapon1"

piecesTable[#piecesTable + 1] = Weapon1
podturret1 = piece "podturret1"

piecesTable[#piecesTable + 1] = podturret1
Weapon3 = piece "Weapon3"

piecesTable[#piecesTable + 1] = Weapon3
AUR = piece "AUR"

piecesTable[#piecesTable + 1] = AUR
podturret0 = piece "podturret0"

piecesTable[#piecesTable + 1] = podturret0
Weapon5 = piece "Weapon5"

piecesTable[#piecesTable + 1] = Weapon5
Shield1 = piece "Shield1"

piecesTable[#piecesTable + 1] = Shield1
Shield4 = piece "Shield4"

piecesTable[#piecesTable + 1] = Shield4
Shield3 = piece "Shield3"

piecesTable[#piecesTable + 1] = Shield3
Head = piece "Head"

piecesTable[#piecesTable + 1] = Head
Core = piece "Core"

piecesTable[#piecesTable + 1] = Core
LL = piece "LL"

piecesTable[#piecesTable + 1] = LL
podturret5 = piece "podturret5"

piecesTable[#piecesTable + 1] = podturret5
Weapon8 = piece "Weapon8"

piecesTable[#piecesTable + 1] = Weapon8
Shield6 = piece "Shield6"

piecesTable[#piecesTable + 1] = Shield6
LUL = piece "LUL"

piecesTable[#piecesTable + 1] = LUL
SR4 = piece "SR4"

piecesTable[#piecesTable + 1] = SR4
SR5 = piece "SR5"

piecesTable[#piecesTable + 1] = SR5
SR6 = piece "SR6"

piecesTable[#piecesTable + 1] = SR6
Shield8 = piece "Shield8"

piecesTable[#piecesTable + 1] = Shield8
LR = piece "LR"

piecesTable[#piecesTable + 1] = LR
Shield5 = piece "Shield5"

piecesTable[#piecesTable + 1] = Shield5
podturret2 = piece "podturret2"

piecesTable[#piecesTable + 1] = podturret2
Weapon7 = piece "Weapon7"

piecesTable[#piecesTable + 1] = Weapon7
LUR = piece "LUR"

piecesTable[#piecesTable + 1] = LUR
SR1 = piece "SR1"

piecesTable[#piecesTable + 1] = SR1
SR2 = piece "SR2"

piecesTable[#piecesTable + 1] = SR2
SR3 = piece "SR3"

piecesTable[#piecesTable + 1] = SR3
Shield7 = piece "Shield7"

piecesTable[#piecesTable + 1] = Shield7

local Animations = {};
WeaponTable = {}

include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

function HitByWeapon(x, z, weaponDefID, damage)
    --Turn Shielding
    if boolBattle == false then StartThread(battleReseter) end
    boolBattle = true
end

function battleReseter()
    Sleep(3000)
    boolBattle = false
end


function script.Create()
    Spring.PlaySoundFile("sounds/cPaxCentrail/PaxCentrailSound.wav", 1.0)
    local map = Spring.GetUnitPieceMap(unitID)
    local offsets = constructSkeleton(unitID, deathpivot, { 0, 0, 0 })

    for a, anim in pairs(Animations) do
        for i, keyframe in pairs(anim) do
            local commands = keyframe.commands;
            for k, command in pairs(commands) do
                -- commands are described in (c)ommand,(p)iece,(a)xis,(t)arget,(s)peed format
                -- the t attribute needs to be adjusted for move commands from blender's absolute values
                if (command.c == "move") then
                    local adjusted = command.t - (offsets[command.p][command.a]);
                    Animations[a][i]['commands'][k].t = command.t - (offsets[command.p][command.a]);
                end
            end
        end
    end

    StartThread(cExpReloader)
    StartThread(moveStarter)
    StartThread(underPressure)
end

function animTest()


    while true do
        pack()
        Sleep(10000)
        PlayAnimation("pax_unpack")
        Sleep(2000)
    end
end

function moveStarter()
    PlayAnimation("pax_unpack")
    Sleep(500)
    Signal(SIG_IDLE)
    StartThread(move)
end

local animCmd = { ['turn'] = Turn, ['move'] = Move };

function PlayAnimation(animname)
    boolCo = false
    if animname == "pax_defensive" then boolCo = true; Move(Body, y_axis, -32, 12) end
    if animname == "pax_unpack" then boolCo = true; StartThread(pax_unpack_CoThread) end
    if animname == "pack" then boolCo = true; StartThread(pack); return end

    if boolCo == false then
        reset(Body, 22)
        reset(deathpivot, 22)
    end

    if not Animations[animname] then Spring.Echo(animname) end

    local anim = Animations[animname];
    assert(anim, animname)
    for i = 1, #anim do
        local commands = anim[i].commands;
        for j = 1, #commands do
            local cmd = commands[j];
            animCmd[cmd.c](cmd.p, cmd.a, cmd.t, cmd.s);
        end
        if (i < #anim) then
            local t = anim[i + 1]['Time'] - anim[i]['Time'];
            Sleep(t * 33); -- sleep works on milliseconds
        end
    end
end

local ListedPieces = { Body, LR, LL, LUR, LUL }
function resetStance()
    PlayAnimation("pax_standing")
end

function identifyNearestEnemyAir()
    ed = Spring.GetUnitNearestEnemy(unitID)
    ex, ey, ez = Spring.GetUnitPosition(ed)
    h = Spring.GetGroundHeight(ex, ez)
    return ey - math.abs(h) > 100
end

function script.Killed(recentDamage, _)
    --the Centrail knows no mercy
    if Spring.ValidUnitID(hostageid) == true then
        Spring.DestroyUnit(hostageid, true, false, unitID)
    end
    fooward = 1
    --if math.random(false,true) then Spring.Echo("Math.random accepts false/true as true in cPaxCentrail/PaxCentrailSound") end
    PlayAnimation("pax_death")
    createCorpseCUnitGeneric(recentDamage)
    return 0
end

boolMoving = false
function move()
    Signal(SIG_IDLE)
    boolMoving = false
    PlayAnimation("pack")
    while boolMoving == false do
        Sleep(100)
    end

    PlayAnimation("pax_unpack")

    while true do
        if boolMoving == true then
            moveAnimation()
        else
            if boolBattle == true then
                boolIsAir = identifyNearestEnemyAir()
                if boolIsAir == false then
                    idle()
                else
                    PlayAnimation("paxcentrail_antiairstance")
                end
                while boolMoving == false and boolBattle == true do
                    Sleep(100)
                end
                resetStance()

            else
                while boolMoving == false and boolBattle == false do
                    resetStance()
                end
            end
            Sleep(200)
        end
    end
end

function hammerclawin(boolleft)
    if boolleft == true then
        Move(SR4, y_axis, -9, 35)
        Move(SR5, y_axis, -9, 35)
        Move(SR6, y_axis, -9, 35)
        Move(SR4, z_axis, 5, 35)
    else
        Move(SR1, y_axis, -9, 35)
        Move(SR2, y_axis, -9, 35)
        Move(SR3, y_axis, -9, 35)
        Move(SR1, z_axis, 5, 35)
    end
end

function retractclaw(boolleft)
    if boolleft == true then
        Move(SR4, y_axis, 0, 15)
        Move(SR5, y_axis, 0, 15)
        Move(SR6, y_axis, 0, 15)
        Move(SR4, z_axis, 0, 15)
    else
        Move(SR1, y_axis, 0, 15)
        Move(SR2, y_axis, 0, 15)
        Move(SR3, y_axis, 0, 15)
        Move(SR1, z_axis, 0, 15)
    end
end

gheading, gpitch = 0, 0





--tur(axis,bodyt,uarml,uarmr,arml,armr,--[[]] uplegl,uplegr,lowlegl,lowlegr,speedt)
ThreeInArow = 3
Dec = false
stomp = piece "stomp"
local spGetNearestEnemy = Spring.GetNearestEnemy
local spGetUnitPosition = Spring.GetUnitPosition
local globalHeading = 0

function moveAnimation()
    if boolBattle == false then
        if ThreeInArow > 0 then ThreeInArow = ThreeInArow - 1 else ThreeInArow = 3; Dec = Dec == false end

        if Dec == 1 then
            PlayAnimation("pax_walk")
        else
            PlayAnimation("paxcentrail_walk")
        end
    else
        ed = spGetNearestEnemy()

        ex, _, ez = spGetUnitPosition(ed)
        ux, _, uz = Spring.GetUnitPiecePosition(unitID, stomp)
        ex, ez = ex - ux, ez - uz

        if ed and ex and math.sqrt(ex ^ 2 + ez ^ 2) < 60 then
            Turn(deathpivot, y_axis, -globalHeading, 33)
            PlayAnimation("paxcentrail_stomp")
            WaitForTurn(deathpivot, y_axis)
            Turn(deathpivot, y_axis, 0, 12)
        else
            PlayAnimation("pax_attack")
        end
    end
    StartThread(OhLawd)
end

boolBattle = false


TableOfSoundPathStrings = {
    [1] = { path = "sounds/cPaxCentrail/ghospell1.ogg", Time = 2500 },
    [2] = { path = "sounds/cPaxCentrail/ghospell2.ogg", Time = 3500 },
    [3] = { path = "sounds/cPaxCentrail/ghospell3.ogg", Time = 3000 },
    [4] = { path = "sounds/cPaxCentrail/ghospell4.ogg", Time = 2500 },
    [5] = { path = "sounds/cPaxCentrail/ghospell5.ogg", Time = 2500 },
    [5] = { path = "sounds/cPaxCentrail/ghospell6.ogg", Time = 4500 },
}

unitdefID = Spring.GetUnitDefID(unitID)
counter = 1
boolBusy = false
function OhLawd()


    if boolBusy == false and TableOfSoundPathStrings[counter] and TableOfSoundPathStrings[counter].path and TableOfSoundPathStrings[counter].Time then
        boolBusy = true
        StartThread(PlaySoundByUnitDefID, unitdefID, TableOfSoundPathStrings[counter].path, 1, TableOfSoundPathStrings[counter].Time, 1)
        Sleep(TableOfSoundPathStrings[counter].Time)
        counter = (counter % (5)) + 1
        boolBusy = false
    end
end


numberTable = { "one", "two", "three", "four", "five" }
function NotYetProperlyMotivated()

    StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/number.ogg", 1, 1000, 1)
    StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/" .. (numberTable[math.random(1, #numberTable)]) .. ".ogg", 1, 1000, 1, 1002)
    StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/motivation.ogg", 1, 14000, 1, 2005)
end

SIG_IDLE = 8

function idle()
    SetSignalMask(SIG_IDLE)
    PlayAnimation("pax_defensive")
end

function script.StartMoving()
    boolMoving = true
end

function delayedStop()
    SetSignalMask(SIG_STOP)
    Sleep(1000)
    if math.abs(Spring.GetUnitHeading(unitID) - startHeading) < 25 then
        boolMoving = false
    end
end

startHeading = 0
local SIG_STOP = 2
function script.StopMoving()
    Signal(SIG_STOP)
    startHeading = Spring.GetUnitHeading(unitID)
    StartThread(delayedStop)
end

hostageid = ""
function underPressure()
    while hostageid == "" do
        Sleep(500)
    end

    boolUnderPressure = true
    while Spring.GetUnitIsDead(hostageid) == false do
        Sleep(1000)
    end

    eid = Spring.GetUnitNearestEnemy(unitID)
    eteam = Spring.GetUnitTeam(eid)
    if eteam then
        Spring.TransferUnit(unitID, eteam, true)
    end
end

function unblockWhileThere(ex, ey, ez)
    boolUnderPressure = true

    x, y, z = Spring.GetUnitPosition(unitID)


    while math.abs(x - ex) + math.abs(y - ey) + math.abs(z - ez) < 450 do
        x, y, z = Spring.GetUnitPosition(unitID)
        Sleep(500)
    end

    teamid = Spring.GetUnitTeam(unitID)
    hostageid = Spring.CreateUnit("choblock", ex, ey, ez, 0, teamid)

    x, y, z = Spring.GetUnitPosition(hostageid)
    Spring.SetUnitBlocking(hostageid, false, false)
    while table.getn(getAllInCircle(x, z, 75, hostageid)) > 0 do
        Sleep(500)
    end
    Spring.SetUnitBlocking(hostageid, true, true)
end

boolUnderPressure = false
function script.Activate()
    if boolUnderPressure == false then

        x, y, z = Spring.GetUnitPosition(unitID)


        StartThread(unblockWhileThere, x, y, z)
    end
    return 1
end

function script.Deactivate()

    return 0
end

aimWeapFunc = function(Heading, pitch, nr)
    if nr ~= 7 then
        Turn(WeaponTable[nr].qpiece, y_axis, -Heading, 1.8)
        Turn(WeaponTable[nr].qpiece, x_axis, pitch, 1.8)
        WaitForTurn(WeaponTable[nr].qpiece, y_axis)
        WaitForTurn(WeaponTable[nr].qpiece, x_axis)
        return true
    else
        piecename = ""

        if math.random(0, 1) == 1 then piecename = Weapon1 else piecename = Weapon2 end
        Turn(piecename, y_axis, -Heading, 1.8)
        Turn(piecename, x_axis, pitch, 1.8)
        WaitForTurn(piecename, y_axis)
        WaitForTurn(piecename, x_axis)
        return true
    end
end

WeaponTable = {
    [1] = {
        AimFromqpiece = podturret2,
        qpiece = Weapon7,
        fireweapon = function() return true
        end,
        aimweapon = function(Heading, pitch, nr)
            Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
            Turn(WeaponTable[nr].qpiece, x_axis, pitch, 8)
            WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            WaitForTurn(WeaponTable[nr].qpiece, x_axis)
            return true
        end
    },
    [2] = {
        AimFromqpiece = podturret4,
        qpiece = Weapon4,
        fireweapon = function() return true
        end,
        aimweapon = function(Heading, pitch, nr)
            Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
            Turn(WeaponTable[nr].qpiece, x_axis, pitch, 8)
            WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            WaitForTurn(WeaponTable[nr].qpiece, x_axis)
            if boolExponentialGunReloaded == true then
                boolExponentialGunReloaded = false
                return true
            else
                return false
            end
        end
    },
    [3] = {
        AimFromqpiece = podturret5,
        qpiece = Weapon8,
        fireweapon = function() return true
        end,
        aimweapon = function(Heading, pitch, nr)
            globalHeading = Heading
            Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
            Turn(WeaponTable[nr].qpiece, x_axis, pitch, 8)
            WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            WaitForTurn(WeaponTable[nr].qpiece, x_axis)
            return true
        end
    },
    [4] = {
        AimFromqpiece = podturret1,
        qpiece = Weapon3,
        fireweapon = function() return true
        end,
        aimweapon = function(Heading, pitch, nr)
            Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
            Turn(WeaponTable[nr].qpiece, x_axis, pitch, 8)
            WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            WaitForTurn(WeaponTable[nr].qpiece, x_axis)
            if boolExponentialGunReloaded == true then
                boolExponentialGunReloaded = false
                return true
            else
                return false
            end
        end
    },
    [5] = {
        AimFromqpiece = podturret0,
        qpiece = Weapon5,
        fireweapon = function()
            return true
        end,
        aimweapon = function(Heading, pitch, nr)
            Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
            Turn(WeaponTable[nr].qpiece, x_axis, pitch, 8)
            WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            WaitForTurn(WeaponTable[nr].qpiece, x_axis)
            return true
        end
    },
    [6] = {
        AimFromqpiece = podturret3,
        qpiece = Weapon6,
        fireweapon = function() return true
        end,
        aimweapon = function(Heading, pitch, nr)
            globalHeading = Heading
            Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
            Turn(WeaponTable[nr].qpiece, x_axis, pitch, 8)
            WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            WaitForTurn(WeaponTable[nr].qpiece, x_axis)
            return true
        end
    },
    [7] = {
        AimFromqpiece = Core,
        qpiece = Head,
        fireweapon = function()
            return true
        end,
        aimweapon = function(Heading, pitch, nr)
            if math.abs(Heading) < 3.141 / 2 then
                Turn(WeaponTable[nr].AimFromqpiece, y_axis, -Heading, 8)
                WaitForTurn(WeaponTable[nr].AimFromqpiece, y_axis)
            end
            return true
        end
    }
}
--Weapon1

local boolExponentialGunReloaded = false
local boolExponentialGunFired = false
local CoolDownTime = 3000
local Exponent = 0
local ReloadTime = 2049

function cExpReloader()
    coolDownTimer = CoolDownTime
    while true do
        ReloadTime = math.max(1, 2049 - (2 ^ Exponent))
        --if not reloaded
        if boolExponentialGunReloaded == false then

            if ReloadTime > 1128 then
                StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/singleShotExponential.ogg", 1, 500, 2, 0)
            elseif ReloadTime <= 1128 and ReloadTime > 978 then
                StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/TenShotsPerSecond.ogg", 1, 1100, 2, 0)
            elseif ReloadTime <= 978 and ReloadTime > 512 then
                StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/TwenShotsPerSecond.ogg", 1, 2400, 2, 0)
            elseif ReloadTime <= 512 and ReloadTime > 0 then
                StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/MaxShotsPerSecond.ogg", 1, 2400, 2, 0)
            end
            Sleep(ReloadTime)
            Exponent = Exponent + 1
            coolDownTimer = CoolDownTime - ReloadTime
            boolExponentialGunReloaded = true
        end
        Sleep(5)
        coolDownTimer = coolDownTimer - 5
        if coolDownTimer <= 0 then
            Exponent = 0
        end
    end
end



local aimpiece1 = WeaponTable[1].AimFromqpiece
function script.AimFromWeapon1()
    return aimpiece1
end

local weaponpiece1 = WeaponTable[1].qpiece
function script.QueryWeapon1()
    return weaponpiece1
end


function script.AimWeapon1(Heading, pitch)
    return WeaponTable[1].aimweapon(Heading, pitch, 1) and boolUnderPressure == true
end


function script.FireWeapon1()
    StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/LineGunFire.ogg", 5000, 1, 1)
    return WeaponTable[1].fireweapon()
end



aimpiece2 = WeaponTable[2].AimFromqpiece
function script.AimFromWeapon2()
    return aimpiece2
end

weaponpiece2 = WeaponTable[2].qpiece
function script.QueryWeapon2()
    return weaponpiece2
end


function script.AimWeapon2(Heading, pitch)
    return WeaponTable[2].aimweapon(Heading, pitch, 2) and boolUnderPressure == true
end


function script.FireWeapon2()
    return WeaponTable[2].fireweapon()
end

--------------------------------------------------------------

aimpiece3 = WeaponTable[3].AimFromqpiece
function script.AimFromWeapon3()
    return aimpiece3
end

weaponpiece3 = WeaponTable[3].qpiece
function script.QueryWeapon3()
    return weaponpiece3
end


function script.AimWeapon3(Heading, pitch)
    return WeaponTable[3].aimweapon(Heading, pitch, 3) and boolUnderPressure == true
end


function script.FireWeapon3()
    StartThread(PlaySoundByUnitDefID, unitdefID, "sounds/cPaxCentrail/LineGunFire.ogg", 5000, 1, 1)
    return WeaponTable[3].fireweapon()
end

--------------------------------------------------------------

aimpiece4 = WeaponTable[4].AimFromqpiece
function script.AimFromWeapon4()
    return aimpiece4
end

weaponpiece4 = WeaponTable[4].qpiece
function script.QueryWeapon4()
    return weaponpiece4
end


function script.AimWeapon4(Heading, pitch)
    return WeaponTable[4].aimweapon(Heading, pitch, 4) and boolUnderPressure == true
end


function script.FireWeapon4()
    return WeaponTable[4].fireweapon()
end

aimpiece5 = WeaponTable[5].AimFromqpiece
function script.AimFromWeapon5()
    return aimpiece5
end

weaponpiece5 = WeaponTable[5].qpiece
function script.QueryWeapon5()
    return weaponpiece5
end


function script.AimWeapon5(Heading, pitch)
    return WeaponTable[5].aimweapon(Heading, pitch, 5) and boolUnderPressure == true and true == false
end


function script.FireWeapon5()
    return WeaponTable[5].fireweapon()
end


aimpiece6 = WeaponTable[6].AimFromqpiece
function script.AimFromWeapon6()
    return aimpiece6
end

weaponpiece6 = WeaponTable[6].qpiece
function script.QueryWeapon6()
    return weaponpiece6
end


function script.AimWeapon6(Heading, pitch)
    return WeaponTable[6].aimweapon(Heading, pitch, 6) and boolUnderPressure == true
end


function script.FireWeapon6()
    return WeaponTable[6].fireweapon()
end

aimpiece7 = WeaponTable[7].AimFromqpiece
function script.AimFromWeapon7()
    return aimpiece7
end

weaponpiece7 = WeaponTable[7].qpiece
function script.QueryWeapon7()
    return weaponpiece7
end


function script.AimWeapon7(Heading, pitch)

    return WeaponTable[7].aimweapon(Heading, pitch, 7) and boolUnderPressure == true
end


function script.FireWeapon7()
    return WeaponTable[7].fireweapon()
end






Animations['pax_death'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -1.124613, ['s'] = 0.393313 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.363993, ['s'] = 0.992707 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.188151, ['s'] = 0.705566 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.058676, ['s'] = 0.220034 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.005538, ['s'] = 0.020767 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000028, ['s'] = 0.000104 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.035547, ['s'] = 0.133299 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.344067, ['s'] = 1.290252 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.467816, ['s'] = 1.754309 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.140687, ['s'] = 0.527576 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.033574, ['s'] = 0.125901 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.066513, ['s'] = 0.026605 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.276526, ['s'] = 1.036974 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.085535, ['s'] = 0.320755 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.011909, ['s'] = 0.044660 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.929882, ['s'] = 0.778260 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.389926, ['s'] = 1.461903 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.121291, ['s'] = 0.440440 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.027176, ['s'] = 0.092736 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -4.005963, ['s'] = 8.011926 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -4.112760, ['s'] = 8.225519 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.900618, ['s'] = 5.801237 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.313295, ['s'] = 3.939885 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -1.091664, ['s'] = 3.274993 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.200638, ['s'] = 0.601915 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.715448, ['s'] = 3.430897 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.242644, ['s'] = 0.485288 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.712697, ['s'] = 1.425395 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.678370, ['s'] = 2.035110 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.338925, ['s'] = 1.016774 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.028013, ['s'] = 0.084040 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.886042, ['s'] = 0.681439 },
        }
    },
    {
        ['Time'] = 3,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.423584, ['s'] = 0.361816 },
        }
    },
    {
        ['Time'] = 9,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.363354, ['s'] = 3.766400 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.101227, ['s'] = 1.112591 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.019191, ['s'] = 0.039925 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.616981, ['s'] = 5.423981 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.171669, ['s'] = 1.561782 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.056178, ['s'] = 0.113023 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.460932, ['s'] = 0.922028 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.137386, ['s'] = 0.259255 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.032207, ['s'] = 0.101489 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.445597, ['s'] = 1.287228 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.132507, ['s'] = 0.369154 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.030262, ['s'] = 0.123621 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000065, ['s'] = 0.000161 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.083573, ['s'] = 0.205830 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.297377, ['s'] = 2.749045 },
        }
    },
    {
        ['Time'] = 11,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.683713, ['s'] = 0.011449 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.318116, ['s'] = 0.044590 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.022870, ['s'] = 0.011022 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.530343, ['s'] = 0.591951 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.417777, ['s'] = 1.837874 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.334943, ['s'] = 0.366286 },
        }
    },
    {
        ['Time'] = 12,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.908695, ['s'] = 0.809695 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 1.364972 },
        }
    },
    {
        ['Time'] = 15,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.312418, ['s'] = 4.054632 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.091065, ['s'] = 0.060971 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.048244, ['s'] = 0.404611 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.547220, ['s'] = 6.985204 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.164239, ['s'] = 0.044584 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.026572, ['s'] = 0.496505 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.473447, ['s'] = 0.075089 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.137356, ['s'] = 0.000175 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.032268, ['s'] = 0.000362 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.161828, ['s'] = 3.644545 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.126201, ['s'] = 0.037832 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.050549, ['s'] = 0.484870 },
        }
    },
    {
        ['Time'] = 16,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.551537, ['s'] = 0.983471 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.248001, ['s'] = 0.032144 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.635604, ['s'] = 0.462558 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000075, ['s'] = 0.000070 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.095523, ['s'] = 0.089618 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.037966, ['s'] = 1.945577 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -4.000208, ['s'] = 0.034530 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -4.104716, ['s'] = 0.048260 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.887214, ['s'] = 0.080425 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.608606, ['s'] = 1.000296 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.560301, ['s'] = 1.867670 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.726394, ['s'] = 0.413478 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.172029, ['s'] = 0.017978 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.007515, ['s'] = 0.043980 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000075, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.095523, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.378297, ['s'] = 2.552483 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.067440, ['s'] = 1.719510 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.063190, ['s'] = 0.472583 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.028766, ['s'] = 0.163377 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.622523, ['s'] = 1.033682 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.253613, ['s'] = 0.541824 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.102018, ['s'] = 0.179246 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.231828, ['s'] = 1.812142 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.210367, ['s'] = 0.547580 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.010101, ['s'] = 0.166249 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.125962, ['s'] = 0.288022 },
        }
    },
    {
        ['Time'] = 21,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.248001, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.433788, ['s'] = 3.208176 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -3.512031, ['s'] = 1.464530 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -2.871596, ['s'] = 3.699361 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 3.122256, ['s'] = 0.705126 },
        }
    },
    {
        ['Time'] = 22,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.913275, ['s'] = 1.276437 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.660766, ['s'] = 0.809962 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.677937, ['s'] = 1.143315 },
        }
    },
    {
        ['Time'] = 24,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.859067, ['s'] = 3.763434 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.157346, ['s'] = 2.206277 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.039670, ['s'] = 0.298626 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.505324, ['s'] = 2.627305 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.190186, ['s'] = 1.520255 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.057231, ['s'] = 0.170789 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000075, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.780415, ['s'] = 2.010586 },
        }
    },
    {
        ['Time'] = 25,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.253344, ['s'] = 1.613882 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.554329, ['s'] = 0.885797 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.652135, ['s'] = 2.359745 },
        }
    },
    {
        ['Time'] = 29,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.412650, ['s'] = 0.979780 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.223597, ['s'] = 3.919490 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.189626, ['s'] = 6.091115 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.251189, ['s'] = 0.018180 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.111915, ['s'] = 1.604502 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.173606, ['s'] = 1.869439 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.006032, ['s'] = 0.412673 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.002719, ['s'] = 0.115606 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.658309, ['s'] = 0.573691 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.194848, ['s'] = 0.017484 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.086305, ['s'] = 0.109028 },
        }
    },
    {
        ['Time'] = 30,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.456481, ['s'] = 1.053245 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.331993, ['s'] = 0.986575 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.090911, ['s'] = 1.591162 },
        }
    },
    {
        ['Time'] = 31,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.980946, ['s'] = 1.069858 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.301535, ['s'] = 1.030380 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.394375, ['s'] = 1.552806 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -3.642204, ['s'] = 0.488146 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -3.895365, ['s'] = 3.839132 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.845736, ['s'] = 1.036953 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -2.103406, ['s'] = 0.380263 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.037707, ['s'] = 1.246117 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -1.246711, ['s'] = 3.849297 },
        }
    },
    {
        ['Time'] = 33,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.230754, ['s'] = 0.123383 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.229870, ['s'] = 0.063957 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.465222, ['s'] = 1.059920 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.672642, ['s'] = 2.314965 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.626546, ['s'] = 0.180542 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.903736, ['s'] = 0.629002 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.228835, ['s'] = 1.148214 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.369232, ['s'] = 0.455084 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.210758, ['s'] = 0.469022 },
        }
    },
    {
        ['Time'] = 35,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.383500, ['s'] = 0.874496 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 6.707907 },
        }
    },
    {
        ['Time'] = 36,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.105962, ['s'] = 0.925126 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.352279, ['s'] = 1.174264 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.316518, ['s'] = 1.055060 },
        }
    },
    {
        ['Time'] = 37,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.542433, ['s'] = 3.274749 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.025463, ['s'] = 0.600848 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.068206, ['s'] = 0.421394 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.906935, ['s'] = 0.062583 },
        }
    },
    {
        ['Time'] = 38,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.051558, ['s'] = 0.782329 },
        }
    },
    {
        ['Time'] = 39,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -3.420030, ['s'] = 0.256354 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -3.579015, ['s'] = 0.365019 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.812403, ['s'] = 0.038460 },
        }
    },
    {
        ['Time'] = 40,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.760110, ['s'] = 2.199390 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.129310, ['s'] = 0.462291 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.014735, ['s'] = 0.045060 },
        }
    },
    {
        ['Time'] = 43,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.191309, ['s'] = 0.791367 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.401578, ['s'] = 0.321952 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.331895, ['s'] = 0.249988 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.442793, ['s'] = 0.012832 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.327284, ['s'] = 0.004415 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.095935, ['s'] = 0.004710 },
        }
    },
    {
        ['Time'] = 45,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.060881, ['s'] = 0.338113 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.421254, ['s'] = 0.517308 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 2.373884 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.323114, ['s'] = 0.748988 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.036734, ['s'] = 1.263882 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.375814, ['s'] = 1.131261 },
        }
    },
    {
        ['Time'] = 46,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.467671, ['s'] = 1.433015 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.408700, ['s'] = 0.236808 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.220245, ['s'] = 0.056922 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.177518, ['s'] = 3.472079 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.591826, ['s'] = 2.360749 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.082968, ['s'] = 4.364034 },
        }
    },
    {
        ['Time'] = 47,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -2.014133, ['s'] = 2.582968 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.200348, ['s'] = 1.254708 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.406947, ['s'] = 0.031429 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.606692, ['s'] = 8.200810 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.075610, ['s'] = 1.229519 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.041701, ['s'] = 0.161795 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.723721, ['s'] = 1.087729 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.069079, ['s'] = 0.261695 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.115562, ['s'] = 0.284133 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.030729, ['s'] = 1.172081 },
        }
    },
    {
        ['Time'] = 49,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.955798, ['s'] = 3.835362 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 2.654398, ['s'] = 0.695698 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.396329, ['s'] = 3.503924 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.042441, ['s'] = 0.181891 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.120327, ['s'] = 2.204990 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.259029, ['s'] = 0.561267 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.034865, ['s'] = 0.695173 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.911318, ['s'] = 0.279970 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = y_axis, ['t'] = 2.886722, ['s'] = 0.023077 },
        }
    },
    {
        ['Time'] = 53,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.034916, ['s'] = 3.208040 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.049973, ['s'] = 0.627913 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.067164, ['s'] = 0.127316 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.053261, ['s'] = 5.028448 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.018084, ['s'] = 0.653718 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.133342, ['s'] = 0.133350 },
        }
    },
    {
        ['Time'] = 54,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.852132, ['s'] = 1.952318 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.662740, ['s'] = 0.425483 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.516604, ['s'] = 3.597437 },
        }
    },
    {
        ['Time'] = 56,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -1.441023, ['s'] = 4.852251 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 2.423273, ['s'] = 2.311256 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.775464, ['s'] = 3.791356 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.424412 },
        }
    },
    {
        ['Time'] = 57,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.164284, ['s'] = 3.263183 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.046582, ['s'] = 0.427472 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.126281, ['s'] = 0.105918 },
        }
    },
    {
        ['Time'] = 59,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -1.576616, ['s'] = 4.067767 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 2.307059, ['s'] = 3.486407 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.855248, ['s'] = 2.393507 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.018911, ['s'] = 0.567332 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -2.162709, ['s'] = 0.742882 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.277924, ['s'] = 0.387879 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.410902, ['s'] = 0.019777 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.042620, ['s'] = 4.888414 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.303343, ['s'] = 1.329430 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.092056, ['s'] = 3.807643 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.504613, ['s'] = 1.761363 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.138151, ['s'] = 0.330670 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.034295, ['s'] = 0.123256 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.098253, ['s'] = 0.116525 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.038109, ['s'] = 0.014951 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.129077, ['s'] = 0.004935 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.233166, ['s'] = 0.040507 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.286041, ['s'] = 0.111810 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.325959, ['s'] = 0.005745 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.037018, ['s'] = 3.601322 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.251428, ['s'] = 2.881625 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.325716, ['s'] = 0.500979 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.118234, ['s'] = 0.725733 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.869055, ['s'] = 0.562679 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.497798, ['s'] = 0.051289 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.326639, ['s'] = 3.214386 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 1.297177, ['s'] = 4.328066 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.155244, ['s'] = 1.285697 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.081047 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.690753, ['s'] = 2.777713 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.156796, ['s'] = 0.628059 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.013919, ['s'] = 0.454179 },
        }
    },
    {
        ['Time'] = 62,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.058927, ['s'] = 0.328636 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.223303, ['s'] = 0.421886 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.324961, ['s'] = 0.011337 },
        }
    },
    {
        ['Time'] = 64,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.614047, ['s'] = 6.729744 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.788176, ['s'] = 5.648734 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.662230, ['s'] = 3.372696 },
        }
    },
    {
        ['Time'] = 65,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -2.536587, ['s'] = 1.602334 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.087788, ['s'] = 0.814870 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.239913, ['s'] = 0.732813 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -3.772390, ['s'] = 0.813139 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -3.458610, ['s'] = 0.277857 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.665811, ['s'] = 0.338289 },
        }
    },
    {
        ['Time'] = 67,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.586135, ['s'] = 1.112127 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 0.541835, ['s'] = 3.237182 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.520556, ['s'] = 1.565625 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.879397, ['s'] = 7.960485 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.950972, ['s'] = 4.883865 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.767797, ['s'] = 3.167006 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.502606, ['s'] = 0.806348 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.080655, ['s'] = 0.326319 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.056276, ['s'] = 0.181532 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.267290, ['s'] = 1.017096 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.095663, ['s'] = 0.182091 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.056595, ['s'] = 0.095567 },
        }
    },
    {
        ['Time'] = 68,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -1.505697, ['s'] = 9.394499 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 1.037127, ['s'] = 1.292325 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -1.255220, ['s'] = 7.311350 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.514487, ['s'] = 0.925858 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.307357, ['s'] = 3.595020 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.632417, ['s'] = 1.214129 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.414625, ['s'] = 2.521787 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -2.146438, ['s'] = 10.282038 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.718444, ['s'] = 1.506107 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.519279, ['s'] = 10.170771 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -3.223152, ['s'] = 3.432822 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 1.266712, ['s'] = 6.772499 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.432338, ['s'] = 0.962125 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.497979, ['s'] = 1.321772 },
        }
    },
    {
        ['Time'] = 73,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -2.670640, ['s'] = 2.246580 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.423030, ['s'] = 1.266063 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.969484, ['s'] = 1.929451 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.624847, ['s'] = 0.580670 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 0.413628, ['s'] = 1.923098 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.562001, ['s'] = 0.621670 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.836563, ['s'] = 5.009353 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.220358, ['s'] = 2.095541 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.008826, ['s'] = 0.976541 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.977664, ['s'] = 0.124398 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = y_axis, ['t'] = 2.838598, ['s'] = 0.090233 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.746350, ['s'] = 7.185887 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.174577, ['s'] = 1.183700 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.002527, ['s'] = 0.811005 },
        }
    },
    {
        ['Time'] = 75,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.036834, ['s'] = 2.398136 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.249014, ['s'] = 0.391347 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.234792, ['s'] = 0.694285 },
        }
    },
    {
        ['Time'] = 76,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.638751, ['s'] = 0.417137 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 0.375253, ['s'] = 1.151260 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.598139, ['s'] = 1.084138 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.431641, ['s'] = 2.429530 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.054808, ['s'] = 0.993303 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.075427, ['s'] = 0.505518 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.045529, ['s'] = 4.204923 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.052113, ['s'] = 0.734782 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.066892, ['s'] = 0.386189 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.122384, ['s'] = 0.144786 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.031274, ['s'] = 0.041015 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.128903, ['s'] = 0.001045 },
        }
    },
    {
        ['Time'] = 77,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.665824, ['s'] = 0.406097 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 0.347458, ['s'] = 0.416923 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.637778, ['s'] = 0.594589 },
        }
    },
    {
        ['Time'] = 78,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -5.155259, ['s'] = 5.796321 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 1.387869, ['s'] = 0.363473 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -2.365596, ['s'] = 5.799775 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -4.882514, ['s'] = 3.700413 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -4.109923, ['s'] = 2.171044 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 1.490143, ['s'] = 3.918896 },
        }
    },
    {
        ['Time'] = 79,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.753061, ['s'] = 0.872369 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.619076, ['s'] = 0.187019 },
        }
    },
    {
        ['Time'] = 80,
        ['commands'] = {}
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.427943, ['s'] = 0.011094 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.053246, ['s'] = 0.004684 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.079023, ['s'] = 0.010790 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.030645, ['s'] = 0.044653 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.126713, ['s'] = 0.223800 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.063773, ['s'] = 0.009359 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.133043, ['s'] = 0.031977 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.049227, ['s'] = 0.241501 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.134449, ['s'] = 0.016638 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.182750, ['s'] = 2.195846 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.293244, ['s'] = 0.442295 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.175748, ['s'] = 0.590437 },
        }
    },
    {
        ['Time'] = 82,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.784631, ['s'] = 0.473553 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.637778, ['s'] = 0.280529 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Body, ['a'] = z_axis, ['t'] = -2.787931, ['s'] = 0.019798 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.365513, ['s'] = 0.548289 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.159264, ['s'] = 1.357522 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.681947, ['s'] = 1.518597 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.007311, ['s'] = 1.010581 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023795, ['s'] = 1.242190 },
        }
    },
    {
        ['Time'] = 87,
        ['commands'] = {}
    },
    {
        ['Time'] = 88,
        ['commands'] = {}
    },
    {
        ['Time'] = 89,
        ['commands'] = {}
    },
    {
        ['Time'] = 90,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.949049, ['s'] = 0.095383 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = y_axis, ['t'] = 2.848042, ['s'] = 0.031482 },
        }
    },
    {
        ['Time'] = 91,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.429560, ['s'] = 0.016172 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.055982, ['s'] = 0.027360 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.077380, ['s'] = 0.016433 },
        }
    },
    {
        ['Time'] = 94,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.434402, ['s'] = 0.072635 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.039165, ['s'] = 0.252249 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.072927, ['s'] = 0.066802 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.091850, ['s'] = 1.641983 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.206583, ['s'] = 0.283919 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -1.042584, ['s'] = 2.163819 },
        }
    },
    {
        ['Time'] = 96,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.433684, ['s'] = 0.021537 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.041862, ['s'] = 0.080887 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.073593, ['s'] = 0.020008 },
        }
    },
    {
        ['Time'] = 97,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.427617, ['s'] = 0.182014 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.066603, ['s'] = 0.742252 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.079102, ['s'] = 0.165262 },
        }
    },
    {
        ['Time'] = 98,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.422594, ['s'] = 0.150687 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.085361, ['s'] = 0.562731 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.083738, ['s'] = 0.139085 },
        }
    },
    {
        ['Time'] = 99,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.418365, ['s'] = 0.042295 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.105101, ['s'] = 0.197400 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.087500, ['s'] = 0.037613 },
        }
    },
    {
        ['Time'] = 102,
        ['commands'] = {}
    },
}


Animations['pax_walk'] = {
    {
        ['Time'] = 0,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.358180, ['s'] = 0.344609 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.199964, ['s'] = 5.744802 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.015476, ['s'] = 0.694790 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.134363, ['s'] = 1.549543 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.003453, ['s'] = 0.029840 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.002440, ['s'] = 0.037297 },
        }
    },
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.195783, ['s'] = 0.695990 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.004861, ['s'] = 0.836158 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.003670, ['s'] = 0.082053 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.296411, ['s'] = 0.221333 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.118522, ['s'] = 0.422767 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.117142, ['s'] = 0.365468 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.158707, ['s'] = 0.418669 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.004371, ['s'] = 0.012647 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.002234, ['s'] = 0.002652 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.817666, ['s'] = 0.446766 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.460721, ['s'] = 1.584592 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.097139, ['s'] = 0.242639 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.320451, ['s'] = 1.130384 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.070170, ['s'] = 0.050945 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.011246, ['s'] = 0.053601 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.246504, ['s'] = 0.569927 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.083341, ['s'] = 0.010067 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.028827, ['s'] = 0.028155 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.107465, ['s'] = 1.162329 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.013371, ['s'] = 0.034408 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.027986, ['s'] = 0.010292 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.613326, ['s'] = 0.704145 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.013426, ['s'] = 0.013086 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.008924, ['s'] = 0.013459 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.777544, ['s'] = 0.319217 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.003550, ['s'] = 0.007309 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.002930, ['s'] = 0.004383 },
        }
    },
    {
        ['Time'] = 8,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.404366, ['s'] = 0.231759 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.089829, ['s'] = 0.105211 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.027107, ['s'] = 0.026042 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.405620, ['s'] = 0.478690 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.106756, ['s'] = 0.194487 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.027627, ['s'] = 0.053060 },
        }
    },
    {
        ['Time'] = 10,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.393352, ['s'] = 1.259652 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.032381, ['s'] = 0.066685 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.037301, ['s'] = 0.045978 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.408844, ['s'] = 0.919899 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.011841, ['s'] = 0.139149 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.004305, ['s'] = 0.158409 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.026061, ['s'] = 0.944756 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.070276, ['s'] = 0.055996 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.024684, ['s'] = 0.017754 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.441153, ['s'] = 0.303835 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.010245, ['s'] = 0.005614 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.005608, ['s'] = 0.005851 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.204760, ['s'] = 0.583766 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.010589, ['s'] = 0.016694 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.029152, ['s'] = 0.006999 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.405886, ['s'] = 0.823561 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.097118, ['s'] = 1.115676 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.115830, ['s'] = 0.037382 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.764270, ['s'] = 0.023424 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.003863, ['s'] = 0.000552 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.002763, ['s'] = 0.000296 },
        }
    },
    {
        ['Time'] = 15,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.326816, ['s'] = 0.183085 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.006960, ['s'] = 0.005444 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.030224, ['s'] = 0.001608 },
        }
    },
    {
        ['Time'] = 17,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.010676, ['s'] = 5.183684 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.027515, ['s'] = 0.213802 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.001739, ['s'] = 0.132117 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {}
    },
    {
        ['Time'] = 23,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.794869, ['s'] = 1.618551 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.041114, ['s'] = 0.101988 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.001988, ['s'] = 0.001870 },
        }
    },
    {
        ['Time'] = 25,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.512134, ['s'] = 0.319543 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.010845, ['s'] = 0.352801 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.011372, ['s'] = 0.116997 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.279537, ['s'] = 0.473807 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.130414, ['s'] = 0.124863 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.038382, ['s'] = 0.578293 },
        }
    },
    {
        ['Time'] = 27,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.228672, ['s'] = 1.318926 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.020150, ['s'] = 0.082944 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.028264, ['s'] = 0.014269 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.742855, ['s'] = 1.496820 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.003660, ['s'] = 0.070695 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.015131, ['s'] = 0.027031 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.585564, ['s'] = 3.422388 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.012741, ['s'] = 0.076617 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.002557, ['s'] = 0.010171 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.047148, ['s'] = 2.390408 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.021586, ['s'] = 0.059078 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.003326, ['s'] = 0.001876 },
        }
    },
    {
        ['Time'] = 28,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.002477, ['s'] = 0.167389 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.000063, ['s'] = 0.004616 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.000032, ['s'] = 0.002359 },
        }
    },
    {
        ['Time'] = 33,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.654797, ['s'] = 0.368929 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.033071, ['s'] = 0.067368 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.037977, ['s'] = 0.050509 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -1.115522, ['s'] = 1.253976 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.061269, ['s'] = 0.287525 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.015161, ['s'] = 0.080315 },
        }
    },
    {
        ['Time'] = 35,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.745743, ['s'] = 0.320041 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.013578, ['s'] = 0.096944 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.018059, ['s'] = 0.008483 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.803632, ['s'] = 1.233531 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.023964, ['s'] = 0.032633 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.003653, ['s'] = 0.014086 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.101899, ['s'] = 0.396912 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.013527, ['s'] = 0.011589 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.027911, ['s'] = 0.004083 },
        }
    },
    {
        ['Time'] = 36,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.491438, ['s'] = 0.282377 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.012926, ['s'] = 0.000558 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.000445, ['s'] = 0.009007 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.277945, ['s'] = 0.975278 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.030365, ['s'] = 0.026335 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.003733, ['s'] = 0.001222 },
        }
    },
    {
        ['Time'] = 46,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.604252, ['s'] = 3.122101 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.018732, ['s'] = 0.194407 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.039259, ['s'] = 0.054978 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.433155, ['s'] = 6.548498 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.059282, ['s'] = 0.314707 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.003393, ['s'] = 0.058689 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.569259, ['s'] = 0.259403 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.015283, ['s'] = 0.007857 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.001164, ['s'] = 0.005366 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.565678, ['s'] = 0.616571 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.036213, ['s'] = 0.012531 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.008659, ['s'] = 0.010555 },
        }
    },
    {
        ['Time'] = 52,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.325291, ['s'] = 1.195548 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.036731, ['s'] = 0.077139 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.036053, ['s'] = 0.013741 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.047456, ['s'] = 0.448066 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.017530, ['s'] = 0.012009 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.025587, ['s'] = 0.006970 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.348181, ['s'] = 0.364174 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.063165, ['s'] = 0.016643 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.005586, ['s'] = 0.009395 },
        }
    },
    {
        ['Time'] = 53,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.096441, ['s'] = 2.093836 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.172446, ['s'] = 0.522659 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.003247, ['s'] = 0.130238 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.305632, ['s'] = 1.429218 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.070835, ['s'] = 0.016880 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.004622, ['s'] = 0.018600 },
        }
    },
    {
        ['Time'] = 55,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.144077, ['s'] = 5.350019 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.003667, ['s'] = 0.142125 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.001323, ['s'] = 0.001192 },
        }
    },
    {
        ['Time'] = 56,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.132730, ['s'] = 0.130252 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.003621, ['s'] = 0.003558 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.001913, ['s'] = 0.001881 },
        }
    },
    {
        ['Time'] = 59,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.389249, ['s'] = 1.020771 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.072604, ['s'] = 0.051248 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.007408, ['s'] = 0.040922 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.580415, ['s'] = 1.326566 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.087701, ['s'] = 0.035052 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.045668, ['s'] = 0.057260 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.319033, ['s'] = 3.524869 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.019344, ['s'] = 0.047031 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.026419, ['s'] = 0.075287 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.990346, ['s'] = 5.186747 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.001148, ['s'] = 0.124536 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.006174, ['s'] = 0.008284 },
        }
    },
    {
        ['Time'] = 61,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.587859, ['s'] = 2.281000 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.060569, ['s'] = 0.372924 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.052283, ['s'] = 0.185098 },
        }
    },
    {
        ['Time'] = 62,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.118798, ['s'] = 0.356258 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.013053, ['s'] = 0.009593 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.028135, ['s'] = 0.005460 },
        }
    },
    {
        ['Time'] = 67,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.745576, ['s'] = 0.005003 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.084551, ['s'] = 2.129178 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.090252, ['s'] = 2.165816 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.444862, ['s'] = 1.628470 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.009732, ['s'] = 0.043951 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.009525, ['s'] = 0.017189 },
        }
    },
    {
        ['Time'] = 68,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.371332, ['s'] = 0.561366 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.127418, ['s'] = 0.317953 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.044538, ['s'] = 0.068572 },
        }
    },
    {
        ['Time'] = 69,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.643346, ['s'] = 1.689219 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.013984, ['s'] = 0.013398 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.009577, ['s'] = 0.042104 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.859864, ['s'] = 0.326205 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.001624, ['s'] = 0.006931 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.004078, ['s'] = 0.005239 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.178768, ['s'] = 1.227274 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.064541, ['s'] = 0.011917 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.019607, ['s'] = 0.098028 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.414007, ['s'] = 0.295570 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.054811, ['s'] = 0.043702 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.030995, ['s'] = 0.097135 },
        }
    },
    {
        ['Time'] = 76,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.375523, ['s'] = 0.320907 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.005479, ['s'] = 0.009467 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.030527, ['s'] = 0.002990 },
        }
    },
    {
        ['Time'] = 80,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.184357, ['s'] = 0.307337 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.064565, ['s'] = 0.012060 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.018154, ['s'] = 0.016119 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.199651, ['s'] = 0.597503 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.137396, ['s'] = 0.318848 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.088103, ['s'] = 0.170068 },
        }
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.529754, ['s'] = 0.378638 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.012031, ['s'] = 0.006511 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.007268, ['s'] = 0.007699 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.657969, ['s'] = 0.406603 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.195872, ['s'] = 0.417805 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.183801, ['s'] = 0.357993 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.833964, ['s'] = 0.086333 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.002205, ['s'] = 0.001937 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.003706, ['s'] = 0.001239 },
        }
    },
    {
        ['Time'] = 86,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.473850, ['s'] = 0.730973 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.013824, ['s'] = 0.021863 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.004522, ['s'] = 0.005592 },
        }
    },
    {
        ['Time'] = 88,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.271375, ['s'] = 0.249894 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.006464, ['s'] = 0.334704 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.005367, ['s'] = 0.097928 },
        }
    },

    {
        ['Time'] = 99,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.210860, ['s'] = 0.336268 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.090455, ['s'] = 1.408212 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.069146, ['s'] = 0.568711 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.649579, ['s'] = 0.251691 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.069596, ['s'] = 3.788288 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.101082, ['s'] = 2.481589 },
        }
    },
    {
        ['Time'] = 100,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.230830, ['s'] = 0.149779 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.055172, ['s'] = 1.092204 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.012000, ['s'] = 0.428590 },
        }
    },
}

Animations['pax_depressed'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = -0.000086, ['s'] = 0.002575 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.003050, ['s'] = 0.091500 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.003417, ['s'] = 0.018407 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.196512, ['s'] = 1.994316 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.001613, ['s'] = 0.007771 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.002811, ['s'] = 0.006303 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = SR6, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = SR6, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = SR6, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -2.002442, ['s'] = 1.251477 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.337478, ['s'] = 0.209017 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.466473, ['s'] = 0.292152 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.008045, ['s'] = 0.004979 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.321116, ['s'] = 0.198791 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.047067, ['s'] = 0.028810 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = -0.000015, ['s'] = 0.000002 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * 0.001453, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.376099, ['s'] = 2.293628 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.009218, ['s'] = 0.020447 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.023936, ['s'] = 0.041511 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000239 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.002531 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.886042, ['s'] = 0.680630 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.109655, ['s'] = 0.068486 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.504130, ['s'] = 0.316988 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.118713, ['s'] = 0.073589 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000131 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = z_axis, ['t'] = -0.071041, ['s'] = 0.005084 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.001627 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000074 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.002614 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.929882, ['s'] = 0.799970 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.595669, ['s'] = 0.372342 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.003812, ['s'] = 0.000476 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.001128, ['s'] = 0.001312 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.899552, ['s'] = 0.692023 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.104456, ['s'] = 0.078005 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.013519, ['s'] = 0.009653 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 1.473168, ['s'] = 1.173132 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.002351 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.091506 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.029123 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.724878, ['s'] = 1.078000 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.202417, ['s'] = 0.128417 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.587264, ['s'] = 0.366433 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.882008, ['s'] = 1.469882 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.009634, ['s'] = 0.021140 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.018730, ['s'] = 0.029599 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = SR4, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = SR4, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = SR4, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -2.658880, ['s'] = 1.697048 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.045165, ['s'] = 0.033227 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.013639, ['s'] = 0.006525 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
            { ['c'] = 'turn', ['p'] = SR5, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.000012 },
            { ['c'] = 'turn', ['p'] = SR5, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000464 },
            { ['c'] = 'turn', ['p'] = SR5, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.000148 },
        }
    },
    {
        ['Time'] = 3,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.423584, ['s'] = 0.361816 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -2.697583, ['s'] = 1.878181 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.045593, ['s'] = 0.037199 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.013914, ['s'] = 0.004982 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 2.502812, ['s'] = 1.351345 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.008383, ['s'] = 0.007004 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.007610, ['s'] = 0.004965 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.125962, ['s'] = 0.288022 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = x_axis, ['t'] = -0.000038, ['s'] = 0.000015 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = z_axis, ['t'] = -0.072542, ['s'] = 0.000570 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = y_axis, ['t'] = -1 * 0.000481, ['s'] = 0.000183 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 2.455008, ['s'] = 1.116113 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.008071, ['s'] = 0.001187 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.007824, ['s'] = 0.016668 },
        }
    },
    {
        ['Time'] = 37,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.906935, ['s'] = 0.062583 },
        }
    },
    {
        ['Time'] = 38,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.051558, ['s'] = 0.782329 },
        }
    },
    {
        ['Time'] = 41,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.663755, ['s'] = 0.785990 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.059989, ['s'] = 0.148223 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.015184, ['s'] = 0.005549 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 1.343886, ['s'] = 0.430941 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.030729, ['s'] = 1.172081 },
        }
    },
    {
        ['Time'] = 49,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -2.435587, ['s'] = 7.859874 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.003642, ['s'] = 1.258545 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.001525, ['s'] = 0.371677 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.435964, ['s'] = 1.143052 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.003830, ['s'] = 0.004878 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.007349, ['s'] = 0.000279 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.326383, ['s'] = 1.209241 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.000375, ['s'] = 0.008246 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.004705, ['s'] = 0.003342 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -2.472104, ['s'] = 5.603292 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.008219, ['s'] = 1.108385 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.001851, ['s'] = 0.353639 },
        }
    },

    {
        ['Time'] = 50,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.364768 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.000453 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.001578 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -3.407609, ['s'] = 2.194867 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.303130, ['s'] = 0.659408 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.178020, ['s'] = 0.998197 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.000038, ['s'] = 0.406404 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.001502, ['s'] = 0.035809 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000478, ['s'] = 0.009004 },
            { ['c'] = 'move', ['p'] = Body, ['a'] = y_axis, ['t'] = 2.999974, ['s'] = 1.013932 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.027900, ['s'] = 1.604671 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.002684, ['s'] = 0.012114 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.007826, ['s'] = 0.006638 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.004854 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.193815 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.027930 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.242619, ['s'] = 2.436631 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.006733, ['s'] = 0.011528 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.003214, ['s'] = 0.005266 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.826823, ['s'] = 0.229068 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.275150, ['s'] = 0.081297 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.644916, ['s'] = 1.449638 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -1.338637, ['s'] = 5.267063 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.941797, ['s'] = 1.875717 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.014300, ['s'] = 0.447483 },
        }
    }
}

Animations['pax_recover'] = {
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.277195, ['s'] = 0.197261 },
        }
    },
    {
        ['Time'] = 57,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.337449, ['s'] = 1.877227 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.489765, ['s'] = 2.684179 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.355063, ['s'] = 0.638929 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.514487, ['s'] = 0.925858 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.497979, ['s'] = 1.321772 },
        }
    },
    {
        ['Time'] = 73,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 3.931721 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.344513 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.207080 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.389228 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.559861 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.408016 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 2.107737 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.312229 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.742462 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.431317, ['s'] = 0.288979 },
        }
    },
    {
        ['Time'] = 77,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 0.330683 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.002974 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.006359 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 1.958293 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.011430 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.011998 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.000118, ['s'] = 1.808865 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.004552, ['s'] = 0.006718 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.001449, ['s'] = 0.008391 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.000215, ['s'] = 1.401390 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.008392, ['s'] = 0.007784 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.003896, ['s'] = 0.005359 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = -0.000049, ['s'] = 0.000098 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.001501, ['s'] = 0.003003 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.007789, ['s'] = 1.011537 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023795, ['s'] = 1.242190 },
        }
    },
    {
        ['Time'] = 90,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = -0.000038, ['s'] = 0.000127 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.001502, ['s'] = 0.005006 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * 0.000478, ['s'] = 0.001593 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.261913, ['s'] = 0.564680 },
        }
    },
    {
        ['Time'] = 98,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000002, ['s'] = 0.000074 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.001502, ['s'] = 0.045067 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023317, ['s'] = 0.014337 },
        }
    },
    {
        ['Time'] = 99,
        ['commands'] = {}
    },
}

Animations['pax_standing'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.065030, ['s'] = 0.031281 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.005757, ['s'] = 0.000357 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.000187, ['s'] = 0.000174 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.070299, ['s'] = 0.029070 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.006223, ['s'] = 0.000334 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.000219, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.929882, ['s'] = 0.778260 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.117003, ['s'] = 0.126528 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.072469, ['s'] = 0.066854 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.010190, ['s'] = 0.005629 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.002964, ['s'] = 0.000468 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.886042, ['s'] = 0.681439 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -0.960865, ['s'] = 0.900811 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.010454, ['s'] = 0.010436 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.019649, ['s'] = 0.013745 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 1.083889, ['s'] = 1.020066 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.065802, ['s'] = 0.091953 },
        }
    },
    {
        ['Time'] = 3,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.137512, ['s'] = 0.102967 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.084377, ['s'] = 0.074120 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.007323, ['s'] = 0.000853 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.000288, ['s'] = 0.000508 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.090539, ['s'] = 0.081751 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.423584, ['s'] = 0.361816 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.125962, ['s'] = 0.288022 },
        }
    },
    {
        ['Time'] = 28,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.096996, ['s'] = 0.139565 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.099784, ['s'] = 0.107991 },
        }
    },
    {
        ['Time'] = 32,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.084214, ['s'] = 0.131064 },
        }
    },
    {
        ['Time'] = 34,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -1.985182, ['s'] = 0.787936 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.028304, ['s'] = 0.013731 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.015961, ['s'] = 0.002837 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 1.951998, ['s'] = 0.667776 },
        }
    },
    {
        ['Time'] = 35,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.068350, ['s'] = 0.133379 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.015363, ['s'] = 0.009606 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.001223, ['s'] = 0.001411 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.056659, ['s'] = 0.126958 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.015414, ['s'] = 0.009191 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.000174, ['s'] = 0.000045 },
        }
    },
    {
        ['Time'] = 36,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.051600, ['s'] = 0.086794 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.014392, ['s'] = 0.004512 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.000751, ['s'] = 0.000296 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.040366, ['s'] = 0.072023 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.020266, ['s'] = 0.006432 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.000963, ['s'] = 0.001277 },
        }
    },
    {
        ['Time'] = 37,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.906935, ['s'] = 0.062583 },
        }
    },
    {
        ['Time'] = 38,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.051558, ['s'] = 0.782329 },
        }
    },
    {
        ['Time'] = 40,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.071810, ['s'] = 0.190293 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.030729, ['s'] = 1.172081 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.277195, ['s'] = 0.197261 },
        }
    },
    {
        ['Time'] = 65,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.028111, ['s'] = 0.035505 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.015702, ['s'] = 0.000299 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.000598, ['s'] = 0.000552 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.514487, ['s'] = 0.925858 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.007506, ['s'] = 0.101911 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.497979, ['s'] = 1.321772 },
        }
    },
    {
        ['Time'] = 73,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.007598, ['s'] = 0.095290 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * 0.000789, ['s'] = 2.291505 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = -0.000108, ['s'] = 0.032783 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.000824, ['s'] = 0.017465 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * -0.000690, ['s'] = 2.253102 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.007346, ['s'] = 0.125211 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.431317, ['s'] = 0.288979 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.014749, ['s'] = 0.102041 },
        }
    },
    {
        ['Time'] = 83,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.051600, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.014392, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.000751, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.029846, ['s'] = 0.019725 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.020334, ['s'] = 0.000127 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.001176, ['s'] = 0.000400 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.007311, ['s'] = 1.010581 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023795, ['s'] = 1.242190 },
        }
    },
    {
        ['Time'] = 90,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.261913, ['s'] = 0.564680 },
        }
    },
    {
        ['Time'] = 98,
        ['commands'] = {}
    },
    {
        ['Time'] = 99,
        ['commands'] = {}
    },
}

Animations['pax_defensive'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = -0.000004, ['s'] = 0.000118 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000341, ['s'] = 0.010229 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.002392, ['s'] = 0.049155 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -1.073041, ['s'] = 0.370013 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.023624, ['s'] = 0.008029 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.050628, ['s'] = 0.017439 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = SR6, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = SR6, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = SR6, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.259212, ['s'] = 0.162010 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.150320, ['s'] = 0.094163 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.379268, ['s'] = 0.237076 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.631327, ['s'] = 0.217701 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.000209, ['s'] = 0.000190 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.004859, ['s'] = 0.001694 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = 0.000007, ['s'] = 0.000005 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.034239, ['s'] = 0.011808 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = 0.061819, ['s'] = 0.021199 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * 2.709001, ['s'] = 0.934157 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -1.110017, ['s'] = 0.382763 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.051086, ['s'] = 0.017733 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.067102, ['s'] = 0.023157 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000015 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000284 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.886042, ['s'] = 0.681484 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.002340 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.007055 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 1.312664 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = -0.000000, ['s'] = 0.003949 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.041912 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000000, ['s'] = 1.616946 },
            { ['c'] = 'move', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 4.354425, ['s'] = 0.000734 },
            { ['c'] = 'move', ['p'] = Shield6, ['a'] = z_axis, ['t'] = -1.211433, ['s'] = 0.014386 },
            { ['c'] = 'move', ['p'] = Shield6, ['a'] = y_axis, ['t'] = 1.633964, ['s'] = 0.024645 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.515835, ['s'] = 0.177876 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.000011, ['s'] = 0.000114 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.003991, ['s'] = 0.001395 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000008 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = z_axis, ['t'] = -0.071041, ['s'] = 0.000568 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.000090 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.037300, ['s'] = 0.012864 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = -0.045004, ['s'] = 0.015636 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -1.116632, ['s'] = 0.385027 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.014703, ['s'] = 0.005072 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.035807, ['s'] = 0.012230 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 1.212476, ['s'] = 0.418114 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000292 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.929882, ['s'] = 0.799092 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.828822, ['s'] = 0.285799 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.004584, ['s'] = 0.001698 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.004751, ['s'] = 0.001619 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.303087, ['s'] = 0.452996 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.004553, ['s'] = 0.001339 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.006908, ['s'] = 0.003330 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.010229 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.001625 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = 0.000003, ['s'] = 0.000002 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * 0.000046, ['s'] = 0.000032 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.018234, ['s'] = 0.011399 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.265357, ['s'] = 0.165635 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.706888, ['s'] = 0.441771 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.085065, ['s'] = 0.029331 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.436501, ['s'] = 0.150635 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.251266, ['s'] = 0.086625 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = -0.002851, ['s'] = 0.000981 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -0.028157, ['s'] = 0.009827 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * -2.050724, ['s'] = 0.707127 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = SR4, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = SR4, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = SR4, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.154666, ['s'] = 0.053302 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.448723, ['s'] = 0.155939 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.224282, ['s'] = 0.076514 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
            { ['c'] = 'turn', ['p'] = SR5, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = SR5, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.000189 },
            { ['c'] = 'turn', ['p'] = SR5, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 0.000030 },
        }
    },
    {
        ['Time'] = 3,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.423584, ['s'] = 0.361816 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.125962, ['s'] = 0.288022 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = x_axis, ['t'] = 0.000009, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = z_axis, ['t'] = -0.071653, ['s'] = 0.000233 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = y_axis, ['t'] = -1 * 0.000097, ['s'] = 0.000037 },
        }
    },
    {
        ['Time'] = 37,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.906935, ['s'] = 0.062583 },
        }
    },
    {
        ['Time'] = 38,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.051558, ['s'] = 0.782329 },
        }
    },
    {
        ['Time'] = 47,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000008, ['s'] = 0.000005 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = -0.000612, ['s'] = 0.000353 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * 0.000097, ['s'] = 0.000056 },
            { ['c'] = 'move', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 4.349874, ['s'] = 0.002626 },
            { ['c'] = 'move', ['p'] = Shield6, ['a'] = z_axis, ['t'] = -1.188905, ['s'] = 0.012997 },
            { ['c'] = 'move', ['p'] = Shield6, ['a'] = y_axis, ['t'] = 1.597238, ['s'] = 0.021188 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.030729, ['s'] = 1.172081 },
        }
    },
    {
        ['Time'] = 50,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.879895, ['s'] = 1.460100 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.012585, ['s'] = 0.213801 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.003918, ['s'] = 0.540746 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.785499, ['s'] = 1.572855 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.011953, ['s'] = 0.106436 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.004334, ['s'] = 0.295078 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.277195, ['s'] = 0.197261 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.514487, ['s'] = 0.925858 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.497979, ['s'] = 1.321772 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.431317, ['s'] = 0.288979 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.000008 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000612, ['s'] = 0.001225 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.007409, ['s'] = 1.010776 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023795, ['s'] = 1.242190 },
        }
    },
    {
        ['Time'] = 89,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.102704 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.186270 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 8.126875 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.044098 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.108235 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 3.637299 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.008564 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.083655 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 6.152301 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.000004, ['s'] = 0.111888 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = -0.000271, ['s'] = 0.134197 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * 0.000043, ['s'] = 3.350025 },
        }
    },
    {
        ['Time'] = 90,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000008, ['s'] = 0.000028 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.000612, ['s'] = 0.002041 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * 0.000097, ['s'] = 0.000324 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.261913, ['s'] = 0.564680 },
        }
    },
    {
        ['Time'] = 98,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000023, ['s'] = 0.000692 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000612, ['s'] = 0.018362 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023698, ['s'] = 0.002918 },
        }
    },
}

Animations['pax_attack'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.929882, ['s'] = 0.778260 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.265313, ['s'] = 0.297157 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.740723, ['s'] = 0.382963 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.209028, ['s'] = 0.159419 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.261601, ['s'] = 0.558978 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.279932, ['s'] = 0.093650 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.162727, ['s'] = 0.354230 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.625230, ['s'] = 0.417449 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.175594, ['s'] = 0.119715 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.544918, ['s'] = 0.370282 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -1.164300, ['s'] = 1.587682 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.207285, ['s'] = 0.136669 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.133049, ['s'] = 0.181431 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.375629, ['s'] = 0.804919 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.312071, ['s'] = 0.002598 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.006612, ['s'] = 0.014168 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.000646, ['s'] = 0.014817 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.797848, ['s'] = 0.387392 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.002346, ['s'] = 0.013366 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.886042, ['s'] = 0.681439 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.873780, ['s'] = 1.191519 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.299962, ['s'] = 0.005767 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.009473, ['s'] = 0.012918 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.420113, ['s'] = 0.257872 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.093123, ['s'] = 0.058107 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.426421, ['s'] = 0.265603 },
        }
    },
    {
        ['Time'] = 3,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.423584, ['s'] = 0.361816 },
        }
    },
    {
        ['Time'] = 16,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.570083, ['s'] = 0.291681 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.313670, ['s'] = 0.002398 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.009734, ['s'] = 0.004682 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.417791, ['s'] = 0.234285 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.206559, ['s'] = 0.110061 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.350002, ['s'] = 0.280911 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.125962, ['s'] = 0.288022 },
        }
    },
    {
        ['Time'] = 24,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.772852, ['s'] = 1.304828 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.288749, ['s'] = 0.271547 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.098803, ['s'] = 0.114155 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.365276, ['s'] = 1.695017 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.412856, ['s'] = 0.376314 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.231848, ['s'] = 0.741250 },
        }
    },
    {
        ['Time'] = 30,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.549029, ['s'] = 0.386885 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.097151, ['s'] = 0.241721 },
        }
    },
    {
        ['Time'] = 33,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.454509, ['s'] = 1.363735 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.277954, ['s'] = 0.011994 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.133280, ['s'] = 0.038307 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.367498, ['s'] = 0.814193 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.296522, ['s'] = 0.129260 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.004439, ['s'] = 0.262542 },
        }
    },
    {
        ['Time'] = 36,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.887657, ['s'] = 3.644350 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.061593, ['s'] = 0.938156 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.151869, ['s'] = 0.404007 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.855444, ['s'] = 1.591544 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.125959, ['s'] = 0.415648 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.319198, ['s'] = 0.038505 },
        }
    },
    {
        ['Time'] = 37,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.906935, ['s'] = 0.062583 },
        }
    },
    {
        ['Time'] = 38,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.051558, ['s'] = 0.782329 },
        }
    },
    {
        ['Time'] = 46,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.032005, ['s'] = 0.335788 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.000123, ['s'] = 0.099323 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.010435, ['s'] = 0.302538 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.126793, ['s'] = 0.597841 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.165532, ['s'] = 0.259849 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.210262, ['s'] = 0.145982 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.030729, ['s'] = 1.172081 },
        }
    },
    {
        ['Time'] = 49,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.000012, ['s'] = 0.000007 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.205569, ['s'] = 0.321092 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.000125, ['s'] = 0.000075 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.020675, ['s'] = 0.012793 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.177353, ['s'] = 0.372297 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.019211, ['s'] = 0.010119 },
        }
    },
    {
        ['Time'] = 50,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.001753, ['s'] = 0.256139 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.000087, ['s'] = 0.056960 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.001156, ['s'] = 0.261782 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.277195, ['s'] = 0.197261 },
        }
    },
    {
        ['Time'] = 52,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.499035, ['s'] = 0.045449 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.834419, ['s'] = 0.542729 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.216381, ['s'] = 0.087962 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.127289, ['s'] = 0.008559 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.661866, ['s'] = 1.743479 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.114381, ['s'] = 0.191818 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.080648, ['s'] = 0.486051 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.755374, ['s'] = 0.554108 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.298946, ['s'] = 0.003463 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.008470, ['s'] = 0.005759 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.601883, ['s'] = 0.950853 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.033980, ['s'] = 0.344922 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.280631, ['s'] = 0.144625 },
        }
    },
    {
        ['Time'] = 68,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.297020, ['s'] = 0.912113 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.347222, ['s'] = 1.154006 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.263539, ['s'] = 0.457227 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.000633, ['s'] = 0.093405 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.341275, ['s'] = 0.488641 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.282436, ['s'] = 0.593280 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.176368, ['s'] = 0.195494 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.514487, ['s'] = 0.925858 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.497979, ['s'] = 1.321772 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.431317, ['s'] = 0.288979 },
        }
    },
    {
        ['Time'] = 80,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.148545, ['s'] = 0.494919 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.329025, ['s'] = 0.060655 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.679517, ['s'] = 1.386592 },
        }
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.440183, ['s'] = 1.314122 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.268328, ['s'] = 0.173158 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.407582, ['s'] = 1.782901 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.063496, ['s'] = 1.153130 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.295757, ['s'] = 0.005315 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.000784, ['s'] = 0.012810 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.305891, ['s'] = 0.212300 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.145219, ['s'] = 0.823299 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.327487, ['s'] = 0.906714 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.007311, ['s'] = 1.010581 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.119738, ['s'] = 0.812780 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023795, ['s'] = 1.242190 },
        }
    },
    {
        ['Time'] = 89,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.014559, ['s'] = 0.401957 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.365329, ['s'] = 0.108911 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.056928, ['s'] = 2.209335 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.003277, ['s'] = 0.927505 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.333411, ['s'] = 0.564574 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.002457, ['s'] = 0.989831 },
        }
    },
    {
        ['Time'] = 90,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.049577, ['s'] = 1.302021 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.307154, ['s'] = 0.129421 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.015001, ['s'] = 1.408607 },
            { ['c'] = 'move', ['p'] = Core, ['a'] = z_axis, ['t'] = -1.261913, ['s'] = 0.564680 },
        }
    },
    {
        ['Time'] = 98,
        ['commands'] = {}
    },
    {
        ['Time'] = 99,
        ['commands'] = {}
    },
}

function pax_unpack_CoThread()

    Sleep(1600)
    Move(Body, y_axis, 15, 80.972222222222222222222222222222)
    WaitForMove(Body, y_axis)
    Move(Body, y_axis, 0, 60)
    WaitForMove(Body, y_axis)
    Spring.PlaySoundFile("sounds/cComEnder/comEnderStep.wav", 0.9)
end

Animations['pax_unpack'] = {
    {
        ['Time'] = 0,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.046979, ['s'] = 0.317460 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.000002, ['s'] = 0.000010 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.000057, ['s'] = 0.000015 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.522583, ['s'] = 0.672458 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.864446, ['s'] = 0.027831 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 1.507519, ['s'] = 0.020517 },
        }
    },
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 1.481772, ['s'] = 0.117162 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.188993, ['s'] = 0.188961 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.890101, ['s'] = 0.890068 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 2.433565, ['s'] = 1.932978 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.000104, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.000237, ['s'] = 0.000409 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.929882, ['s'] = 0.778260 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.617071, ['s'] = 2.226634 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.004340, ['s'] = 0.004543 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.000314, ['s'] = 0.008125 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -1.477902, ['s'] = 0.066542 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.000015, ['s'] = 0.000004 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.000005, ['s'] = 0.000001 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 1.665738, ['s'] = 0.833873 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.464229, ['s'] = 0.464260 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -1.276006, ['s'] = 1.276009 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.674404, ['s'] = 2.078669 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.000027, ['s'] = 0.000011 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.000001, ['s'] = 0.000077 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.088827, ['s'] = 0.433755 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.764122, ['s'] = 0.100324 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.839452, ['s'] = 0.668067 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -1.051558, ['s'] = 1.045655 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.812705, ['s'] = 0.725144 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 1.391144, ['s'] = 0.734350 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 2.434680, ['s'] = 1.936453 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.000005, ['s'] = 0.000090 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.000093, ['s'] = 0.000078 },
        }
    },
    {
        ['Time'] = 2,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.886042, ['s'] = 0.681439 },
        }
    },
    {
        ['Time'] = 14,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.201377, ['s'] = 1.459634 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.000005, ['s'] = 0.000037 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.000020, ['s'] = 0.000032 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.272901, ['s'] = 1.483287 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.003024, ['s'] = 0.002193 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.003250, ['s'] = 0.005941 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.793865, ['s'] = 1.066167 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.000100, ['s'] = 0.000006 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.000154, ['s'] = 0.000139 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.711082, ['s'] = 1.205996 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.000021, ['s'] = 0.000025 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.000066, ['s'] = 0.000045 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.000027 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = z_axis, ['t'] = -0.071034, ['s'] = 0.000002 },
            { ['c'] = 'turn', ['p'] = podturret1, ['a'] = y_axis, ['t'] = -1 * -0.000014, ['s'] = 0.000005 },
        }
    },
    {
        ['Time'] = 31,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.090651, ['s'] = 0.027351 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.763390, ['s'] = 0.010980 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.813182, ['s'] = 0.394039 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 1.456805, ['s'] = 0.374501 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.211282, ['s'] = 0.334341 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.838871, ['s'] = 0.768461 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 1.673937, ['s'] = 0.122983 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.469339, ['s'] = 0.076654 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -1.235462, ['s'] = 0.608150 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.758452, ['s'] = 4.396600 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.770204, ['s'] = 0.637520 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 1.157345, ['s'] = 3.506981 },
        }
    },
    {
        ['Time'] = 32,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.222799, ['s'] = 0.091809 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.657906, ['s'] = 2.819619 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.077053, ['s'] = 0.330313 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.274276, ['s'] = 0.005893 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.415595, ['s'] = 1.794079 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.040789, ['s'] = 0.188739 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.936774, ['s'] = 0.122493 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.204718, ['s'] = 0.175558 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.041142, ['s'] = 0.035133 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.648918, ['s'] = 0.053283 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.016163, ['s'] = 0.013872 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.397413, ['s'] = 0.340697 },
        }
    },
    {
        ['Time'] = 33,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.073044, ['s'] = 1.745542 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.505480, ['s'] = 1.903306 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.380167, ['s'] = 0.649523 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 1.015638, ['s'] = 0.696580 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.631006, ['s'] = 0.662722 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.038179, ['s'] = 1.264250 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.605311, ['s'] = 1.781043 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -1.041652, ['s'] = 0.953855 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.352433, ['s'] = 2.646492 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.203962, ['s'] = 1.443620 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.307845, ['s'] = 1.617072 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.323714, ['s'] = 1.250447 },
        }
    },
    {
        ['Time'] = 37,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.906935, ['s'] = 0.062583 },
        }
    },
    {
        ['Time'] = 38,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.381957, ['s'] = 1.468310 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.000012, ['s'] = 0.000021 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.000009, ['s'] = 0.000003 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.051558, ['s'] = 0.782329 },
        }
    },
    {
        ['Time'] = 39,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.486841, ['s'] = 0.282902 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.243110, ['s'] = 0.444424 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.158782, ['s'] = 0.087567 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.698825, ['s'] = 0.454874 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.140461, ['s'] = 0.294786 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.116772, ['s'] = 0.081411 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.030729, ['s'] = 1.172081 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.579776, ['s'] = 0.766064 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -1.034073, ['s'] = 0.227373 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.384461, ['s'] = 0.960851 },
        }
    },
    {
        ['Time'] = 52,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 1.404758, ['s'] = 11.673628 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.607642, ['s'] = 0.700917 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.023081, ['s'] = 1.837792 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.757210, ['s'] = 5.323026 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.872874, ['s'] = 4.835980 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.276114, ['s'] = 3.250417 },
        }
    },
    {
        ['Time'] = 53,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.047592 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.329665 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.247948 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.193817, ['s'] = 1.498665 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.020440, ['s'] = 0.588827 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.033561, ['s'] = 0.053102 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.703955, ['s'] = 1.597643 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.825621, ['s'] = 1.417583 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.363935, ['s'] = 2.634623 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.133064 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.200764 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.211130 },
        }
    },
    {
        ['Time'] = 54,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.220144, ['s'] = 0.894290 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.054143, ['s'] = 0.851385 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.045498, ['s'] = 0.308165 },
        }
    },
    {
        ['Time'] = 67,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.987426, ['s'] = 3.754393 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.114684, ['s'] = 0.963196 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.193226, ['s'] = 0.258329 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.101139, ['s'] = 3.017355 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.063632, ['s'] = 0.576220 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.126051, ['s'] = 0.069592 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.888853, ['s'] = 0.359405 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.129605, ['s'] = 0.563349 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.136587, ['s'] = 0.715832 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.927774, ['s'] = 1.673134 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.227869, ['s'] = 1.464191 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.244158, ['s'] = 0.919533 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.514487, ['s'] = 0.925858 },
        }
    },
    {
        ['Time'] = 71,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -1.386684, ['s'] = 11.977714 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.033285, ['s'] = 2.441962 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.226245, ['s'] = 0.990557 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.431661, ['s'] = 9.915676 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.020599, ['s'] = 1.290995 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.140017, ['s'] = 0.418971 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.875432, ['s'] = 0.402632 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.133335, ['s'] = 0.111922 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.147932, ['s'] = 0.340348 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.817757, ['s'] = 8.533895 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.143676, ['s'] = 1.655862 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.168473, ['s'] = 0.866571 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.497979, ['s'] = 1.321772 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.778784, ['s'] = 9.793161 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.133316, ['s'] = 1.690757 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.118226, ['s'] = 0.326861 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.424896, ['s'] = 21.758045 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.036154, ['s'] = 1.457723 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.035751, ['s'] = 1.682702 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.483628, ['s'] = 21.662180 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.044297, ['s'] = 2.753567 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.062680, ['s'] = 2.722165 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.860529, ['s'] = 0.427722 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.119797, ['s'] = 0.238790 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.180301, ['s'] = 0.118282 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.800742, ['s'] = 0.219577 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.166429, ['s'] = 0.331128 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.181911, ['s'] = 0.636844 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.376074, ['s'] = 0.488220 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.095788, ['s'] = 0.596342 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.073799, ['s'] = 0.380477 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.465303, ['s'] = 0.183253 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.092636, ['s'] = 0.483387 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.090874, ['s'] = 0.281935 },
        }
    },
    {
        ['Time'] = 76,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.375268, ['s'] = 0.200691 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.001083, ['s'] = 0.032849 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.000092, ['s'] = 0.003052 },
        }
    },
    {
        ['Time'] = 77,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.045932, ['s'] = 1.097784 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.049380, ['s'] = 0.160990 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.004580, ['s'] = 0.014957 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.889317, ['s'] = 0.431807 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.062285, ['s'] = 0.862687 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.336325, ['s'] = 2.340355 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.819840, ['s'] = 0.286475 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.152279, ['s'] = 0.212241 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.311932, ['s'] = 1.950324 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.432723, ['s'] = 0.849745 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.166617, ['s'] = 1.062438 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.101555, ['s'] = 0.416340 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.591441, ['s'] = 1.892063 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.158261, ['s'] = 0.984375 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.102179, ['s'] = 0.169580 },
        }
    },
    {
        ['Time'] = 79,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.762933, ['s'] = 1.895748 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.122284, ['s'] = 0.899984 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.164590, ['s'] = 2.576024 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.704912, ['s'] = 1.723917 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.230718, ['s'] = 1.176581 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.167053, ['s'] = 2.173191 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.367012, ['s'] = 0.281618 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.366214, ['s'] = 0.855414 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.094667, ['s'] = 0.029519 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.539137, ['s'] = 0.784552 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.206573, ['s'] = 0.724681 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.096577, ['s'] = 0.084037 },
        }
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.382472, ['s'] = 2.282771 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.196239, ['s'] = 0.443730 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.118126, ['s'] = 0.278787 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.430444, ['s'] = 1.646810 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.316009, ['s'] = 0.511745 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.140159, ['s'] = 0.161362 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.347776, ['s'] = 1.148169 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.254176, ['s'] = 0.285615 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.043812, ['s'] = 0.316587 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.188313, ['s'] = 2.352922 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.000217, ['s'] = 0.002145 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.010628, ['s'] = 0.105709 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.000139 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.000014 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.007292, ['s'] = 1.010543 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.415173 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.043814 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.071958 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000000, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023795, ['s'] = 1.242190 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.471588 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.116008 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.097536 },
        }
    },
    {
        ['Time'] = 86,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.106159 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.113969 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.010613 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.882466 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.452873 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.272642 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.000155, ['s'] = 0.992974 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.003834, ['s'] = 0.738099 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.002427, ['s'] = 0.329046 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.847113 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.845124 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.218508 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.802721 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.586544 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.101060 },
        }
    },
    {
        ['Time'] = 87,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.104682, ['s'] = 4.394937 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000136, ['s'] = 0.005292 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.002350, ['s'] = 0.194668 },
        }
    },
    {
        ['Time'] = 89,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.313838 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.000388 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.007107 },
        }
    },
    {
        ['Time'] = 90,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.000233 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = 0.000007, ['s'] = 0.000022 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * -0.000019, ['s'] = 0.000064 },
        }
    },
    {
        ['Time'] = 98,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000070, ['s'] = 0.002097 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000005, ['s'] = 0.000147 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.023814, ['s'] = 0.000579 },
        }
    },
    {
        ['Time'] = 99,
        ['commands'] = {}
    },
}

function pack()
    Move(Body, y_axis, -40, 0)
    Turn(Body, x_axis, math.rad(-90), 0)
    tP(AUL, 0, 0, 90, 0)
    tP(AL, 88, 0, 0, 0)

    tP(AUR, 44, 0, -69, 0)
    tP(AR, 44, 25, 0, 0)


    tP(LL, 92, 0, 0, 0)
    tP(LUL, 88, 0, 0, 0)

    tP(LR, 92, 0, 0, 0)
    tP(LUR, 88, 0, 0, 0)
end



Animations['pax_alt_walk'] = {
    {
        ['Time'] = 0,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.028567, ['s'] = 0.026001 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = -0.048731, ['s'] = 0.048492 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * 1.015729, ['s'] = 0.924314 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.388859, ['s'] = 2.697053 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.015124, ['s'] = 0.038519 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.016531, ['s'] = 0.075625 },

            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.002856, ['s'] = 0.005100 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.005717, ['s'] = 0.001952 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.683117, ['s'] = 1.203706 },

            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.994413, ['s'] = 3.691073 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.023924, ['s'] = 0.052328 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.106236, ['s'] = 0.296152 },

            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = -0.020115, ['s'] = 0.011812 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = -0.050290, ['s'] = 0.032294 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -1.157691, ['s'] = 0.680397 },

            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.036439, ['s'] = 0.028057 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.090590, ['s'] = 0.066138 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * 1.294894, ['s'] = 0.996855 },

            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = 0.063065, ['s'] = 0.028682 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = -0.027927, ['s'] = 0.014790 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * -1.855356, ['s'] = 0.842882 },

            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.004244, ['s'] = 0.004510 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.007020, ['s'] = 0.002582 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 1.063510, ['s'] = 1.140564 },

            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * -0.001144, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.345132, ['s'] = 2.621227 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.013570, ['s'] = 0.053064 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.007887, ['s'] = 0.031300 },

            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.058263, ['s'] = 0.052998 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = 0.043115, ['s'] = 0.035004 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1.003590, ['s'] = 0.911431 },

            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.005645, ['s'] = 8.208740 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.027112, ['s'] = 0.178458 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.003685, ['s'] = 0.012229 },

            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = 0.005066, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * -0.001145, ['s'] = 0.000039 },

            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.391584, ['s'] = 0.978873 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.027610, ['s'] = 0.057498 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.027284, ['s'] = 0.065668 },

            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.445056, ['s'] = 1.112555 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.029008, ['s'] = 0.060993 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.033391, ['s'] = 0.080935 },

            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * -0.001144, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = 0.005066, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * -0.001145, ['s'] = 0.000039 },

            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = 0.005068, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * -0.001139, ['s'] = 0.000037 },

            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * -0.001140, ['s'] = 0.000037 },

            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.070518, ['s'] = 0.105725 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.022742, ['s'] = 0.041029 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.195368, ['s'] = 0.291528 },

            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.311119, ['s'] = 0.777710 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.023229, ['s'] = 0.046545 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.022554, ['s'] = 0.053843 },

            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = -0.000449, ['s'] = 0.000103 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * -0.001113, ['s'] = 0.000030 },

            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.015097, ['s'] = 0.018914 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = -0.043721, ['s'] = 0.060415 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 1.847208, ['s'] = 2.310280 },

            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.000100 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000137 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.000038 },

            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.333467, ['s'] = 0.833755 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.122185, ['s'] = 0.316989 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.025747, ['s'] = 0.066909 },

            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.209780, ['s'] = 0.286111 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.068136, ['s'] = 0.086626 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.135627, ['s'] = 0.186332 },
        }
    },
    {
        ['Time'] = 5,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.362967, ['s'] = 1.786610 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.106289, ['s'] = 0.395883 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.013397, ['s'] = 0.085406 },
        }
    },
    {
        ['Time'] = 8,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.650946, ['s'] = 0.524175 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.031768, ['s'] = 0.033289 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.059932, ['s'] = 0.086802 },

            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.451713, ['s'] = 0.213163 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.032060, ['s'] = 0.036979 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.018338, ['s'] = 0.020902 },
        }
    },
    {
        ['Time'] = 11,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.909215, ['s'] = 0.283991 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.075860, ['s'] = 0.332614 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.095299, ['s'] = 0.036456 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.727284, ['s'] = 2.118943 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.098358, ['s'] = 0.026434 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.037901, ['s'] = 0.081680 },
        }
    },
    {
        ['Time'] = 12,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.128212, ['s'] = 0.820730 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.122868, ['s'] = 0.150408 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.007879, ['s'] = 0.030639 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.511787, ['s'] = 0.136819 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.012620, ['s'] = 0.007233 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.041726, ['s'] = 0.043827 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.497126, ['s'] = 0.035502 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.002937, ['s'] = 0.017776 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.012141, ['s'] = 0.031045 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.403330, ['s'] = 0.502362 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.048200, ['s'] = 0.050444 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.091013, ['s'] = 0.044499 },
        }
    },
    {
        ['Time'] = 17,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = -0.000101, ['s'] = 0.003412 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.004828, ['s'] = 0.001025 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.033460, ['s'] = 0.749604 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.224686, ['s'] = 0.340619 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.016317, ['s'] = 0.045068 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.152973, ['s'] = 0.401933 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.285903, ['s'] = 0.945815 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.020761, ['s'] = 0.166279 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.066247, ['s'] = 0.060742 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.511243, ['s'] = 1.085381 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.089223, ['s'] = 0.036445 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.075238, ['s'] = 0.054712 },
        }
    },
    {
        ['Time'] = 22,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.101750, ['s'] = 0.467296 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.032299, ['s'] = 0.150653 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.039236, ['s'] = 0.262294 },
        }
    },
    {
        ['Time'] = 23,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.574382, ['s'] = 0.382822 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.029761, ['s'] = 0.010036 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.052023, ['s'] = 0.039547 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.688026, ['s'] = 1.709609 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.048559, ['s'] = 0.120928 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.089903, ['s'] = 0.107348 },
        }
    },
    {
        ['Time'] = 24,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.006105 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.019258 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.729612 },
        }
    },
    {
        ['Time'] = 28,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000222, ['s'] = 0.006380 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.005108, ['s'] = 0.002731 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.000648, ['s'] = 1.518375 },
        }
    },
    {
        ['Time'] = 29,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.855919, ['s'] = 5.207787 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.120442, ['s'] = 0.194316 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.006750, ['s'] = 0.125942 },
        }
    },
    {
        ['Time'] = 31,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.540047, ['s'] = 0.494202 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.031167, ['s'] = 0.110042 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.035923, ['s'] = 0.033653 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.436792, ['s'] = 2.031502 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.120630, ['s'] = 0.449686 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.022393, ['s'] = 0.113240 },
        }
    },
    {
        ['Time'] = 33,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.016176, ['s'] = 0.030795 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = 0.008003, ['s'] = 0.025691 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1.361738, ['s'] = 0.262059 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 3.614267, ['s'] = 0.000047 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -1.188023, ['s'] = 0.000074 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = y_axis, ['t'] = 0.376384, ['s'] = 0.000144 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.003235, ['s'] = 0.016521 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = -0.023488, ['s'] = 0.016463 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * 1.220757, ['s'] = 0.133714 },
        }
    },
    {
        ['Time'] = 34,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.331915, ['s'] = 1.684959 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.091485, ['s'] = 0.192882 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.042288, ['s'] = 0.065344 },
        }
    },
    {
        ['Time'] = 39,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.018102 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.042060 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.637395 },
        }
    },
    {
        ['Time'] = 42,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.318081, ['s'] = 0.484421 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.105872, ['s'] = 0.084892 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.062037, ['s'] = 0.026309 },
        }
    },
    {
        ['Time'] = 43,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.002123, ['s'] = 0.002301 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.005795, ['s'] = 0.001000 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.531204, ['s'] = 0.514908 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.960515, ['s'] = 5.372425 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.085996, ['s'] = 0.206673 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.022730, ['s'] = 0.176877 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.891131, ['s'] = 1.218631 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.057954, ['s'] = 0.056371 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.100253, ['s'] = 0.062098 },
        }
    },
    {
        ['Time'] = 45,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.262524, ['s'] = 0.290446 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.113360, ['s'] = 0.012116 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.029720, ['s'] = 0.012212 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.577764, ['s'] = 0.460968 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.056742, ['s'] = 0.065143 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.060783, ['s'] = 0.034678 },
        }
    },
    {
        ['Time'] = 46,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.196209, ['s'] = 0.485648 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.056998, ['s'] = 0.046940 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.174638, ['s'] = 0.024998 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.460231, ['s'] = 1.250708 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.059187, ['s'] = 0.067023 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.025342, ['s'] = 0.006531 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.404763, ['s'] = 0.972735 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.118097, ['s'] = 0.120286 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.002997, ['s'] = 0.206500 },
        }
    },
    {
        ['Time'] = 49,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.002260, ['s'] = 0.004381 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.005516, ['s'] = 0.000720 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.483825, ['s'] = 0.852666 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.012090 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.033892 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 0.708090 },
        }
    },
    {
        ['Time'] = 56,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.255297, ['s'] = 1.704308 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.130487, ['s'] = 0.212829 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.073709, ['s'] = 0.080969 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.415565, ['s'] = 0.103095 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.028262, ['s'] = 0.016759 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.001330, ['s'] = 0.046131 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.506402, ['s'] = 0.019875 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.113712, ['s'] = 0.237374 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.003800, ['s'] = 0.034161 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.319610, ['s'] = 0.774579 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.037901, ['s'] = 0.011034 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.033910, ['s'] = 0.061182 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.236384, ['s'] = 2.089845 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.023451, ['s'] = 0.107209 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.015988, ['s'] = 0.123991 },
        }
    },
    {
        ['Time'] = 61,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.896528, ['s'] = 4.422877 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.022602, ['s'] = 0.102421 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.001341, ['s'] = 0.178326 },
        }
    },
    {
        ['Time'] = 63,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.829735, ['s'] = 2.047987 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.034357, ['s'] = 0.148132 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.018163, ['s'] = 0.021669 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.071336, ['s'] = 1.428974 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.079761, ['s'] = 0.164295 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.022762, ['s'] = 0.084704 },
        }
    },
    {
        ['Time'] = 66,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.055971 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.029112 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 1.636071 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.001669 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000396 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.001140, ['s'] = 0.427911 },
        }
    },
    {
        ['Time'] = 68,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.075332, ['s'] = 0.491767 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.086406, ['s'] = 0.240348 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.082576, ['s'] = 0.180767 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.766783, ['s'] = 1.394961 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.005824, ['s'] = 0.339990 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.027109, ['s'] = 0.127089 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.570784, ['s'] = 0.627002 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.030850, ['s'] = 0.013874 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.032254, ['s'] = 0.090454 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.494170, ['s'] = 0.033358 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.005350, ['s'] = 0.295532 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.001391, ['s'] = 0.006571 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.612981, ['s'] = 1.283095 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.048203, ['s'] = 0.239932 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.023904, ['s'] = 0.087498 },
        }
    },
    {
        ['Time'] = 71,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.665574, ['s'] = 0.866077 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = -0.045758, ['s'] = 0.086835 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.019262, ['s'] = 0.067205 },
        }
    },
    {
        ['Time'] = 72,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.002669 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000779 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.001140, ['s'] = 0.567925 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.231135, ['s'] = 0.754137 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.001626, ['s'] = 0.103455 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.261342, ['s'] = 0.769375 },
        }
    },
    {
        ['Time'] = 74,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.019090 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.003388 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -0.001143, ['s'] = 1.569916 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 3.614287, ['s'] = 0.000023 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -1.187992, ['s'] = 0.000036 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = y_axis, ['t'] = 0.376445, ['s'] = 0.000070 },
        }
    },
    {
        ['Time'] = 79,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.631253, ['s'] = 0.850640 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.019681, ['s'] = 0.231590 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.012133, ['s'] = 0.025846 },



            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = -0.000368, ['s'] = 0.005147 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.040792 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * -0.001143, ['s'] = 1.745571 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.360451, ['s'] = 1.465750 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.002888, ['s'] = 0.069495 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.006280, ['s'] = 0.036488 },
        }
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 1.210127 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.001194 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.001140, ['s'] = 0.041003 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.779687 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.000447 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.000393 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.778493 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.043490 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.001142, ['s'] = 0.000353 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.599960 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.080567 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.001140, ['s'] = 0.065719 },
        }
    },
    {
        ['Time'] = 86,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.355266, ['s'] = 2.113968 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.005226, ['s'] = 0.053373 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.002531, ['s'] = 0.031422 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.140893, ['s'] = 5.705593 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.086994, ['s'] = 0.392816 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.026308, ['s'] = 0.195205 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.263777, ['s'] = 2.922527 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.011931, ['s'] = 0.200444 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.018218, ['s'] = 0.140406 },
        }
    },
    {
        ['Time'] = 89,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.631374 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.005067, ['s'] = 0.018256 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.001140, ['s'] = 0.709639 },
        }
    },
    {
        ['Time'] = 92,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.000369, ['s'] = 0.281113 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.005068, ['s'] = 0.305018 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.001139, ['s'] = 0.313933 },
        }
    },
    {
        ['Time'] = 95,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.338078, ['s'] = 4.816892 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.005339, ['s'] = 0.553999 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.004100, ['s'] = 0.133248 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.358043, ['s'] = 0.565597 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.000889, ['s'] = 0.066250 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.000907, ['s'] = 0.103862 },
        }
    },
}


Animations['paxcentrail_walk'] = {
    {
        ['Time'] = 0,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.183129, ['s'] = 0.299342 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.033583, ['s'] = 1.007493 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.003084, ['s'] = 0.092518 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.184824, ['s'] = 0.284555 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.033890, ['s'] = 1.016707 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.003141, ['s'] = 0.094233 },
        }
    },
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.497080, ['s'] = 1.345506 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.076936, ['s'] = 0.185799 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.007053, ['s'] = 0.043446 },


            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.755981, ['s'] = 1.922493 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.025099, ['s'] = 0.426353 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.001994, ['s'] = 0.226254 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.436591, ['s'] = 0.186582 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.318569, ['s'] = 0.830719 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.078350, ['s'] = 0.121248 },



            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.609493, ['s'] = 2.315630 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.051813, ['s'] = 0.029467 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.055303, ['s'] = 0.119114 },



            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.013257, ['s'] = 0.056969 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.030774, ['s'] = 0.115861 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.022091, ['s'] = 0.384969 },



            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = 0.000123, ['s'] = 0.000527 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = -0.007608, ['s'] = 0.032608 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * 0.000013, ['s'] = 0.000055 },



            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = -0.008578, ['s'] = 0.018381 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000113, ['s'] = 0.000242 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * 0.001209, ['s'] = 0.002592 },



            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.383226, ['s'] = 0.686075 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.011184, ['s'] = 0.467042 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.040026, ['s'] = 0.083295 },



            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.005931, ['s'] = 0.025419 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.000128, ['s'] = 0.000547 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.100764, ['s'] = 0.431844 },



            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.676315, ['s'] = 1.272531 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.023558, ['s'] = 0.101558 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.188382, ['s'] = 0.826859 },



            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = -0.019836, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * -0.000718, ['s'] = 0.000220 },



            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.000180, ['s'] = 0.000073 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = 0.000768, ['s'] = 0.000311 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * -0.000618, ['s'] = 0.000251 },



            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = 0.000040, ['s'] = 0.000041 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = 0.000170, ['s'] = 0.000176 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * -0.000137, ['s'] = 0.000142 },



            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.125751, ['s'] = 0.096732 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = -0.208931, ['s'] = 0.160716 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * 2.664121, ['s'] = 2.049324 },



            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000071, ['s'] = 0.000084 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000124, ['s'] = 0.000149 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.311416, ['s'] = 0.373699 },



            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.150619, ['s'] = 0.079273 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = 0.134881, ['s'] = 0.070990 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -2.792893, ['s'] = 1.469944 },


            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000014, ['s'] = 0.000025 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000059, ['s'] = 0.000105 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000048, ['s'] = 0.000084 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000066, ['s'] = 0.000079 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000302, ['s'] = 0.000362 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.558663, ['s'] = 0.670395 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.670736, ['s'] = 3.083026 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.032373, ['s'] = 0.138742 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.089863, ['s'] = 0.385129 },



            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.476582, ['s'] = 1.250391 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.061423, ['s'] = 0.117998 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.039334, ['s'] = 0.155113 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 3.612007, ['s'] = 0.000332 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -1.188691, ['s'] = 0.000078 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * 0.372597, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },
        }
    },
    {
        ['Time'] = 7,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.019397, ['s'] = 1.509838 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.065376, ['s'] = 0.203219 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.392040, ['s'] = 1.620246 },


            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.519608, ['s'] = 3.545595 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.072983, ['s'] = 0.718261 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.015800, ['s'] = 0.266915 },
        }
    },
    {
        ['Time'] = 8,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.691114, ['s'] = 0.443966 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.026507, ['s'] = 0.088474 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.184090, ['s'] = 0.128788 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.033683, ['s'] = 4.592290 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.124082, ['s'] = 0.141438 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.007537, ['s'] = 0.043772 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.126603, ['s'] = 1.809553 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.081479, ['s'] = 0.060167 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.020255, ['s'] = 0.178769 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.085571, ['s'] = 2.745071 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.049635, ['s'] = 1.492884 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.091823, ['s'] = 0.268220 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.678586, ['s'] = 0.235480 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.029991, ['s'] = 0.071457 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.092133, ['s'] = 0.068078 },



            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000028 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.002800 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000239 },
        }
    },
    {
        ['Time'] = 9,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.487090, ['s'] = 6.120725 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.049406, ['s'] = 0.686972 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.186706, ['s'] = 0.078481 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.626068, ['s'] = 0.010360 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.041133, ['s'] = 0.006675 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.072943, ['s'] = 0.011025 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.439305, ['s'] = 7.178414 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.023167, ['s'] = 0.204737 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.077018, ['s'] = 0.453451 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.020199, ['s'] = 0.793273 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.006258, ['s'] = 0.325326 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.002712, ['s'] = 0.709013 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.297733, ['s'] = 2.043351 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.001756, ['s'] = 0.178066 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.009773, ['s'] = 0.063932 },
        }
    },
    {
        ['Time'] = 10,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.040024, ['s'] = 4.470660 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.118044, ['s'] = 0.686383 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.175293, ['s'] = 0.114123 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.018099, ['s'] = 4.212065 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.021962, ['s'] = 0.451284 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.031785, ['s'] = 0.452321 },
        }
    },
    {
        ['Time'] = 13,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.505369, ['s'] = 1.090786 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.300507, ['s'] = 0.364925 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.024227, ['s'] = 0.399040 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.503108, ['s'] = 1.042413 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.314491, ['s'] = 0.585058 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.043234, ['s'] = 0.150040 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.101629, ['s'] = 0.261060 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.012735, ['s'] = 0.013878 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.131980, ['s'] = 0.277002 },
        }
    },
    {
        ['Time'] = 15,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000135, ['s'] = 0.005940 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000574, ['s'] = 0.000314 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000462, ['s'] = 0.001140 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.335811, ['s'] = 1.054712 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.103352, ['s'] = 0.562426 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.066206, ['s'] = 1.527486 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.452832, ['s'] = 0.032482 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.186747, ['s'] = 0.263644 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.345115, ['s'] = 0.533529 },
        }
    },
    {
        ['Time'] = 17,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.000026, ['s'] = 0.022052 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.080754, ['s'] = 0.185880 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.247926, ['s'] = 0.376392 },
        }
    },
    {
        ['Time'] = 18,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.747209, ['s'] = 3.057968 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.232620, ['s'] = 0.465164 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.219735, ['s'] = 0.974023 },


            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000107, ['s'] = 0.000083 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000457, ['s'] = 0.000351 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000368, ['s'] = 0.000283 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.755731, ['s'] = 2.696265 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.201480, ['s'] = 0.514290 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.098144, ['s'] = 0.333809 },
        }
    },
    {
        ['Time'] = 21,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.627094, ['s'] = 2.470208 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.046118, ['s'] = 0.359061 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.013335, ['s'] = 0.026719 },
        }
    },
    {
        ['Time'] = 24,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.543302, ['s'] = 1.037456 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.125094, ['s'] = 0.108710 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.335301, ['s'] = 1.345477 },
        }
    },
    {
        ['Time'] = 25,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.667479, ['s'] = 3.599101 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.134021, ['s'] = 0.328663 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.014626, ['s'] = 0.683695 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.749276, ['s'] = 0.019367 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.194758, ['s'] = 0.020166 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.097902, ['s'] = 0.000727 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.015132, ['s'] = 1.284452 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.089211, ['s'] = 0.270660 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.003931, ['s'] = 0.018807 },
        }
    },
    {
        ['Time'] = 26,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000001, ['s'] = 0.000077 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000466, ['s'] = 0.000380 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.062039, ['s'] = 0.414949 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000024, ['s'] = 0.000052 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000773, ['s'] = 0.000589 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.022090, ['s'] = 0.670716 },
        }
    },
    {
        ['Time'] = 27,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.009769, ['s'] = 0.477423 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.007109, ['s'] = 0.024111 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.183537, ['s'] = 0.220961 },
        }
    },
    {
        ['Time'] = 28,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.536520, ['s'] = 0.116814 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.307115, ['s'] = 0.024781 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.046179, ['s'] = 0.082322 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.147259, ['s'] = 1.334434 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.172548, ['s'] = 0.532286 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.041101, ['s'] = 0.007998 },
        }
    },
    {
        ['Time'] = 30,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.699415, ['s'] = 0.468340 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.035700, ['s'] = 0.268182 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.029802, ['s'] = 1.095311 },



            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000073 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000311 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000250 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.289928, ['s'] = 0.287477 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.206907, ['s'] = 0.035576 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.038974, ['s'] = 0.540248 },
        }
    },
    {
        ['Time'] = 34,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.704583, ['s'] = 1.113127 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.141702, ['s'] = 0.230421 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.026509, ['s'] = 0.356471 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.150500, ['s'] = 2.404049 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.044321, ['s'] = 0.558183 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.143144, ['s'] = 0.605899 },
        }
    },
    {
        ['Time'] = 35,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.140838, ['s'] = 1.491921 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.198993, ['s'] = 0.101102 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.044167, ['s'] = 0.031163 },



            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.027538, ['s'] = 0.051585 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.005583, ['s'] = 0.140945 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.011272, ['s'] = 0.485998 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.085804, ['s'] = 1.473671 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.174043, ['s'] = 0.036556 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.026098, ['s'] = 0.218824 },
        }
    },
    {
        ['Time'] = 36,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.472608, ['s'] = 3.784229 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.080020, ['s'] = 0.851607 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.197148, ['s'] = 0.912477 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.296709, ['s'] = 5.414879 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.043960, ['s'] = 0.811905 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.285388, ['s'] = 1.224335 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.043579, ['s'] = 1.455595 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.002833, ['s'] = 0.353654 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.070935, ['s'] = 0.541569 },
        }
    },
    {
        ['Time'] = 40,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.063835 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.106686 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.355000 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.134029, ['s'] = 2.120199 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.016997, ['s'] = 0.070139 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.014183, ['s'] = 0.164945 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.014041, ['s'] = 0.172859 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.001602, ['s'] = 0.003692 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.025007, ['s'] = 0.137783 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.776608, ['s'] = 1.343781 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.061381, ['s'] = 0.049112 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.031611, ['s'] = 0.062722 },
        }
    },
    {
        ['Time'] = 44,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.194529, ['s'] = 2.707204 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.043352, ['s'] = 0.462644 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.193471, ['s'] = 0.013789 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.052031, ['s'] = 0.917543 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.077673, ['s'] = 0.126423 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.206304, ['s'] = 0.296566 },
        }
    },
    {
        ['Time'] = 47,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.262094, ['s'] = 0.083504 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.098585, ['s'] = 0.916474 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.174692, ['s'] = 0.640999 },
        }
    },
    {
        ['Time'] = 48,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.146209, ['s'] = 2.802376 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.014722, ['s'] = 0.022748 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.035985, ['s'] = 0.218017 },
        }
    },
    {
        ['Time'] = 50,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000387, ['s'] = 0.000436 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.001283, ['s'] = 0.000612 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 1.014264, ['s'] = 1.190609 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.021955, ['s'] = 0.359960 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.000662, ['s'] = 0.009398 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.000835, ['s'] = 0.258421 },
        }
    },
    {
        ['Time'] = 51,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.551892, ['s'] = 2.028416 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.013678, ['s'] = 0.005220 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.067546, ['s'] = 0.157805 },



            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.058819, ['s'] = 0.093844 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.092967, ['s'] = 0.295649 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.128386, ['s'] = 0.351341 },
        }
    },
    {
        ['Time'] = 52,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.808607, ['s'] = 2.315535 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.004148, ['s'] = 0.235223 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.222160, ['s'] = 0.172134 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.503617, ['s'] = 1.554764 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.166118, ['s'] = 0.140891 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.083505, ['s'] = 0.168589 },



            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000188, ['s'] = 0.000083 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000801, ['s'] = 0.000356 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000645, ['s'] = 0.000287 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.721889, ['s'] = 1.980848 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.082356, ['s'] = 0.028102 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.129788, ['s'] = 0.459092 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.419136, ['s'] = 1.428564 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.171503, ['s'] = 0.010885 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.096213, ['s'] = 0.300493 },
        }
    },
    {
        ['Time'] = 53,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000804, ['s'] = 0.001047 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000892, ['s'] = 0.000556 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.895629, ['s'] = 1.249131 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.020495, ['s'] = 0.424506 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.002365, ['s'] = 0.017024 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.001509, ['s'] = 0.006748 },
        }
    },
    {
        ['Time'] = 56,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.144778, ['s'] = 1.864236 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.019700, ['s'] = 0.260021 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.061969, ['s'] = 0.906893 },
        }
    },
    {
        ['Time'] = 57,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.871503, ['s'] = 1.886896 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.010649, ['s'] = 0.195015 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.216009, ['s'] = 0.184531 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.601378, ['s'] = 0.376982 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.011809, ['s'] = 0.122659 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.007445, ['s'] = 0.202374 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.233997, ['s'] = 0.511397 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.014271, ['s'] = 0.035038 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.029340, ['s'] = 0.056874 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.622907, ['s'] = 1.305332 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.100268, ['s'] = 0.096211 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.049858, ['s'] = 0.130449 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.598440, ['s'] = 1.793541 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.082617, ['s'] = 0.027699 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.036898, ['s'] = 0.089360 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.773408, ['s'] = 1.545562 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.082652, ['s'] = 0.008854 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.128530, ['s'] = 0.037746 },
        }
    },
    {
        ['Time'] = 58,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.720488, ['s'] = 2.265235 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.004415, ['s'] = 0.225951 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.225162, ['s'] = 0.137298 },



            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.110057 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.098045 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 2.043059 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.637773, ['s'] = 2.034526 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.081150, ['s'] = 0.022519 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.103710, ['s'] = 0.372305 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.056089, ['s'] = 0.204665 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.038917, ['s'] = 0.135269 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.141674, ['s'] = 0.183934 },
        }
    },
    {
        ['Time'] = 59,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.562725, ['s'] = 0.177324 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.286948, ['s'] = 0.362488 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.172001, ['s'] = 0.265488 },



            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000158, ['s'] = 0.000070 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000674, ['s'] = 0.000300 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000543, ['s'] = 0.000241 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.563390, ['s'] = 0.432762 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.155682, ['s'] = 0.047463 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.227011, ['s'] = 0.392393 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.200709, ['s'] = 1.559336 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.060186, ['s'] = 0.167313 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.239307, ['s'] = 0.042437 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.151211, ['s'] = 1.459687 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.003675, ['s'] = 0.254476 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.029727, ['s'] = 0.221949 },
        }
    },
    {
        ['Time'] = 61,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.000209, ['s'] = 0.125593 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.073300, ['s'] = 0.042143 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.124179, ['s'] = 0.009015 },
        }
    },
    {
        ['Time'] = 69,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.537325, ['s'] = 5.500250 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.165431, ['s'] = 0.607583 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.169202, ['s'] = 0.013995 },



            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000050 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000212 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000170 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.196842, ['s'] = 1.832739 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.167739, ['s'] = 0.060284 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.193806, ['s'] = 0.166027 },
        }
    },
    {
        ['Time'] = 70,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.607459, ['s'] = 2.020420 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.198317, ['s'] = 0.345326 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.047000, ['s'] = 0.480769 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.620737, ['s'] = 1.929868 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.251221, ['s'] = 0.618865 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.025773, ['s'] = 0.138749 },
        }
    },
    {
        ['Time'] = 71,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.010271, ['s'] = 0.142200 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.005152, ['s'] = 0.094434 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.004648, ['s'] = 0.293627 },
        }
    },
    {
        ['Time'] = 75,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 1.705291, ['s'] = 5.839828 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.089612, ['s'] = 0.379095 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.157333, ['s'] = 0.059344 },



            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000035 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000147 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000118 },



            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.022176, ['s'] = 0.054917 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.059667, ['s'] = 0.332418 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.077955, ['s'] = 0.505335 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000744 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000497 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.268722 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.816308, ['s'] = 5.065749 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.167550, ['s'] = 0.000941 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.020266, ['s'] = 0.867696 },
        }
    },
    {
        ['Time'] = 76,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000777 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000009 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.167281 },
        }
    },
    {
        ['Time'] = 80,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.370776, ['s'] = 0.341948 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.038362, ['s'] = 0.060228 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.037408, ['s'] = 0.020171 },


            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.310329, ['s'] = 2.160830 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.041788, ['s'] = 0.306218 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.031451, ['s'] = 0.040853 },
        }
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.763248, ['s'] = 5.652254 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.089922, ['s'] = 0.001862 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.084691, ['s'] = 0.435850 },


            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000197, ['s'] = 0.000056 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000841, ['s'] = 0.000235 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000677, ['s'] = 0.000189 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.758506, ['s'] = 0.346809 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.126155, ['s'] = 0.248370 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.004844, ['s'] = 0.150658 },
        }
    },
    {
        ['Time'] = 82,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.964211, ['s'] = 2.773535 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.001250, ['s'] = 0.352176 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.153826, ['s'] = 0.188516 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.257385, ['s'] = 6.260407 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.048748, ['s'] = 0.674912 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.041581, ['s'] = 0.224513 },
        }
    },
    {
        ['Time'] = 84,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.510482, ['s'] = 2.266778 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.098783, ['s'] = 0.398102 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.023009, ['s'] = 0.145735 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.352452, ['s'] = 0.497852 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.067068, ['s'] = 0.157754 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.020796, ['s'] = 0.026702 },


            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.104865, ['s'] = 1.556980 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.019131, ['s'] = 0.228446 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.024056, ['s'] = 0.027732 },
        }
    },
    {
        ['Time'] = 85,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.081809, ['s'] = 0.920797 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.003350, ['s'] = 0.085016 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.001399, ['s'] = 0.060467 },
        }
    },
    {
        ['Time'] = 86,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.781124, ['s'] = 0.268131 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.081181, ['s'] = 0.131122 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.089841, ['s'] = 0.077249 },


            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000024 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000104 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000084 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.723667, ['s'] = 0.174195 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.060136, ['s'] = 0.330096 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.026957, ['s'] = 0.110569 },
        }
    },
    {
        ['Time'] = 87,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.016199, ['s'] = 0.095935 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = -0.091991, ['s'] = 0.379145 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.175107, ['s'] = 0.632655 },
        }
    },
    {
        ['Time'] = 88,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.695516, ['s'] = 0.642056 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.041648, ['s'] = 0.296499 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.088051, ['s'] = 0.013426 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.065078, ['s'] = 0.501947 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.002352, ['s'] = 0.029924 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.000569, ['s'] = 0.024894 },
        }
    },
    {
        ['Time'] = 89,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.194609 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.004400 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.003848 },
        }
    },
    {
        ['Time'] = 91,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.388866, ['s'] = 0.493053 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.000815, ['s'] = 0.185861 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.003651, ['s'] = 0.142236 },
        }
    },
    {
        ['Time'] = 92,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.163610, ['s'] = 3.681968 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.000501, ['s'] = 0.176343 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.001118, ['s'] = 0.382152 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.008432, ['s'] = 1.625180 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.067618, ['s'] = 0.125384 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.027305, ['s'] = 0.043301 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.190537, ['s'] = 3.918019 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = 0.001123, ['s'] = 0.262541 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.000352, ['s'] = 0.117041 },


            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.376039, ['s'] = 1.162171 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.056706, ['s'] = 0.161033 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.047366, ['s'] = 0.099899 },
        }
    },
    {
        ['Time'] = 99,
        ['commands'] = {}
    },
}



Animations['paxcentrail_antiairstance'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.195984, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.003386, ['s'] = 0.000000 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -2.766912, ['s'] = 2.766912 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.038810, ['s'] = 0.038810 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.002720, ['s'] = 0.002720 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.084751, ['s'] = 0.231140 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.381036, ['s'] = 1.039189 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.144275, ['s'] = 0.393478 },



            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.489756, ['s'] = 0.489756 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.003363, ['s'] = 0.003363 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.009219, ['s'] = 0.009219 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.003610, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -1.054161, ['s'] = 0.318779 },



            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000057, ['s'] = 0.000049 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000244, ['s'] = 0.000209 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000196, ['s'] = 0.000168 },



            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = -0.010885, ['s'] = 0.040819 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = 0.203806, ['s'] = 0.764274 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * -0.050577, ['s'] = 0.189664 },



            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.425004, ['s'] = 0.750007 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.144711, ['s'] = 0.255373 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 1.033593, ['s'] = 1.823988 },



            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.773269, ['s'] = 0.074027 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.007139, ['s'] = 0.001156 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.013057, ['s'] = 0.000808 },



            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.016026, ['s'] = 0.147812 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.373488, ['s'] = 1.360852 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.098207, ['s'] = 0.102179 },



            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = -0.019836, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * -0.000718, ['s'] = 0.000220 },



            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000071, ['s'] = 0.000084 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000124, ['s'] = 0.000149 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.311416, ['s'] = 0.373699 },



            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000066, ['s'] = 0.000079 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000302, ['s'] = 0.000362 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.558663, ['s'] = 0.670395 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },



            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.069403, ['s'] = 0.040019 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.454721, ['s'] = 1.655695 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.094828, ['s'] = 0.175919 },



            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.189430, ['s'] = 0.017273 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.268322, ['s'] = 0.879118 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.008670, ['s'] = 0.044293 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 3.612007, ['s'] = 0.000332 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -1.188691, ['s'] = 0.000078 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * 0.372597, ['s'] = 0.000000 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000064 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000271 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000218 },
        }
    },
    {
        ['Time'] = 9,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.019765, ['s'] = 0.005608 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.425941, ['s'] = 0.078680 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.047803, ['s'] = 0.219014 },



            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.003698 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.067640 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.016621 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.085708, ['s'] = 0.290833 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.457866, ['s'] = 0.005897 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.058554, ['s'] = 0.287591 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.325857, ['s'] = 0.099824 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.263517, ['s'] = 0.003516 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.272935, ['s'] = 0.193364 },
        }
    },
    {
        ['Time'] = 11,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.201425, ['s'] = 0.009068 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.274764, ['s'] = 0.402106 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.052045, ['s'] = 0.081097 },
        }
    },
    {
        ['Time'] = 12,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.306446, ['s'] = 1.330167 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.063497, ['s'] = 1.905236 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.446365, ['s'] = 1.812535 },
        }
    },
    {
        ['Time'] = 13,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -1.111222, ['s'] = 0.440809 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.012586, ['s'] = 0.007105 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.126487, ['s'] = 0.182014 },
        }
    },
    {
        ['Time'] = 17,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.363348, ['s'] = 0.569020 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.364035, ['s'] = 3.005378 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.369971, ['s'] = 0.763938 },
        }
    },
    {
        ['Time'] = 18,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.080732, ['s'] = 1.092881 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.341239, ['s'] = 0.809918 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.359751, ['s'] = 1.123071 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.307315, ['s'] = 0.560327 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.155726, ['s'] = 2.083085 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.450391, ['s'] = 0.804200 },
        }
    },
    {
        ['Time'] = 23,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.968277, ['s'] = 3.832990 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.612570, ['s'] = 1.772991 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.564299, ['s'] = 4.878249 },
        }
    },
    {
        ['Time'] = 25,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.097787, ['s'] = 0.008628 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.536410, ['s'] = 0.056103 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.506730, ['s'] = 0.403775 },
        }
    },
    {
        ['Time'] = 26,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.016716, ['s'] = 0.033291 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.006877, ['s'] = 0.013505 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -1.026105, ['s'] = 1.429378 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.009154, ['s'] = 0.018178 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.007671, ['s'] = 0.014739 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.772536, ['s'] = 0.427747 },
        }
    },
    {
        ['Time'] = 29,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.019069, ['s'] = 0.020881 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.429725, ['s'] = 0.113501 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.070174, ['s'] = 0.671156 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.424361, ['s'] = 0.098354 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.274458, ['s'] = 0.000135 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.059340, ['s'] = 0.003218 },
        }
    },
    {
        ['Time'] = 30,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.195558, ['s'] = 0.321941 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.392476, ['s'] = 0.055874 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.079842, ['s'] = 0.014501 },
        }
    },
    {
        ['Time'] = 31,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -1.056627, ['s'] = 1.546011 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.012912, ['s'] = 0.026041 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.014272, ['s'] = 0.013781 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -3.026959, ['s'] = 0.260046 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.609331, ['s'] = 0.570522 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.068888, ['s'] = 0.071608 },
        }
    },
    {
        ['Time'] = 36,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000072 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000306 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000246 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -3.044495, ['s'] = 5.355716 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.281636, ['s'] = 1.698752 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.822235, ['s'] = 3.223597 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.813897, ['s'] = 0.405443 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.009742, ['s'] = 0.003878 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.119027, ['s'] = 0.334792 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.963382, ['s'] = 0.029373 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.977537, ['s'] = 2.189802 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.770567, ['s'] = 1.237610 },
        }
    },
    {
        ['Time'] = 41,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 2.927517, ['s'] = 1.522319 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.985414, ['s'] = 0.012437 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 2.382318, ['s'] = 0.613024 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000024, ['s'] = 0.030436 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000773, ['s'] = 0.022994 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.022090, ['s'] = 2.501488 },



            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000001, ['s'] = 0.041786 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000466, ['s'] = 0.016027 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.062039, ['s'] = 2.720359 },
        }
    },
    {
        ['Time'] = 42,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.464718, ['s'] = 2.536751 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.001913, ['s'] = 0.047139 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.010773, ['s'] = 0.014998 },
        }
    },
    {
        ['Time'] = 47,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -4.658952, ['s'] = 3.725670 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.176004, ['s'] = 0.243768 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -1.488625, ['s'] = 1.537823 },
        }
    },
    {
        ['Time'] = 49,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.190839, ['s'] = 0.684698 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.447165, ['s'] = 1.113131 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.124950, ['s'] = 0.339306 },
        }
    },
    {
        ['Time'] = 50,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.268949, ['s'] = 0.275218 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.379251, ['s'] = 0.049591 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.002113, ['s'] = 0.291483 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000387, ['s'] = 0.000436 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.001283, ['s'] = 0.000612 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 1.014264, ['s'] = 1.190609 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.349575, ['s'] = 0.088946 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.262909, ['s'] = 0.002277 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.250514, ['s'] = 0.084076 },
        }
    },
    {
        ['Time'] = 53,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000804, ['s'] = 0.001047 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000892, ['s'] = 0.000556 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.895629, ['s'] = 1.249131 },
        }
    },
    {
        ['Time'] = 58,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.374379, ['s'] = 0.243300 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.361443, ['s'] = 0.041096 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.060048, ['s'] = 0.133698 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.377433, ['s'] = 0.064287 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.259517, ['s'] = 0.007828 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.473153, ['s'] = 0.513780 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.773837, ['s'] = 0.052253 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.030395, ['s'] = 0.026938 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.049871, ['s'] = 0.090204 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -3.196298, ['s'] = 1.125118 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.610965, ['s'] = 0.334586 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.004590, ['s'] = 1.148627 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.007330, ['s'] = 2.246298 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.576791, ['s'] = 0.314325 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.032884, ['s'] = 1.807257 },
        }
    },
    {
        ['Time'] = 61,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.003719, ['s'] = 0.153599 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.215634, ['s'] = 0.182788 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.021749, ['s'] = 0.115814 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -2.973211, ['s'] = 0.042433 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.361122, ['s'] = 0.195955 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.082972, ['s'] = 0.119890 },
        }
    },
    {
        ['Time'] = 67,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.352177, ['s'] = 0.254390 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.450675, ['s'] = 0.085735 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.093013, ['s'] = 0.413718 },
        }
    },
    {
        ['Time'] = 71,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.497049, ['s'] = 0.141542 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.342333, ['s'] = 0.022050 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.328952, ['s'] = 0.310274 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.411598, ['s'] = 0.039421 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.258234, ['s'] = 0.001481 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.563006, ['s'] = 0.103677 },
        }
    },
    {
        ['Time'] = 75,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000744 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000497 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.268722 },
        }
    },
    {
        ['Time'] = 76,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000777 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000009 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.167281 },
        }
    },
    {
        ['Time'] = 81,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = -0.822360, ['s'] = 0.080872 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.041271, ['s'] = 0.018128 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.032309, ['s'] = 0.029269 },
        }
    },
    {
        ['Time'] = 97,
        ['commands'] = {}
    },
    {
        ['Time'] = 99,
        ['commands'] = {}
    },
    {
        ['Time'] = 100,
        ['commands'] = {}
    },
}


Animations['paxcentrail_stomp'] = {
    {
        ['Time'] = 1,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.195984, ['s'] = 0.000887 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.033500, ['s'] = 0.003436 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.003386, ['s'] = 0.003156 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -2.523762, ['s'] = 5.407504 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.273503, ['s'] = 0.583250 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.804521, ['s'] = 1.722209 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.014877, ['s'] = 0.023079 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.182389, ['s'] = 0.285900 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 1.246755, ['s'] = 1.969860 },



            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000154 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000136 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000024 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 1.700912, ['s'] = 3.645368 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.141191, ['s'] = 0.305378 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -1.142727, ['s'] = 2.446938 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.639464, ['s'] = 0.829734 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.018340, ['s'] = 0.003323 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.009802, ['s'] = 0.016711 },



            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000154 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000136 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000024 },



            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000153 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000080 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000101 },



            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.072462, ['s'] = 0.136353 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.001499, ['s'] = 0.000338 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 0.000770, ['s'] = 0.002988 },



            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000153 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000080 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000101 },


            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.747907, ['s'] = 2.244500 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.002162, ['s'] = 0.010444 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.014963, ['s'] = 0.047359 },



            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000154 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000136 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000024 },



            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.591321, ['s'] = 0.843146 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.040223, ['s'] = 0.067975 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.075036, ['s'] = 0.004239 },



            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = -0.019836, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * -0.000718, ['s'] = 0.000031 },



            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000135 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000029 },



            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000147 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000134 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000031 },



            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000071, ['s'] = 0.000396 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000124, ['s'] = 0.001434 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.311416, ['s'] = 0.372711 },



            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000153 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000080 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000101 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000066, ['s'] = 0.000233 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000302, ['s'] = 0.001220 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.558663, ['s'] = 0.671383 },



            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000169 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000111 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000057 },



            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000143 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000133 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000034 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.119980, ['s'] = 0.022859 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.010953, ['s'] = 0.000569 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.049062, ['s'] = 0.001178 },



            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000147 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000134 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000031 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.464269, ['s'] = 0.846299 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.034629, ['s'] = 0.002683 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.004919, ['s'] = 0.011575 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 3.612007, ['s'] = 0.000405 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -1.188691, ['s'] = 0.000136 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * 0.372597, ['s'] = 0.000177 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000154 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000136 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000024 },
        }
    },
    {
        ['Time'] = 11,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.078041, ['s'] = 0.152236 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.032201, ['s'] = 0.000722 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.001313, ['s'] = 0.002611 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.400226, ['s'] = 0.613555 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000100, ['s'] = 0.003991 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.008129, ['s'] = 0.012061 },
        }
    },
    {
        ['Time'] = 15,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 2.029076, ['s'] = 0.656328 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.172160, ['s'] = 0.061939 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.894506, ['s'] = 0.496442 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -3.265073, ['s'] = 1.482622 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.209539, ['s'] = 0.966083 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.561594, ['s'] = 0.485853 },
        }
    },
    {
        ['Time'] = 17,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -2.467001, ['s'] = 4.761492 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.296675, ['s'] = 0.559076 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 1.586202, ['s'] = 2.972684 },
        }
    },
    {
        ['Time'] = 20,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.787299, ['s'] = 4.158868 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.745798, ['s'] = 1.300174 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 1.834588, ['s'] = 1.356538 },
        }
    },
    {
        ['Time'] = 24,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.915174, ['s'] = 1.619265 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.064186, ['s'] = 0.119814 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.064119, ['s'] = 0.054583 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 1.394895, ['s'] = 1.416433 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.006286, ['s'] = 0.022601 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * 0.019204, ['s'] = 0.017628 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -1.222189, ['s'] = 1.421100 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.029251, ['s'] = 0.010084 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.014559, ['s'] = 0.018075 },
        }
    },
    {
        ['Time'] = 26,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000001, ['s'] = 0.000077 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000466, ['s'] = 0.000380 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * 0.062039, ['s'] = 0.414949 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000024, ['s'] = 0.000052 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000773, ['s'] = 0.000589 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 0.022090, ['s'] = 0.670716 },
        }
    },
    {
        ['Time'] = 28,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.900326, ['s'] = 0.577039 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.005111, ['s'] = 0.006013 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.015704, ['s'] = 0.008741 },
        }
    },
    {
        ['Time'] = 30,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.366506, ['s'] = 1.353995 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.087186, ['s'] = 0.069001 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.036524, ['s'] = 0.082786 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.074090, ['s'] = 5.864958 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.431432, ['s'] = 1.810778 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.106506, ['s'] = 2.363999 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -1.204314, ['s'] = 6.182276 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.731478, ['s'] = 2.823051 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.792766, ['s'] = 4.063080 },
        }
    },
    {
        ['Time'] = 33,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -2.081968, ['s'] = 1.925166 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.118829, ['s'] = 2.077521 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * 1.045813, ['s'] = 2.701942 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 1.608356, ['s'] = 0.894719 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.062717, ['s'] = 4.042575 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 1.582680, ['s'] = 1.259541 },
        }
    },
    {
        ['Time'] = 39,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.660315, ['s'] = 4.216530 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.069989, ['s'] = 0.488410 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.591072, ['s'] = 16.368854 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.202942, ['s'] = 18.112973 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.460218, ['s'] = 3.975002 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.913317, ['s'] = 6.693630 },
        }
    },
    {
        ['Time'] = 40,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.517892, ['s'] = 3.636917 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.034974, ['s'] = 0.223766 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.075112, ['s'] = 0.165378 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.020465, ['s'] = 0.402185 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.333715, ['s'] = 0.732884 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.214862, ['s'] = 0.812665 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = -0.062486, ['s'] = 3.363185 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.018254, ['s'] = 0.027618 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.002969, ['s'] = 0.051168 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.234269, ['s'] = 3.361058 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.031802, ['s'] = 0.005886 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.006465, ['s'] = 0.048517 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = -0.311453, ['s'] = 2.060448 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.330522, ['s'] = 0.925283 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.906102, ['s'] = 0.261544 },
        }
    },
    {
        ['Time'] = 42,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.647137, ['s'] = 0.395318 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.037456, ['s'] = 0.975964 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.529772, ['s'] = 1.838999 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.143194, ['s'] = 1.792430 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.343931, ['s'] = 3.488591 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.853754, ['s'] = 1.786898 },
        }
    },
    {
        ['Time'] = 43,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -1.707977, ['s'] = 0.456301 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.023865, ['s'] = 0.459909 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.666671, ['s'] = 1.026744 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.383971, ['s'] = 3.611659 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.087083, ['s'] = 3.852731 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.604184, ['s'] = 3.743545 },
        }
    },
    {
        ['Time'] = 44,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = -0.552772, ['s'] = 0.859855 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.977865, ['s'] = 1.967369 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * 0.415360, ['s'] = 0.945333 },
        }
    },
    {
        ['Time'] = 45,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = -0.309510, ['s'] = 1.116921 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.394415, ['s'] = 4.609986 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.651032, ['s'] = 0.702719 },
        }
    },
    {
        ['Time'] = 47,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.106856, ['s'] = 3.123743 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.006641, ['s'] = 0.208077 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.063704, ['s'] = 0.057040 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.387537, ['s'] = 7.922645 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.274193, ['s'] = 1.501966 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.353012, ['s'] = 1.881954 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.177665, ['s'] = 2.435874 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.440301, ['s'] = 4.173577 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 0.677045, ['s'] = 0.130066 },
        }
    },
    {
        ['Time'] = 50,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = -0.000387, ['s'] = 0.000436 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.001283, ['s'] = 0.000612 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * 1.014264, ['s'] = 1.190609 },
        }
    },
    {
        ['Time'] = 52,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = -0.228223, ['s'] = 4.779402 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.268843, ['s'] = 0.160495 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.043102, ['s'] = 9.297315 },
        }
    },
    {
        ['Time'] = 53,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -1.729923, ['s'] = 4.591948 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.106787, ['s'] = 0.283571 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.335866, ['s'] = 0.998926 },



            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000804, ['s'] = 0.001047 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000892, ['s'] = 0.000556 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.895629, ['s'] = 1.249131 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.931645, ['s'] = 8.792678 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.032917, ['s'] = 0.094133 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * -0.119984, ['s'] = 0.724485 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.882879, ['s'] = 1.923311 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 1.019006, ['s'] = 1.578287 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * 1.096788, ['s'] = 1.144753 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.221915, ['s'] = 1.227649 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.970053, ['s'] = 1.912393 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.237689, ['s'] = 0.530691 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.534422, ['s'] = 2.306931 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.746681, ['s'] = 1.134978 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * 0.323375, ['s'] = 1.589255 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = x_axis, ['t'] = 0.003342, ['s'] = 0.042018 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = z_axis, ['t'] = 0.018283, ['s'] = 0.000018 },
            { ['c'] = 'turn', ['p'] = Body, ['a'] = y_axis, ['t'] = -1 * -0.003010, ['s'] = 0.000026 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.007259, ['s'] = 0.567525 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.035310, ['s'] = 0.008771 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.001868, ['s'] = 0.011494 },
        }
    },
    {
        ['Time'] = 54,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.119393, ['s'] = 1.378118 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000841, ['s'] = 0.010505 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.002055, ['s'] = 0.024087 },
        }
    },
    {
        ['Time'] = 60,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 1.751625, ['s'] = 1.080121 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.001668, ['s'] = 0.187492 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.087418, ['s'] = 1.244414 },
        }
    },
    {
        ['Time'] = 64,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.190034 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.832233 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.203122 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.473983 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.838929 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.356634 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.756575 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.872674 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.940715 },



            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.457898 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.639253 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.277790 },
        }
    },
    {
        ['Time'] = 65,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.798875, ['s'] = 1.862095 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.104634, ['s'] = 0.004307 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.163597, ['s'] = 0.344538 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.520993, ['s'] = 1.057118 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.028130, ['s'] = 0.007185 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.006839, ['s'] = 0.014386 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.641143, ['s'] = 2.220964 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.006045, ['s'] = 0.015428 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.087588, ['s'] = 0.000339 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.561938, ['s'] = 0.978845 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.031071, ['s'] = 0.007480 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.010072, ['s'] = 0.014478 },
        }
    },
    {
        ['Time'] = 71,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.209855, ['s'] = 1.356934 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000778, ['s'] = 0.000957 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * 0.003761, ['s'] = 0.025593 },
        }
    },
    {
        ['Time'] = 73,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.241901 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000125 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.005163 },
        }
    },
    {
        ['Time'] = 75,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000744 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000497 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.268722 },
        }
    },
    {
        ['Time'] = 76,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000208, ['s'] = 0.000777 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = 0.000886, ['s'] = 0.000009 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 1.167281 },
        }
    },
    {
        ['Time'] = 80,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.895394, ['s'] = 1.447780 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.071931, ['s'] = 0.490539 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.152464, ['s'] = 0.166999 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.706118, ['s'] = 0.974629 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.016280, ['s'] = 0.334887 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.059590, ['s'] = 0.419965 },
        }
    },
    {
        ['Time'] = 82,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.652238, ['s'] = 1.823668 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.043133, ['s'] = 0.215987 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.084469, ['s'] = 0.509962 },



            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.536738, ['s'] = 6.346386 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.032073, ['s'] = 0.023659 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.007893, ['s'] = 0.088391 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.639392, ['s'] = 0.500445 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.025413, ['s'] = 0.068497 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.030224, ['s'] = 0.220243 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = -0.165225, ['s'] = 1.678070 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.036339, ['s'] = 0.012156 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * 0.002207, ['s'] = 0.028336 },
        }
    },
    {
        ['Time'] = 86,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.400105, ['s'] = 3.781991 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.051047, ['s'] = 0.118707 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.039318, ['s'] = 0.677262 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.497565, ['s'] = 2.127402 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.011505, ['s'] = 0.208620 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.048444, ['s'] = 0.273299 },
        }
    },
    {
        ['Time'] = 87,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.712936, ['s'] = 0.755134 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.030408, ['s'] = 0.007135 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.009774, ['s'] = 0.008063 },
        }
    },
    {
        ['Time'] = 88,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = -0.430210, ['s'] = 0.903136 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = -0.035066, ['s'] = 0.479429 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * 0.037071, ['s'] = 0.067422 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.452740, ['s'] = 1.344751 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.013130, ['s'] = 0.048732 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.042904, ['s'] = 0.166204 },
        }
    },
    {
        ['Time'] = 89,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LR, ['a'] = x_axis, ['t'] = 0.055635, ['s'] = 1.325033 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = z_axis, ['t'] = 0.007996, ['s'] = 0.117441 },
            { ['c'] = 'turn', ['p'] = LR, ['a'] = y_axis, ['t'] = -1 * -0.070949, ['s'] = 0.294599 },



            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = 0.058527, ['s'] = 5.913202 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = 0.021263, ['s'] = 0.515897 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.079886, ['s'] = 0.554730 },
        }
    },
    {
        ['Time'] = 91,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = x_axis, ['t'] = -0.080282, ['s'] = 0.462696 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = z_axis, ['t'] = -0.014537, ['s'] = 0.119336 },
            { ['c'] = 'turn', ['p'] = LUR, ['a'] = y_axis, ['t'] = -1 * 0.047176, ['s'] = 0.109034 },
        }
    },
    {
        ['Time'] = 94,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = 0.713182, ['s'] = 0.007396 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.030348, ['s'] = 0.001796 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * 0.009777, ['s'] = 0.000079 },
        }
    },
    {
        ['Time'] = 95,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = x_axis, ['t'] = -0.195958, ['s'] = 5.454841 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = z_axis, ['t'] = 0.030941, ['s'] = 0.003560 },
            { ['c'] = 'turn', ['p'] = LUL, ['a'] = y_axis, ['t'] = -1 * -0.002899, ['s'] = 0.076055 },



            { ['c'] = 'turn', ['p'] = LL, ['a'] = x_axis, ['t'] = 0.184578, ['s'] = 2.098821 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = z_axis, ['t'] = -0.035177, ['s'] = 0.006972 },
            { ['c'] = 'turn', ['p'] = LL, ['a'] = y_axis, ['t'] = -1 * -0.003947, ['s'] = 0.036924 },
        }
    },
    {
        ['Time'] = 99,
        ['commands'] = {
            { ['c'] = 'turn', ['p'] = AR, ['a'] = x_axis, ['t'] = 0.000218, ['s'] = 0.000291 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = AR, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000265 },



            { ['c'] = 'turn', ['p'] = AUL, ['a'] = x_axis, ['t'] = 0.000219, ['s'] = 0.000346 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = AUL, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000282 },



            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = x_axis, ['t'] = 0.000219, ['s'] = 0.000346 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = podturret4, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000282 },



            { ['c'] = 'turn', ['p'] = SR2, ['a'] = x_axis, ['t'] = 0.000288, ['s'] = 0.002395 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = z_axis, ['t'] = -0.001718, ['s'] = 0.078092 },
            { ['c'] = 'turn', ['p'] = SR2, ['a'] = y_axis, ['t'] = -1 * -0.000767, ['s'] = 0.001629 },



            { ['c'] = 'turn', ['p'] = Core, ['a'] = x_axis, ['t'] = 0.000218, ['s'] = 0.000291 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = Core, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000265 },



            { ['c'] = 'turn', ['p'] = SR3, ['a'] = x_axis, ['t'] = 0.000288, ['s'] = 0.002395 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = z_axis, ['t'] = -0.001718, ['s'] = 0.078092 },
            { ['c'] = 'turn', ['p'] = SR3, ['a'] = y_axis, ['t'] = -1 * -0.000768, ['s'] = 0.001629 },



            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = x_axis, ['t'] = 0.000221, ['s'] = 0.000401 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = podturret3, ['a'] = y_axis, ['t'] = -1 * -0.000703, ['s'] = 0.000298 },



            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = x_axis, ['t'] = 0.000221, ['s'] = 0.000401 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = podturret0, ['a'] = y_axis, ['t'] = -1 * -0.000703, ['s'] = 0.000298 },



            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = x_axis, ['t'] = 0.000228, ['s'] = 0.000589 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = z_axis, ['t'] = -0.001673, ['s'] = 0.076771 },
            { ['c'] = 'turn', ['p'] = podturret5, ['a'] = y_axis, ['t'] = -1 * -0.000227, ['s'] = 0.014584 },



            { ['c'] = 'turn', ['p'] = AUR, ['a'] = x_axis, ['t'] = 0.000219, ['s'] = 0.000346 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = AUR, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000282 },



            { ['c'] = 'turn', ['p'] = AL, ['a'] = x_axis, ['t'] = 0.000218, ['s'] = 0.000291 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = AL, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000265 },



            { ['c'] = 'turn', ['p'] = SR1, ['a'] = x_axis, ['t'] = 0.000288, ['s'] = 0.002395 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = z_axis, ['t'] = -0.001718, ['s'] = 0.078092 },
            { ['c'] = 'turn', ['p'] = SR1, ['a'] = y_axis, ['t'] = -1 * -0.000767, ['s'] = 0.001629 },



            { ['c'] = 'turn', ['p'] = Head, ['a'] = x_axis, ['t'] = 0.000218, ['s'] = 0.000291 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = Head, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000265 },


            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = x_axis, ['t'] = 0.000210, ['s'] = 0.000056 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078146 },
            { ['c'] = 'turn', ['p'] = Weapon7, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000000 },



            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = x_axis, ['t'] = 0.000223, ['s'] = 0.000457 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = z_axis, ['t'] = -0.022441, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = Weapon6, ['a'] = y_axis, ['t'] = -1 * -0.000707, ['s'] = 0.000305 },



            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = x_axis, ['t'] = 0.000221, ['s'] = 0.000380 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078143 },
            { ['c'] = 'turn', ['p'] = Shield8, ['a'] = y_axis, ['t'] = -1 * -0.000734, ['s'] = 0.000626 },



            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = x_axis, ['t'] = 0.000221, ['s'] = 0.000401 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = Weapon4, ['a'] = y_axis, ['t'] = -1 * -0.000703, ['s'] = 0.000298 },


            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = x_axis, ['t'] = 0.000210, ['s'] = 0.000056 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078146 },
            { ['c'] = 'turn', ['p'] = Weapon3, ['a'] = y_axis, ['t'] = -1 * -0.000713, ['s'] = 0.000000 },



            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = x_axis, ['t'] = 0.000219, ['s'] = 0.000346 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = Weapon2, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000282 },



            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = x_axis, ['t'] = 0.000219, ['s'] = 0.000346 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = Weapon1, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000282 },



            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = x_axis, ['t'] = 0.000221, ['s'] = 0.000401 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = Shield2, ['a'] = y_axis, ['t'] = -1 * -0.000703, ['s'] = 0.000298 },



            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = x_axis, ['t'] = 0.000218, ['s'] = 0.000291 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = Shield3, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000265 },



            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = x_axis, ['t'] = 0.000221, ['s'] = 0.000401 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = Shield1, ['a'] = y_axis, ['t'] = -1 * -0.000703, ['s'] = 0.000298 },



            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = x_axis, ['t'] = 0.000228, ['s'] = 0.000589 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = z_axis, ['t'] = -0.001673, ['s'] = 0.076771 },
            { ['c'] = 'turn', ['p'] = Shield6, ['a'] = y_axis, ['t'] = -1 * -0.000227, ['s'] = 0.014584 },



            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = x_axis, ['t'] = 0.000218, ['s'] = 0.000291 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078145 },
            { ['c'] = 'turn', ['p'] = Shield4, ['a'] = y_axis, ['t'] = -1 * -0.000704, ['s'] = 0.000265 },



            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = x_axis, ['t'] = 0.000408, ['s'] = 0.005994 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = z_axis, ['t'] = -0.001707, ['s'] = 0.077776 },
            { ['c'] = 'turn', ['p'] = Shield5, ['a'] = y_axis, ['t'] = -1 * -0.000557, ['s'] = 0.004671 },



            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = x_axis, ['t'] = 0.000223, ['s'] = 0.000457 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = z_axis, ['t'] = -0.001719, ['s'] = 0.078144 },
            { ['c'] = 'turn', ['p'] = Weapon5, ['a'] = y_axis, ['t'] = -1 * -0.000703, ['s'] = 0.000315 },



            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = x_axis, ['t'] = 0.000229, ['s'] = 0.000631 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = z_axis, ['t'] = -0.001673, ['s'] = 0.076767 },
            { ['c'] = 'turn', ['p'] = Weapon8, ['a'] = y_axis, ['t'] = -1 * -0.000227, ['s'] = 0.014600 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 3.616915, ['s'] = 0.147243 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -1.188519, ['s'] = 0.005150 },
            { ['c'] = 'move', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * 0.371409, ['s'] = 0.035619 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = x_axis, ['t'] = 0.000288, ['s'] = 0.002395 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = z_axis, ['t'] = -0.001718, ['s'] = 0.078092 },
            { ['c'] = 'turn', ['p'] = Shield7, ['a'] = y_axis, ['t'] = -1 * -0.000767, ['s'] = 0.001629 },
        }
    },
    {
        ['Time'] = 100,
        ['commands'] = {}
    },
}



function constructSkeleton(unit, piece, offset)
    if (offset == nil) then
        offset = { 0, 0, 0 };
    end

    local bones = {};
    local info = Spring.GetUnitPieceInfo(unit, piece);

    for i = 1, 3 do
        info.offset[i] = offset[i] + info.offset[i];
    end

    bones[piece] = info.offset;
    local map = Spring.GetUnitPieceMap(unit);
    local children = info.children;

    if (children) then
        for i, childName in pairs(children) do
            local childId = map[childName];
            local childBones = constructSkeleton(unit, childId, info.offset);
            for cid, cinfo in pairs(childBones) do
                bones[cid] = cinfo;
            end
        end
    end
    return bones;
end