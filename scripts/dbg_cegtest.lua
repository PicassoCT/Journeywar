include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
Quader04=piece"Quader04"
Quader01=piece"Quader01"

function script.Create()
	--generatepiecesTableAndArrayCode(unitID)
	StartThread(emitSFX)
--	StartThread(saySay)
end

function script.Killed(recentDamage,_)
	
	createCorpseCUnitGeneric(recentDamage)
	return 1
end

function testTurnInTime()
	
	syncTurnInTime(Quader01,0,-45,0,300,0,0,0)
	while true do
		syncTurnInTime(Quader01,0,0,0,3000,0,-45,0)
		WaitForTurn(Quader01,y_axis)
		Sleep(3000)
		syncTurnInTime(Quader01,0,-45,0,3000,0,0,0)
		WaitForTurn(Quader01,y_axis)
		Sleep(3000)
	end
	
end

function saySay()
while true do
	Sleep(10000)
		T=prepSpeach("Test 1 2 3     ", "Honk",64, 0.5, 500)
	
		say(T,5000, NameColour, {r=1.0,g=1.0, b=1.0},OptionString,unitID)

	end
end

function emitSFX()
	--StartThread(constDistanceDrag)
	StartThread(testTurnInTime)
	x,y,z=Spring.GetUnitPosition(unitID)
	modHeight=0
	i=0
	while true do
		modHeight=(modHeight%250)+10
		
		
		--Sleep(1500)	
		
		--	Spring.SpawnCEG("jvaryfoohit",x,y,z,0,1,0)
		--Sleep(1500)
		--	Spring.SpawnCEG("jvaryfoohit2",x,y,z,0,1,0)	
		--Sleep(1500)
		--	Spring.SpawnCEG("jvaryfootrail",x,y,z,0,1,0)	
		--Sleep(1500)
		--Spring.SpawnCEG("cnanotics",x,y+400,z,1,0,0,0)	
		--Sleep(1500)
		--Spring.SpawnCEG("jgalateatend",x,y+20,z,0,1,0,60)

	--	Spring.SpawnCEG("jplankaaimpact",x,y+60,z,0,1,0,60)	

	Spring.SpawnCEG("jmeteortrail",x,y+400,z, math.random(-1,1),math.random(0.1,1), math.random(-1,1),60)	
	Sleep(4000)
	--Spring.SpawnCEG("jsupernova",x,y+400,z, math.random(-1,1),math.random(0.1,1), math.random(-1,1),60)	

	--Spring.SpawnCEG("suckfire",x,y+60,z,0,1,0,60)	
		--	Spring.SpawnCEG("citlightpillar",x,y+400,z,0,-1,0,60)
		--Sleep(3000)
		--StartThread(portalStormWave,unitID)
		
	end
	
end
dragInRange= 1200
liftUpRange= 900



----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end



function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
	
end