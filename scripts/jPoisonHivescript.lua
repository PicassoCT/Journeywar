include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

PiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"


function script.Create()

	PiecesGroups=makePiecesTablesByNameGroups(false,true)
	hideT(PiecesGroups["Spire"])
	hideT(PiecesGroups["eggStage"])
	hideT(PiecesGroups["egg"])
	StartThread(eggWobble)
	StartThread(unfoldSpire)	
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


----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end



function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	

	return true
	
end


function script.FireWeapon1()	
	index=math.random(1,#PiecesGroups["Egg"])
	Explode(PiecesGroups["Egg"][index],SFX.FALL+ SFX.NO_HEATCLOUD)
	
	return true
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

function script.QueryBuildInfo() 
	return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})