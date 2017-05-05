include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
wheelPivot=piece"wheelPivot"
waterwheel=piece"waterwheel"
WaterPlan0=piece"WaterPlan0"
WaterPlane=piece"WaterPlane"
DryBasin=piece"DryBasin"
BasinFarnDry=piece"BasinFarnDry"
Basin=piece"Basin"
BasinFarn=piece"BasinFarn"
FlucWheel=piece"FlucWheel"
foamsphere1=piece"foamsphere1"
foamsphere2=piece"foamsphere2"
foamsphere3=piece"foamsphere3"
spherespin= piece"spherespin"

g_AddOnRate= 0.005

rval = function () 
	val= math.random(-35,35) 
	if val == 0 then return 42 end
	return val
end

function emitSound()
unitDefID=Spring.GetUnitDefID(unitID)
	while true do 
		
		while boolWaterSpilling== true do
		modulation=math.random(0.5,1)
		StartThread(PlaySoundByUnitDefID,unitDefID,"sounds/jBonsai/jBonsaiWater.ogg",modulation,7500,1)
			
			Sleep(50)
					
		end
		Sleep(150)
	end
end

function foamspheres()
	yval=math.random(-5,-0.5)
	Move(foamsphere1,y_axis,yval,2.95)	
	yval=math.random(-5,-0.5)
	Move(foamsphere2,y_axis,yval,2.95)
	yval=math.random(-5,-0.5)
	Move(foamsphere3,y_axis,yval,2.95)
	
	Spin(spherespin,y_axis, rval()/math.random(1,10),0)
	Spin(foamsphere3,z_axis, rval(),0)
	Spin(foamsphere2,z_axis, rval(),0)
	Spin(foamsphere1,z_axis, rval(),0)
	Spin(foamsphere3,y_axis, rval(),0)
	Spin(foamsphere2,y_axis, rval(),0)
	Spin(foamsphere1,y_axis, rval(),0)
end
SIG_WATER = 2 
boolWaterWheelDone=false
function waterWheel()
	boolWaterWheelDone=false
	showWaterWheels()
	Spin(FlucWheel,z_axis,math.rad(-65),0)
	Spin(waterwheel,z_axis,math.rad(-65),0)
	
	StartThread(circulOS,TablesOfPiecesGroups["WatWhe"],wheelPivot,z_axis, -65, 10, 3, "waterWheel"..unitID)
	
	
	
	while boolWaterSpilling== true do
		foamspheres()
		
		val=math.random(-75,75)
		Spin(WaterPlan0,y_axis,math.rad(val),0)
		val=math.random(-75,75)
		Spin(WaterPlane,y_axis,math.rad(val),0)
		speed = math.random(7,12.5)/10
		Move(WaterPlan0,y_axis,-1.5, speed)
		Move(WaterPlane,y_axis,-1.5, speed)
		
		Sleep(2000)
		speed = math.random(7,12.5)/10
		if math.random(0,1)==1 then
			Show(WaterPlan0)
			Hide(WaterPlane)
	
			Move(WaterPlan0,y_axis,0.5 ,speed)
			
		else
			Hide(WaterPlan0)
			Show(WaterPlane)
			Move(WaterPlane,y_axis,0.5 ,speed)
			
		end
		
		Sleep(2000)
		
	end
	 GG.OsKeys["waterWheel"..unitID]=false
	 hideWaterWheels()
	 while 	 GG.OsKeys["waterWheel"..unitID]== false do 
		Sleep(100)
	 end
	 boolWaterWheelDone=true
end

basinpillar=piece"basinpillar"
Basin=piece"Basin"

function showWaterWheels()
	Hide(DryBasin)
	Hide(BasinFarnDry)
	Show(BasinFarn)
	Show(Basin)
	Sleep(500)
	Show(waterwheel	)
	Show(WaterPlan0	)
	Show(WaterPlane	)
	Show(waterwheel)
	if maRa()==true then Show(FlucWheel) end
	Show(foamsphere1)
	Show(foamsphere2)
	Show(foamsphere3)

end
function hideWaterWheels()
	hideT(TablesOfPiecesGroups["WatWhe"])
	Hide(waterwheel	)

	Hide(FlucWheel	)
	Hide(foamsphere1)
	Hide(foamsphere2)
	Hide(foamsphere3)
	
	Hide(waterwheel)
	Hide(Basin)
	Show(DryBasin)
	Sleep(550)
	Hide(WaterPlan0	)
	Hide(WaterPlane	)

	Show(BasinFarnDry)
	Hide(BasinFarn)
end

boolWaterSpilling=true
TablesOfPiecesGroups={}
function script.Create()
	allreadyInsertedPieces={}
	--generatepiecesTableAndArrayCode(unitID)
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	resetT(TablesOfPiecesGroups["bP"])
	resetT(TablesOfPiecesGroups["Tree"])
	hideT(TablesOfPiecesGroups["bP"])
	Show(basinpillar)
	reset(wheelPivot)
	reset(FlucWheel)
	
	bonsaiPieces={}
	
	for i=1, 9, 1 do
		bonsaiPieces[i]={}
		for k=1 , 10, 1 do
			if (((i-1)*10)+k) < 98 then
				pieceName= "bP"..(((i-1)*10)+k)
				
				pieceName= piece(pieceName)
				bonsaiPieces[math.max(math.min(3,i%3),1)][#bonsaiPieces[i]+k]={	Piece= pieceName 
					
				}
			end
		end
	end
	StartThread(emitSound)
	StartThread(addWaterLvl)
	StartThread(buildLTree,center, 7, "Bonsai", "B", 18)
	StartThread(waterWheel)
	StartThread(showWaterWheels)
	
	
	
	sizeX, sizeY, sizeZ= 8,3,8
	baseShapeTable = createBaseShapeTable(sizeX, sizeY, sizeZ, 30)
	
	StartThread(buildBonsai, bonsaiPieces, baseShapeTable, sizeX, sizeZ, sizeY)
end

function createBaseShapeTable(sizeX, sizeY, sizeZ, piecenumber)
	overhanglikelihoodMax=math.random(0.1,1)
	backTracklikelihoodMax= math.random(0.05,1)
	riftliklihoodmax = math.random(0.1,3)--
	baseRotLikelikhoodMax =math.random(0.1,0.95)--
	
	baseShapeTable ={}
	radiusA,radiusB= math.random(sizeX/2,sizeX),math.random(sizeZ/2,sizeZ)
	y=1
	for x= 1, sizeX, 1 do
		for z= 1, sizeZ, 1 do
			if not baseShapeTable[x] then baseShapeTable[x] ={} end
			if not baseShapeTable[x][z] then baseShapeTable[x][z] ={} end
			if not baseShapeTable[x][z][y] then baseShapeTable[x][z][y] ={} end
			
			baseShapeTable[x][z][y]= true
			if distance(x,z,sizeX,sizeZ) < radiusA then baseShapeTable[x][z][y]= false end
			if distance(x,z,1,sizeZ) < radiusB then baseShapeTable[x][z][y]= false end
			if math.random(1,100)/100 > baseRotLikelikhoodMax then	baseShapeTable[x][z][y]= false	end
			
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
	if math.random(0,5)==2 then
		for i=0, sizeX, 1 do
			heightGradient[i]= i* fractionHeight -45
		end
	else
		for i=0, sizeX, 1 do
			heightGradient[sizeX-i]= i* fractionHeight -45
		end
	end
	return heightGradient
end

allreadyInsertedPieces={}
function getBonsaiPiece(y, bonsaiPieces, sizeY)
	for i=1,#bonsaiPieces[1], 1 do
		if math.random(0,1) == 1 and not allreadyInsertedPieces[bonsaiPieces[1][i].Piece] then
			allreadyInsertedPieces[bonsaiPieces[1][i].Piece] =true
			return bonsaiPieces[1][i].Piece
		end
	end
	
	for y=1, sizeY, 1 do
		
		for i=1,#bonsaiPieces[y], 1 do
			if math.random(0,1) == 1 and not allreadyInsertedPieces[bonsaiPieces[y][i].Piece] then
				allreadyInsertedPieces[bonsaiPieces[y][i].Piece] =true
				return bonsaiPieces[y][i].Piece
			end
		end
	end
	
	return nil
end

function getCollissionOffset(id, piece)
	vx,vy,vz=Spring.GetUnitPieceCollisionVolumeData(id,piece)
	px,py,pz =Spring.GetUnitPiecePosition(id,piece)
	dx,dy,dz=Spring.GetUnitPieceDirection(id,piece)
	vec=normVector(makeVector(dx,dy,dz))
	px,py,pz=px + vec.x*vx, py + vec.y*vy, pz +vec.z*vz
	
	return px, py,pz
end

--bonsaiPieces must be a objecttable containing layers of tables, containing a table with a piece and a Sensory
function buildBonsai(bonsaiPieces, baseShapeTable, sizeX, sizeZ, sizeY, maxHeight)
	
	WTurn(center,y_axis,0,0)
	--This hides all the bonsaisPieces
	for i=1,#bonsaiPieces, 1 do
		for k=1,#bonsaiPieces[i] do
			Hide(bonsaiPieces[i][k].Piece)
		end
	end
	--bonsaiTable[x][z][1]={height, BoolGround, piece, Sensory}
	defaultTable= {height=0, BoolGround=false, Piece= -math.huge}
	
	
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
	sx,sy,sz= getCollissionOffset(unitID, bonsaiPieces[1][1].Piece)
	bx, boldHght, bz = math.max(vx,sz)*0.75, math.abs(sy-vy) , math.abs(vz,sz)*0.75
	
	
	for y=1,sizeY, 1 do
		for x= 1, sizeX, 1 do
			for z= 1, sizeZ, 1 do
				if y==1 and baseShapeTable[x][z][1] == true then
					
					
					--get the heightOffset
					
					heightOffset= heightGradient[z] + cliffFactor*(math.random(boldHght/-4,boldHght/4))
					bonsaiTable[x][z][1].Height=heightOffset	
					bonsaiTable[x][z][1].BoolGround=true
					bonsaiTable[x][z][1].Piece = getBonsaiPiece(y, bonsaiPieces, sizeY)
					if not 	bonsaiTable[x][z][1].Piece then return end
					--place a bolder
					px,py,pz= bx*x, -10 + bonsaiTable[x][z][1].Height, bz*z
					MovePieceToPos(bonsaiTable[x][z][y].Piece, px, py, pz, 0)
					
					dir, angular = getClosestDirection(directionTable,x,z) 
					dir = dir + math.random(-15,15)
					--Turn Boulder towards dir
					Turn(bonsaiTable[x][z][1].Piece,y_axis,math.rad(dir), 0)
					WTurn(bonsaiTable[x][z][1].Piece,x_axis,math.rad(angular), 0)
					Show(bonsaiTable[x][z][1].Piece)
					Sleep(1)
				end
				
				
				if y~=1 and baseShapeTable[x][z][y] == true then
					
					--get the heightOffset
					heightOffset= heightGradient[x] + cliffFactor*(math.random(-boldHght/4,boldHght/4))
					bonsaiTable[x][z][y].Height=heightOffset	
					bonsaiTable[x][z][y].BoolGround= true	
					bonsaiTable[x][z][y].Piece = getBonsaiPiece(y, bonsaiPieces, sizeY)
					if not 	bonsaiTable[x][z][y].Piece then return end
					Show(bonsaiTable[x][z][y].Piece)
					
					
					if baseShapeTable[x][z][y-1] == true then
						Sleep(1)
						ox,oy,oz= getCollissionOffset(unitID,bonsaiTable[x][z][y-1].Piece)
					
						ox=ox*-1
						Move(bonsaiTable[x][z][y].Piece,x_axis,ox,0)
						Move(bonsaiTable[x][z][y].Piece,y_axis,oy,0)
						Move(bonsaiTable[x][z][y].Piece,z_axis,oz,0,true)
						Sleep(1)
						
					else
						px,py,pz= bx*x, bonsaiTable[x][z][y].Height, bz*z
						MovePieceToPos(bonsaiTable[x][z][y].Piece, px, py, pz, 0)
						Sleep(1)
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
	end	
	Move(center,y_axis, 0, 0)-- boldHght/-2,0)
	Turn(center,y_axis,math.random(-math.pi,math.pi),0)
	
	roofPieceTable={}
	allreadyFoundTile=makeTable(false,sizeX,sizeZ)
	
	for y=sizeY, 1, -1 do
		for x= 1, sizeX, 1 do
			for z= 1, sizeZ, 1 do
				if baseShapeTable[x][z][y] and baseShapeTable[x][z][y] == true and allreadyFoundTile[x][z] == false then
					roofPieceTable[bonsaiTable[x][z][y].Piece]=bonsaiTable[x][z][y].Piece
					allreadyFoundTile[x][z] = true			
				end			
			end
		end
	end	
	
	for k,v in pairs (TablesOfPiecesGroups["Tree"]) do
		for key,value in pairs(roofPieceTable)do
			if value then
				if math.random(0,1)== 1 then
					--place piece on top
					x,y,z= getCollissionOffset(unitID, value)
					MovePieceToPos(v,x,y,z, 0)
					
				else
					pox,_,poz= Spring.GetUnitPiecePosDir(unitID,value)
					pox,poz= pox +math.random(-75,75), poz +math.random(-75,75)
					groundHeight= Spring.GetGroundHeight(pox,poz)
					movePieceToGround(value,v, 0)
				end
				Show(value)
				roofPieceTable[key]= nil
				
			end
		end
	end
	
end

	function addWaterLvl()
		Sleep(100)
		while(true) do
		
			minExtreme,maxExtreme=Spring.GetGroundExtremes()
			if minExtreme -50 > 0 then 
				g_AddOnRate =0.0005 
			else
				g_AddOnRate =1
			end
			
			if GG.addWaterLevel ~= nil and boolWaterSpilling == true then
				
				GG.addWaterLevel=GG.addWaterLevel+g_AddOnRate
				Sleep(1000)

			else
				Sleep(1000)
			end
		end
	end

function script.Activate()
	if boolWaterWheelDone== true then
		boolWaterSpilling=true
		StartThread(waterWheel)
	end

	return 1
end


function script.Deactivate()


	boolWaterSpilling=false
	return 0
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