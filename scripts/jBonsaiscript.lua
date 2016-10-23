include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"


function script.Create()
	allreadyInsertedPieces={}
	generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	resetT(TablesOfPiecesGroups["bP"])
	--hideT(TablesOfPiecesGroups["bP"])
	resetT(TablesOfPiecesGroups["pEnd"])
	bonsaiPieces={}
	
	for i=1, 3,1 do
		bonsaiPieces[i]={}
		for k=1 , 10, 1 do
			pieceName= "bP"..(((i-1)*10)+k)
			SensoryName= "pEnd"..(((i-1)*10)+k)
			SensoryName= piece(SensoryName)
			pieceName= piece(pieceName)
			bonsaiPieces[i][k]={	Piece= pieceName ,
									Sensory = SensoryName
								}
		end
	end
	
	sizeX, sizeY, sizeZ= 8,4,8
	baseShapeTable = createBaseShapeTable(sizeX, sizeY, sizeZ, 30)
	buildBonsai(bonsaiPieces, baseShapeTable, sizeX, sizeZ, sizeY)
end

function createBaseShapeTable(sizeX, sizeY, sizeZ, piecenumber)
	overhanglikelihoodMax=math.random(0.1,1)
	backTracklikelihoodMax= math.random(0.05,1)
	riftliklihoodmax = math.random(0.1,3)--
	baseRotLikelikhoodMax =math.random(0.1,0.95)--
	
	baseShapeTable ={}
	radiusA,radiusB= math.random(1,sizeX),math.random(1,sizeZ)
	y=1
	for x= 1, sizeX, 1 do
		for z= 1, sizeZ, 1 do
			if not baseShapeTable[x] then baseShapeTable[x] ={} end
			if not baseShapeTable[x][z] then baseShapeTable[x][z] ={} end
			if not baseShapeTable[x][z][y] then baseShapeTable[x][z][y] ={} end
			
			baseShapeTable[x][z][y]= true
			if distance(x,z,sizeX,sizeZ) < radiusA then baseShapeTable[x][z][y]= false end
			if distance(x,z,1,sizeZ) < radiusB then baseShapeTable[x][z][y]= false end
			if math.random(0.01,1) > baseRotLikelikhoodMax then	baseShapeTable[x][z][y]= false	end
			
			if baseShapeTable[x][z][y]== true then
				piecenumber=piecenumber-1
			end
		end
	end
	
	
	for y=2,sizeY, 1 do
		for x=1, sizeX, 1 do
			for z=1, sizeZ, 1 do
				if not baseShapeTable[x] then baseShapeTable[x] ={} end
				if not baseShapeTable[x][z] then baseShapeTable[x][z] ={} end
				if not baseShapeTable[x][z][y] then baseShapeTable[x][z][y] ={} end
				baseShapeTable[x][z][y]=false
				--if below is ground
				if baseShapeTable[x][z][y-1]== true then
					
					baseShapeTable[x][z][y]= riftliklihoodmax > math.random(0.1,1)
					
				else --nothing below
					--sidetracking
					if overhanglikelihoodMax > math.random(0.1,1) and checksides(baseShapeTable, x, z) == true then
						baseShapeTable[x][z][y]= true
						piecenumber=piecenumber-1
						
					end
					--downtracking
					yIndex= y-1
					while backTracklikelihoodMax > math.random(0.75,1) and piecenumber > 0 and baseShapeTable[x][z][yIndex] and baseShapeTable[x][z][yIndex] == false do 
						yIndex= yIndex-1
						baseShapeTable[x][z][yIndex]= true			
						piecenumber=piecenumber-1						
					end
					
		
				end
			end
		end
		
		
	end
	return baseShapeTable
end
	

	function checksides(baseShapeTable, x, z)
		return (
		(baseShapeTable[x-1] and baseShapeTable[x-1][z+1] and baseShapeTable[x-1][z+1] == true)or 
		(baseShapeTable[x] and baseShapeTable[x][z+1] and baseShapeTable[x][z+1] == true)or 
		(baseShapeTable[x+1] and baseShapeTable[x+1][z+1] and baseShapeTable[x+1][z+1] == true)or 
		(baseShapeTable[x+1] and baseShapeTable[x+1][z] and baseShapeTable[x+1][z] == true)or 
		(baseShapeTable[x+1] and baseShapeTable[x+1][z-1] and baseShapeTable[x+1][z-1] == true)or 
		(baseShapeTable[x] and baseShapeTable[x][z-1] and baseShapeTable[x][z-1] == true)or 
		(baseShapeTable[x-1] and baseShapeTable[x-1][z-1] and baseShapeTable[x-1][z-1] == true) )
		
	end
	
	function script.Killed(recentDamage,_)
		
		createCorpseJBuilding(recentDamage)
		return 1
	end
	
	
	
	function getClosestDirection(directionTable,i,j) 
		dirIndex=1
		lastDist=math.huge
		for i=1,#directionTable do
			local dx=directionTable[i]
			if distance(i,dx.x,j,dx.z) < lastDist then dirIndex= i; lastDist =distance(i,dx.x,j,dx.z) end
		end
		
		return directionTable[dirIndex].direction, directionTable[dirIndex].angular
	end
	
	function getHeightGradient(sizeX, sizeZ, maxHeight)
	heightGradient=makeTable(0, sizeX)
	fractionHeight= maxHeight/sizeX
		for i=0, sizeX, 1 do
			heightGradient[i]= i* fractionHeight
		end
	return heightGradient
	end
	
	allreadyInsertedPieces={}
	function getBonsaiPiece(y, bonsaiPieces, sizeY)
		for i=1,#bonsaiPieces[1], 1 do
			if math.random(0,1) == 1 and not allreadyInsertedPieces[bonsaiPieces[1][i].Piece] then
				allreadyInsertedPieces[bonsaiPieces[y][i].Piece] =true
				return bonsaiPieces[1][i].Piece , bonsaiPieces[1][i].Sensory 
			end
		end
	for y=1, sizeY do
		for i=1,#bonsaiPieces[y], 1 do
			if math.random(0,1) == 1 and not allreadyInsertedPieces[bonsaiPieces[y][i].Piece] then
				allreadyInsertedPieces[bonsaiPieces[y][i].Piece] =true
				return bonsaiPieces[y][i].Piece , bonsaiPieces[y][i].Sensory 
			end
		end
	end
	
	return nil
	end
	
	--bonsaiPieces must be a objecttable containing layers of tables, containing a table with a piece and a Sensory
	function buildBonsai(bonsaiPieces, baseShapeTable, sizeX, sizeZ, sizeY, maxHeight)

	--This hides all the bonsaisPieces
		for i=1,#bonsaiPieces, 1 do
			for k=1,#bonsaiPieces[i] do
				--Hide(bonsaiPieces[i][k].Piece)
			end
		end
		--bonsaiTable[x][z][1]={height, BoolGround, piece, Sensory}
		defaultTable= {height=0, BoolGround=false, Piece= -math.huge, Sensory= -math.huge}

		
		bonsaiTable= makeTable( defaultTable, sizeX, sizeZ, sizeY)
		--layers of stone in the bonsai
		numberOfDirections=math.ceil(math.random(1,3))
		directionTable={}
		cliffFactor=math.random(0.01,0.399)
		for i=1, 3 do
			radoAnguVal=math.random(-40,40)
			directionTable[i]={ x=math.ceil(1,sizeX), 
								z=math.ceil(1,sizeZ), direction=math.random(0,360), angular=radoAnguVal}
		end
		 maxHeight = math.random(10,120)
		 heightGradient = getHeightGradient(sizeX, sizeZ, maxHeight)
		
		vx,vy,vz= Spring.GetUnitPieceCollisionVolumeData(unitID, bonsaiPieces[1][1].Piece)
		sx,sy,sz= Spring.GetUnitPieceCollisionVolumeData(unitID, bonsaiPieces[1][1].Sensory)
		bx, boldHght, bz = math.max(vx,sz)*0.75, math.abs(sy-vy)  , math.abs(vz,sz)*0.75
			

		for y=1,sizeY, 1 do
			for x= 1, sizeX, 1 do
				for z= 1, sizeZ, 1 do
					if y==1 and baseShapeTable[x][z][1] == true then
						
						
						--get the heightOffset
						
						heightOffset= heightGradient[z] + cliffFactor*(math.random(boldHght/-4,boldHght/4))
						bonsaiTable[x][z][1].Height=heightOffset	
						bonsaiTable[x][z][1].BoolGround=true
						bonsaiTable[x][z][1].Piece, bonsaiTable[x][z][1].Sensory= getBonsaiPiece(y, bonsaiPieces, sizeY)
						if not 	bonsaiTable[x][z][1].Piece then return end
						--place a bolder
						px,py,pz= bx*x, -10 + bonsaiTable[x][z][1].Height, bz*z
						MovePieceToPos(bonsaiTable[x][z][y].Piece, px, py, pz, 0)
						
						dir, angular = getClosestDirection(directionTable,x,z) 
						dir = dir + math.random(-15,15)
						--Turn Boulder towards dir
						Turn(bonsaiTable[x][z][1].Piece,y_axis,math.rad(dir), 0)
						Turn(bonsaiTable[x][z][1].Piece,x_axis,math.rad(angular), 0, true)
						
					end
				end
				
				if true == false and y~=1 and baseShapeTable[x][z][y] == true then
					
					--get the heightOffset
					heightOffset= heightGradient[x] + cliffFactor*(math.random(-boldHght/4,boldHght/4))
					bonsaiTable[x][z][y].Height=heightOffset	
					bonsaiTable[x][z][y].BoolGround= true	
					bonsaiTable[x][z][y].Piece, bonsaiTable[x][z][y].Sensory = getBonsaiPiece(y, bonsaiPieces, sizeY)
						if not 	bonsaiTable[x][z][y].Piece then return end
					Show(bonsaiTable[x][z][y].Piece)
					
						if baseShapeTable[x][z][y-1].BoolGround == true then
							MovePieceToPiece(bonsaiTable[x][z][y].Piece, bonsaiTable[x][z][y-1].Sensory, 0)
							WaitForMoves(bonsaiTable[x][z][y].Piece)
						else
							px,py,pz= bx*x, bonsaiTable[x][z][y-1].Height, bz*z
							MovePieceToPos(bonsaiTable[x][z][y].Piece, px, py, pz, 0)
							WaitForMoves(bonsaiTable[x][z][y].Piece)
						end
					
					--place a bolder a the predecessorpiece 
					dir, angular = getClosestDirection(directionTable,x,z) 
					dir = dir + math.random(-15,15)
					--Turn Boulder towards dir
					Turn(bonsaiTable[x][z][y].Piece,y_axis,math.rad(dir), 0)
					Turn(bonsaiTable[x][z][y].Piece,x_axis,math.rad(angular), 0, true)
				end
				
			end
		end
		
		Move(center,y_axis, 0, 0)-- boldHght/-2,0)
		Turn(center,y_axis,math.random(-math.pi,math.pi),0)
end



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


function script.FireWeapon1()	
	
	return true
end