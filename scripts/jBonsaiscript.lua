include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
aimpiece=piece"aimpiece"

function script.Create()
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
end

function script.Killed(recentDamage,_)

	createCorpseJBuilding(recentDamage)
return 1
end

function shapeCondition(layer, i, j, boolBelow)



end

function getClosestDirection()

end

function buildBonsai(bonsaiPieces,baseShapeTable, sizeX,sizeY,sizeZ,)
hideT(bonsaiPieces)
bonsaiTable= makeTable({height=0, boolBelow=false}, 8, 8, 4)
numberOfDirections=math.ceil(math.random(1,3))
directionTable={}
cliffFactor=math.random(0.01,0.999)
for i=1, 3 do
	directionTable[i]={x=math.ceil(1,8), y=math.ceil(1,8), direction=math.random(0,360), angular=math.random(-10,10)}
end

boulderHeight= 25

for z=1,sizeZ, 1 do
	for i= sizeX, 1, -1 do
	for j= sizeY,  1, -1 do
		if z==1 and baseShapeTable[i][j]== true then
		
			 if shapeCondition(1, i, j, true) == true then
				--get the heightOffset
				heightOffset= heightGradient[j] + cliffFactor*(math.random(-boulderHeight/4,boulderHeight/4)
				bonsaiTable[i][j][1].height=heightOffset	
				bonsaiTable[i][j][1].boolBelow=true
				bonsaiTable[i][j][1].piece, bonsaiPieces= getBonsaiPiece(z, bonsaiPieces)
				
				--place a bolder

				dir, angular  = getClosestDirection(directionTable,i,j) 
				dir = dir + math.random(-15,15)
				--Turn Boulder towards dir
				
			 end
		elseif bonsaiTable[i][j][z-1].boolBelow== true then
				if math.random(1,z) < z * 0.75 then
		
					--get the heightOffset
				heightOffset= heightGradient[j] + cliffFactor*(math.random(-boulderHeight/4,boulderHeight/4)
				bonsaiTable[i][j][1].height=heightOffset	
				bonsaiTable[i][j][1].boolBelow=true	
				bonsaiTable[i][j][1].piece= getBonsaiPiece(z, bonsaiPieces)
				
				--place a bolder a the predecessorpiece 

				dir, angular  = getClosestDirection(directionTable,i,j) 
				dir = dir + math.random(-15,15)
				--Turn Boulder towards dir
		
			end
		end
				
	end
	end
end

end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end 



function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
end


