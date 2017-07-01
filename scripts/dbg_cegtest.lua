include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


function script.HitByWeapon(x, z, weaponDefID, damage)
end

center = piece "center"
Quader04 = piece "Quader04"
Quader08 = piece "Quader08"
Quader01 = piece "Quader01"

function script.Create()
    --generatepiecesTableAndArrayCode(unitID)
    StartThread(emitSFX)
    StartThread(testTurnInTime)

end

function script.Killed(recentDamage, _)

    createCorpseCUnitGeneric(recentDamage)
    return 1
end

function testTurnInTime()
    while true do
		ox, oz = math.random(-250,250),  math.random(-250,250)
		MovePieceToPos(Quader04,ox,120,oz,7.5)
		sentence = "Moving to "..ox.." / "..oz.."  "

		WaitForMoves(Quader04)
		movePieceToPieceNoReset(unitID,Quader01,Quader08,15)
		WaitForMoves(Quader08)
		Sleep(100)
    end
end

function saySay()
    while true do
        Sleep(10000)
        T = prepSpeach("Test 1 2 3     ", "Honk", 64, 0.5, 500)

        say(T, 5000, NameColour, { r = 1.0, g = 1.0, b = 1.0 }, OptionString, unitID)
    end
end

function emitSFX()
    --StartThread(constDistanceDrag)
    StartThread(testTurnInTime)
    x, y, z = Spring.GetUnitPosition(unitID)
    modHeight = 0
    i = 0
    while true do
        modHeight = (modHeight % 250) + 10




        Spring.SpawnCEG("tangeldceg", x + 50, y + 75, z, math.random(-10, 10) / 10, math.random(0, 10) / 10, math.random(-10, 10) / 10, 60)
        Sleep(4000)
        --Spring.SpawnCEG("jsupernova",x,y+400,z, math.random(-1,1),math.random(0.1,1), math.random(-1,1),60)

        --Spring.SpawnCEG("suckfire",x,y+60,z,0,1,0,60)
        --	Spring.SpawnCEG("citlightpillar",x,y+400,z,0,-1,0,60)
        --Sleep(3000)
        --StartThread(portalStormWave,unitID)
    end
end

dragInRange = 1200
liftUpRange = 900



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