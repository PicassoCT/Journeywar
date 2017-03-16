include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

PiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
aimspot=piece"aimspot"
center=piece"center"
SIGHT_RANGE= 2500

function script.Create()
	
	PiecesGroups=makePiecesTablesByNameGroups(false,true)
	hideT(PiecesGroups["Spire"])
	hideT(PiecesGroups["eggStage"])
	hideT(PiecesGroups["egg"])
	StartThread(eggWobble)
	StartThread(unfoldSpire)	
	StartThread(checkSpawn)	
end

function unfoldSpire()
	process(PiecesGroups["spireRot"],
	function(id)
		rand=math.random(-360,360)
		Turn(id,y_axis,math.rad(rand),0)
	end
	)
	
	process(PiecesGroups["Spire"],
	function(id)
		rand=math.random(-360,360)
		Turn(id,y_axis,math.rad(rand),0)
		if maRa()==true then Show(id)
		end
	end
	)
end

function eggWobble()
	while true do
		showT(PiecesGroups["egg"])
		process(PiecesGroups["egg"],
		function(id)
			randSpeed=math.random(1,7)
			turnPieceRandDir(id,randSpeed,15,-15,15,-15,15,-15)
		end)
		Sleep(1200)
		randSpeed=math.random(1,7)
		resetT(PiecesGroups["egg"], randSpeed)
		hideT(PiecesGroups["egg"])
		for i=1,#PiecesGroups["eggStage"] do
			if PiecesGroups["eggStage"][i-1] then
				Hide(PiecesGroups["eggStage"][i-1])
			end	
			Show(PiecesGroups["eggStage"][i])
			restVal=math.random(150,350)
			Sleep(restVal)
		end
		for i=#PiecesGroups["eggStage"],1,-1 do
			if PiecesGroups["eggStage"][i+1] then
				Hide(PiecesGroups["eggStage"][i+1])
			end	
			Show(PiecesGroups["eggStage"][i])
			restVal=math.random(150,350)
			Sleep(restVal)
		end
		Sleep(250)
		hideT(PiecesGroups["eggStage"])
		
	end
end

function script.Killed(recentDamage,_)
	
	createCorpseJUnitGeneric(recentDamage)
	return 1
end

dartID=-math.huge

function getTowersDartPoisonDartIfThereIsNone()
	boolvalidID= Spring.ValidUnitID(dartID) 
	if boolvalidID and boolvalidID == true then
		boolAlive= Spring.GetUnitIsDead(dartID) 
		if boolAlive and boolAlive== true then
			return dartID
		end
	end
	x,y,z=Spring.GetUnitPosition(unitID)
	team=Spring.GetUnitTeam(unitID)
	
	offx,offz=RotationMatrice(0,35,math.rad(math.random(-360,360)))
	dartID= Spring.CreateUnit("jpoisonracedart",x+offx,y,z+offz,0,team)
	soundStart         = "sounds/jPoisondart/jPoisonDartLaunch.ogg"
	Spring.PlaySoundFile(soundStart,1.0)
	return dartID
end

LOAD_TIME=7000
function checkSpawn()
	reloadTime=LOAD_TIME
	while true do
		
		enemyID=Spring.GetUnitNearestEnemy(unitID, SIGHT_RANGE)
		if enemyID then 
			ex,ey,ez=Spring.GetUnitPosition(enemyID)
			myDart=getTowersDartPoisonDartIfThereIsNone()
			Command(myDart,"go",{x=ex,y=ey,z=ez},{"shift"})
			Sleep(reloadTime)
			boolNotDeadYet= Spring.GetUnitIsDead(myDart)
			while boolNotDeadYet and boolNotDeadYet==false do
				Sleep(200)
				boolNotDeadYet= Spring.GetUnitIsDead(myDart)
			end
		end
		Sleep(100)
	end
end


function script.StartMoving()
	
end

function script.StopMoving()
	
	
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end