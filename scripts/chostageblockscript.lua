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
	TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
	hideT(TablesOfPiecesGroups["PathA"])
	hideT(TablesOfPiecesGroups["PathB"])
	hideT(TablesOfPiecesGroups["PathC"])
	resetT(TablesOfPiecesGroups["Cell"])
	Show(frame)
	 StartThread(animationLoop)
	StartThread(letsfetz)
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
	resetT(TablesOfPiecesGroups["Cell"])
	WMove(hoblocks,y_axis, 0, 0)
	
	
end
function disolve(PieceName)
	followPath(unitID, PieceName,TablesOfPiecesGroups["PathC"],12, 250)
end


function dissolveOrRetract()
	for i=1, 6 do
		currPiece=TablesOfPiecesGroups["Cell"][i]
		if currPiece then
			reset(currPiece)
				Show(currPiece)
			if  math.random(1,22) > 2  then
				followPath(unitID, currPiece,TablesOfPiecesGroups["PathB"],12, 250)
			else
				disolve( currPiece)		
				for i=1, 5 do 
				spawnCegAtPiece(unitID, currPiece, "antimatter", math.random(-5,5), math.random(-5,5), math.random(-5,5))
				end
				getCegDevil(currPiece)
			end
		Hide(currPiece)
		end		
	end
	
	for i=12,6, -1 do
		currPiece=TablesOfPiecesGroups["Cell"][i]
		if currPiece then
			reset(currPiece)
					Show(currPiece)
			if math.random(1,22) > 2 then
				followPath(unitID, currPiece,TablesOfPiecesGroups["PathA"],5, 250)
			else
				disolve(currPiece)
				for i=1, 5 do 
				spawnCegAtPiece(unitID, currPiece, "antimatter", math.random(-5,5), math.random(-5,5), math.random(-5,5))
				end
				getCegDevil(currPiece)
			end
		Hide(currPiece)
		end
	end
	
	
end


function getCegDevil(currPiece)
x,y,z=Spring.GetUnitPiecePosDir(unitID,currPiece)
				StartThread(cegDevil, "antimatter",x,y,z, 5,
				function(times) 
				if times > 1500 then 
				return false 
				else 
				return true 
				end
				end
				)

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