include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

TablesOfPiecesGroups = {}

function script.HitByWeapon(x, z, weaponDefID, damage)
end

frame = piece "frame"
center = piece "center"
ExecutedCell= piece "ExecutedCell"
hoblocks= piece"hoblocks"
Cubes = piece"Cubes"
buihobloc1 = piece"buihobloc1"
buihoblock = piece"buihoblock"

function script.Create()
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups = makePiecesTablesByNameGroups(false, true)
	hideT(TablesOfPiecesGroups["PathA"])
	hideT(TablesOfPiecesGroups["PathB"])
	StartThread(moveTestLoop,TablesOfPiecesGroups["Cell"][1])
	-- StartThread(animationLoop)
	-- StartThread(letsfetz)
end

function moveTestLoop(pieceName)
	Hide(frame)
	
	Hide(ExecutedCell)
	Hide(hoblocks)
	Hide(Cubes)
	hideT(TablesOfPiecesGroups["Cell"])
	hideT(TablesOfPiecesGroups["PathB"])
	hideT(TablesOfPiecesGroups["PathC"])
	hideT(TablesOfPiecesGroups["PathA"])
	resetT(TablesOfPiecesGroups["PathB"])
	Show(pieceName)
	while true do
		echoT(TablesOfPiecesGroups["PathD"])
		followPath(unitID, pieceName,TablesOfPiecesGroups["PathD"],25,250)
		Sleep(6000)
		reset(pieceName)
	
	end

	
		
		
		
	

	
end

function letsfetz()
	while true do 
		
		val=math.random(-4,4)
		Move(buihobloc1,x_axis,val,7)
		val=math.random(-4,4)
		Move(buihoblock,x_axis,val,7)
		Sleep(600)
	end
end
function moveNextCellGenerationUp()
	Hide(ExecutedCell)
	hideT(TablesOfPiecesGroups["Cell"])
	Show(Cubes)
	Show(hoblocks)
	
	WMove(hoblocks,y_axis, 10, 5)
	showT(TablesOfPiecesGroups["Cell"])
	WMove(hoblocks,y_axis, 0, 0)
	
	
end
function disolve()
	
end


function dissolveOrRetract()
	for i=1, 6 do
		currPiece=TablesOfPiecesGroups["Cell"][i]
		if maRa()==true then
			reset(pieceName)
			Show(pieceName)
			followPath(currPiece,TablesOfPiecesGroups["PathB"],5, 250)
			Hide(pieceName)
		else
			
		end
		Hide(currPiece)
	end
	for i=12,6, -1 do
		currPiece=TablesOfPiecesGroups["Cell"][i]
		if maRa()==true then
			followPath(currPiece,TablesOfPiecesGroups["PathA"],5, 250)
		else
			
		end
		Hide(currPiece)
	end
	
	
end
function animationLoop()
	while true do
		moveNextCellGenerationUp()
		dissolveOrRetract()
		Sleep(1000)
	end
end
function script.Killed(recentDamage, _)
	
	createCorpseCUnitGeneric(recentDamage)
	return 0
end
turret1 = piece"turret1"
turret2 = piece"turret2"

--- -aimining & fire weapon
function script.AimFromWeapon1()
	return turret1
end



function script.QueryWeapon1()
	return turret1
end

function script.AimWeapon1(Heading, pitch)
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
end


function script.FireWeapon1()
	
	return true
end

function script.AimFromWeapon2()
	return turret2
end



function script.QueryWeapon2()
	return turret2
end

function script.AimWeapon2(Heading, pitch)
	--aiming animation: instantly turn the gun towards the enemy
	
	return true
end


function script.FireWeapon2()
	
	return true
end