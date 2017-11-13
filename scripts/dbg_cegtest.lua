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
	-- StartThread(testTurnInTime)
	echo(minimalAbsoluteDistance(15,-15))
	echo(minimalAbsoluteDistance(-15,-15))
	echo(minimalAbsoluteDistance(-15,15))
	echo(minimalAbsoluteDistance(360,-270))
end

function script.Killed(recentDamage, _)
	
	createCorpseCUnitGeneric(recentDamage)
	return 1
end
Quader02 = piece"Quader02"
function testTurnInTime()
	
	while true do
		reset(Quader02)
		Sleep(1000)
		turnInTime(Quader02, y_axis, 360, 5000, 0,0,0, false)
		WaitForTurns(Quader02)	
		turnInTime(Quader02, y_axis, -360, 5000, 0,360,0, false)
		WaitForTurns(Quader02)	
	end
end

function saySay()
	while true do
		Sleep(10000)
		T = prepSpeach("Test 1 2 3 ", "Honk", 64, 0.5, 500)
		
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
		
		Spring.SpawnCEG("internalexplosion", x +50 , y+ 50 , z, math.random(-10, 10) / 10, math.random(0, 10) / 10, math.random(-10, 10) / 10, 60)
		Sleep(1000)
		
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