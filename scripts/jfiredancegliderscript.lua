include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

TablesOfPiecesGroups = {}

function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"
aimpiece = piece "Glider"

function script.Create()
    generatepiecesTableAndArrayCode(unitID)
    TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
    Spring.SetUnitNoSelect(unitID, true)
    Spring.SetUnitCOBValue(unitID, COB.ACTIVATION, 1)
    StartThread(flightstartDetector)
end

function script.Killed(recentDamage, _)

    return 0
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return aimpiece
end



function script.QueryWeapon1()
    return aimpiece
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return true
end


function script.FireWeapon1()

    return true
end



function script.StartMoving()
end

function script.StopMoving()
end

boolStartedOnce = false
function script.Activate()

    Spring.Echo("Starting jfiredanceglider")
    boolStartedOnce = true
    return 1
end

boolJustOnce = false
function flightstartDetector()

    while true do
        Sleep(100)
        if boolStartedOnce == true and boolJustOnce == false then
            boolJustOnce = true
            StartThread(LandingDetector)
        end
    end
end

SIG_FLY = 2

function revertTimer()
    Signal(SIG_FLY)
    SetSignalMask(SIG_FLY)
    Sleep(4000)
    transformUnitInto(unitID, "jfiredancer")
end

boolFlying = false
function script.Deactivate()
    if boolFlying == true then
        boolFlying = false
    end
    StartThread(revertTimer)

    return 0
end

function LandingDetector()

    --lets fly it to peak
    oldy = Spring.GetUnitPosition(unitID)
    gx, newy, gz = Spring.GetUnitPosition(unitID)

    downCounter = 10
    while downCounter > 0 do
        if oldy <= newy then downCounter = 10 else downCounter = downCounter - 1 end
        oldy = newy
        Sleep(250)
        gx, newy, gz = Spring.GetUnitPosition(unitID)
    end

    boolFlying = true

    while (newy <= oldy and boolFlying == true) or Spring.GetGroundHeight(gx, gz) <= 0 do
        oldy = newy
        Sleep(250)
        gx, newy, gz = Spring.GetUnitPosition(unitID)
    end
    transformUnitInto(unitID, "jfiredancer")
end

function script.QueryBuildInfo()
    return center
end

Spring.SetUnitNanoPieces(unitID, { center })

