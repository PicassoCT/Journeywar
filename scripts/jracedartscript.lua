include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 
LifeTime = 20000
center = piece "center"
RaceDrone = piece "RaceDrone"

isPoisonRaceDart = UnitDefNames["jpoisonracedart"].id == Spring.GetUnitDefID(unitID)
function script.Create()
    StartThread(uHave20Seconds)
end

function uHave20Seconds()
    Sleep(LifeTime)
    Spring.DestroyUnit(unitID, true)
end

function script.Killed(recentDamage, _)
    return 1
end

--- -aimining & fire weapon
function script.AimFromWeapon1()
    return RaceDrone
end

function script.QueryWeapon1()
    return RaceDrone
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return true
end

function script.FireWeapon1()
    if isPoisonRaceDart == true then
        x, y, z = Spring.GetUnitPosition(unitID)
        Spring.SpawnCEG("poisonteal", x, y + 25, z, 0, 1, 0, 60)
    end
    Spring.DestroyUnit(unitID, false, true)
    return true
end

boolItsOff = false
boolMove = false
function script.StartMoving()
    boolMove = true
    boolItsOff = true
end

function TimeDelayedDestruction()
    Sleep(1000)
    if boolItsOff == false then
        Spring.DestroyUnit(unitID, false, true)
    end
    boolItsOff = false
end

function script.StopMoving()
    boolMove = false
    StartThread(TimeDelayedDestruction)
end