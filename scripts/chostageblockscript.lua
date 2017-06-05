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
	Show(pieceName)
	Hide(ExecutedCell)
	Hide(hoblocks)
	Hide(Cubes)
	hideT(TablesOfPiecesGroups["Cell"])
	hideT(TablesOfPiecesGroups["PathA"])
	showT(TablesOfPiecesGroups["PathB"])
	resetT(TablesOfPiecesGroups["PathB"])
	while true do
		reset(pieceName)
		Show(pieceName)
		for i=1,#TablesOfPiecesGroups["PathB"] do
			movePieceToPieceNoReset(unitID, pieceName, TablesOfPiecesGroups["PathB"][i], 3)
		end
		
		
		Sleep(6000)
		
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

function followPath(pieceName, pathTable)
	reset(pieceName)
	Show(pieceName)
	for i=1,#pathTable do
		movePieceToPieceNoReset(unitID, pieceName,pathTable[i], 5)
		Sleep(250)
	end
	
	Hide(pieceName)
end


function dissolveOrRetract()
	for i=1, 6 do
		currPiece=TablesOfPiecesGroups["Cell"][i]
		if maRa()==true then
			followPath(currPiece,TablesOfPiecesGroups["PathB"])
		else
			
		end
		Hide(currPiece)
	end
	for i=12,6, -1 do
		currPiece=TablesOfPiecesGroups["Cell"][i]
		if maRa()==true then
			followPath(currPiece,TablesOfPiecesGroups["PathA"])
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
	return 1
end


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


function script.FireWeapon1()
	
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

Spring.SetUnitNanoPieces(unitID, { center })