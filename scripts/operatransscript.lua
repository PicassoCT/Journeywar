include "wildPartySystem.lua"
include "createCorpse.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
local loaded = false

Ragdolls = {}
for i = 1, 10, 1 do
    if i ~= 9 then
        Ragdolls[i] = {}
        slot = "Rag" .. i
        Ragdolls[i] = piece(slot)
    elseif i == 10 then
        Ragdolls[9] = {}
        slot = "Rag" .. i
        Ragdolls[9] = piece(slot)
    end
end

sloth = {}
for i = 1, 5, 1 do
    sloth[i] = {}
    local slot = "slot" .. i
    sloth[i] = piece(slot)
end


--forbidden Zones
forbZone = {}
nrOfforbZones = 2

forbZone[1] = updegree
forbZone[2] = lowdegree
forbZone[3] = updist
forbZone[4] = dowdist

forbMap[1] = forbZone

forbZone2 = {}

updegree = 145
lowdegree = 42
updist = 13
dowdist = 2


forbZone2[1] = updegree
forbZone2[2] = lowdegree
forbZone2[3] = updist
forbZone2[4] = dowdist

forbMap[2] = forbZone2

local base = piece "operatrans"
local opcrane = piece "opcrane"
local operadoor1 = piece "operadoor1"
local operadoor2 = piece "operadoor2"
local testCenter1 = piece "testCenter1"

local body1 = piece "oppod"
local oppod1gun1 = piece "oppod1gun1"
local flare1 = piece "flare1"
local oppod1gun2 = piece "oppod1gun2"
local flare2 = piece "flare2"
local opAttachP = piece "opAttachP"
local passengertable = {}

local body2 = piece "oppod2"
local oppod2gun2 = piece "oppod2gun2"
local flare3 = piece "flare03"
local oppod2gun1 = piece "oppod2gun1"
local flare4 = piece "flare04"
-- declares all the pieces we'll use in the script.
local flipflop = true
local flipflop2 = false
local SIG_AIM = 2
local SIG_REST = 4
local SIG_BAY = 8
local overhead = 0
local cargo = 0
local cargoMax = 5
local RESTORE_DELAY = (Spring.UnitScript.GetLongestReloadTime(unitID) * 2) + 1024
-- picks a sensible Time to wait before trying to turn the turret back to default.


function script.Create()
    Turn(testCenter1, x_axis, math.rad(5.8), 0)
    Turn(testCenter1, z_axis, math.rad(-4), 0)
    Hide(flare1)
    Hide(flare2)
    Hide(flare3)
    Hide(flare4)
    StartThread(WildPartyManager)
    StartThread(costlyUnderAttack)
end

function script.StartMoving()
end

function script.StopMoving()
end


local function RestoreAfterDelay()
    -- defines a local funtion to wait a bit, then move the turret back to how it was originally.

    Sleep(RESTORE_DELAY)

    ------ Spring.Echo("Phail reached")
    Turn(body1, y_axis, math.rad(0), 5)
    Turn(body1, x_axis, math.rad(0), 5)
    Turn(body2, y_axis, math.rad(0), 5)
    Turn(body2, x_axis, math.rad(0), 5)
    Turn(oppod2gun2, x_axis, math.rad(0), 5)
    Turn(oppod2gun1, x_axis, math.rad(0), 5)
    Turn(oppod1gun2, x_axis, math.rad(0), 5)
    Turn(oppod1gun1, x_axis, math.rad(0), 5)
end

function script.AimWeapon1(heading, pitch)

    -- each Time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same Time.
    Turn(body1, y_axis, heading, 6)
    Turn(oppod1gun2, x_axis, -pitch, 5)
    Turn(oppod1gun1, x_axis, -pitch, 5)
    overhead = pitch

    WaitForTurn(body1, y_axis)
    WaitForTurn(oppod1gun2, x_axis)
    WaitForTurn(oppod1gun2, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

function script.QueryWeapon1()

    if (flipflop == true) then flipflop = false

        return flare1
    else
        flipflop = true
        return flare2
    end
end

function script.FireWeapon1()
    EmitSfx(flare1, 1)
    EmitSfx(flare2, 1)

    Turn(oppod1gun2, x_axis, overhead - 10, 8)
    Turn(oppod1gun1, x_axis, overhead - 10, 8)

    return true
end

function script.AimFromWeapon1()
    return body1
end



-- The piece that the bullet/laser/whatever comes out of.


function script.AimWeapon2(heading, pitch)

    -- each Time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same Time.
    Turn(body2, y_axis, heading, 6)
    Turn(oppod2gun2, x_axis, -pitch, 5)
    Turn(oppod2gun1, x_axis, -pitch, 5)
    overhead = pitch

    WaitForTurn(body2, y_axis)
    WaitForTurn(oppod2gun1, x_axis)
    WaitForTurn(oppod2gun2, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

function script.QueryWeapon2()

    if (flipflop2 == true) then flipflop2 = false

        return flare3
    else
        flipflop2 = true
        return flare4
    end
end

function script.FireWeapon2()
    EmitSfx(flare3, 1)
    EmitSfx(flare4, 1)

    Turn(oppod2gun2, x_axis, overhead - 10, 8)
    Turn(oppod2gun1, x_axis, overhead - 10, 8)

    return true
end

function script.AimFromWeapon2()
    return body2
end

function closeBaydoors()
    SetSignalMask(SIG_BAY)
    while (true == Spring.UnitScript.IsInMove(opcrane, y_axis)) do
        Sleep(300)
    end
    Move(operadoor1, x_axis, 0, 2)
    Move(operadoor1, z_axis, 0, 2)
    Move(operadoor2, x_axis, 0, 2)
    Move(operadoor2, z_axis, 0, 2)
end

function script.TransportPickup(passengerID)
    -- no napping!
    local passengerTeam = Spring.GetUnitTeam(passengerID)
    local ourTeam = Spring.GetUnitTeam(unitID)
    local gaiaTeamID = Spring.GetGaiaTeamID()
    if Spring.AreTeamsAllied(passengerTeam, ourTeam) == false and passengerTeam ~= gaiaTeamID then
        return
    end
    Signal(SIG_BAY)

    StartThread(playOperaSound)

    --if opera has full house
    if cargo >= cargoMax then return end
    SetUnitValue(COB.BUSY, 1)
    Move(operadoor1, x_axis, -12, 4)
    Move(operadoor1, z_axis, -14, 4)
    Move(operadoor2, x_axis, 12, 4)
    Move(operadoor2, z_axis, -14, 4)
    Spring.PlaySoundFile("sounds/cOperaT/opendoor.wav")
    WaitForMove(operadoor2, z_axis)
    WaitForMove(operadoor2, x_axis)
    WaitForMove(operadoor1, z_axis)
    WaitForMove(operadoor1, x_axis)

    local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
    local px2, py2, pz2 = Spring.GetUnitBasePosition(passengerID)
    local dx, dy, dz = px2 - px1, py2 - py1, pz2 - pz1
    local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID)) / 32768 * math.pi
    local dist = (dx ^ 2 + dy ^ 2) ^ 0.5

    --openBayDoors

    if dist > 128 then return end
    Move(opcrane, z_axis, dist, 15)
    WaitForMove(opcrane, z_axis)
    Turn(base, y_axis, heading, 9)
    WaitForTurn(base, y_axis)
    AttachUnit(opAttachP, passengerID)

    table.insert(passengertable, passengerID)
    Move(opcrane, z_axis, 0, 15)
    cargo = cargo + 1
    WaitForMove(opcrane, z_axis)
    AttachUnit(sloth[cargo], passengerID)
    Spring.SetUnitNoDraw(passengerID, true)
    Turn(base, y_axis, math.rad(0), 19)
    loaded = true
    SetUnitValue(COB.BUSY, 0)
    StartThread(closeBaydoors)
end


function script.TransportDrop(passengerID, x, y, z)
    if loaded == false then return end
    --if unit not loaded
    notloaded = true
    for i = 1, cargo, 1 do
        if passengertable[i] == passengerID then
            notloaded = false
        end
    end

    if notloaded == true then return end

    SetUnitValue(COB.BUSY, 1)
    Signal(SIG_BAY)

    y = y - Spring.GetUnitHeight(passengerID) - 10
    local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
    local dx, dy, dz = x - px1, y - py1, z - pz1
    local heading = (Spring.GetHeadingFromVector(dx, dz) - Spring.GetUnitHeading(unitID)) / 32768 * math.pi
    local dist = (dx ^ 2 + dy ^ 2) ^ 0.5
    local angleV = math.atan(dy / dist)
    dist = dist / math.cos(angleV) -- convert 2d distance (adjacent) to 3d dist (hypotenuse)


    Move(operadoor1, x_axis, -12, 2)
    Move(operadoor1, z_axis, -14, 2)
    Move(operadoor2, x_axis, 12, 2)
    Move(operadoor2, z_axis, -14, 2)
    Spring.PlaySoundFile("sounds/cOperaT/opendoor.wav")
    WaitForMove(operadoor2, z_axis)
    WaitForMove(operadoor2, x_axis)
    WaitForMove(operadoor1, z_axis)
    WaitForMove(operadoor1, x_axis)
    Move(opcrane, z_axis, 0, 15)
    WaitForMove(opcrane, z_axis)

    AttachUnit(opAttachP, passengerID)
    Spring.SetUnitNoDraw(passengerID, false)
    Move(opcrane, z_axis, 50, 15)
    WaitForMove(opcrane, z_axis)

    DropUnit(passengerID)
    cargo = cargo - 1

    if cargo <= 0 then
        loaded = false
    end

    Move(opcrane, z_axis, 0, 15)
    WaitForMove(opcrane, z_axis)

    StartThread(closeBaydoors)
    SetUnitValue(COB.BUSY, 0)
end


LastDamage = 0
_, maxHP = Spring.GetUnitHealth(unitID)
enumerate = 1
operaDefID = Spring.GetUnitDefID(unitID)

function playOperaSound()
    path = "sounds/cOperaT/opera" .. enumerate .. ".ogg"
    succesfull = PlaySoundByUnitDefID(operaDefID, path, 0.5, 10000, 1, 0)
    if succesfull == true then
        enumerate = enumerate % 6 + 1
    end
end


function script.HitByWeapon(x, z, weaponDefID, damage)

    if damage > maxHP / 20 then
        StartThread(playOperaSound)
    end


    LastDamage = damage
    return damage
end

SIGHT_DISTANCE = 420

function costlyUnderAttack()
    id, olhp, hp = 0, 0, 0
    while true do

        if LastDamage and LastDamage > 0 then
            LastDamage = 0
            Spring.UseUnitResource(unitID, "e", 50)
            Spring.UseUnitResource(unitID, "m", 5)
        end

        --Add Reward with Battles in Sight
        if id and Spring.GetUnitIsDead(id) == false and oldhp and hp and oldhp > hp then
            distanced = distanceUnitToUnit(id, uniID)
            if isAlive(id) == true and distanced < SIGHT_DISTANCE then
                Spring.AddUnitResource(unitID, "m", 10)
                oldhp = hp
            end
        end


        id = Spring.GetUnitNearestEnemy(unitID)
        if id then
            hp = Spring.GetUnitHealth(id)
        end
        Sleep(500)
    end
end




-- The unit looks from this piece down the QueryWeapon piece, to see whether it's aiming at anything.

function script.Killed(recentDamage, maxHealth)
    for i = 1, 8, 1 do
        Explode(Ragdolls[i], SFX.FIRE + SFX.FALL)
        tempVal = dramatisPersona[i][11]
        for a = 1, tempVal, 1 do
            ------ Spring.Echo("I:",i .." A:", a)
            Hide(dramatisPersona[i][3][a])
        end
        Sleep(80)
    end
    random = math.random(-1, 1)
    if random == 0 then
        random = 1
    end
    random = random * 65
    Explode(operadoor1, SFX.FIRE + SFX.FALL)
    Hide(operadoor1)
    Explode(operadoor2, SFX.FIRE + SFX.FALL)
    Hide(operadoor2)
    Turn(base, x_axis, math.rad(10), 0.2)
    Turn(base, z_axis, math.rad(random), 0.5)
    Explode(body1, SFX.FIRE + SFX.FALL)
    Hide(body1)
    Explode(body2, SFX.FIRE + SFX.FALL)
    Hide(body2)
    WaitForTurn(base, z_axis)
    unitx, unity, unitz = Spring.GetUnitBasePosition(unitID)
    Spring.SpawnCEG("factory_explosion", unitx, unity, unitz, 0, 1, 0, 50, 0)
    createCorpseCUnitGeneric(recentDamage)
    i = 1 + 1
end

function script.AimWeapon3(heading, pitch)

    -- each Time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same Time.
    Turn(body1, y_axis, heading, 6)
    Turn(oppod1gun2, x_axis, -pitch, 5)
    Turn(oppod1gun1, x_axis, -pitch, 5)
    overhead = pitch

    WaitForTurn(body1, y_axis)
    WaitForTurn(oppod1gun2, x_axis)
    WaitForTurn(oppod1gun2, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

function script.QueryWeapon3()

    if (flipflop == true) then flipflop = false

        return flare1
    else
        flipflop = true
        return flare2
    end
end

function script.FireWeapon3()
    EmitSfx(flare1, 1)
    EmitSfx(flare2, 1)

    Turn(oppod1gun2, x_axis, overhead - 10, 8)
    Turn(oppod1gun1, x_axis, overhead - 10, 8)

    return true
end

function script.AimFromWeapon3()
    return body1
end



-- The piece that the bullet/laser/whatever comes out of.


function script.AimWeapon4(heading, pitch)

    -- each Time the Signal is called, all other functions with the same SignalMask will stop running. This makes sure the tank isn't trying to fire at something, and restore the turret position, at the same Time.
    Turn(body2, y_axis, heading, 6)
    Turn(oppod2gun2, x_axis, -pitch, 5)
    Turn(oppod2gun1, x_axis, -pitch, 5)
    overhead = pitch

    WaitForTurn(body2, y_axis)
    WaitForTurn(oppod2gun1, x_axis)
    WaitForTurn(oppod2gun2, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

function script.QueryWeapon4()

    if (flipflop2 == true) then flipflop2 = false

        return flare3
    else
        flipflop2 = true
        return flare4
    end
end

function script.FireWeapon4()
    EmitSfx(flare3, 1)
    EmitSfx(flare4, 1)

    Turn(oppod2gun2, x_axis, overhead - 10, 8)
    Turn(oppod2gun1, x_axis, overhead - 10, 8)

    return true
end

function script.AimFromWeapon4()
    return body2
end


local pieceMap = Spring.GetUnitPieceMap(unitID)

function walkAnimation1(personNr)


    Turn(pieceMap["abTusM5"], z_axis, math.rad(5), 3)
    Turn(pieceMap["abTusM5"], x_axis, math.rad(-3), 3)

    Turn(pieceMap["abTLarR5"], x_axis, math.rad(11), 6)
    Turn(pieceMap["abTLarR5"], y_axis, math.rad(-21), 5)
    Turn(pieceMap["abTLarR5"], z_axis, math.rad(-26), 6)

    Turn(pieceMap["abTUarR5"], x_axis, math.rad(-67), 4)
    Turn(pieceMap["abTUarR5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTUarR5"], z_axis, math.rad(-86), 6)


    Turn(pieceMap["abTusHead5"], x_axis, math.rad(5), 4)
    Turn(pieceMap["abTusHead5"], y_axis, math.rad(3), 5)
    Turn(pieceMap["abTusHead5"], z_axis, math.rad(-5), 5)

    Turn(pieceMap["abTULegR5"], x_axis, math.rad(-26), 4)
    Turn(pieceMap["abTULegR5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTULegR5"], z_axis, math.rad(2), 5)

    Turn(pieceMap["abTLLegR5"], x_axis, math.rad(44), 6)
    Turn(pieceMap["abTLLegR5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTLLegR5"], z_axis, math.rad(0), 5)

    Turn(pieceMap["abTULegL5"], x_axis, math.rad(20), 4)
    Turn(pieceMap["abTULegL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTULegL5"], z_axis, math.rad(-7), 5)

    Turn(pieceMap["abTLLegL5"], x_axis, math.rad(26), 4)
    Turn(pieceMap["abTLLegL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTLLegL5"], z_axis, math.rad(0), 5)

    Turn(pieceMap["abTUarL5"], x_axis, math.rad(5), 4)
    Turn(pieceMap["abTUarL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTUarL5"], z_axis, math.rad(68), 5)

    Turn(pieceMap["abTUarL5"], x_axis, math.rad(0), 4)
    Turn(pieceMap["abTUarL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTUarL5"], z_axis, math.rad(25), 5)

    Sleep(450)
    Turn(pieceMap["abTusM5"], z_axis, math.rad(-5), 3)
    Turn(pieceMap["abTusM5"], x_axis, math.rad(3), 3)
    Turn(pieceMap["abTusHead5"], x_axis, math.rad(-3), 4)
    Turn(pieceMap["abTusHead5"], y_axis, math.rad(-2), 5)
    Turn(pieceMap["abTusHead5"], z_axis, math.rad(3), 5)

    Turn(pieceMap["abTULegL5"], x_axis, math.rad(-26), 4)
    Turn(pieceMap["abTULegL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTULegL5"], z_axis, math.rad(-2), 5)

    Turn(pieceMap["abTLLegL5"], x_axis, math.rad(44), 5)
    Turn(pieceMap["abTLLegL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTLLegL5"], z_axis, math.rad(0), 5)

    Turn(pieceMap["abTULegR5"], x_axis, math.rad(20), 4)
    Turn(pieceMap["abTULegR5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTULegR5"], z_axis, math.rad(7), 5)

    Turn(pieceMap["abTLLegR5"], x_axis, math.rad(26), 4)
    Turn(pieceMap["abTLLegR5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTLLegR5"], z_axis, math.rad(0), 5)

    Turn(pieceMap["abTLarR5"], x_axis, math.rad(-46), 4)
    Turn(pieceMap["abTLarR5"], y_axis, math.rad(-95), 5)
    Turn(pieceMap["abTLarR5"], z_axis, math.rad(-4), 5) -- -24


    Turn(pieceMap["abTUarR5"], x_axis, math.rad(16), 4)
    Turn(pieceMap["abTUarR5"], y_axis, math.rad(0), 14)
    Turn(pieceMap["abTUarR5"], z_axis, math.rad(-32), 5)

    Turn(pieceMap["abTUarL5"], x_axis, math.rad(-25), 4)
    Turn(pieceMap["abTUarL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTUarL5"], z_axis, math.rad(70), 8)

    Turn(pieceMap["abTLarL5"], x_axis, math.rad(0), 4)
    Turn(pieceMap["abTLarL5"], y_axis, math.rad(0), 5)
    Turn(pieceMap["abTLarL5"], z_axis, math.rad(10), 5)

    Sleep(450)
end

function idleAnimation1(personNr)
    idle = math.random(0, 2)
    randSleep = math.random(1000, 4000)
    if idle == 0 then

        Turn(pieceMap["abTusM5"], z_axis, math.rad(0), 3)
        Turn(pieceMap["abTusM5"], x_axis, math.rad(0), 3)
        Turn(pieceMap["abTusHead5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTusHead5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTULegL5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTULegL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTULegL5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLLegL5"], x_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegL5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTULegR5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTULegR5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTULegR5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLLegR5"], x_axis, math.rad(26), 4)
        Turn(pieceMap["abTLLegR5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegR5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLarR5"], x_axis, math.rad(-1), 4)
        Turn(pieceMap["abTLarR5"], y_axis, math.rad(-17), 5)
        Turn(pieceMap["abTLarR5"], z_axis, math.rad(-92), 5) -- -24


        Turn(pieceMap["abTUarR5"], x_axis, math.rad(-60), 4)
        Turn(pieceMap["abTUarR5"], y_axis, math.rad(0), 14)
        Turn(pieceMap["abTUarR5"], z_axis, math.rad(-71), 5)

        Turn(pieceMap["abTUarL5"], x_axis, math.rad(-66), 4)
        Turn(pieceMap["abTUarL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTUarL5"], z_axis, math.rad(64), 8)

        Turn(pieceMap["abTLarL5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTLarL5"], y_axis, math.rad(131), 5)
        Turn(pieceMap["abTLarL5"], z_axis, math.rad(66), 5)


        Sleep(randSleep)
    elseif idle == 1 then

        Turn(pieceMap["abTusM5"], z_axis, math.rad(0), 3)
        Turn(pieceMap["abTusM5"], x_axis, math.rad(0), 3)
        Turn(pieceMap["abTusHead5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTusHead5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTULegL5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTULegL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTULegL5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLLegL5"], x_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegL5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTULegR5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTULegR5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTULegR5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLLegR5"], x_axis, math.rad(26), 4)
        Turn(pieceMap["abTLLegR5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegR5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLarR5"], x_axis, math.rad(-1), 4)
        Turn(pieceMap["abTLarR5"], y_axis, math.rad(-17), 5)
        Turn(pieceMap["abTLarR5"], z_axis, math.rad(-92), 5) -- -24


        Turn(pieceMap["abTUarR5"], x_axis, math.rad(-60), 4)
        Turn(pieceMap["abTUarR5"], y_axis, math.rad(0), 14)
        Turn(pieceMap["abTUarR5"], z_axis, math.rad(-71), 5)

        Turn(pieceMap["abTUarL5"], x_axis, math.rad(-66), 4)
        Turn(pieceMap["abTUarL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTUarL5"], z_axis, math.rad(64), 8)

        Turn(pieceMap["abTLarL5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTLarL5"], y_axis, math.rad(131), 5)
        Turn(pieceMap["abTLarL5"], z_axis, math.rad(66), 5)

        Talk = math.random(1, 6)
        for tlk = 1, Talk, 1 do
            shake = math.random(0, 5)
            headBang = math.random(-9, 18)
            if shake ~= 3 then
                Turn(pieceMap["abTusHead5"], x_axis, math.rad(headBang), 4)
                Turn(pieceMap["abTusHead5"], y_axis, math.rad(0), 5)
                Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)
            else
                Turn(pieceMap["abTusHead5"], x_axis, math.rad(0), 4)
                Turn(pieceMap["abTusHead5"], y_axis, math.rad(headBang), 5)
                Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)
                Sleep(450)
                Turn(pieceMap["abTusHead5"], x_axis, math.rad(0), 4)
                Turn(pieceMap["abTusHead5"], y_axis, math.rad(-1 * headBang), 5)
                Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)
                Sleep(450)
                Turn(pieceMap["abTusHead5"], x_axis, math.rad(0), 4)
                Turn(pieceMap["abTusHead5"], y_axis, math.rad(headBang), 5)
                Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)
            end
            Sleep(450 + (headBang * 2))
        end

        Sleep(randSleep)
    else

        Turn(pieceMap["abTusM5"], z_axis, math.rad(0), 3)
        Turn(pieceMap["abTusM5"], x_axis, math.rad(0), 3)
        Turn(pieceMap["abTusHead5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTusHead5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTusHead5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTULegL5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTULegL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTULegL5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLLegL5"], x_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegL5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTULegR5"], x_axis, math.rad(0), 4)
        Turn(pieceMap["abTULegR5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTULegR5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLLegR5"], x_axis, math.rad(26), 4)
        Turn(pieceMap["abTLLegR5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTLLegR5"], z_axis, math.rad(0), 5)

        Turn(pieceMap["abTLarR5"], x_axis, math.rad(-1), 4)
        Turn(pieceMap["abTLarR5"], y_axis, math.rad(-17), 5)
        Turn(pieceMap["abTLarR5"], z_axis, math.rad(-12), 5) -- -24


        Turn(pieceMap["abTUarR5"], x_axis, math.rad(-60), 4)
        Turn(pieceMap["abTUarR5"], y_axis, math.rad(0), 14)
        Turn(pieceMap["abTUarR5"], z_axis, math.rad(-71), 5)

        Turn(pieceMap["abTUarL5"], x_axis, math.rad(-66), 4)
        Turn(pieceMap["abTUarL5"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTUarL5"], z_axis, math.rad(46), 8)

        Turn(pieceMap["abTLarL5"], x_axis, math.rad(113), 4)
        Turn(pieceMap["abTLarL5"], y_axis, math.rad(131), 5)
        Turn(pieceMap["abTLarL5"], z_axis, math.rad(119), 5)





        Sleep(randSleep)
    end
end


function walkAnimation2(personNr)
    toDrunk2Walk = math.random(0, 4)
    if toDrunk2Walk ~= 3 then
        Turn(pieceMap["abTusM7"], z_axis, math.rad(0), 3)
        Turn(pieceMap["abTUarR7"], x_axis, math.rad(-81), 7)
        Turn(pieceMap["abTUarR7"], y_axis, math.rad(9), 1)
        Turn(pieceMap["abTUarR7"], z_axis, math.rad(37), 3)

        Turn(pieceMap["abTLarR7"], z_axis, math.rad(79), 8)

        Turn(pieceMap["abTusM7"], x_axis, math.rad(-1), 8)
        Turn(pieceMap["abTusM7"], z_axis, math.rad(-2), 0.5)
        Turn(pieceMap["abTHead7"], x_axis, math.rad(7), 3)
        Turn(pieceMap["abTHead7"], z_axis, math.rad(10), 3)
        Turn(pieceMap["abTHead7"], y_axis, math.rad(0), 3)
        Move(pieceMap["abTusM7"], y_axis, 0, 9)
        xor = math.random(2, 3)
        if xor == 1 then
            Turn(pieceMap["abTUarL7"], x_axis, math.rad(7), 2)
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(-44), 5)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(-66), 7)
            Sleep(176)
        elseif xor == 2 then
            Turn(pieceMap["abTUarL7"], x_axis, math.rad(-192), 12)
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(35), 5)
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(43), 5)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(-124), 12)
            Sleep(500)
        elseif xor == 3 then
            Turn(pieceMap["abTUarL7"], x_axis, math.rad(-48), 12)
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(79), 5)
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(-130), 15)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(-151), 12)
            Turn(pieceMap["abTLarL7"], x_axis, math.rad(-14), 3)
            Sleep(700)
        elseif xor == 4 then
            Turn(pieceMap["abTUarL7"], x_axis, math.rad(-37), 12)
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(-58), 5)
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(74), 15)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(-14), 2)
            Turn(pieceMap["abTLarL7"], x_axis, math.rad(-12), 3)
            Sleep(200)
            winkeWinke = math.random(0, 5)
            for l = 1, winkeWinke, 1 do
                Turn(pieceMap["abTLarL7"], z_axis, math.rad(-46), 5)
                Sleep(400)
                Turn(pieceMap["abTLarL7"], z_axis, math.rad(-19), 4)
                Sleep(400)
            end
        else
            --Reset the Arm
            Turn(pieceMap["abTUarL7"], x_axis, math.rad(0), 12)
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(-40), 15)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(-19), 2)
            Turn(pieceMap["abTLarL7"], y_axis, math.rad(0), 2)
            Turn(pieceMap["abTLarL7"], x_axis, math.rad(0), 3)
            Sleep(400)
        end

        WaitForTurn(pieceMap["abTusM7"], x_axis)
        WaitForTurn(pieceMap["abTusM7"], x_axis)
        Turn(pieceMap["abTUarR7"], x_axis, math.rad(-92), 7)

        Turn(pieceMap["abTUarR7"], y_axis, math.rad(9), 1)
        Turn(pieceMap["abTUarR7"], z_axis, math.rad(61), 3)
        Turn(pieceMap["abTLarR7"], y_axis, math.rad(22), 8)
        Turn(pieceMap["abTLarR7"], z_axis, math.rad(81), 8)


        Turn(pieceMap["abTusM7"], x_axis, math.rad(2), 0.5)
        Turn(pieceMap["abTusM7"], z_axis, math.rad(2), 0.5)
        Turn(pieceMap["abTHead7"], x_axis, math.rad(19), 3)
        Turn(pieceMap["abTHead7"], z_axis, math.rad(31), 3)
        Turn(pieceMap["abTHead7"], y_axis, math.rad(16), 3)
        WaitForTurn(pieceMap["abTUarR7"], y_axis)
        WaitForTurn(pieceMap["abTusM7"], x_axis)
        WaitForTurn(pieceMap["abTusM7"], x_axis)
    else
        Explode(pieceMap["glasprop7"], SFX.FALL + SFX.NO_CEG_TRAIL + SFX.NO_HEATCLOUD)
        Hide(pieceMap["glasprop7"])
        Turn(pieceMap["abTusM7"], x_axis, math.rad(63), 12)
        Move(pieceMap["abTusM7"], y_axis, -0.15, 1)
        crawl = math.random(3, 9)
        Turn(pieceMap["abTUarL7"], x_axis, math.rad(0), 12)
        Turn(pieceMap["abTUarL7"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTUarL7"], z_axis, math.rad(0), 15)
        Turn(pieceMap["abTLarL7"], z_axis, math.rad(0), 2)
        Turn(pieceMap["abTLarL7"], y_axis, math.rad(0), 2)
        Turn(pieceMap["abTLarL7"], x_axis, math.rad(0), 3)
        Turn(pieceMap["abTUarR7"], x_axis, math.rad(0), 1)
        Turn(pieceMap["abTUarR7"], y_axis, math.rad(0), 8)
        Turn(pieceMap["abTUarR7"], z_axis, math.rad(0), 4)
        Turn(pieceMap["abTLarR7"], y_axis, math.rad(0), 8)
        Turn(pieceMap["abTLarR7"], z_axis, math.rad(0), 8)
        Turn(pieceMap["abTLarR7"], x_axis, math.rad(0), 8)
        Sleep(350)

        for y = 1, crawl, 1 do
            Turn(pieceMap["abTUarL7"], x_axis, math.rad(2), 12)
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(-74), 5) --
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(-11), 15)
            Turn(pieceMap["abTLarL7"], x_axis, math.rad(-36), 2)
            Turn(pieceMap["abTLarL7"], y_axis, math.rad(0), 2)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(51), 3)


            Turn(pieceMap["abTUarR7"], x_axis, math.rad(0), 1)
            Turn(pieceMap["abTUarR7"], y_axis, math.rad(69), 8) --
            Turn(pieceMap["abTUarR7"], z_axis, math.rad(30), 4)
            Turn(pieceMap["abTLarR7"], y_axis, math.rad(22), 8)
            Turn(pieceMap["abTLarR7"], z_axis, math.rad(-29), 8)
            Turn(pieceMap["abTLarR7"], x_axis, math.rad(7), 8)

            Turn(pieceMap["abTHead7"], x_axis, math.rad(-30), 3)
            Turn(pieceMap["abTHead7"], z_axis, math.rad(20), 3)
            Turn(pieceMap["abTHead7"], y_axis, math.rad(-16), 3)

            Sleep(360)

            Turn(pieceMap["abTusM7"], z_axis, math.rad(-9), 3)

            Turn(pieceMap["abTUarL7"], x_axis, math.rad(0), 1)
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(-69), 8) --
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(-30), 4)
            Turn(pieceMap["abTLarL7"], y_axis, math.rad(-22), 8)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(29), 8)
            Turn(pieceMap["abTLarL7"], x_axis, math.rad(7), 8)



            Turn(pieceMap["abTUarR7"], x_axis, math.rad(-26), 1) --
            Turn(pieceMap["abTUarR7"], y_axis, math.rad(41), 8)
            Turn(pieceMap["abTUarR7"], z_axis, math.rad(80), 4)
            Turn(pieceMap["abTLarR7"], x_axis, math.rad(7), 8)
            Turn(pieceMap["abTLarR7"], y_axis, math.rad(22), 8)
            Turn(pieceMap["abTLarR7"], z_axis, math.rad(39), 8)

            Turn(pieceMap["abTHead7"], x_axis, math.rad(-32), 3)
            Turn(pieceMap["abTHead7"], z_axis, math.rad(-12), 3)
            Turn(pieceMap["abTHead7"], y_axis, math.rad(13), 3)

            Sleep(450)
            Turn(pieceMap["abTusM7"], z_axis, math.rad(9), 3)

            Turn(pieceMap["abTUarL7"], x_axis, math.rad(-26), 1) --
            Turn(pieceMap["abTUarL7"], y_axis, math.rad(-41), 8)
            Turn(pieceMap["abTUarL7"], z_axis, math.rad(-80), 4)
            Turn(pieceMap["abTLarL7"], x_axis, math.rad(7), 8)
            Turn(pieceMap["abTLarL7"], y_axis, math.rad(-22), 8)
            Turn(pieceMap["abTLarL7"], z_axis, math.rad(-39), 8)



            Turn(pieceMap["abTUarR7"], x_axis, math.rad(2), 12)
            Turn(pieceMap["abTUarR7"], y_axis, math.rad(74), 5) --
            Turn(pieceMap["abTUarR7"], z_axis, math.rad(11), 15)
            Turn(pieceMap["abTLarR7"], x_axis, math.rad(-36), 2)
            Turn(pieceMap["abTLarR7"], y_axis, math.rad(0), 2)
            Turn(pieceMap["abTLarR7"], z_axis, math.rad(-51), 3)




            Turn(pieceMap["abTHead7"], x_axis, math.rad(24), 3)
            Turn(pieceMap["abTHead7"], z_axis, math.rad(-9), 3)
            Turn(pieceMap["abTHead7"], y_axis, math.rad(-18), 3)
            Sleep(640)
        end
    end
end

function idleAnimation2(personNr)
    xenio = math.random(0, 1)
    if xenio == 1 then
        Turn(pieceMap["abTusM7"], x_axis, math.rad(-90), 22)

        Move(pieceMap["abTusM7"], y_axis, -0.3, 1)
    else
        Turn(pieceMap["abTusM7"], z_axis, math.rad(0), 3)

        Turn(pieceMap["abTusM7"], y_axis, math.rad(0), 3)
    end
    Move(pieceMap["abTusM7"], y_axis, 0, 9)

    Show(pieceMap["glasprop7"])
    Sleep(250)
    Turn(pieceMap["abTHead7"], x_axis, math.rad(0), 3)
    Turn(pieceMap["abTHead7"], z_axis, math.rad(0), 3)
    Turn(pieceMap["abTHead7"], y_axis, math.rad(0), 3)
    Sleep(250)
    Turn(pieceMap["abTUarR7"], x_axis, math.rad(-122), 12)
    Turn(pieceMap["abTUarR7"], y_axis, math.rad(-55), 6)
    Turn(pieceMap["abTUarR7"], z_axis, math.rad(57), 6)
    Turn(pieceMap["abTLarR7"], x_axis, math.rad(4), 8)
    Turn(pieceMap["abTLarR7"], y_axis, math.rad(49), 6)
    Turn(pieceMap["abTLarR7"], z_axis, math.rad(96), 12)
    Turn(pieceMap["glasprop7"], x_axis, math.rad(9), 8)
    Turn(pieceMap["glasprop7"], y_axis, math.rad(24), 6)
    Turn(pieceMap["glasprop7"], z_axis, math.rad(281), 28)
    Sleep(2200)
    Turn(pieceMap["abTUarR7"], x_axis, math.rad(-14), 12)
    Turn(pieceMap["abTUarR7"], y_axis, math.rad(-100), 6)
    Turn(pieceMap["abTUarR7"], z_axis, math.rad(57), 6)
    Turn(pieceMap["abTLarR7"], x_axis, math.rad(4), 8)
    Turn(pieceMap["abTLarR7"], y_axis, math.rad(49), 6)
    Turn(pieceMap["abTLarR7"], z_axis, math.rad(96), 12)
    Turn(pieceMap["glasprop7"], x_axis, math.rad(0), 8)
    Turn(pieceMap["glasprop7"], y_axis, math.rad(0), 6)
    Turn(pieceMap["glasprop7"], z_axis, math.rad(0), 28)
    Sleep(900)
    schluckAuf = math.random(0, 2)
    if schluckAuf == 1 then
        Turn(pieceMap["abTUarL7"], x_axis, math.rad(4), 12)
        Turn(pieceMap["abTUarL7"], y_axis, math.rad(-74), 5)
        Turn(pieceMap["abTUarL7"], z_axis, math.rad(-31), 15)
        Turn(pieceMap["abTLarL7"], z_axis, math.rad(36), 2)
        Turn(pieceMap["abTLarL7"], y_axis, math.rad(0), 2)
        Turn(pieceMap["abTLarL7"], x_axis, math.rad(0), 3)

    else
        Turn(pieceMap["abTUarL7"], x_axis, math.rad(108), 12) --
        Turn(pieceMap["abTUarL7"], y_axis, math.rad(0), 5)
        Turn(pieceMap["abTUarL7"], z_axis, math.rad(-54), 15)
        Turn(pieceMap["abTLarL7"], z_axis, math.rad(-18), 2)
        Turn(pieceMap["abTLarL7"], y_axis, math.rad(0), 2)
        Turn(pieceMap["abTLarL7"], x_axis, math.rad(-137), 3)
        Sleep(450)
    end
end

--[[
	1	abTUarR3= piece "abTUarR3"

	2	abTLarR3= piece "abTLarR3"

	3	abTUarL3= piece "abTUarL3"

	4	abTLarL3= piece "abTLarL3"

	5	glasprop3= piece "glasprop3"

	6	abTULegL3= piece "abTULegL3"

	7	abTLLegL3= piece "abTLLegL3"

	8	abTLLegR3= piece "abTLLegR3"

	9	abTHead3= piece "abTHead3"


]]
function walkAnimation3(personNr)
    multiPlaya = 1
    if dramatisPersona[personNr][12] == 1 then
        multiPlaya = -1
    end
    Hide(dramatisPersona[personNr][3][5])

    Turn(dramatisPersona[personNr][2], x_axis, math.rad(2), 0.5)
    --Turn(dramatisPersona[personNr][2],y_axis,math.rad((dramatisPersona[personNr][4])+4),0.9)
    Turn(dramatisPersona[personNr][2], z_axis, math.rad(-2), 0.9)
    --leg
    Turn(dramatisPersona[personNr][3][6], x_axis, math.rad(-25), 1)
    Turn(dramatisPersona[personNr][3][6], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][6], z_axis, math.rad(-4), 1)
    --lowerleg
    Turn(dramatisPersona[personNr][3][7], x_axis, math.rad(26), 1)
    Turn(dramatisPersona[personNr][3][7], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][7], z_axis, math.rad(9), 1)

    Turn(dramatisPersona[personNr][3][8], x_axis, math.rad(19), 1)
    Turn(dramatisPersona[personNr][3][8], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][8], z_axis, math.rad(0), 1)
    --head
    Turn(dramatisPersona[personNr][3][9], x_axis, math.rad(9), 1)
    Turn(dramatisPersona[personNr][3][9], y_axis, math.rad(1), 0.2)
    Turn(dramatisPersona[personNr][3][9], z_axis, math.rad(-5), 0.5)

    --arms
    Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(-18), 1)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(-81 * multiPlaya), 1)

    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(3), 1)
    Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(-35 * multiPlaya), 1)
    Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(-6 * multiPlaya), 3)

    --left
    Turn(dramatisPersona[personNr][3][3], x_axis, math.rad(28), 1)
    Turn(dramatisPersona[personNr][3][3], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][3], z_axis, math.rad(84 * multiPlaya), 4)

    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-27), 3)
    Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(-1 * multiPlaya), 1)



    Sleep(250)

    --armright
    Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(-8), 1)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(-65 * multiPlaya), 1)

    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(25 * multiPlaya), 1)
    Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(-20 * multiPlaya), 1)

    --left
    Turn(dramatisPersona[personNr][3][3], x_axis, math.rad(10), 1)
    Turn(dramatisPersona[personNr][3][3], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][3], z_axis, math.rad(82 * multiPlaya), 1)

    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-9), 1)
    Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(3 * multiPlaya), 1)

    Sleep(200)
    Turn(dramatisPersona[personNr][2], x_axis, math.rad(-1), 0.5)
    --Turn(dramatisPersona[personNr][2],y_axis,math.rad((dramatisPersona[personNr][4])+4),0.9)
    Turn(dramatisPersona[personNr][2], z_axis, math.rad(2), 0.9)

    --armright

    Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(16), 1)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(-70 * multiPlaya), 1)

    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(-26), 1)
    Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(25 * multiPlaya), 1)
    Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(-20 * multiPlaya), 1)

    --left
    Turn(dramatisPersona[personNr][3][3], x_axis, math.rad(-11), 1)
    Turn(dramatisPersona[personNr][3][3], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][3], z_axis, math.rad(82 * multiPlaya), 1)

    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(15 * multiPlaya), 1)

    -----------------------------------------------------------
    -- leg
    Turn(dramatisPersona[personNr][3][6], x_axis, math.rad(14), 1)
    Turn(dramatisPersona[personNr][3][6], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][6], z_axis, math.rad(-4), 1)
    --lowerleg
    Turn(dramatisPersona[personNr][3][7], x_axis, math.rad(2), 1)
    Turn(dramatisPersona[personNr][3][7], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][7], z_axis, math.rad(4), 1)

    Turn(dramatisPersona[personNr][3][8], x_axis, math.rad(-11), 1)
    Turn(dramatisPersona[personNr][3][8], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][8], z_axis, math.rad(0), 1)
    --head
    Turn(dramatisPersona[personNr][3][9], x_axis, math.rad(10), 1)
    Turn(dramatisPersona[personNr][3][9], y_axis, math.rad(9), 0.2)
    Turn(dramatisPersona[personNr][3][9], z_axis, math.rad(8), 0.5)




    Sleep(440)
end

function idleAnimation3(personNr)


    Show(dramatisPersona[personNr][3][5])
    --Turn(dramatisPersona[personNr][2],y_axis,math.rad(( faceValue2Degree(personNr))),0.9)
    Turn(dramatisPersona[personNr][3][6], x_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][6], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][6], z_axis, math.rad(0), 1)
    --lowerleg
    Turn(dramatisPersona[personNr][3][7], x_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][7], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][7], z_axis, math.rad(4), 1)

    Turn(dramatisPersona[personNr][3][8], x_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][8], y_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][8], z_axis, math.rad(0), 1)
    --head
    Turn(dramatisPersona[personNr][3][9], x_axis, math.rad(0), 1)
    Turn(dramatisPersona[personNr][3][9], y_axis, math.rad(0), 0.2)
    Turn(dramatisPersona[personNr][3][9], z_axis, math.rad(0), 0.5)


    Sleep(500)
end

function walkAnimation4(personNr)

    --- -Spring.Echo(personNr)
    Turn(dramatisPersona[personNr][2], x_axis, math.rad(1), 0.1)
    Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(35), 2)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-33), 3)
    Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(-56), 4)
    WaitForTurn(dramatisPersona[personNr][2], x_axis)
    Turn(dramatisPersona[personNr][2], x_axis, math.rad(0), 0.1)
    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(35), 2)
    Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(-33), 3)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-56), 4)
    WaitForTurn(dramatisPersona[personNr][2], x_axis)
    Sleep(50)
end

function idleAnimation4(personNr) --done
    drehdurch = math.random(0, 1)
    if drehdurch == 1 then
        Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(75), 2)

        Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(-76), 2)
        Spin(dramatisPersona[personNr][2], x_axis, 2, 0.62)
        Sleep(6000)
        StopSpin(dramatisPersona[personNr][2], x_axis)
    else
        Move(dramatisPersona[personNr][2], y_axis, 4, 4)
        WaitForMove(dramatisPersona[personNr][2], y_axis)

        Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(-5.9), 2)
        Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(-36), 2)
        xorbic = math.random(0, 1)
        if xorbic == 1 then
            Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(-5.9), 2)
            Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(259), 14)
            Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(-259), 14)
        else
            Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(5), 2)
            Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(-5), 14)
        end

        Spin(dramatisPersona[personNr][2], y_axis, 2, 0.042)
        Spin(dramatisPersona[personNr][2], z_axis, 0.2, 0.042)
        upAndDown = math.random(-20, 18)
        if upAndDown < 0 then
            Move(dramatisPersona[personNr][2], z_axis, 25, 7)
            WaitForMove(dramatisPersona[personNr][2], z_axis)
        end
        Move(dramatisPersona[personNr][2], y_axis, upAndDown, 1)
        sleepy = math.random(2000, 32000)
        Sleep(sleepy)



        Move(dramatisPersona[personNr][2], y_axis, 0, 4)
        WaitForMove(dramatisPersona[personNr][2], y_axis)
        Move(dramatisPersona[personNr][2], z_axis, dramatisPersona[personNr][5], 7)
        WaitForMove(dramatisPersona[personNr][2], z_axis)

        Sleep(50)
        Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][2], y_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][2], z_axis, math.rad(0), 14)
        Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(0), 2)
        Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(0), 14)
        StopSpin(dramatisPersona[personNr][2], y_axis)
        StopSpin(dramatisPersona[personNr][2], z_axis)
        Turn(dramatisPersona[personNr][2], z_axis, math.rad(0), 12)
        --Turn(dramatisPersona[personNr][2],y_axis,math.rad(( faceValue2Degree(personNr))),12)
        Sleep(500)
    end
end

function walkAnimation5(personNr)
    Turn(pieceMap["abTMarmL"], x_axis, math.rad(-32), 8)
    Turn(pieceMap["abTMhandL"], y_axis, math.rad(-93), 12)
    Turn(pieceMap["abTMhandL"], z_axis, math.rad(60), 12)

    Turn(pieceMap["abTMuplR"], x_axis, math.rad(100), 16)
    Turn(pieceMap["abTMlowR"], x_axis, math.rad(-82), 16)
    Turn(pieceMap["abTMFeedR"], x_axis, math.rad(-20), 4)
    Turn(pieceMap["abTMarmR"], x_axis, math.rad(33), 6)

    Turn(pieceMap["abTMuplL"], x_axis, math.rad(-16), 5)
    Turn(pieceMap["abTMlowL"], x_axis, math.rad(-70), 16)
    Turn(pieceMap["abTMFeedL"], x_axis, math.rad(88), 16)
    Turn(pieceMap["abTMarmR"], x_axis, math.rad(33), 6)

    WaitForTurn(pieceMap["abTMarmR"], x_axis)
    WaitForTurn(pieceMap["abTMFeedL"], x_axis)
    WaitForTurn(pieceMap["abTMlowL"], x_axis)
    WaitForTurn(pieceMap["abTMuplL"], x_axis)
    WaitForTurn(pieceMap["abTMarmR"], x_axis)
    WaitForTurn(pieceMap["abTMFeedR"], x_axis)
    WaitForTurn(pieceMap["abTMlowR"], x_axis)
    WaitForTurn(pieceMap["abTMuplR"], x_axis)
    Sleep(10)   
    --Waits till step is done

    Turn(pieceMap["abTMuplL"], x_axis, math.rad(100), 16)
    Turn(pieceMap["abTMlowL"], x_axis, math.rad(-82), 16)
    Turn(pieceMap["abTMFeedL"], x_axis, math.rad(-20), 4)
    Turn(pieceMap["abTMarmR"], x_axis, math.rad(33), 6)

    Turn(pieceMap["abTMuplR"], x_axis, math.rad(-16), 5)
    Turn(pieceMap["abTMlowR"], x_axis, math.rad(-70), 16)
    Turn(pieceMap["abTMFeedR"], x_axis, math.rad(88), 16)
                     
    Turn(pieceMap["abTMarmL"], x_axis, math.rad(32), 6)
    Turn(pieceMap["abTMhandL"], y_axis, math.rad(-93), 12)
    Turn(pieceMap["abTMhandL"], z_axis, math.rad(121), 12)
                    
    WaitForTurn(pieceMap["abTMarmR"], x_axis)
    WaitForTurn(pieceMap["abTMFeedL"], x_axis)
    WaitForTurn(pieceMap["abTMlowL"], x_axis)
    WaitForTurn(pieceMap["abTMuplL"], x_axis)
    WaitForTurn(pieceMap["abTMarmR"], x_axis)
    WaitForTurn(pieceMap["abTMFeedR"] , x_axis)
    WaitForTurn(pieceMap["abTMlowR"], x_axis)
    WaitForTurn(pieceMap["abTMuplR"], x_axis)
    Sleep(10)
end

function idleAnimation5(personNr)


    Turn(pieceMap["abTMuplL"], x_axis, math.rad(0), 16)
    Turn(pieceMap["abTMlowL"], x_axis, math.rad(0), 16)
    Turn(pieceMap["abTMFeedL"], x_axis, math.rad(0), 4)
    Turn(pieceMap["abTMarmR"], x_axis, math.rad(0), 6)

    Turn(pieceMap["abTMuplR"], x_axis, math.rad(0), 5)
    Turn(pieceMap["abTMlowR"], x_axis, math.rad(0), 16)
    Turn(pieceMap["abTMFeedR"], x_axis, math.rad(0), 16)
 --   Turn(`, x_axis, math.rad(0), 6)
    Turn(pieceMap["abTMhandL"], z_axis, math.rad(90), 12)
    WaitForTurn(pieceMap["abTMarmR"], x_axis)
    WaitForTurn(pieceMap["abTMFeedL"], x_axis)
    WaitForTurn(pieceMap["abTMlowL"], x_axis)
    WaitForTurn(pieceMap["abTMuplL"], x_axis)
    WaitForTurn(pieceMap["abTMarmR"], x_axis)
    WaitForTurn(pieceMap["abTMFeedR"], x_axis)
    WaitForTurn(pieceMap["abTMlowR"], x_axis)
    WaitForTurn(pieceMap["abTMuplR"], x_axis)
    Sleep(100)
    Turn(pieceMap["abTMarmL"], x_axis, math.rad(-34), 6)
    Turn(pieceMap["abTMhandL"], z_axis, math.rad(53), 12)
    Turn(pieceMap["abTMhandL"], y_axis, math.rad(-50), 12)
    Turn(pieceMap["abTMhandL"], x_axis, math.rad(32), 12)
    Sleep(4000)
    Turn(pieceMap["abTMarmL"], x_axis, math.rad(0), 6)
    Turn(pieceMap["abTMhandL"], z_axis, math.rad(90), 12)
    Turn(pieceMap["abTMhandL"], y_axis, math.rad(-90), 12)
    Turn(pieceMap["abTMhandL"], x_axis, math.rad(0), 12)
    Sleep(1000)
end

--JUMPONIT

--[[		--traditional pieces hiearchy, swingCenter beeing the Center
		local swingCenter10 = piece "swingCenter10"
		table.insert(person,1,swingCenter10) --swingCenter always atfirstPlace 1

		local abBuMain10 = piece "abBuMain10" -- the persons centerpiece 2
		table.insert(person,2,abBuMain10)

		piecetable={}  --contains the remaining pieces 3

		abBuArmR 10= piece "abBuArmR10"	1
		abBuLegR 10= piece "abBuLegR10"	2
		abBuLegL 10= piece "abBuLegL10"	3
		abBuArmL 10= piece "abBuArmL10"	4
		glasprop 10= piece "glasprop10"	5
		table.insert(piecetable,abBuArmR10)
		table.insert(piecetable,abBuLegR10)
		table.insert(piecetable,abBuLegL10)
		table.insert(piecetable,abBuArmL10)
		table.insert(piecetable,glasprop10)

		table.insert(person,3,piecetable)
		dramatisPersona[personNr][3][5]
		]]

function walkAnimation6(personNr)
    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(35), 3)
    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(-22), 2)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-90), 7)
    zo = math.random(-85, -70)
    Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(zo), 2)

    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-26), 3)
    Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(96), 7)
    Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(30), 3)

    Turn(dramatisPersona[personNr][3][5], x_axis, math.rad(32), 3)
    Turn(dramatisPersona[personNr][3][5], y_axis, math.rad(63), 7)
    Turn(dramatisPersona[personNr][3][5], z_axis, math.rad(8), 3)

    WaitForTurn(dramatisPersona[personNr][3][4], x_axis)
    WaitForTurn(dramatisPersona[personNr][3][2], x_axis)
    WaitForTurn(dramatisPersona[personNr][3][1], y_axis)


    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-14), 3)
    xy = math.random(110, 130)
    --Turn(dramatisPersona[personNr][3][4],y_axis,math.rad(xy),2)
    --Turn(dramatisPersona[personNr][3][4],z_axis,math.rad(40),4)

    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(35), 4)
    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-22), 3)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-90), 2)
    za = math.random(-110, -100)
    Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(za), 6)
    WaitForTurn(dramatisPersona[personNr][3][4], x_axis)
    WaitForTurn(dramatisPersona[personNr][3][2], x_axis)
    WaitForTurn(dramatisPersona[personNr][3][1], y_axis)
    Sleep(20)
end

function idleAnimation6(personNr)
    Turn(dramatisPersona[personNr][3][2], x_axis, math.rad(0), 4)
    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(0), 3)
    lulz = math.random(0, 2)
    if lulz == 1 then
        handClap = math.random(3, 16)
        for i = 1, handClap, 1 do
            Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(129), 7)
            Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-58), 7)
            Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(46), 7)
            Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-52), 7)
            Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(96), 7)
            Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(40), 7)
            WaitForTurn(dramatisPersona[personNr][3][4], y_axis)
            WaitForTurn(dramatisPersona[personNr][3][1], x_axis)
            Sleep(98)
            Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(129), 7)
            Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-32), 7)
            Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(46), 7)
            Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-52), 7)
            Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(69), 7)
            Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(40), 7)
            WaitForTurn(dramatisPersona[personNr][3][4], y_axis)
            WaitForTurn(dramatisPersona[personNr][3][1], y_axis)
            Sleep(200)
        end
        WaitForTurn(dramatisPersona[personNr][3][4], y_axis)
        WaitForTurn(dramatisPersona[personNr][3][1], y_axis)
        WaitForTurn(dramatisPersona[personNr][3][4], y_axis)
        WaitForTurn(dramatisPersona[personNr][3][1], x_axis)
    elseif lulz == 0 then
        Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(86), 7)
        Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-32), 7)
        Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(46), 7)
        Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-25), 7)
        Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(69), 7)
        Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(85), 7)
        Turn(dramatisPersona[personNr][3][5], x_axis, math.rad(77), 7)
        Turn(dramatisPersona[personNr][3][5], y_axis, math.rad(96), 7)
        Turn(dramatisPersona[personNr][3][5], z_axis, math.rad(21), 7)
        Sleep(2400)
    else
        --just standing there... enjoying the evening
        Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(0), 7)
        Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-90), 7)
        zo = math.random(-85, -70)
        Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(zo), 2)

        Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-26), 3)
        Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(96), 7)
        Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(30), 3)

        randSleep = math.random(5000, 80000)
        Sleep(randSleep)
    end
    Turn(dramatisPersona[personNr][3][1], x_axis, math.rad(0), 7)
    Turn(dramatisPersona[personNr][3][1], y_axis, math.rad(-90), 7)
    zo = math.random(-85, -70)
    Turn(dramatisPersona[personNr][3][1], z_axis, math.rad(zo), 2)

    Turn(dramatisPersona[personNr][3][4], x_axis, math.rad(-26), 3)
    Turn(dramatisPersona[personNr][3][4], y_axis, math.rad(96), 7)
    Turn(dramatisPersona[personNr][3][4], z_axis, math.rad(30), 3)
end

function walkAnimation7(personNr)
    moveIt = math.random(0, 1)
    moreRandom = math.random(7, 12)
    if moveIt == 1 then
        --aufgesessen
        Turn(pieceMap["fucAbuTop"], x_axis, math.rad(92), 10)

        Turn(pieceMap["fucAbuTop"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-90), 10)
        Turn(pieceMap["fucAbuAL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], x_axis, math.rad(-90), 10)
        Turn(pieceMap["fucAbuR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], x_axis, math.rad(-90), 10)
        Turn(pieceMap["fucAbuM"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], z_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuLR"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTusM9"], x_axis, math.rad(104), 10)
        Turn(pieceMap["abTusM9"], y_axis, math.rad(-171), 10)
        Turn(pieceMap["abTusM9"], z_axis, math.rad(12), 10)

        Move(pieceMap["abTusM9"], x_axis, 0, 10) --0.1
        Move(pieceMap["abTusM9"], y_axis, -0.086, 10) --1.4
        Move(pieceMap["abTusM9"], z_axis, -0.124, 10) -- -0.4

        Turn(pieceMap["abTHead9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTHead9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTHead9"], z_axis, math.rad(0), 10)
        --armright
        Turn(pieceMap["abTUarR9"], x_axis, math.rad(-38), 10)
        Turn(pieceMap["abTUarR9"], y_axis, math.rad(2), 10)
        Turn(pieceMap["abTUarR9"], z_axis, math.rad(69), 10)

        Turn(pieceMap["abTLarR9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarR9"], z_axis, math.rad(0), 10)
        --arm left
        Turn(pieceMap["abTUarL9"], x_axis, math.rad(106), 20)
        Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTUarL9"], z_axis, math.rad(-67), 10)


        Turn(pieceMap["abTLarL9"], x_axis, math.rad(-9), 20)
        Turn(pieceMap["abTLarL9"], y_axis, math.rad(-19), 10)
        Turn(pieceMap["abTLarL9"], z_axis, math.rad(-42), 10)


        Turn(pieceMap["abTULegR9"], x_axis, math.rad(67), 10)
        Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTULegR9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-142), 20)
        Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTULegL9"], x_axis, math.rad(70), 10)
        Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTULegL9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-145), 20)
        Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)



        --hoppe, hoppe Reiter, wenn sie f�llt, dann schreit er
        for tx = 0, moreRandom, 1 do
            Turn(pieceMap["fucAbuTop"], x_axis, math.rad(86), 10)
            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-143), 10)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-142), 10)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-142), 10)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(55), 10)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(42), 10)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(97), 10)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-171), 10)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(12), 10)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(-33), 10)
            Turn(pieceMap["abTHead9"], z_axis, math.rad(5), 10)

            Turn(pieceMap["abTUarR9"], x_axis, math.rad(-38), 10)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(2), 10)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(36), 10)
            Turn(pieceMap["abTLarR9"], x_axis, math.rad(0), 10)
            Turn(pieceMap["abTLarR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLarR9"], z_axis, math.rad(-20), 10)
            --arm left
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(82), 20)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-49), 10)

            Turn(pieceMap["abTLarL9"], x_axis, math.rad(22), 20)
            Turn(pieceMap["abTLarL9"], y_axis, math.rad(-19), 10)
            Turn(pieceMap["abTLarL9"], z_axis, math.rad(-42), 10)




            Turn(pieceMap["abTULegR9"], x_axis, math.rad(67), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-154), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(70), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-153), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)


            Sleep(666)
            --------------------------------------------------
            Turn(pieceMap["fucAbuTop"], x_axis, math.rad(101), 10)
            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-57), 10)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-56), 10)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-57), 10)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-48), 10)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-55), 10)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(87), 10)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-171), 10)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(12), 10)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(9), 10)
            Turn(pieceMap["abTHead9"], z_axis, math.rad(-5), 10)

            Turn(pieceMap["abTUarR9"], x_axis, math.rad(-38), 10)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(2), 10)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(86), 10)
            Turn(pieceMap["abTLarR9"], x_axis, math.rad(0), 10)
            Turn(pieceMap["abTLarR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLarR9"], z_axis, math.rad(0), 10)
            --arm left
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(123), 20)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(-138), 10)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-153), 10)

            Turn(pieceMap["abTLarL9"], x_axis, math.rad(37), 20)
            Turn(pieceMap["abTLarL9"], y_axis, math.rad(-19), 10)
            Turn(pieceMap["abTLarL9"], z_axis, math.rad(-117), 15)




            Turn(pieceMap["abTULegR9"], x_axis, math.rad(85), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-144), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(82), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-148), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)



            --------------------------------------------------
            Sleep(666)
        end
        Turn(pieceMap["fucAbuTop"], x_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuTop"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], z_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuLR"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTusM9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTusM9"], y_axis, math.rad(-171), 10)
        Turn(pieceMap["abTusM9"], z_axis, math.rad(-12), 10)

        Move(pieceMap["abTusM9"], x_axis, 0, 10) --0.1
        Move(pieceMap["abTusM9"], y_axis, 0, 10) --1.4
        Move(pieceMap["abTusM9"], z_axis, 0, 10) -- -0.4

        Turn(pieceMap["abTHead9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTHead9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTHead9"], z_axis, math.rad(0), 10)
        --armright
        Turn(pieceMap["abTUarR9"], x_axis, math.rad(-38), 10)
        Turn(pieceMap["abTUarR9"], y_axis, math.rad(2), 10)
        Turn(pieceMap["abTUarR9"], z_axis, math.rad(69), 10)

        Turn(pieceMap["abTLarR9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarR9"], z_axis, math.rad(0), 10)
        --arm left
        Turn(pieceMap["abTUarL9"], x_axis, math.rad(106), 20)
        Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTUarL9"], z_axis, math.rad(0), 10)


        Turn(pieceMap["abTLarL9"], x_axis, math.rad(0), 20)
        Turn(pieceMap["abTLarL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarL9"], z_axis, math.rad(0), 10)


        Turn(pieceMap["abTULegR9"], x_axis, math.rad(67), 10)
        Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTULegR9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTLLegR9"], x_axis, math.rad(0), 20)
        Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTULegL9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTULegL9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTLLegL9"], x_axis, math.rad(0), 20)
        Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)




    else

        Move(pieceMap["abTusM9"], x_axis, 0, 10) --0.1
        Move(pieceMap["abTusM9"], y_axis, 0.091, 10) --1.4
        Move(pieceMap["abTusM9"], z_axis, 0, 10) -- -0.4

        Turn(pieceMap["fucAbuTop"], x_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuTop"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-152), 10)
        Turn(pieceMap["fucAbuAL"], y_axis, math.rad(306), 10)
        Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], x_axis, math.rad(-170), 17)
        Turn(pieceMap["fucAbuR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], z_axis, math.rad(20), 10)
        Turn(pieceMap["fucAbuM"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], z_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuLR"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTusM9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTusM9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTusM9"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTHead9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTHead9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTHead9"], z_axis, math.rad(0), 10)
        --armright
        Turn(pieceMap["abTUarR9"], x_axis, math.rad(20), 10)
        Turn(pieceMap["abTUarR9"], y_axis, math.rad(-89), 10)
        Turn(pieceMap["abTUarR9"], z_axis, math.rad(35), 10)

        Turn(pieceMap["abTLarR9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarR9"], z_axis, math.rad(0), 10)
        --arm left
        Turn(pieceMap["abTUarL9"], x_axis, math.rad(67), 20)
        Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTUarL9"], z_axis, math.rad(-46), 10)


        Turn(pieceMap["abTLarL9"], x_axis, math.rad(0), 20)
        Turn(pieceMap["abTLarL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLarL9"], z_axis, math.rad(-63), 10)


        Turn(pieceMap["abTULegR9"], x_axis, math.rad(73), 10)
        Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTULegR9"], z_axis, math.rad(-2), 10)

        Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-114), 20)
        Turn(pieceMap["abTLLegR9"], y_axis, math.rad(7), 10)
        Turn(pieceMap["abTLLegR9"], z_axis, math.rad(-7), 10)

        Turn(pieceMap["abTULegL9"], x_axis, math.rad(69), 10)
        Turn(pieceMap["abTULegL9"], y_axis, math.rad(34), 10)
        Turn(pieceMap["abTULegL9"], z_axis, math.rad(43), 10)

        Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-117), 20)
        Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)
        Sleep(800)
        ridingHigh = math.random(6, 9)
        for ix = 1, ridingHigh, 1 do
            Turn(pieceMap["abTHead9"], x_axis, math.rad(-49), 7)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(-8), 3)
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(40), 20)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(46), 10)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-35), 6)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(28), 10)
            Turn(pieceMap["fucAbuLR"], y_axis, math.rad(28), 10)
            Turn(pieceMap["fucAbuLR"], z_axis, math.rad(0), 10)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(31), 10)
            Turn(pieceMap["fucAbuLL"], y_axis, math.rad(-29), 10)
            Turn(pieceMap["fucAbuLL"], z_axis, math.rad(0), 10)



            Sleep(300)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(23), 10)
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(67), 20)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(46), 10)

            Turn(pieceMap["fucAbuM"], x_axis, math.rad(0), 6)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(0), 10)
            Turn(pieceMap["fucAbuLR"], y_axis, math.rad(0), 10)
            Turn(pieceMap["fucAbuLR"], z_axis, math.rad(0), 10)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(0), 10)
            Turn(pieceMap["fucAbuLL"], y_axis, math.rad(0), 10)
            Turn(pieceMap["fucAbuLL"], z_axis, math.rad(0), 10)

            Sleep(200)
        end


        Move(pieceMap["abTusM9"], x_axis, 0, 10) --0.1
        Move(pieceMap["abTusM9"], y_axis, 0, 10) --1.4
        Move(pieceMap["abTusM9"], z_axis, 0, 10) -- -0.4
        Turn(pieceMap["fucAbuTop"], x_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuTop"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuM"], z_axis, math.rad(0), 10)

        Turn(pieceMap["fucAbuLR"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLR"], z_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], x_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], y_axis, math.rad(0), 10)
        Turn(pieceMap["fucAbuLL"], z_axis, math.rad(0), 10)

        Turn(pieceMap["abTusM9"], x_axis, math.rad(0), 10)
        Turn(pieceMap["abTusM9"], y_axis, math.rad(0), 10)
        Turn(pieceMap["abTusM9"], z_axis, math.rad(0), 10)
    end
end

function idleAnimation7(personNr)
    inStellungBring = math.random(0, 3)
    if inStellungBring == 0 then
        Move(pieceMap["abTusM9"], y_axis, 0.0, 1)
        Move(pieceMap["abTusM9"], z_axis, -0.03, 1)
        wieDieKarnickel = math.random(6, 14)
        dice = math.random(0, 1)
        sleeper = 666
        for da = 1, wieDieKarnickel, 1 do
            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(30), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-21), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(3), 5)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-14), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(40), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(-22), 5)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(255), 25)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-9), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(189), 15)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(45), 5)
            Turn(pieceMap["abTUarR9"], x_axis, math.rad(92), 5)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(75), 5)
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(88), 10)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-74), 5)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(25), 4)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-47), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-42), 4)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(104), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(-25), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(-10), 2)
            if dice == 1 then
                Turn(pieceMap["abTULegR9"], z_axis, math.rad(71), 7)
            end
            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-123), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(118), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-22), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-127), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)



            Sleep(sleeper)
            sleeper = sleeper - wieDieKarnickel

            Move(pieceMap["abTusM9"], y_axis, -0.2, 1)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-25), 4)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(25), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(18), 4)

            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-42), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-5), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(-11), 5)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-14), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(93), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(-22), 5)

            ------------------------------------------
            Turn(pieceMap["abTusM9"], x_axis, math.rad(255), 25)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-9), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(189), 15)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(-36), 5)
            Turn(pieceMap["abTUarR9"], x_axis, math.rad(127), 7)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(8), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(75), 5)
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(117), 5)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(-2), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-70), 5)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(58), 5)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(-25), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(-10), 2)
            if dice == 1 then
                Turn(pieceMap["abTULegR9"], z_axis, math.rad(71), 7)
            end

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-92), 10)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 5)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(60), 5)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-22), 5)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-84), 5)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 5)

            Sleep(sleeper)
        end

        Move(pieceMap["abTusM9"], y_axis, 0.0, 1)
        Move(pieceMap["abTusM9"], z_axis, 0.0, 1)
    elseif inStellungBring == 1 then
        Move(pieceMap["abTusM9"], y_axis, 0.0, 1)
        Move(pieceMap["abTusM9"], z_axis, -0.03, 1)
        wieDieKarnickel = math.random(6, 14)
        sleeper = 666
        for da = 1, wieDieKarnickel, 1 do
            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(30), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-21), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(3), 5)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-14), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(40), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(-22), 5)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(145), 25)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-3), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(5), 15)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(-54), 5)
            Turn(pieceMap["abTUarR9"], x_axis, math.rad(92), 5)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(75), 5)
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(88), 10)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-74), 5)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(25), 4)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-47), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-42), 4)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(104), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(-25), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(-10), 2)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-123), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(118), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-22), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-127), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)

            Sleep(sleeper)
            sleeper = sleeper - wieDieKarnickel

            Move(pieceMap["abTusM9"], y_axis, -0.2, 1)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-25), 4)
            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(25), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(18), 4)

            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-42), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-5), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(-11), 5)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-14), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(93), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(-22), 5)

            ------------------------------------------
            Turn(pieceMap["abTusM9"], x_axis, math.rad(145), 25)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-3), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(-4), 15)
            Turn(pieceMap["abTHead9"], x_axis, math.rad(-100), 5)
            Turn(pieceMap["abTUarR9"], x_axis, math.rad(127), 7)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(8), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(75), 5)
            Turn(pieceMap["abTUarL9"], x_axis, math.rad(117), 5)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(-2), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-70), 5)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(58), 5)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(-25), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(-10), 2)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-92), 10)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 5)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(60), 5)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-22), 5)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-84), 5)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 5)

            Sleep(sleeper)
        end
        Move(pieceMap["abTusM9"], y_axis, 0, 1)
        Move(pieceMap["abTusM9"], z_axis, 0, 1)

    elseif inStellungBring == 2 then
        --upright

        Move(pieceMap["abTusM9"], y_axis, -0.238, 1)
        Move(pieceMap["fucAbuTop"], y_axis, 0.238, 1)

        keineErschoepfung = math.random(8, 14)
        Sleepest = 900
        for it = 1, keineErschoepfung, 1 do
            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-34), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(0), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 5)
            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-35), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(0), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 5)
            Turn(pieceMap["fucAbuM"], x_axis, math.rad(22), 5)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(-6), 25)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(180), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(0), 15)

            Turn(pieceMap["abTHead9"], x_axis, math.rad(26), 5)

            Turn(pieceMap["abTUarR9"], x_axis, math.rad(135), 5)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(-67), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(-24), 5)

            Turn(pieceMap["abTUarL9"], x_axis, math.rad(59), 10)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(-48), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-90), 5)

            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-106), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-104), 4)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(12), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(12), 2)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(0), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(12), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-14), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(0), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLarL9"], x_axis, math.rad(0), 10)
            Turn(pieceMap["abTLarL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTLarL9"], z_axis, math.rad(0), 5)




            Sleep(Sleepest)
            Sleepest = Sleepest - 4 * keineErschoepfung
            Move(pieceMap["abTusM9"], z_axis, -0.0328, 1)

            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-58), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-21), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 5)

            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-57), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(16), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 5)

            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-2), 10)
            Turn(pieceMap["abTusM9"], x_axis, math.rad(-24), 12)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(180), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(0), 15)

            Turn(pieceMap["abTHead9"], x_axis, math.rad(-33), 6)

            Turn(pieceMap["abTUarR9"], x_axis, math.rad(146), 5)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(-30), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(45), 5)

            Turn(pieceMap["abTUarL9"], x_axis, math.rad(153), 10)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(30), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-54), 10)

            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-75), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-84), 4)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(32), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(12), 2)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-45), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(25), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-14), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-24), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLarL9"], x_axis, math.rad(5), 10)
            Turn(pieceMap["abTLarL9"], y_axis, math.rad(18), 5)
            Turn(pieceMap["abTLarL9"], z_axis, math.rad(18), 10)


            Sleep(Sleepest)
            Move(pieceMap["abTusM9"], z_axis, 0, 1)
        end

    elseif inStellungBring == 3 then
        --
        Move(pieceMap["abTusM9"], y_axis, -0.238, 1)
        Move(pieceMap["fucAbuTop"], y_axis, 0.238, 1)
        ridersInTheSky = math.random(4, 14)
        Deep = 800

        for o = 1, ridersInTheSky, 1 do
            Move(pieceMap["abTusM9"], z_axis, 0.04, 1)
            Move(pieceMap["abTusM9"], y_axis, -0.2, 1)

            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-58), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-21), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 5)

            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-57), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(16), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 5)

            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-17), 10)

            Turn(pieceMap["abTusM9"], x_axis, math.rad(8), 12)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-18), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(0), 15)

            Turn(pieceMap["abTHead9"], x_axis, math.rad(-59), 6)
            Turn(pieceMap["abTHead9"], y_axis, math.rad(-6), 6)
            Turn(pieceMap["abTHead9"], z_axis, math.rad(-16), 6)

            Turn(pieceMap["abTUarR9"], x_axis, math.rad(80), 5)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(-30), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(45), 5)

            Turn(pieceMap["abTUarL9"], x_axis, math.rad(84), 10)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(-182), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-214), 14)

            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-75), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-84), 4)
            --------------------------------------------------

            --Turn(pieceMap["abTULegL9,y_axis,math.rad(107),10)
            --Turn(pieceMap["abTULegL9,z_axis,math.rad(-125),10)

            -------------------------------------------------
            Turn(pieceMap["abTULegR9"], x_axis, math.rad(-230), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(110), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(124), 12)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-129), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(109), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(-19), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-34), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-135), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)
            ---------------------------------------
            Turn(pieceMap["abTLarL9"], x_axis, math.rad(-25), 10)
            Turn(pieceMap["abTLarL9"], y_axis, math.rad(0), 5)
            Turn(pieceMap["abTLarL9"], z_axis, math.rad(-128), 10)

            Turn(pieceMap["abTLarR9"], x_axis, math.rad(161), 10)
            Turn(pieceMap["abTLarR9"], y_axis, math.rad(-18), 5)
            Turn(pieceMap["abTLarR9"], z_axis, math.rad(-114), 10)


            Sleep(Deep)
            Deep = Deep - ridersInTheSky * 3
            Move(pieceMap["abTusM9"], y_axis, -0.24, 1)


            Turn(pieceMap["fucAbuAL"], x_axis, math.rad(-58), 6)
            Turn(pieceMap["fucAbuAL"], y_axis, math.rad(-21), 5)
            Turn(pieceMap["fucAbuAL"], z_axis, math.rad(0), 5)

            Turn(pieceMap["fucAbuR"], x_axis, math.rad(-57), 5)
            Turn(pieceMap["fucAbuR"], y_axis, math.rad(16), 5)
            Turn(pieceMap["fucAbuR"], z_axis, math.rad(0), 5)

            Turn(pieceMap["fucAbuM"], x_axis, math.rad(-17), 10)

            Turn(pieceMap["abTusM9"], x_axis, math.rad(31), 12)
            Turn(pieceMap["abTusM9"], y_axis, math.rad(-18), 5)
            Turn(pieceMap["abTusM9"], z_axis, math.rad(0), 15)

            Turn(pieceMap["abTHead9"], x_axis, math.rad(35), 6)
            Turn(pieceMap["abTHead9"], y_axis, math.rad(0), 6)
            Turn(pieceMap["abTHead9"], z_axis, math.rad(0), 6)

            Turn(pieceMap["abTUarR9"], x_axis, math.rad(103), 5)
            Turn(pieceMap["abTUarR9"], y_axis, math.rad(-30), 5)
            Turn(pieceMap["abTUarR9"], z_axis, math.rad(45), 5)

            Turn(pieceMap["abTUarL9"], x_axis, math.rad(84), 10)
            Turn(pieceMap["abTUarL9"], y_axis, math.rad(-167), 5)
            Turn(pieceMap["abTUarL9"], z_axis, math.rad(-215), 14)

            Turn(pieceMap["fucAbuLR"], x_axis, math.rad(-75), 4)
            Turn(pieceMap["fucAbuLL"], x_axis, math.rad(-84), 4)

            Turn(pieceMap["abTULegR9"], x_axis, math.rad(-205), 10)
            Turn(pieceMap["abTULegR9"], y_axis, math.rad(81), 5)
            Turn(pieceMap["abTULegR9"], z_axis, math.rad(76), 12)

            Turn(pieceMap["abTLLegR9"], x_axis, math.rad(-129), 20)
            Turn(pieceMap["abTLLegR9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegR9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTULegL9"], x_axis, math.rad(110), 10)
            Turn(pieceMap["abTULegL9"], y_axis, math.rad(-19), 10)
            Turn(pieceMap["abTULegL9"], z_axis, math.rad(-34), 10)

            Turn(pieceMap["abTLLegL9"], x_axis, math.rad(-135), 20)
            Turn(pieceMap["abTLLegL9"], y_axis, math.rad(0), 10)
            Turn(pieceMap["abTLLegL9"], z_axis, math.rad(0), 10)

            Turn(pieceMap["abTLarL9"], x_axis, math.rad(84), 10)
            Turn(pieceMap["abTLarL9"], y_axis, math.rad(68), 5)
            Turn(pieceMap["abTLarL9"], z_axis, math.rad(35), 10)

            Turn(pieceMap["abTLarR9"], x_axis, math.rad(161), 10)
            Turn(pieceMap["abTLarR9"], y_axis, math.rad(-18), 5)
            Turn(pieceMap["abTLarR9"], z_axis, math.rad(-45), 10)
            Sleep(Deep)
        end
    end
    Move(pieceMap["abTusM9"], x_axis, 0, 1)
    Move(pieceMap["abTusM9"], y_axis, 0, 1)
    Move(pieceMap["abTusM9"], z_axis, 0, 1)
    Move(pieceMap["fucAbuTop"], x_axis, 0, 1)
    Move(pieceMap["fucAbuTop"], y_axis, 0, 1)
    Move(pieceMap["fucAbuTop"], z_axis, 0, 1)
end

