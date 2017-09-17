
function mirrorMapCenter(x,y,z)
	mx,mz=Game.mapSizeX,Game.mapSizeZ
	mx,mz= mx/2,mz/2
	
	return x-1*(x-mx), y, z-1*(z-mz)
end

	function sanitizeRandom(lowerBound,UpperBound)
	if lowerBound >= UpperBound then return lowerBound end
	
	return math.random(lowerBound,UpperBound)
	end

--Rule of Order
--Rule of Shape by Absence
--Rule of Symmetry
--Rule of ReverseAtEnd

--Rule of Symmetry+ Rule of Order => Selbstähnlichkeit Mirroring of Order



-->Returns a Ordered Queue of Pieces that conform 

-->In absence of symmetric pieces, the buildpieces are paired with one example of connection sockets on exploration to add the 3d point
function buildVehicle(center,Arm_Max,Leg_Max, Body_Double_Max,Head_Max, lDeco_Max, DecoD,Body_Max, symDegFilterFunction, linDegFilterFunction,lexpandWeightTable, lMinPieces)
	ConCenter=piece("ConCenter")
	Hide(ConCenter)
	ConLinPiece={}
	ConSynPiece={}
	--Debug 
	expandWeightTable=lexpandWeightTable or {[1]=2, 	--front
		[2]=2, 		--rear
		[3]=1, 		--side left
		[4]=1,		--side right
		[5]=0.5, 	--up
		[6]=0.5 	--low
	}
	
	function bd_makePointFromPiece(piecename)
		if not piecename then return nil end
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,piecename)
		return{x=ox*-1,y=oy,z=oz, Piece=piecename }
	end
	
	--Contains enumerated the points of a piece
	SymConCoord={}
	LinConCoord={}
	AllDynamicSockets={}
	reset(ConCenter)
	for i=1,4 do
		dynString="LinCon"..i
		ConLinPiece[i]=piece(dynString)
		Hide(ConLinPiece[i])
		LinConCoord[i]=bd_makePointFromPiece(ConLinPiece[i])
	end	
	ConSynPiece[1]= piece"SymCon1"
	assert(ConSynPiece[1])
	ConSynPiece[2]= piece"SymCon2"
	assert(ConSynPiece[2])
	Hide(ConSynPiece[1])
	Hide(ConSynPiece[2])
	
	SymConCoord[1]=bd_makePointFromPiece(	ConSynPiece[1])
	SymConCoord[2]=bd_makePointFromPiece(	ConSynPiece[2])
	AllDynamicSockets[#AllDynamicSockets+1]=ConSynPiece[1]
	AllDynamicSockets[#AllDynamicSockets+1]=ConSynPiece[2]
	--TODO add SymBodyConCoords
	
	AllReadyUsedPieces={}
	AllReadyUsedCoords={}
	--BODY
	--all the yet unused BodyPieces
	BodyPieces={}
	ConCoords={}
	
	DoubleBodyPieces={}
	BodyID=1
	--Define the max numbers of each Piece Category
	DoubleMax=Body_Double_Max 
	BodyMax=Body_Max or 22
	ArmMax= Arm_Max or 8
	ArmDouble=Leg_Max or 4 --arms that can be used for linear expansion
	MinPieces=lMinPieces or 10
	HeadMax= Head_Max or 4
	DecoMax= lDeco_Max or 35
	DecoDouble= DecoD or 29
	
	
	--Connection pieces for linear Connections only
	for i=1,BodyMax,1 do	
		bodyPieceNameOrigin="body"..i.."s1"
		bodyPieceName="body"..i.."s2"
		BodyPieces[#BodyPieces+1]=piece(bodyPieceNameOrigin)-- starts with 1
		BodyPieces[#BodyPieces+1]=piece(bodyPieceName)		-- 2 is the symmetric second piece 
	
		if i < DoubleMax and i %2 ==0 then
			DoubleBodyPieces[#DoubleBodyPieces+1]={k=BodyPieces[i-1],
												   v=BodyPieces[i]}									
		end
	end

	--ARM
	ArmPieces={}
	DoubleArmPieces={}
	
	ArmTable={}
	--arms must come in symmetric pairs
	for i=1,ArmMax,1 do
		mod=((i-1)%2+1)
		bodyPieceName1="Leg"..i..mod --Uper Arm
		bodyPieceName2="Leg"..i..mod.."l" --Lower Arm - Wheels
		bodyPieceName3=bodyPieceName2 --the lower leg is the body piece on which we use as distance measure to ground 
		ArmPieces[i]={}
		
		ArmPieces[i][1]=	piece(bodyPieceName1)
		ArmPieces[i][2]=	piece(bodyPieceName2)
		ArmPieces[i][3]=	piece(bodyPieceName3)
		Hide(ArmPieces[i][1])
		Hide(ArmPieces[i][2])
		
		
		--add the linear connections
		if i < ArmDouble and i %2 ==0 then
			DoubleArmPieces[#DoubleArmPieces+1]={k=ArmPieces[i-1],v=ArmPieces[i]			}
		end
	end
	
	--HEAD
	HeadPieces={}
	
	DoubleHeadPieces={}
	
	for i=1,HeadMax,1 do
		
		bodyPieceName="Head"..i
		HeadPieces[i]=piece(bodyPieceName)
		Hide(HeadPieces[i])
		
		--add the linear connections
		if i < HeadMax and i %2 ==0 then
			DoubleHeadPieces[#DoubleHeadPieces+1]={k=HeadPieces[i-1],v=HeadPieces[i]			}											
		end		
	end
	
	--DECO
	DecoPieces={}
	DoubleDecoPieces={}
	
	for i=1,DecoMax,1 do
		
		bodyPieceName="Deco"..i
		DecoPieces[i]=piece(bodyPieceName)
		
		--add the linear connectionsk
		if i < DecoDouble and i %2 ==0 then
			DoubleDecoPieces[#DoubleDecoPieces+1]={k=DecoPieces[i-1],v=DecoPieces[i]			}							
		end
		Hide(DecoPieces[i])
		
	end
	-------------------------------------------------------------------EndOfPieceDelcarations-----------
	--Contains all Connections exposed by allready used BodyParts 
	--every added Symetric ConnectionPoint is parallel such as [1] <-> [2] form a symetric pair
	SymBodyConCoords={}
	LinBodyConCoords	={}
	
	--> Turns a Piece into a random Direction
	function bd_turnPieceInRandDir(pie,dirVec,SymSideVal,llinDegFilterFunction,lsymDegFilterFunction,symPiece)
		x,y,z=0,0,0	
		offSetX= dirVec.offSetX or 0
		
		if dirVec.boolFixedDegree and dirVec.boolFixedDegree ==true then
			x,y,z=dirVec.x,dirVec.y,dirVec.z
			
		else --randomIntervall
			minx,maxx,miny,maxy,minz,maxz=dirVec.minx,dirVec.maxx,dirVec.miny,dirVec.maxy,dirVec.minz,dirVec.maxz
			x=math.random(minx,maxx)
			z=math.random(minz,maxz)%180
			y=math.random(miny,maxy)
			linDegFilterFunction= llinDegFilterFunction or function(a,b,c) return a - (a%90), b- (b%90), c- (c%90) end
			symDegFilterFunction= lsymDegFilterFunction or function(a,b,c) return a - (a%45), b- (b%45), c- (c%45) end
			_,y,_= linDegFilterFunction(0,y,0) 
		end
		
		Turn(pie,y_axis,math.rad(y),0,true)
		
		if symPiece == nil then
			--Turn(pie,z_axis,math.rad(0),0,true)
			x,_,_=linDegFilterFunction(x,0,0)
			Turn(pie,x_axis,math.rad(x+offSetX),0,true)
		else --if a Sympiece exists
			
			val=y*-1
			x,y,_=symDegFilterFunction(x,val,0)
			Turn(symPiece,y_axis,math.rad(y),0,true)
			
			Turn(pie,x_axis,math.rad(x+offSetX),0,true)
			Turn(symPiece,x_axis,math.rad(x+offSetX),0,true)
			
			
		end
		
		
		return x,y,z
	end
	
	-->	Connects a lin Piece to a Socket Socket,ConectionSocket,BodyPiece
	function bd_conPieceCon2Socket(Socket,Pie,dirVec, boolLeftRight)	
		
		x,y,z=Socket.x*-1,Socket.y,Socket.z
		--Spring.Echo("Socket Coordinates Relative (X):"..Socket.x .." (Y):"..Socket.y.." (Z):"..Socket.z)
		SymSideVal=1	
		
		if boolLeftRight and boolLeftRight==true then
			SymSideVal=-1
		end
		
		Show(Pie)
		Move(Pie,x_axis,x,0,true)
		Move(Pie,z_axis,z,0,true)
		Move(Pie,y_axis,y,0,true)
		--Now the piece is at the exact location of the connection piece
		if dirVec then				
			bd_turnPieceInRandDir(Pie,dirVec,SymSideVal,linDegFilterFunction,symDegFilterFunction)
		end		
	end
	--> Connects a symmetric Piecepair to sockets
	function bd_sconPieceCon2Socket(Socket,Pie,dirVec, boolLeftRight)
		x,y,z=Socket.x,Socket.y,Socket.z
		--	--Spring.Echo("JW:SymetricConPiece:"..Pie.." to Socket "..Socket)
		SymSideVal=1	
		if boolLeftRight and boolLeftRight==true then SymSideVal=-1 end
		
		Show(Pie)
		
		Move(Pie,x_axis,x,0,true)
		Move(Pie,z_axis,z,0,true)
		Move(Pie,y_axis,y,0,true)
		--Now the piece is at the exact location of the connection piece
		
		if dirVec then				
			bd_turnPieceInRandDir(Pie,dirVec,SymSideVal,linDegFilterFunction,symDegFilterFunction)
		end
	end
	---------------------------
	
	function bd_initVehicleCreation()
		
		for i=1,ArmMax,1 do
			Hide(ArmPieces[i][1])
			Hide(ArmPieces[i][2])
		end
		hideT(BodyPieces)		
		hideT(HeadPieces)
		hideT(DecoPieces)
		resetT(BodyPieces)
		resetT(DecoPieces)
		resetT(HeadPieces)
		bd_init()
		StartThread(bd_buildRandomizedVehicle)		
	end
	
	function bd_existsParts(tablename)
		return table.getn(tablename)~= 0
	end
	
	function makeVecFromPoint(piecess)
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,piecess)
		l=math.sqrt(ox* ox + oy*oy + oz *oz)
		return {x=ox/l ,y=oy/l,z=oz/l}		
	end
	
	function getSocketsAsPoints(part, sympart)
		getLinCoords= function (piecename)
			AlignPieceToPiece(unitID, ConCenter,piecename,0,true,true,AllDynamicSockets)
			retTable={}
			
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[1]))
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[2]))
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[3]))
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[4]))
			
			return retTable
		end
		
		getSynCoords= function(piecename)
			AlignPieceToPiece(unitID, ConCenter,piecename,0)
			retTable={}
			
			table.insert(retTable,bd_makePointFromPiece(ConSynPiece[1]))
			table.insert(retTable,bd_makePointFromPiece(ConSynPiece[2]))
			
			return retTable
		end
		
		local RetLinConCoord=	{}
		local SLinConCoord=	{}
		local RetSynConCoords={}
		local SSynCon={}
		-- we move the ConCenter to the part
		
		--get the points Coordinates
		RetLinConCoord=getLinCoords(part)
		RetSynConCoords=getSynCoords(part)
		
		if sympart then	
			-- we move the ConCenter to the part
			--get the points Coordinates
			SLinConCoord=getLinCoords(sympart)
			SSynCon=getSynCoords(sympart)
		end
		
		if table.getn(SLinConCoord) > 0 or table.getn(SSynCon) > 0 then 
			return RetLinConCoord, RetSynConCoords, SLinConCoord, SSynCon 
		else
			return RetLinConCoord,RetSynConCoords, {},{}
		end
	end
	
	--Continue here TODO
	function bd_LinAddPieceSocketsToPool(partnr,boolAddSymetrics)
		--> we move the conCenter to the piece
		AlignPieceToPiece(unitID, ConCenter, BodyPieces[partnr], 0)
		--movePieceToPiece(unitID, ConCenter, BodyPieces[partnr], 0)

		--WaitForMoves(ConCenter)

		if not ConCoords[partnr] then ConCoords[partnr] = {Symetric ={},Linear ={}} end
		
		ConCoords[partnr].Symetric = {[1] = bd_makePointFromPiece(ConSynPiece[1]),
									  [2] = bd_makePointFromPiece(ConSynPiece[2])}

		
		ConCoords[partnr].Linear ={
									[1]=bd_makePointFromPiece(ConLinPiece[1]),
									[2]=bd_makePointFromPiece(ConLinPiece[2]),
									}
									
		LinBodyConCoords[#LinBodyConCoords+1]= ConCoords[partnr].Linear[1]
		LinBodyConCoords[#LinBodyConCoords+1]= ConCoords[partnr].Linear[2]
	
		
		if math.random(1,8) == 4 then	
			ConCoords[partnr].Linear[#ConCoords[partnr].Linear+1] =	bd_makePointFromPiece(ConLinPiece[3])
			LinBodyConCoords[#LinBodyConCoords+1]= ConCoords[partnr].Linear[3]
		end
		
		if math.random(1,4)== 4 then 
			ConCoords[partnr].Linear[#ConCoords[partnr].Linear+1] =	bd_makePointFromPiece(ConLinPiece[4])
			LinBodyConCoords[#LinBodyConCoords+1]= ConCoords[partnr].Linear[4]
		end
		--Add the Linear connction spots
		--add the point from ConLinPiece
		
		--> Add the Symmetric connectionspots
		if ( boolAddSymetrics and boolAddSymetrics == true) then
			SymBodyConCoords[#SymBodyConCoords+1] = {}
			SymBodyConCoords[#SymBodyConCoords][1]= ConCoords[partnr].Symetric[1]
			SymBodyConCoords[#SymBodyConCoords][2]= ConCoords[partnr].Symetric[2]	
		end
	end
	
	function bd_SymAddPieceSocketsToPool(part,sympiece)
		--we add the points into the table for symmmetric expansion
		--all the sockects are to be replaced by points--> implicating that 
		ConCoords[part].Linear,ConCoords[part].Symetric,	ConCoords[sympiece].Linear,	ConCoords[sympiece].Symetric=	getSocketsAsPoints(part,sympiece)
		
		local LinearCon=ConCoords[part].Linear
		local LinearConS=ConCoords[sympiece].Linear
		local SymConCoord=ConCoords[part].Symetric
		local SymConCoordS=ConCoords[sympiece].Symetric
		
		if LinearCon then
			for i=1,#LinearCon, 1 do
				SymBodyConCoords[#SymBodyConCoords+1]=	{
					[1]=LinearCon[i],
					[2]=LinearConS[i]	
				}
			end
		end
		
		if SymConCoord then
			for i=1,#SymConCoord, 1 do
				SymBodyConCoords[#SymBodyConCoords+1]=	{
					[1]=SymConCoord[i],
					[2]=SymConCoordS[i]	
				}
			end
		end
	end
	
	function bd_makeDirVecFromDeg(degx, valx, degy, valy, degz, valz, offSetX)
		dirVec={}
		dirVec.minx, dirVec.maxx=degx-valx, degx+valx
		dirVec.miny, dirVec.maxy=degy-valy, degy+valy
		dirVec.minz, dirVec.maxz=degz-valz, degz+valz
		if offSetX then	dirVec.offSetX=offSetX end
		return dirVec
	end
	
	function bd_init()
		hideAllPieces(unitID)
		Move(BodyPieces[1],x_axis, 0, 0, true)	
		Move(BodyPieces[1],y_axis, 0, 0, true)	
		Move(BodyPieces[1],z_axis, 0, 0, true)	
		bd_turnPieceInRandDir(BodyPieces[1],bd_makeDirVecFromDeg(180, 180, 0, 0, 0, 0),1, linDegFilterFunction, symDegFilterFunction)
		
		Show(BodyPieces[1])
		bd_LinAddPieceSocketsToPool(1, true)
		bd_usedPiece(BodyPieces[1])
	end
	
	function bd_DoubleCheckPiece(tablename)
		--Rewrite
		
		local pieceA = 0
		local pieceB = 0
				
		for num, entry in pairs(tablename) do
			if entry then
				 pieceA	= entry.k
				 pieceB = entry.v
		
				if pieceA and pieceB and (not AllReadyUsedPieces[pieceA] and not AllReadyUsedPieces[pieceB]) then		
					tablename[num] = nil

					return pieceA, pieceB
				end
			end
		end
		--exists a symetric pair- and a symetric socket pair
	end
	
	function bd_rollDice(maxs)
		return math.random(1, maxs),math.random(1, maxs)
	end

	
	--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
	function bd_LinearExpandPiece(bodyNumber)
		boolFirstOfPair = (bodyNumber % 2 == 0)
		local BodyDice	= math.ceil(math.random(bodyNumber, math.min((bodyNumber +2),table.getn(BodyPieces))))
		local BodyPiece	= BodyPieces[BodyDice]
		if table.getn(LinBodyConCoords) < 1 then echo("bd_linearexpandPiece_EarlyOut");return end
		local SocketDice	= math.random(1, table.getn(LinBodyConCoords))
		local Socket 	 	= LinBodyConCoords[SocketDice]
		Show(BodyPiece)
		
		if not AllReadyUsedPieces[BodyPiece] and not AllReadyUsedCoords[Socket.Piece] then
			randomVec=bd_makeDirVecFromDeg(180, 180, 0, 0, 0, 0)
			echo("Bodypiece added linear"..getUnitPieceName(unitID, BodyPiece))

			bd_conPieceCon2Socket(Socket, BodyPiece, randomVec)
			bd_LinAddPieceSocketsToPool(BodyDice, true)	
			
			Show(BodyPiece)
			bd_usedPiece(BodyPiece)
			bd_usedPiece(LinBodyConCoords[SocketDice].Piece)
			
			if boolFirstOfPair== true then return 2 else return 1 end
		end
		
		return 0
	end
	
	function bd_getPairNrSymBodyConCoords(nr)
		if SymBodyConCoords[nr] and not AllReadyUsedPieces[SymBodyConCoords[nr][1].Piece] and not AllReadyUsedPieces[SymBodyConCoords[nr][2].Piece] then
			return SymBodyConCoords[nr][1],SymBodyConCoords[nr][2]	
		end
	end
	
	function bd_SymmetricExpand(pieceA, pieceB)
		--Spring.Echo("JW:VaryFoo:SymetricExpanding_1 >>"..table.getn(SymBodyConCoords))
		echoT(SymBodyConCoords)
		-->Align Piece A -- add all pieces as symmetrics
		AlignPieceToPiece(unitID, ConCenter, pieceA, 0)
		--> Align PiecB --add all pieces as symmetrics
		echo("jw_Build:A")
		if SymBodyConCoords and table.getn(SymBodyConCoords) > 0 then
			--Spring.Echo("JW:SymetricExpand_1.5")
					echo("jw_Build:B")
			dice=math.floor(math.random(1, math.max(1, table.getn(SymBodyConCoords)	)))
			socketA, socketB=bd_getPairNrSymBodyConCoords(dice)
			--nr=echoNr(nr);assert(socketA)
			if socketA then 
			echo("jw_Build:C")
				
				if AllReadyUsedPieces[pieceA] == nil and AllReadyUsedPieces[pieceB] == nil then
					echo("jw_Build:D")
					Show(pieceA)
					Show(pieceB)	
					
					dirVec=bd_makeDirVecFromDeg(90, 45, 180, 90, 90, 35)
					bd_turnPieceInRandDir(pieceA, dirVec, 1, linDegFilterFunction, symDegFilterFunction, pieceB)
					bd_sconPieceCon2Socket(socketA, pieceA,  dirVec,  true)
					bd_sconPieceCon2Socket(socketB, pieceB,  dirVec,  false)
					--add symmetric expansion points to the pool
					bd_SymAddPieceSocketsToPool(pieceA, pieceB)
					
					bd_usedPiece(socketA)
					bd_usedPiece(socketB)
					bd_usedPiece(pieceA)
					bd_usedPiece(pieceB)
					return 2
				end
			end
		end
		return 0
	end
	
	
	function bd_findInSymBodyConCoords(point)
		for i=1, table.getn(SymBodyConCoords),1 do
			if SymBodyConCoords[i][1]==point or SymBodyConCoords[i][2]==point then
				return i
			end
		end
	end
	
	function bd_usedPiece(piecename)
		AllReadyUsedPieces[piecename]=true
	end
	
	
	local PiecePositionCache={}
	
	function bd_accessCache(key)
		if PiecePositionCache[key] then
			return PiecePositionCache[key].x,  PiecePositionCache[key].y,  PiecePositionCache[key].z, PiecePositionCache[key].piecename
		end
	end
	
	function bd_insertCache(key, x, y, z)
		PiecePositionCache[key]={x=x, y=y, z=z, piecename=key}
		return true
	end
	
	function bd_LinFindFrontCon()
		X=-math.huge
		
		ShorTerMem=LinBodyConCoords[#LinBodyConCoords]
		
		for i=1,  #LinBodyConCoords, 1 do
			x,y,z,piecename=bd_accessCache(LinBodyConCoords[i].Piece)
			if z then
				if z > X then
					X=z			
					ShorTerMem={x=x, y= y, z=z, Piece =piecename}
				end
			else
				x,y,z=LinBodyConCoords[i].x,LinBodyConCoords[i].y,LinBodyConCoords[i].z
				bd_insertCache(LinBodyConCoords[i].Piece,z,y,x)
				
				if z > X then
					X=z
					ShorTerMem=LinBodyConCoords[i]
				end
			end
		end
		--StartThread(DeBugPieceLight,ShorTerMem)
		return ShorTerMem
	end
	
	function bd_getSymHeadCon()
		Spring.Echo("TODO: bd_getSymHeadCon")
		highestZ= {value= -math.huge, instance={}}
		_2ndHighestZ= {value= -math.huge, instance={}}	
		
		for i=1, #SymBodyConCoords do
			local firstPair = SymBodyConCoords[i][1]
			if firstPair.z > highestZ.value then
			highestZ.value = firstPair.z
			highestZ.instance = firstPair		

			_2ndHighestZ.value = SymBodyConCoords[i][2].z
			_2ndHighestZ.instance = SymBodyConCoords[i][2]
			end
		end
		
	return highestZ.instance, _2ndHighestZ.instance
	end
	
	function bd_DeBugPieceLight(vecT)
		while true do
			for i=1,#vecT do
				Spring.SpawnCEG("greenlight",vecT[i].x,vecT[i].y,vecT[i].z,0,1,0)
			end
			Sleep(250)
		end
	end
	
	--attaches a Alienhead linear to the body
	function bd_LinearExpandHead(offSetX)
		HeadDice=math.random(1,table.getn(HeadPieces))
		Head=HeadPieces[HeadDice]
		
		Socket=bd_LinFindFrontCon()
		
		if Head and Socket and not AllReadyUsedPieces[Head] and AllReadyUsedCoords[Socket.Piece]== nil then
			randomVec=bd_makeDirVecFromDeg(0,25,0,0,0,0,offSetX)
			Show(Head)
			assert(type(Socket)=="table")
			bd_conPieceCon2Socket(Socket,Head,randomVec)
			bd_usedPiece(Head)
			bd_usedPiece(Socket)
			return 1
		end
		
		return 0
	end
	
	function bd_SymmetricExpandHead(pieceA,pieceB,offSetX)
		if SymBodyConCoords and table.getn(SymBodyConCoords) > 0 then
			
			socketA,socketB=bd_getSymHeadCon()			
			
			if socketA and AllReadyUsedPieces[pieceA] == nil and AllReadyUsedPieces[pieceB] == nil then
				Show(pieceA)
				Show(pieceB)	
				
				dirVec=bd_makeDirVecFromDeg(0,25,90,45,0,0,offSetX)
				
				bd_sconPieceCon2Socket(socketA,pieceA, dirVec, true)
				bd_sconPieceCon2Socket(socketB,pieceB, dirVec, false)
				
				bd_turnPieceInRandDir(pieceA,dirVec,1,linDegFilterFunction,symDegFilterFunction,pieceB)
				bd_usedPiece(socketA)
				bd_usedPiece(socketB)
				bd_usedPiece(pieceA)
				bd_usedPiece(pieceB)
				return 2
			end			
		end
		return 0
	end
	
	function bd_LinearExpandArm()
		ArmDice=math.random(1,ArmDouble)
		Arm=ArmPieces[ArmDice]
		if table.getn(LinBodyConCoords) <=1 then return -1 end
		
		SocketDice=math.random(1,table.getn(LinBodyConCoords))
		Socket=LinBodyConCoords[SocketDice]
		
		if AllReadyUsedPieces[Arm] == nil and AllReadyUsedCoords[Socket]== nil then
			randomVec=bd_makeDirVecFromDeg(0,0,0,0,0,0,0)
			Show(Arm[1])
			Show(Arm[2])
			assert(type(Socket)=="table")
			bd_conPieceCon2Socket(Socket,Arm[1],randomVec)
			bd_usedPiece(Arm[1])
			bd_usedPiece(Arm[2])
			bd_usedPiece(Socket)
			return Arm
		end
		
		return -1		
	end
	
	function bd_SymetricExpandArm(ArmTableA,ArmTableB )
		
		if SymBodyConCoords and table.getn(SymBodyConCoords) > 0 then
			dice=math.floor(math.random(1,math.max(1,#SymBodyConCoords)	))
			socketA,socketB=bd_getPairNrSymBodyConCoords(dice)
			
			if socketA then 
				table.remove(SymBodyConCoords,socketA)
				table.remove(SymBodyConCoords,socketB)				
				
				if AllReadyUsedPieces[ArmTableA[1]] == nil and AllReadyUsedPieces[ArmTableB[1]] == nil then
					--Spring.Echo("JW:VaryFoo:SymetricExpanding_3")
					Show(ArmTableA[1])
					Show(ArmTableA[2])
					Show(ArmTableB[1])	
					Show(ArmTableB[2])	
					
					dirVec=bd_makeDirVecFromDeg(0,0,0,0,0,0)
					
					bd_sconPieceCon2Socket(socketA,ArmTableA[1], dirVec, true)
					bd_sconPieceCon2Socket(socketB,ArmTableB[1], dirVec, false)
					
					bd_turnPieceInRandDir(ArmTableA[1],dirVec,1,linDegFilterFunction,symDegFilterFunction,ArmTableB[1])
					bd_usedPiece(socketA)
					bd_usedPiece(socketB)
					bd_usedPiece(ArmTableA[1])
					bd_usedPiece(ArmTableA[2])
					bd_usedPiece(ArmTableB[1])
					bd_usedPiece(ArmTableB[2])
					return ArmTableA,ArmTableB
				end
			end
		end		
	end
	
	--DEBUG DODO
	function bd_buildRandomizedVehicle()
		--Nr of Pieces Used to build this VaryFoo
		bodydice=math.random(#BodyPieces/2,#BodyPieces)
		teamID=Spring.GetUnitTeam(unitID)
		if not GG.VehiclePieceMax then GG.VehiclePieceMax={} end
		
		if not GG.VehiclePieceMax[teamID] then 
		end
		
		--we look up wethere there is a Vehicle PieceMax set for our team 
		BodyMax=GG.VehiclePieceMax[teamID] or #BodyPieces 
		
		if math.random(0,1)==1 then
			bodydice=math.ceil(math.random(math.ceil(BodyMax/2),BodyMax))
		else
			bodydice=math.ceil(math.random(math.ceil(BodyMax/4),math.ceil(BodyMax/2)))
		end
		bodyNum=1
		
		Max=math.random(4,#BodyPieces)
		
		LinConCoordLimit=bd_rollDice(Max)
		SymConCoordLimit=bd_rollDice(Max)

		--AddFirstSockets

		
		--DEBUG DELME

		-- DEBUG DELME 
		attempts=0

	
				
		while bodyNum < bodydice and bd_existsParts(BodyPieces)==true and attempts < bodydice do
			Sleep(10)
			-- while there exist BodyParts2 and numberOfBodyPiecesUsed < bodydice
				echo("LinCoorLimit"..LinConCoordLimit)
			if  false == true and LinConCoordLimit < math.random(1,Max) then
				--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
				bodyNum=bodyNum + (bd_LinearExpandPiece(bodyNum) or 0)
			else
				--Check if on of them is existing twice
				-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA, pieceB = bd_DoubleCheckPiece(DoubleBodyPieces)

							
				if pieceA and pieceB then -- and SymConCoordLimit < math.random(1,Max) 
				echo("Bodypiece expand symmetric:"..getUnitPieceName(unitID,pieceA).." /"..getUnitPieceName(unitID,pieceB))
					bodyNum=bodyNum+ (bd_SymmetricExpand(pieceA,pieceB) or 0)	
			--	else -- apply remainging BodyParts linear			
				--	bodyNum=bodyNum+ (bd_LinearExpandPiece(bodyNum) or 0)	
				end
			end
			
			attempts=attempts+1
		end
		
			--[[
		--Arm
		Armdice=math.ceil(math.random(3,ArmMax))
		ArmNum=0
		
		--Add at least one symetric Pair
		pieceA,pieceB=bd_DoubleCheckPiece(DoubleArmPieces)		
		ArmA,ArmB=bd_SymetricExpandArm(pieceA,pieceB)	
		table.insert(ArmTable,ArmA)
		table.insert(ArmTable,ArmB)
		ArmNum=ArmNum+2
		
		while ArmNum < Armdice and bd_existsParts(ArmPieces)==true do
			Spring.Echo("libbuild::arms")
			-- while there exist BodyParts2 and numberOfBodyPiecesUsed <Armdice
			--Spring.Echo("Exit the Loop2")
			--dice usage as a linear connector
			if boolAtLeastOnePair== true and LinConCoordLimit < math.random(1,Max) then
				--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
				--Spring.Echo("JW:LinearExpand")
				res=bd_LinearExpandArm()
				if res then
					ArmNum=ArmNum+1
					if res ~= -1 then table.insert(ArmTable,res)	end
				end
			else
				--Check if on of them is existing twice
				-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=bd_DoubleCheckPiece(DoubleArmPieces)		
				if pieceA and pieceB and SymConCoordLimit < math.random(1,Max) then
					--Spring.Echo("JW:SymetricExpand")
					ArmA,ArmB=bd_SymetricExpandArm(pieceA,pieceB)	
					table.insert(ArmTable,ArmA)
					table.insert(ArmTable,ArmB)
					ArmNum=ArmNum+2
					boolAtLeastOnePair=true
				else -- apply remainging BodyParts linear			
					res=bd_LinearExpandArm()
					if res then
						ArmNum=ArmNum+1
						if res ~= -1 then table.insert(ArmTable,res)	end
					end
					
				end
			end
		end
		
		
		
		headdice=math.ceil(math.random(1,HeadMax))
		headNum=0
		Max=HeadMax
		--Head
		
		LinConCoordLimit,SymConCoordLimit=bd_rollDice(Max)
		
		while headNum < headdice and bd_existsParts(HeadPieces)==true do
			Spring.Echo("libbuild::giving head")
			headNum=headNum+1
			if LinConCoordLimit < math.random(1,Max) then
				headNum=headNum+bd_LinearExpandHead(offSetX)
			else
				--Check if on of them is existing twice
				-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=bd_DoubleCheckPiece(DoubleHeadPieces)		
				if pieceA and pieceB and SymConCoordLimit < math.random(1,Max) then
					headNum=headNum+bd_SymmetricExpandHead(pieceA,pieceB,offSetX)	
				else -- apply remainging BodyParts linear			
					headNum=headNum+bd_LinearExpandHead(offSetX)			
				end
			end
		end
		
		--Not every Varyfoo needs deco	
		if math.random(0,1)==1 then
			decodice=math.ceil(math.random(1,DecoMax))
			decoNum=0
			oldDecoNum=0
			decoCounter=0
			Max=HeadMax
			--Head
			
			LinConCoordLimit,SymConCoordLimit=bd_rollDice(Max)
			
			while decoCounter < DecoMax and decoNum < decodice and bd_existsParts(HeadPieces)==true do
				
				if LinConCoordLimit < math.random(1,Max) then
					Spring.Echo("libbuild::Linear_decoration")
					decoNum=decoNum+bd_LinearExpandDeco(offSetX)
				else
					--Check if on of them is existing twice
					-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
					pieceA,pieceB=bd_DoubleCheckPiece(DoubleDecoPieces)		
					if pieceA and pieceB and SymConCoordLimit < math.random(1,Max) then
						decoNum=decoNum+bd_SymmetricExpandDeco(pieceA,pieceB,offSetX)	
						Spring.Echo("libbuild::Sym_decoration")
					else 			
						Spring.Echo("libbuild::Linear_decoration2")
						decoNum=decoNum+bd_LinearExpandDeco(offSetX)			
					end
				end
				if decoNum== oldDecoNum then decoCounter=decoCounter+1 end
				oldDecoNum=decoNum
			end		
		end		
		
		bd_alignLegsToGround()
		bd_processAddedArms()	
		--]]
		
	end	  	
	
	function bd_getSymDecoCon()
	
	if SymBodyConCoords and table.getn(SymBodyConCoords) > 0 then
			--Spring.Echo("JW:SymetricExpand_1.5")
			dice=math.floor(math.random(1,math.max(1,table.getn(SymBodyConCoords)	)))
			socketA,socketB=bd_getPairNrSymBodyConCoords(dice)
		return SocketA, SocketB
	end
	end
	
	--StartPoint
	local linDecP={}
	boolFoundSomething=false
	function bd_LinFindDecoCon()
		--we find a startpoint by finding start and endpoint and choosing the lowest
		poinTable=LinBodyConCoords
		if linDecP.x == nil or boolFoundSomething==false then 
			linDecP.x,linDecP.y,linDecP.z,linDecP.index=getLowestPointOfSet(poinTable,"z_axis") 
			temp={}
			assertT(poinTable,#poinTable,{x="number",y="number",z="number",Piece="number"})
			temp.x,temp.y,temp.z,temp.index=getHighestPointOfSet(poinTable,"z_axis") 
			if temp.y < linDecP.y then
				linDecP.x,linDecP.y,linDecP.z,linDecP.index= temp.x,temp.y,temp.z,temp.index
			end
		end
		
		--we now have the lowest startpoint and getting from that , we traveser always the nearest, heighest neighbour
		local lx,ly,lz=linDecP.x,linDecP.y,linDecP.z
		local tx,ty,tz,tdist,theight,index=math.huge,math.huge*-1,math.huge, math.huge, math.huge*-1,linDecP.index
		boolFoundSomething=false
		for i=1,#poinTable do
			dist=math.sqrt((lx-poinTable[i].x)^2+(ly-poinTable[i].y)^2+(lz-poinTable[i].z)^2)
			if dist < tdist and poinTable[i].y > theight and not AllReadyUsedPieces[LinBodyConCoords[i].Piece] then
				tx,ty,tz,tdist,theight = poinTable[i].x,poinTable[i].y,poinTable[i].z,dist, poinTable[i].y
				index=i
				--if we found nothing, we need to start again, at another lowest point
				boolFoundSomething=true
			end
		end
		linDecP.x,linDecP.y,linDecP.z,linDecP.index= tx,ty,tz,index
		
		return LinBodyConCoords[index] 
	end
	
	function bd_LinearExpandDeco(offSet)
		DecoDice=math.random(1,table.getn(DecoPieces))
		Deco=DecoPieces[DecoDice]
		
		Socket=bd_LinFindDecoCon()
		
		if AllReadyUsedCoords[Socket.Piece]== nil then
			Spring.Echo("Socket allready used")
		end		
		
		if AllReadyUsedPieces[Deco] == nil and AllReadyUsedCoords[Socket.Piece]== nil then
			
			randomVec=bd_makeDirVecFromDeg(90,45,0,0,0,0,offSet)
			Show(Deco)
			assert(type(Socket)=="table")
			bd_conPieceCon2Socket(Socket.Piece,Deco,randomVec)
			bd_usedPiece(Deco)
			bd_usedPiece(Socket.Piece)
			Spring.Echo("libbuild::LinearDecoExpansion Success")
			return 1
		end
		Spring.Echo("libbuild::LinearDecoExpansion Phail")
		return 0
	end
	
	function bd_SymmetricExpandDeco(pieceA, pieceB)
		if SymBodyConCoords and table.getn(SymBodyConCoords) > 0 then
			
			socketA,socketB=getSymDecoCon()
			
			if socketA and AllReadyUsedPieces[pieceA] == nil and AllReadyUsedPieces[pieceB] == nil then
				Show(pieceA)
				Show(pieceB)	
				
				dirVec=bd_makeDirVecFromDeg(180,180,180,180,180,180)
				
				bd_sconPieceCon2Socket(socketA,pieceA, dirVec, true)
				bd_sconPieceCon2Socket(socketB,pieceB, dirVec, false)
				
				bd_turnPieceInRandDir(pieceA,dirVec,1,linDegFilterFunction,symDegFilterFunction,pieceB)
				bd_usedPiece(socketA)
				bd_usedPiece(socketB)
				bd_usedPiece(pieceA)
				bd_usedPiece(pieceB)
				Spring.Echo("libbuild::SymDecoExpansion Success")
				return 2
			end
			
		end
		Spring.Echo("libbuild::SymDecoExpansion Phail")
		return 0
	end
	
	function bd_findLowestOfSet(Table)
		local spGetUnitPiecePosDir=Spring.GetUnitPiecePosDir
		local Index=1
		_,Min,_=spGetUnitPiecePosDir(unitID,Table[1][3])
		for i=1,#Table,1 do
			if Table[i][3]then 
				m=spGetUnitPiecePosDir(unitID,Table[i][3])
				if m <Min then 
					Min=m 
					Index=i
				end
			end
		end
		return Index
	end
	
	function bd_alignLegsToGround()
		if #ArmTable > 0 then
			--echoT(ArmTable)
			local spGetUnitPiecePos=Spring.GetUnitPiecePosition
			oldMaxDif=99999
			smallestIntervallSoFar=1	
			
			for i=1,360,6 do
				----Spring.Echo("JW:VaryFoo:Align"..i)
				Turn(center,x_axis,math.rad(i),0,true)
				
				IntervallMax,IntervallMin=0,0
				
				for j=1,#ArmTable, 1 do
					if ArmTable[j] and ArmTable[j][1] then
						Turn(ArmTable[j][1],x_axis,math.rad(-1*i),0,true)
						x,y,z=spGetUnitPiecePos(unitID,ArmTable[j][3])
						if y then
							
							if y < IntervallMin then IntervallMin=y end
							if y > IntervallMax then IntervallMax=y end		
						end
					end
				end
				
				if math.abs(IntervallMax-math.abs(IntervallMin)) < oldMaxDif then
					oldMaxDif=math.abs(IntervallMax-math.abs(IntervallMin))
					smallestIntervallSoFar=i
				end		
				
			end
			----Spring.Echo("JW:VaryFoo:SmallestIntervall::"..smallestIntervallSoFar.." Max-> "..IntervallMax.." Min ->"..IntervallMin)
			
			h=0
			y=900
			negVal=-1*smallestIntervallSoFar
			for i=1,table.getn(ArmTable), 1 do
				Turn(ArmTable[i][1],x_axis,math.rad(negVal),0,true)			
			end
			Turn(center,x_axis,math.rad(smallestIntervallSoFar),0,true)			
			WaitForTurn(center,x_axis)
			
			i=bd_findLowestOfSet(ArmTable)
			_,centHeight,_=Spring.GetUnitPiecePosDir(unitID,center)
			x,y,z=Spring.GetUnitPiecePosDir(unitID,ArmTable[i][3])
			
			Move(center,y_axis,centHeight-y,0,true)
			
			
			offSetX=smallestIntervallSoFar
		end
	end
	
	local SymPairArms={}
	local LinArms={}
	
	function bd_processAddedArms()
		temp={}
		for i=1,#ArmTable,1 do
			temp[ArmTable[i]]={}
			temp[ArmTable[i]]=ArmTable[i]
		end
		
		for i=1,#ArmTable,1 do
			--check wether the Arm is in DoubleArmPieces and its counterpart is in 
			if bd_getValByKeyObj(DoubleArmPieces,ArmTable[i]) and temp[bd_getValByKeyObj(DoubleArmPieces,ArmTable[i])] and not AllReadyUsedPieces[temp[bd_getValByKeyObj(DoubleArmPieces,ArmTable[i])]] then
				SymPairArms={[1]=ArmTable[i],
				[2]= temp[bd_getValByKeyObj(DoubleArmPieces,ArmTable[i])],}
			else
				LinArms[#LinArms+1]=ArmTable[i]
			end
		end
		
		
	end
	
	function bd_getValByKeyObj(Table,key)
		local T= Table
		for i=1,#T do
			if T.k== key then return T.v end
		end
	end
	
	
	bd_initVehicleCreation()
	
	
end

-->Creates a fictional Planet Name
function PlanetNameGenerator(llenght, lNamingSamples, lBreakers, lLetterTable,lBoolPrecursor, lBoolPostPoner)
	function PreCurse() return math.random(0,1)==1 end
	function PostPone() return math.random(0,1)==1 end
	
	
	length = llenght or 3
	NamingSamples= lNamingSamples or 10
	LetterTable= lLetterTable or {[1]="A",[2]="O",[3]="E",[4]="U",[5]="I",[6]="K",[7]="C",[8]="L",[9]="N",[10]="R",[11]="S",[12]="Y",[13]="G",[14]="H",[15]="T"}
	Breakers=lBreakers or math.floor(math.random(0,2))
	Precursor=""
	PostPoner=""
	
	PrecursorTable={"Prime ","Ul' ","Pan' ", "Sigma ", "Alpha ", "Beta", " First", "Pragma", "U.P.S. ", "Gama", "Sigma", "Omega", "Al' ", "New ", "Colony ", "El "}
	
	if PreCurse() ==true then
		Precursor=PrecursorTable[math.random(1,#PrecursorTable)]
	end
	
	PostPonerTable={" Colony", " Paradise", " <HellClass>" }
	
	if PostPone()==true then
		PostPoner=PostPonerTable[math.random(1,#PostPonerTable)]
	end
	
	NameEndingTable={"this","iel","ora","os","cia","ash","esh","ill","illa","esh","dor","ran",
		"spin","dia","bah","cant","sen","ino","ine","vin","eese","oga","lon",
	"alla","ico","rah","kel","nis","gam","hell","den","rado","yss","hnoss","lus","har"}
	previousChar="z"
	BreakerTable={}
	boolBreakerBlow=true
	dist=2
	for i=1,Breakers do
		if dist < length then
			BreakerTable[math.ceil(math.random(dist,length))]=true
		end
		dist=dist+3
		if dist> length then i=Breakers+1 end
	end
	
	BreakCounter=1
	for i=1,NamingSamples,1 do
		Name=""..Precursor
		for j=1,length,1 do
			boolBreakerBlow=false
			if (BreakerTable[j]) then Name=Name.." ' ";boolBreakerBlow=true;BreakCounter=1 else BreakCounter=BreakCounter+1 end
			if BreakCounter % 2 ==0 then
				index= math.floor(math.random(1,5)) 
			else
				index=math.random(1,#LetterTable)
			end
			if (LetterTable[index]==previousChar) then index=index+1 end
			if boolBreakerBlow==false and j ~= 1 then
				Name=Name..string.lower(LetterTable[index])
			else
				Name=Name..LetterTable[index]
			end
		end
		ending=math.random(1,#NameEndingTable)
		Name=Name..NameEndingTable[ending]..PostPoner
		Spring.Echo(Name)
	end
	
end

-->add a Terraindeformation to the LandLord
function jw_AddTerrainDeformation(x, z, size, ldepth, shapeFunction, lblendType, lfilterType)
	blendType=lblendType or "melt"
	filterType=lfilterType or "borderblur"
	shapeFunction = shapeFunction or prepareHalfSphereTable
	assert(ldepth)
	depth=ldepth or 4
	
	if GG.DynDefMap == nil then GG.DynDefMap={} end
	if GG.DynRefMap == nil then GG.DynRefMap={} end
	GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType= blendType, filterType=filterType}
	GG.DynRefMap[#GG.DynRefMap+1]=	shapeFunction(size,depth)
	
end

function addFreeSpots(ind_x, ind_y, ind_z, freeSpotList, gridTable, blocksize)
	
	dirTable=	{
		[0]=function() return 0,			1,			0 end,
		[1]=function() return 1,			0,			0 end,		
		[2]=function() return 0,			0,			1 end,
		[3]=function() return -1,			0,			0 end,
		[4]=function() return 0,			0,			-1 end,
		[5]=function() return 0,			1,			0 end
	}	
	
	
	dirRandomizer= math.ceil(math.random(1,5))
	
	ox,oy,oz = dirTable[0]()	
	
	if not gridTable[ind_x+ox] then gridTable[ind_x+ox] ={} end		
	if not gridTable[ind_x+ox][ind_z+oz]then gridTable[ind_x+ox][ind_z+oz] ={} end		
	if not gridTable[ind_x+ox][ind_z+oz][ind_y+oy] then gridTable[ind_x+ox][ind_z+oz][ind_y+oy] ={} end
	
	gridTable[ind_x+ox][ind_z+oz][ind_y+oy] = true	
	freeSpotList[table.getn(freeSpotList)+1] ={x = ind_x+ox, y= ind_y+oy, z= ind_z+oz }
	
	
	for i=1, dirRandomizer, 1 do
		ox,oy,oz = dirTable[i]()
		
		if not gridTable[ind_x+ox] then 
			gridTable[ind_x+ox] ={} 
		end
		
		if not gridTable[ind_x+ox][ind_z+oz]then
			gridTable[ind_x+ox][ind_z+oz] ={} 
		end
		
		if not gridTable[ind_x+ox][ind_z+oz][ind_y+oy] then
			
			gridTable[ind_x+ox][ind_z+oz][ind_y+oy] = true	
			freeSpotList[table.getn(freeSpotList)+1] ={x = ind_x+ox, y= ind_y+oy, z= ind_z+oz }
		end
	end
	
	return freeSpotList,gridTable
end


function moveBlockAddPod(x,y,z, block)--nrFreeSpot,nrBlok,bloks)
	assert(block)
	MovePieceToPos(block,x,y,z,0)
	d=math.floor(math.random(0,3))*90
	Turn(block,y_axis,math.rad(d),0)
	Show(block)
	
end


-->generates from Randomized squarefeeted blocks of size A and height B a Buildings
function buildRandomizedBuilding(lBlocks, gridOffsetY,gridTable,freeSpotList, blocksize, givenIndexFunction, gItteratorFunction, gposPostProcessFunc)
	local Blocks = lBlocks	
	ux,uy,uz= Spring.GetUnitPosition(unitID)
	
	for i=1,table.getn(Blocks),1 do
		Move(Blocks[i],x_axis,0,0)
		Move(Blocks[i],y_axis,0,0)
		Move(Blocks[i],z_axis,0,0,true)
	end
	
	defaultPieceItteratorFunction = function (lastIndex) return lastIndex+1 end
	defaultIndexFunction = function (index)
		return math.ceil(math.random(1,table.getn(freeSpotList))),{}
	end
	
	posPostProcessFunc= gposPostProcessFunc or function(pname, x,y,z) return x,y,z end 
	--selects the default random growth 
	persistancePosition={}
	selectIndexFunction = givenIndexFunction or defaultIndexFunction
	ItteratorFunction = gItteratorFunction or defaultPieceItteratorFunction
	orgOffSetY= gridOffsetY
	
	hideT(Blocks)
	
	
	--for all blocks in the blocklist
	for i=1,table.getn(Blocks), 1 do
		
		iterator= ItteratorFunction(i-1)	
		pieceToMove =	Blocks[iterator] 
		
		
		if pieceToMove then 
			
			--Show the block
			Show(Blocks[i])	
			boolNotPlace=true		
			
			
			while boolNotPlace==true and table.getn(freeSpotList) > 0 do
				randIndex, persistancePosition= selectIndexFunction(i,persistancePosition,freeSpotList, lastIndex)
				
				local index = freeSpotList[randIndex]
				
				if	index and gridTable[index.x] and 	
				gridTable[index.x][index.z] and 
				gridTable[index.x][index.z][index.y] and
				gridTable[index.x][index.z][index.y]== true then
					
					
					
					moveBlockAddPod(	
					freeSpotList[randIndex].x * blocksize ,
					freeSpotList[randIndex].y * blocksize + orgOffSetY ,
					freeSpotList[randIndex].z * blocksize ,
					pieceToMove
					)
					Show(pieceToMove)
					--PostProcessPosition
					posPostProcessFunc(pieceToMove,freeSpotList[randIndex].x,freeSpotList[randIndex].y,freeSpotList[randIndex].z)
					gridTable[index.x][index.z][index.y]= false
					table.remove(freeSpotList,randIndex)
					boolNotPlace= false
					
					freeSpotList,gridTable =addFreeSpots(index.x,index.y,index.z,freeSpotList,gridTable, blocksize)		
					--update current index as lastIndex
					lastIndex = index
					
				end				
			end
			
		end		
	end
end
--]]

function inLimits(value, llim,uplim)
	if value >= llim and value <= uplim then return true end
	return false
end


function buildInfernalMachine(center, pieceSize, pieceTable,limxz,limup)
	
	
	gridTable={}
	freeSpotList={}
	for i= -3,4,1 do
		gridTable[i]={}
		for j=-3,4,1 do
			gridTable[i][j]={}
			
			if j == 0 and math.abs(i) == 3 then
				
				gridTable[i][j][0]= true
				freeSpotList[#freeSpotList+1]={x=i,y= 0,z=j}			
			else
				gridTable[i][j][0]= false
			end
			
			
		end
	end
	
	resetT(pieceTable)
	
	
	getFreeSpotFunction = function (elementIndex,perPosition, freeSpotList)
		
		
		persistancePosition = perPosition or {}
		Sleep(100)
		
		if elementIndex < 41 then
			
			
			--check wether even or uneven piece
			--if evenpiece get a random index in one half +
			ListOfBuildSpots={}
			mySpot={}
			
			for i=1,table.getn(freeSpotList),1 do
				
				
				if freeSpotList[i] and freeSpotList[i].x and freeSpotList[i].z then
					--	Spring.Echo("Itterating Freespot ".. i .. " -> ".. freeSpotList[i].x .. " / "..freeSpotList[i].z)
					if freeSpotList[i].z >= 0 and freeSpotList[i].z < 5 and freeSpotList[i].x > -5 and freeSpotList[i].x < 5 then
						
						ListOfBuildSpots[#ListOfBuildSpots+1]= freeSpotList[i]
						ListOfBuildSpots[#ListOfBuildSpots].index=i
					end
				end
			end
			
			index = math.ceil(math.random(1,table.getn(ListOfBuildSpots)))
			assert(index)
			
			
			persistancePosition[elementIndex]= {x=freeSpotList[index].x, y =freeSpotList[index].y, z = freeSpotList[index].z*-1 }
			return ListOfBuildSpots[index].index, persistancePosition 
			--store that ones brother index in persistancePosition
		else
			--if uneven get the index to go 
			indX= math.max(1,math.min(elementIndex-40,80))
			if 	persistancePosition[indX] then
				for i=1,table.getn(freeSpotList),1 do
					
					if freeSpotList[i] then 
						if 	persistancePosition[indX].x ==freeSpotList[i].x and 
						persistancePosition[indX].y ==freeSpotList[i].y and
						persistancePosition[indX].z ==freeSpotList[i].z*-1 then 
							
							return i, freeSpotList[i] 
						end
					end
					
				end
			end
			
		end
		
		Spring.Echo("buildInfernalMachine:getFreeSpotFunction- Error "..elementIndex.." no index found")
	end
	
	
	postProc =function (pname, x, y, z)
		Turn(pname,x_axis, math.rad(90),0)
	end
	
	if maRa()== true then
		postProc =function (pname, x, y, z)
			val= math.random(-90,90)
			Turn(pname,x_axis, math.rad(val),0)
		end
	end
	
	gItteratorFunction = function (index) 
		return index
	end
	
	
	
	buildRandomizedBuilding(pieceTable ,1, gridTable, freeSpotList, 16, getFreeSpotFunction, gItteratorFunction, postProc)		
	
end
----------------->LTrees -------------------------------------------------------------------
globalTotalItterator=1
RecursionEnd={}
globalStepd=1
globalInCurrentStep={}
TreePiece={}
EndPiece={}


function slightVariation(deg,value)
	return math.random(deg-value,value+deg)
end

detTurnStoreTable={}
function deterministicTurn(index,maxindex,degree)
	if index > maxindex then --not first round
		index=(index%maxindex)+1
		if not detTurnStoreTable[index] then detTurnStoreTable[index]=3.141 end
		
		return detTurnStoreTable[index]+slightVariation(detTurnStoreTable[index] or 3, 7) , (detTurnStoreTable[index]*360) %(index*270)
	else
		detTurnStoreTable[index]= sanitizeRandom(maxindex,180)	/maxindex
		return detTurnStoreTable[index]*4, (detTurnStoreTable[index]*360) %(index*270)+math.random(0,10)
	end
end

detMoveStoreTable={}
function deterministicMove(index,maxindex)
	if index > maxindex and detMoveStoreTable[(index%maxindex)+1] then --not first round
		index=(index%maxindex)+1
		return detMoveStoreTable[index]
	else
		detMoveStoreTable[index]= math.floor(sanitizeRandom(1,maxindex))	
		return detMoveStoreTable[index]
	end
	return math.floor(sanitizeRandom(1,maxindex))	
end



--concatenates some random gramarRules, thus really creating new form of plants
function getRandomGramarProcution(ElementTable, NrOfElements, Recursionstart, RecursionEnd)
	Product=""
	for i=1,NrOfElements do
		if maRa()==true then 
			
			if maRa()==true then 
				Product=Product..(ElementTable[sanitizeRandom(1,#ElementTable)])
			else
				Product=(ElementTable[sanitizeRandom(1,#ElementTable)])..Product
			end
			
		end
	end
	return Product
end

ProductA=getRandomGramarProcution({"F","X","--X","+X"}, 5, "[", "]")
ProductB=getRandomGramarProcution({"F","X","-X","++X"}, 5, "[", "]")

--predefined gramars that generate the same tree if they get the same degree
gramarTable={
	[1]={
		name= "Recursive Tree",
		startElement="X", --GramarStartElement
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				return "FF" 
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				
				return "F-[X]-X" 
			end,
			["-"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel) 
				v=olddeg+degree
				if math.abs(v)-90 < 10 then v=v-25 end
				if math.abs(v) < 10 then v=v+degree end
				Turn(Tpiece,x_axis,math.rad(v),0,true)
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel)
				v=olddeg-degree
				if math.abs(v)-90 < 10 then v=v-25 end
				if math.abs(v) < 10 then v=v-degree end
				Turn(Tpiece,x_axis,math.rad(v),0,true)
				--if math.random(0,1)== 1 then 
				--c=degree*recIt
				--Turn(Tpiece,z_axis,math.rad(c),0,true)							
				--end
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	[2]={
		name= "Fibonacci Tree",
		startElement="F", --GramarStartElement
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true) 	
			return "FFX" end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)
				Turn(Tpiece,z_axis,math.rad(5*recIt),0,true)
				if math.random(0,1)== 1 then 
					Turn(Tpiece,x_axis,math.rad(olddeg),0,true) 
				else
					Turn(Tpiece,x_axis,math.rad(degree),0,true) 
				end 
				return "F[-X]+X" 
			end,
			["-"]= function (olddeg,degree,Tpiece) 
				v=olddeg+2*degree					
				Turn(Tpiece,x_axis,math.rad(v),0,true)	
			return "" end,
			["+"]= function (olddeg,degree,Tpiece)	
				v=olddeg-2*degree
				
				Turn(Tpiece,x_axis,math.rad(v),0,true)	
			return "" end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	
	
	[3]={ --Fibbonacci
		name= "Fibonacci Tree",
		startElement="F", --GramarStartElement
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				if recIt > 3 then Turn(Tpiece,z_axis,math.rad(degree),0,true) 	end
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true) 	
				return "+X[+F]-X" 
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)						
				if recIt > 3 then Turn(Tpiece,z_axis,math.rad(-degree),0,true) 	end
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true) 								
				return "++F[-F]" 
			end,
			["-"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel) 
				val=olddeg-degree*recIt				
				Turn(Tpiece,x_axis,math.rad(val),0,true)	
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel)	 	
				val=olddeg+degree*recIt								
				Turn(Tpiece,x_axis,math.rad(val),0,true)	
				return ""
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},	
	[4]={ --Proballistic L-System
		name= "Standard Gramar Plant",
		startElement="++X", --GramarStartElement
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad(olddeg) ,0,true)
				if math.random(0,1)==1 then 
					return "X" 
				else 
					return "F--X" 
				end
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	 
				if math.random(0,1)==1 then 
					return "F" 
				else 
					return "+XF-X" 
				end
			end,
			["-"]= function (olddeg,degree,Tpiece) 
				val=olddeg+degree;		
				Turn(Tpiece,x_axis,math.rad(val),0,true)	
			return "" end,
			["+"]= function (olddeg,degree,Tpiece)	 		
				val=olddeg-degree;
				Turn(Tpiece,x_axis,math.rad(val),0,true)
			return "" end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},	
	
	[5]={ 
		name= "Probalistic Plant",
		startElement="-F[F]+F", --GramarStartElement
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad(olddeg) ,0,true)
				if math.random(0,1)==1 and recIt > 4 then 	
					return "" 
				elseif math.random(0,1)==1 then 
					Turn(Tpiece,x_axis,math.rad(olddeg*recIt) ,0,true)
					return "X+F" 
				else 
					Turn(Tpiece,x_axis,math.rad(olddeg/recIt,boolLastLevel) ,0,true)								
					return "[--F]-FX" 
				end 
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true) 
				if math.random(0,1)==1 then 
					return "F" 
				else 
					return "-F++X+F" 
				end
			end,
			["-"]= function (olddeg,degree,Tpiece) 
				val=				olddeg+degree
				Turn(Tpiece,x_axis,math.rad(val),0,true)	
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece)	 		
				val=olddeg-degree
				Turn(Tpiece,x_axis,math.rad(val),0,true)	
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},	
	[6]={ 
		name= "FARN",
		degreeFilter=function(startdeg,turndeg)
			if math.abs(startdeg) > 45 then startdeg = 0 end
			if math.abs(turndeg) < 60 then turndeg=60+math.random(0,22) end
			return startdeg,turndeg
		end,
		startElement="[-S][+S]", --FarnGramar
		productiveSymbols={
			["S"]=true,							
			["F"]= true,
			
		},
		transitions={
			["S"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad((olddeg*recIt)),0,true)
				
				return "[-F]][S][+F]"
			end,	
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad(degree),0,true)
				if recIt < 2 then return "F" end
				return ""
			end,
			
			["-"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel) 			
				v=olddeg+degree*2
				Turn(Tpiece,x_axis,math.rad(v),0,true)
				
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece)	 	
				v=olddeg-degree*2
				Turn(Tpiece,x_axis,math.rad(v),0,true)	
				
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},	
	[7]={ --a randomized Gamar
		name= "Randomized Buildrules",
		degreeFilter=function(startdeg,turndeg)
			if math.abs(startdeg) > 45 then startdeg = 0 end
			if math.abs(turndeg) < 60 then turndeg=60+math.random(0,22) end
			return startdeg,turndeg
		end,
		startElement="X[X][-F]", --RandGramar
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad(olddeg) ,0,true)	
				if boolLastLevel==true then turnPieceRandDir(Tpiece,0) end
				
				
				return getRandomGramarProcution({"F","-X","+X"}, 5, "[", "]")
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true) 			
				if boolLastLevel==true then turnPieceRandDir(Tpiece,0) end
				return getRandomGramarProcution({"F","X","+X"}, 5, "[", "]")							
			end,
			["-"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel) 	
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)	
				
				v=x-math.rad(degree*recIt)
				Turn(Tpiece,x_axis,v,0,true)	
				if boolLastLevel==true then turnPieceRandDir(Tpiece,0) end
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel)	 
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)					
				
				v=x+math.rad(degree*recIt)
				Turn(Tpiece,x_axis,v,0,true)	
				if boolLastLevel==true then turnPieceRandDir(Tpiece,0) end
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},	
	[8]={ --a start starshaped spreading gramar
		name= "Test X_Axis",
		startElement="A", --Cacti gramar
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			["F"]= true,
			["X"]=true
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,sanitizeRandom(-1*math.abs(olddeg),math.abs(degree)))
				Turn(Tpiece,y_axis,math.random(0,360),0,true)
				
				return "ABA"
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,z_axis,math.rad(olddeg) ,0,true)
				return "X"
			end,	
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad(olddeg) ,0,true)
				WaitForTurn(Tpiece,x_axis)
				return ""
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				Turn(Tpiece,z_axis,math.rad(olddeg),0,true) 
				WaitForTurn(Tpiece,x_axis)
				return "-FX+F"							
			end,
			["-"]= function (olddeg,degree,Tpiece) 
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)
				Turn(Tpiece,x_axis,x-math.rad(degree),0,true)	
				
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece)	 		
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)
				Turn(Tpiece,x_axis,x+math.rad(degree),0,true)	
				
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	[9]={ --a start starshaped spreading gramar
		name= "Snake Trees",
		startElement="A", --Cacti gramar
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			["F"]= true,
			
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				v=math.rad(math.random(-1*math.abs(olddeg),math.abs(degree)))
				Turn(Tpiece,x_axis,v,0,true)
				--	 Turn(Tpiece,y_axis,math.random(0,360),0,true)
				
				return "-B"
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg) ,0,true)
				return "+A[+F]"
			end,	
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 	
				Turn(Tpiece,x_axis,math.rad(olddeg/recIt,boolLastLevel) ,0,true)
				
				return "-F"
			end,
			
			
			["-"]= function (olddeg,degree,Tpiece)
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)
				Turn(Tpiece,x_axis,x+math.rad(olddeg+degree),0,true)	
				
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece)	 	
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)					
				Turn(Tpiece,x_axis,x+math.rad(olddeg-degree),0,true)	
				
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},	
	[10]={
		name= "Recursion Depth Degree Tree",
		startElement="X", --GramarStartElement
		productiveSymbols={["F"]= true,
			["X"]=true
		},
		transitions={
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				return "FF" 
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				
				return "F-[X]-X" 
			end,
			["-"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel) 
				v=(olddeg+degree*recIt)
				Turn(Tpiece,x_axis,math.rad(v),0,true)
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel)
				v=olddeg-degree*recIt
				Turn(Tpiece,x_axis,math.rad(v),0,true)
				if math.random(0,1)== 1 then 
					c=(olddeg+degree)
					Turn(Tpiece,z_axis,math.rad(c),0,true)							
				end
			return "" end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},		
	[11]={ --a start starshaped spreading gramar
		name= "Cacti",
		startElement="A", --Cacti gramar
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			["F"]= true,
			["X"]=true
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				v=math.random(-1*math.abs(olddeg),math.abs(degree))
				Turn(Tpiece,x_axis,v,0,true)
				return "ABA"
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg) ,0,true)
				return "X"
			end,	
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)
				Turn(Tpiece,x_axis,x+math.rad(olddeg) ,0,true)
				return ""
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				Turn(Tpiece,x_axis,math.rad(math.random(0,360)),0,true)
				
				return "-FX+F"							
			end,
			["-"]= function (olddeg,degree,Tpiece) 			
				Turn(Tpiece,x_axis,math.rad(olddeg+degree),0,true)	
				WaitForTurn(Tpiece,x_axis)
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece)	 		
				Turn(Tpiece,x_axis,math.rad(olddeg-degree),0,true)	
				WaitForTurn(Tpiece,x_axis)
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	[12]={ --a start starshaped spreading gramar
		name= "Cacti",
		startElement="A", --Farn
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			["F"]= true,
			["X"]=true
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg+(olddeg/3.14)*recIt),0,true)
				return "[+X]B[-X]"
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg+(olddeg/3.14)*recIt),0,true)
				return "F"
			end,	
			["F"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg+(olddeg/3.14)*recIt),0,true)
				Turn(Tpiece,x_axis,x+math.rad(olddeg) ,0,true)
				return "A"
			end,
			["X"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel)	
				Turn(Tpiece,x_axis,math.rad(olddeg+(olddeg/3.14)*recIt),0,true)
				
				return "X"							
			end,
			["-"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel) 
				Turn(Tpiece,x_axis,math.rad(olddeg+(olddeg/3.14)*recIt),0,true)
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)					
				Turn(Tpiece,z_axis,z-math.rad(degree),0,true)	
				
				return "" 
			end,
			["+"]= function (olddeg,degree,Tpiece,recIt,boolLastLevel)	 		
				Turn(Tpiece,x_axis,math.rad(olddeg+(olddeg/3.14)*recIt),0,true)
				x,y,z=Spring.UnitScript.GetPieceRotation(Tpiece)					
				Turn(Tpiece,z_axis,z+math.rad(degree),0,true)	
				return "" 
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	[13]={ --snake tree
		name= "Willow",
		startElement="A",
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			
			
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				
				Turn(Tpiece,x_axis,math.rad(recIt*22),0,true)
				return "[A][B]"
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				
				Turn(Tpiece,x_axis,math.rad(recIt*-36),0,true)
				if recIt%2==0 then return "B" end
				if math.random(0,1)==1 then return "[A]" else return "[A][B]" end
			end,
			
			
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	[14]={ 
		name= "CurlTree",
		startElement="A",
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			
			
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				
				Turn(Tpiece,y_axis,math.rad(recIt*22),0,true)
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true)
				if recIt%2 ==0 then return "[A][B]" end
				return "[A]"
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				
				Turn(Tpiece,y_axis,math.rad(recIt*-22),0,true)
				Turn(Tpiece,x_axis,math.rad(olddeg),0,true)
				return "[B]"
			end,
			
			
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	},
	
	[15]={ 
		name= "FoldColony",
		startElement="[A]A[A]A[A]",
		productiveSymbols={
			["A"]= true,
			["B"]= true,
			
			
		},
		transitions={["A"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				
				Turn(Tpiece,x_axis,math.rad(75),0,true)
				if recIt%2 ==0 then return "[B][B]" end
			if math.random(0,1)==1 then return "" else
					return "[A]"
				end
			end,
			["B"]= function (olddeg,degree,Tpiece,Epiece,recIt,boolLastLevel) 
				
				Turn(Tpiece,x_axis,math.rad(-60),0,true)
				if recIt%2 ==0 then return "[A]" end
			if math.random(0,1)==1 then return "" else
					return "[A]"
				end
			end,
			["["]= "RECURSIONSTART",
			["]"]= "RECURSIONEND"	,
			["RECURSIONSTART"]= "[",
			["RECURSIONEND"]= "]" ,
		}
	}		
}


function executeLindeMayerSystem( gramarTable,String, oldDeg, Degree , UpperLimit, recursionDepth,recursiveItterator,PredPiece)
	
	-- this keeps all recursive steps on the same level waiting for the last one - who releases the herd
	gainLock(recursiveItterator)
	
	--we made it into the next step and get our piece
	globalTotalItterator=globalTotalItterator+1
	local hit=globalTotalItterator
	
	if not hit or TreePiece[hit] == nil or hit > UpperLimit then 
		releaseLocalLock(recursiveItterator)
		return 
	end
	
	
	--DebugInfo
	--Spring.Echo("Level "..recursiveItterator.." Thread waiting for Level "..(recursiveItterator-1).. " to go from ".. globalInCurrentStep[recursiveItterator-1].." to zero so String:"..String.." can be processed")
	
	while globalInCurrentStep[recursiveItterator-1] > 0 do	
		Sleep(50)
	end
	
	--return clauses
	if not String or String == "" or string.len(String) < 1 or recursiveItterator == recursionDepth then 
		RecursionEnd[#RecursionEnd+1]=PredPiece
		releaseLocalLock(recursiveItterator)
		return 
	end
	
	ox,oy,oz=Spring.GetUnitPiecePosition(unitID, PredPiece)
	
	--Move Piece to Position
	
	Show(TreePiece[hit])
	
	Move(TreePiece[hit],x_axis,ox,0)
	Move(TreePiece[hit],y_axis,oy,0)
	Move(TreePiece[hit],z_axis,oz ,0,true)
	--DebugStoreInfo[#DebugStoreInfo+1]={"RecursionStep:"..hit.." ||RecursionDepth: "..recursiveItterator.." ||String"..String.." ||PredPiece: "..PredPiece.." || Moving Piece:"..TreePiece[hit].."to x:"..ox.." y:"..oy.." z:"..oz}
	
	--stores non-productive operators
	OperationStorage={}
	--stores Recursions and Operators
	RecursiveStorage={}
	
	for i = 1, string.len(String) do
		--extracting the next token form the current string and find out what type it is
		token = string.sub(String,i,i)
		typeOf=type(gramarTable.transitions[token])
		
		-- if the typeof is a function and a productive Element 
		if typeOf == 'function' and gramarTable.productiveSymbols[token] then 	
			--execute every operation so far pushed back into the operationStorage on the current piece
			
			for i=#OperationStorage,1, -1 do
				gramarTable.transitions[OperationStorage[i]](oldDeg,Degree,TreePiece[hit],PredPiece,recursiveItterator,recursiveItterator==UpperLimit-1)
			end
			
			WaitForTurn(TreePiece[hit],x_axis)
			WaitForTurn(TreePiece[hit],y_axis)
			WaitForTurn(TreePiece[hit],z_axis)
			--renewOperationStorage
			OperationStorage={}
			
			--This LindeMayerSystem has a go
			StartThread(executeLindeMayerSystem,
			
			gramarTable,
			gramarTable.transitions[token](oldDeg ,Degree ,TreePiece[hit],PredPiece,recursiveItterator,recursiveItterator==UpperLimit-1),												
			oldDeg,
			Degree,
			UpperLimit,
			recursionDepth,
			recursiveItterator+1,
			EndPiece[math.max(1,math.min(#EndPiece,hit))]
			)
			
			--if we have a non productive function we push it back into the OperationStorage
		elseif typeOf=="function" then --we execute the commands on the current itteration-- which i
			OperationStorage[#OperationStorage+1]=token
			
			--recursionare pushed into the recursionstorage and executed after the current string has beenn pushed
		elseif typeOf== "string" and token == gramarTable.transitions["RECURSIONSTART"] then							
			--Here comes the trouble, we have to postpone the recurssion 
			RecursiveStorage[#RecursiveStorage+1],recursionEnd=extractRecursion(String,i,gramarTable.transitions["RECURSIONSTART"],gramarTable.transitions["RECURSIONEND"])
			i=math.min(recursionEnd+1,string.len(String))
		end
		
	end
	
	--Recursions are itterated last but not least
	if table.getn(RecursiveStorage) > 0 then
		for i=1,#RecursiveStorage do		
			
			
			StartThread(executeLindeMayerSystem,
			
			gramarTable,
			RecursiveStorage[i],										
			oldDeg,
			Degree,
			UpperLimit,
			recursionDepth,
			recursiveItterator+1,
			EndPiece[math.max(1,math.min(#EndPiece,hit))]
			)
			
		end
	end
	--Recursion Lock - the last one steps the global Itteration a level up
	
	releaseLocalLock(recursiveItterator)
	--Spring.Echo("Thread Level "..recursiveItterator.." signing off")
	return
end

function extractRecursion(String,itterator,recursionOpen,recursionClose)
	openBraces=1
	closeBraces=0
	recursionEnd=string.len(String)
	
	for i=itterator+1,string.len(String), 1 do
		tok=string.sub(String,i,i)
		if tok==recursionOpen then openBraces=openBraces+1 end
		if tok==recursionClose then closeBraces=closeBraces+1 end
		
		if openBraces==closeBraces then 
			recursionEnd=i
			break
		end
	end
	
	returnString= string.sub(String,itterator+1,recursionEnd-1)
	if string.len(returnString)== 0 then returnString ="" end
	
	return returnString,recursionEnd
end

function gainLock(recursiveItterator)
	if globalInCurrentStep[recursiveItterator]== nil then globalInCurrentStep[recursiveItterator]= 0 end
	globalInCurrentStep[recursiveItterator]=globalInCurrentStep[recursiveItterator]+1
	--this muders the recursion start case
	if not globalInCurrentStep[recursiveItterator-1] then 
		globalInCurrentStep[math.max(0,recursiveItterator-1)] =0 
	end
end

function releaseLocalLock(recursiveItterator)
	if globalInCurrentStep[recursiveItterator]== nil then globalInCurrentStep[recursiveItterator]=0 end
	globalInCurrentStep[recursiveItterator]= globalInCurrentStep[recursiveItterator]-1
	if globalInCurrentStep[recursiveItterator] <= 0 then	globalStep=recursiveItterator+1 end
end


--calculates the colonyheight by distance to the core	
function colonySizeByDistance(X,Z,sizeOfPlant,maxDist)
	half=maxDist/2
	
	dist=math.sqrt(X*X+Z*Z)
	--Spring.Echo("Distance to ColonyCore"..dist)
	if dist < maxDist/2 then
		return math.max(1,math.ceil(sizeOfPlant - sizeOfPlant/((half/dist)^2))) -- oo to 1
	end
	if dist > half and dist < maxDist * 0.75 then 
		return math.random(1,2) 
	else 
		return 0
	end
	
end

function placeFollowUps(TreePiece, X,Z,sizeOfPlant,maxDist,i)
	sizeOfColony=colonySizeByDistance(X,Z,sizeOfPlant,maxDist)
	--Spring.Echo("Colonysize"..sizeOfColony)
	
	for ok=i+1,math.min(i+sizeOfPlant-1,i+sizeOfColony),1 do
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID, EndPiece[ok-1])
		
		--Move Piece to Position
		
		Show(TreePiece[ok])
		
		Move(TreePiece[ok],x_axis,ox,0)
		Move(TreePiece[ok],y_axis,oy,0)
		Move(TreePiece[ok],z_axis,oz ,0,true)
		Sleep(400)
	end
	
end



--Contains Fixed Production Rules
fixFunctionTabel={}

-- Turn the whole plant into a Ball Weed
fixFunctionTabel[1]=	function ()
	Spring.Echo("fixFunctionTabel::BallWheed")
	showT(TreePiece)
	showT(EndPiece)
	x,y,z=Spring.GetUnitPosition(unitID)
	
	
	for i=2,9,1 do
		
		val=SIZEOFPIECE*(i-1)
		Move(TreePiece[i],y_axis,(val),0)
		WaitForTurn(TreePiece[i],x_axis)
		
		
	end
	
	for i=9,#TreePiece,1 do
		
		Move(TreePiece[i],y_axis,7*SIZEOFPIECE,0)
		turnPieceRandDir(TreePiece[i],0.5)
	end
	return true
end
--FruitBambooColony
fixFunctionTabel[2]= function (NUMBEROFPIECES)
	resetT(TreePiece)
	Spring.Echo("fixFunctionTabel::Centrallized Colony")
	
	x,y,z=Spring.GetUnitPosition(unitID)
	sizeOfPlant=math.ceil(math.random(2,5))
	maxDist=90
	minDist=45
	degT={}
	for i=1,sizeOfPlant do
		degT[i]={}
		degT[i].x=math.random(-42,42)
		degT[i].y=math.random(-22,22)
		degT[i].z=math.random(-22,22)	
	end
	
	
	
	for i=1,#TreePiece-sizeOfPlant,sizeOfPlant do
		Show(TreePiece[i])
		mx,mz=0,0 		
		if math.random(1,4)==2 then
			mx,mz=math.random(-1*maxDist,maxDist),math.random(-1*maxDist,maxDist)
		else
			mx,mz=math.random(-1*minDist,minDist),math.random(-1*minDist,minDist)	
		end
		
		Move(TreePiece[i],x_axis,mx,0)
		Move(TreePiece[i],z_axis,mz,0,true)
		tx,tz=x+mx,z+mz
		h=Spring.GetGroundHeight(tx,tz)
		h=(y-h)*-1
		Move(TreePiece[i],y_axis,h,0,true)
		Sleep(10)
		
		StartThread(placeFollowUps,mx,mz,sizeOfPlant,maxDist,i)
		
	end
	return false
end


--Arcs
fixFunctionTabel[3]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::FruitArcs")
	showT(TreePiece)
	showT(EndPiece)
	val=15.2
	tax=0
	i=0
	up=math.ceil(math.random(15,25))
	
	for i=1,#TreePiece-1,1 do
		
		Turn(TreePiece[i],x_axis,math.rad((val*i)+tax),0,true)
		
		
		WaitForTurn(TreePiece[i],x_axis)
		
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[i])
		
		-- --Spring.Echo(ox,oy,oz)
		Move(TreePiece[i+1],x_axis,ox,0)
		Move(TreePiece[i+1],y_axis,oy,0)
		Move(TreePiece[i+1],z_axis,oz,0,true)
		
		if i > up then tax=180 end
		
	end
	
	for i=up+1, #TreePiece do
		
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[math.random(1,up+1)])
		if ox then
			-- --Spring.Echo(ox,oy,oz)
			Move(TreePiece[i],x_axis,ox,0)
			Move(TreePiece[i],y_axis,oy,0)
			Move(TreePiece[i],z_axis,oz,0,true)
			Turn(TreePiece[i],y_axis,math.rad(math.random(-360,360)),0)
		end
	end
	return true	
end

-- FruitField
fixFunctionTabel[4]= function (NUMBEROFPIECES)
	resetT(TreePiece)
	
	Spring.Echo("fixFunctionTabel::FruitField")
	x,y,z=Spring.GetUnitPosition(unitID)
	sizeOfPlant=math.ceil(math.random(2,5))
	degT={}
	for i=1,sizeOfPlant do
		degT[i]={}
		degT[i].x=math.random(-22,22)
		degT[i].y=math.random(-22,22)
		degT[i].z=math.random(-22,22)	
	end
	
	
	
	for i=1,#TreePiece-sizeOfPlant,sizeOfPlant do
		Show(TreePiece[i])
		mx,mz=math.random(-35,35),math.random(-34,34)
		if not TreePiece[math.min(i,#TreePiece)] then return end
		moveUnitPieceToGroundPos(unitID,TreePiece[math.min(i,#TreePiece)],mx,mz,0,5)		
	end
	Sleep(100)
	if maRa() ==true then
		--wiggle dat field
		--function getJobDone(unitID, dataT, jobFunction, checkFunction,rest)
		StartThread(getJobDone,
		unitID, 
		TreePiece, 
		function(unitID,Data)
			if math.random(0,1)==1 then
				synX,synY= math.random(-30,30),math.random(-360,360)
				for i=1,#Data do 
					v=0.13
					randoVal=math.random(-10,10)
					TurnPieceTowards(Data[i],synX+randoVal, synY,0,v)
				end 
				
			else
				for i=1,#Data do 
					v=0.13
					turnPieceRandDir(Data[i],v,45,-45,360,-360,45,-45)
				end
			end
			WaitForTurn(Data[table.getn(Data)],y_axis)
			return true	
		end,
		
		function(unitID,Data) 
			if math.random(0,1)==1 then 
				for i=1,#Data do 
					v=0.13
					TurnPieceTowards(Data[i],0, 0,0,v)
				end 
				WaitForTurn(Data[table.getn(Data)],y_axis)
			end
			return false 
		end,
		3000)
	end
	return false
end

-- FruitTonguePad
fixFunctionTabel[5]= function (NUMBEROFPIECES)
	
	Spring.Echo("fixFunctionTabel::FruitTongue")
	local spGetGroundHeight=Spring.GetGroundHeight
	totalIndex=0
	relativeIndex=11
	HeightIndex=0
	halfHeight,quarterheight=SIZEOFPIECE/2,SIZEOFPIECE/4
	PrevPosTable={}
	PrevPosTable[1]={x=0,y=0,z=0}
	for i=2,relativeIndex, 1 do
		PrevPosTable[i]={x=PrevPosTable[i-1].x 	+math.random(-quarterheight,quarterheight), 
			y=PrevPosTable[i-1].y	+math.random(-halfHeight,halfHeight),
		z=PrevPosTable[i-1].z +math.random(-quarterheight,quarterheight)}
	end
	
	while relativeIndex > 1 do
		for i=1, relativeIndex,1 do
			if TreePiece[totalIndex+i] then
				Show(TreePiece[totalIndex+i])
				Move(TreePiece[totalIndex+i],x_axis,PrevPosTable[i].x,0)
				Move(TreePiece[totalIndex+i],y_axis,PrevPosTable[i].y,0)
				Move(TreePiece[totalIndex+i],z_axis,PrevPosTable[i].z,0,true)
				Sleep(1)
				px=PrevPosTable[i].x + quarterheight
				py=PrevPosTable[i].y + halfHeight
				pz=PrevPosTable[i].z +math.random(-quarterheight,halfHeight)
				PrevPosTable[i]={x=px,y=py,z=pz}
			else
				break
			end
		end
		totalIndex=totalIndex+relativeIndex
		relativeIndex=relativeIndex-1
	end
	
	return true
end

-- Spiralltree
fixFunctionTabel[6]=	function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Spiraltree")
	showT(TreePiece)
	showT(EndPiece)
	resetT(EndPiece)
	resetT(TreePiece)
	Turn(center,y_axis,0,0)
	Turn(center,x_axis,0,0)
	Turn(center,z_axis,0,0)
	
	
	
	PrevPiece=0
	
	it=10
	radMax=math.random(1.14,4)
	
	v=math.random(75,95)
	signsum=0
	Sign=1
	for i=1,25,1 do
		Sleep(1)
		
		
		it=it+math.random(33,77)
		
		
		PrevPiece=EndPiece[i]
		Turn(TreePiece[i+1],y_axis,math.rad(it),0)
		
		AddOn=math.random(15,50)/100
		
		v=v-AddOn
		Turn(TreePiece[i+1],x_axis,math.rad(v),0,true)
		ox,oy,oz= Spring.GetUnitPiecePosition(unitID,PrevPiece)
		ox=ox*-1
		Move(TreePiece[i+1],x_axis,ox,0)
		Move(TreePiece[i+1],y_axis,oy,0)
		Move(TreePiece[i+1],z_axis,oz ,0,true)
		
		WaitForMove(TreePiece[i+1],x_axis)
		WaitForMove(TreePiece[i+1],y_axis)
		WaitForMove(TreePiece[i+1],z_axis)
		
	end
	
	for i=26,NUMBEROFPIECES-1,1 do
		Sleep(1)
		
		if math.sin((i/NUMBEROFPIECES)*2*3.141) > 0.5 then			
			it=it+math.random(33,77)*randSign()
		else
			it=it+math.random(33,77)
		end
		
		PrevPiece=EndPiece[i]
		Turn(TreePiece[i+1],y_axis,math.rad(it),0)
		
		AddOn=math.random(1,radMax)*Sign
		
		if i == math.ceil((NUMBEROFPIECES/3)*3) then Sign=Sign*-1 end
		v=v-AddOn
		Turn(TreePiece[i+1],x_axis,math.rad(v),0,true)
		ox,oy,oz= Spring.GetUnitPiecePosition(unitID,PrevPiece)
		ox=ox*-1
		Move(TreePiece[i+1],x_axis,ox,0)
		Move(TreePiece[i+1],y_axis,oy,0)
		Move(TreePiece[i+1],z_axis,oz ,0,true)
		
		WaitForMove(TreePiece[i+1],x_axis)
		WaitForMove(TreePiece[i+1],y_axis)
		WaitForMove(TreePiece[i+1],z_axis)
		--MovePieceToPiece(unitID, TreePiece[i+1],PrevPiece,0,true)					
		Sleep(1)
	end
	
	return false
end


-- Turn the whole plant into a Ground Ball Weed(s)
fixFunctionTabel[7]=	function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::GroundBallWheed")
	showT(TreePiece)
	showT(EndPiece)
	randCent=math.ceil(math.random(2,5))
	
	
	for k=2,randCent do
		ex,ez=math.random(-90,90),math.random(-90,90)
		
		start,End=(k-1)*(NUMBEROFPIECES/randCent)+1,k*(NUMBEROFPIECES/randCent)
		
		if start and End then
			for i=start,End,1 do
				p= TreePiece[math.min(math.max(1,i),#TreePiece)]
				if p then
					moveUnitPieceToGroundPos(unitID,p,ex,ez,0,15)
					turnPieceRandDir(TreePiece[i],0.5)
				end
			end
		end
		
	end
	return true
end



-- RingWeed
fixFunctionTabel[8]=	function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::RingWeed")
	resetT(TreePiece)
	showT(TreePiece)
	showT(EndPiece)
	x,y,z=Spring.GetUnitPosition(unitID)
	AttachPoints={}
	AttachPoints[#AttachPoints+1]=center
	
	for i=1,NUMBEROFPIECES-9,9 do
		AddonPiece=AttachPoints[math.ceil(math.random(1,#AttachPoints))]
		xorZ=maRa()==true
		signum=randSign()
		for k=i+1,i+9, 1 do
			movePieceToPiece(unitID,TreePiece[k],AddonPiece,0)
			degval=(k-i)*40*signum
			if xorZ==true then
				Turn(TreePiece[k],z_axis,math.rad(degval),0,true)
			else
				Turn(TreePiece[k],x_axis,math.rad(degval),0,true)
			end
			WaitForTurn(TreePiece[k],x_axis)
			WaitForTurn(TreePiece[k],z_axis)
			Sleep(1)
			AddonPiece=EndPiece[k]
			if k-i == 3 then
				AttachPoints[#AttachPoints+1]=EndPiece[k]
			end
		end
	end
	
	return true
end


-- Turn the whole plant into a Bucky Ball
fixFunctionTabel[9]=	function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Suckyball")
	showT(TreePiece)
	showT(EndPiece)
	x,y,z=Spring.GetUnitPosition(unitID)
	
	PiecesToGrowUpon={}
	PiecesToGrowUpon={EndPiece[1],EndPiece[2]}
	
	--first and last row have equal number of pentagons and hexagons
	--2:1 hexagons : pentagons 
	for i=3,NUMBEROFPIECES,1 do
		movePieceToPiece(unitID,TreePiece[i],PiecesToGrowUpon[math.random(1,#PiecesToGrowUpon)],0)
		turnPieceRandDir(TreePiece[i],0, 90,0,360,0,90,0)
		WaitForTurn(TreePiece[i],x_axis)
		WaitForTurn(TreePiece[i],y_axis)
		WaitForTurn(TreePiece[i],z_axis)
		table.insert(PiecesToGrowUpon,EndPiece[i])
	end
	
	return true
end

--StarPlants
fixFunctionTabel[10]=	function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::StarPlants")
	resetT(TreePiece)
	showT(TreePiece)
	showT(EndPiece)
	
	randCent=math.ceil(math.random(4,9))
	PiecesNumber=math.floor(NUMBEROFPIECES/randCent)
	for k=1,randCent do
		ex,ez=(math.random(5,10)/10)*90*randSign(),(math.random(5,10)/10)*90*randSign()
		
		moveUnitPieceToGroundPos(unitID,TreePiece[k],ex,ez,0,SIZEOFPIECE)
		WaitForMove(TreePiece[k],x_axis)
		WaitForMove(TreePiece[k],y_axis)
		WaitForMove(TreePiece[k],z_axis)
		Sleep(1)
		
		End=k+1+((k-1)*PiecesNumber)+randCent
		flowerdeg= -90 +math.random(35,65)
		startPiece=EndPiece[k]
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[k])
		ox=ox*-1	
		for i=k+1+((k-1)*PiecesNumber),math.min(End,NUMBEROFPIECES),1 do
			if TreePiece[i] then
				Move(TreePiece[i],x_axis,ox,0)
				Move(TreePiece[i],y_axis,oy,0)
				Move(TreePiece[i],z_axis,oz,0,true)
				
				
				
				if TreePiece[i] then 
					val=((i-(k+1))*(360/randCent)) or math.random(0,360)
					Turn(TreePiece[i],y_axis,math.rad(val),0,true)
					Turn(TreePiece[i],x_axis,flowerdeg,0)
					WaitForTurn(TreePiece[i],y_axis)
					WaitForTurn(TreePiece[i],x_axis)
				end
				Sleep(1)	
			end
		end
		
	end
	return true
end


--SpiralTree
fixFunctionTabel[11]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Spiraltree")
	showT(TreePiece)
	showT(EndPiece)
	val=15.2
	tax=0
	
	up=math.ceil(math.random(15,25))
	
	spirallength=math.floor(math.max(3,(#TreePiece-6)/math.random(1,6)))
	deg=math.random(-5,5)
	if math.random(0,1)==1 then
		for j=1,5 do
			Turn(TreePiece[j],x_axis,deg,0,true)
			ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[j])
			ox=ox*-1
			-- --Spring.Echo(ox,oy,oz)
			Move(TreePiece[j+1],x_axis,ox,0)
			Move(TreePiece[j+1],y_axis,oy,0)
			Move(TreePiece[j+1],z_axis,oz,0,true)
			Sleep(1)
			
		end	
	end	
	
	val=math.random(-55,55)
	if math.abs(val) < 10 then val =22.5 end
	sval=math.random(-5.5,5.5)
	if math.abs(sval) < 2.5 then sval =2.5 end
	
	for j=6,#TreePiece,spirallength do
		for i=j, j+spirallength,1 do
			if TreePiece[i] then
				Turn(TreePiece[i],x_axis,math.rad((val*i)),0,true)
				Turn(TreePiece[i],z_axis,math.rad((sval)),0,true)
				WaitForTurn(TreePiece[i],x_axis)
				WaitForTurn(TreePiece[i],z_axis)
				
				
			end
			if TreePiece[i+1] then
				ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[i])
				ox=ox*-1
				Move(TreePiece[i+1],x_axis,ox,0)
				Move(TreePiece[i+1],y_axis,oy,0)
				Move(TreePiece[i+1],z_axis,oz,0,true)
				Sleep(1)
			end	
			
		end
	end
	
	
	return true	
end


fixFunctionTabel[12]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::CircleTree")
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	
	const=math.random(9,45)*randSign()
	spirallength=math.floor(math.random(4,8))
	currEndPoint=EndPiece[1]
	for j=2,#TreePiece-spirallength, spirallength do
		
		sval=math.random(25,120)
		--	Spring.Echo("ValueA"..sval.." ValueB:"..spirallength.." Value C: "..const)
		
		for i=j, j+spirallength,1 do
			
			ox,oy,oz=Spring.GetUnitPiecePosition(unitID,currEndPoint)
			ox=ox*-1
			
			Move(TreePiece[i],x_axis,ox,0)
			Move(TreePiece[i],y_axis,oy,0)
			Move(TreePiece[i],z_axis,oz,0,true)
			
			WaitForMove(TreePiece[i],x_axis)
			WaitForMove(TreePiece[i],y_axis)
			WaitForMove(TreePiece[i],z_axis)
			degval=const*(i-j+1)
			
			Turn(TreePiece[i],y_axis,math.rad(degval%360),0)
			Turn(TreePiece[i],z_axis,math.rad((sval)),0,true)
			WaitForTurn(TreePiece[i],y_axis)
			WaitForTurn(TreePiece[i],z_axis)
			currEndPoint=EndPiece[i]
			
		end
		
		currEndPoint=EndPiece[math.ceil(math.random(1,2+spirallength))] or EndPiece[1]
		
	end
	
	
	return true	
end



EndPointReservoir={}
--free Form Function function
fixFunctionTabel[13]= function (NUMBEROFPIECES)
	Spring.Echo("Free Form Function")
	resetT(TreePiece)
	showT(TreePiece)
	showT(EndPiece)
	
	
	up=math.ceil(math.random(15,25))
	
	val=60
	spirallength=math.floor(math.random(4,12))
	
	for j=1,#TreePiece-spirallength,spirallength do
		
		aPos,bPos=math.random(-75,75), math.random(-75,75)
		for i=j, j+spirallength,1 do
			if i==j then
				
				moveUnitPieceToGroundPos(unitID,TreePiece[i],aPos,bPos,0,0)	
			else
				
				sval=math.random(10,120)
				whatADeg,butWhy=deterministicTurn(i,spirallength, sval)
				
				Move(TreePiece[1],x_axis,0,0)
				Move(TreePiece[1],y_axis,0,0)
				Move(TreePiece[1],z_axis,0,0,true)
				EndPointReservoir[1]=EndPiece[1]
				if TreePiece[i] then
					Turn(TreePiece[i],x_axis,math.rad(whatADeg),0)
					Turn(TreePiece[i],y_axis,math.rad(butWhy),0,true)
					WaitForTurn(TreePiece[i],y_axis)
					WaitForTurn(TreePiece[i],x_axis)
				end
				
				
				pieceSelected= math.ceil(math.random(1,#EndPointReservoir))
				ox,oy,oz= Spring.GetUnitPiecePosition(unitID,EndPointReservoir[pieceSelected])
				
				ox=ox*-1
				divcompare(i,ox,0)
				divcompare(i,val,0)
				divcompare(i,val,0)
				
				if TreePiece[i+1] then
					Move(TreePiece[i+1],x_axis,ox,0)
					Move(TreePiece[i+1],y_axis,oy,0)
					Move(TreePiece[i+1],z_axis,oz,0,true)
					WaitForMove(TreePiece[i+1],x_axis)
					WaitForMove(TreePiece[i+1],y_axis)
					WaitForMove(TreePiece[i+1],z_axis)
					EndPointReservoir[#EndPointReservoir+1]=EndPiece[i]
				end
				Sleep(1)
				
			end
		end
	end
	
	
	return false	
end

function divcompare(it,val,pos)
	if math.abs(val-pos)>500 then Spring.Echo("Node behaving badly"..it-1) end	
end


--"Bow Fern Function"
fixFunctionTabel[14]= function (NUMBEROFPIECES)
	Director=maRa()==true
	Spring.Echo("Fern Function")
	resetT(TreePiece)
	showT(TreePiece)
	showT(EndPiece)
	
	GrowPointTable={}
	val=math.random(5,12)
	
	for i=2,math.ceil(#TreePiece/3) do
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[i-1])
		ox=ox*-1
		Move(TreePiece[i],x_axis,ox,0)
		Move(TreePiece[i],y_axis,oy,0)
		Move(TreePiece[i],z_axis,oz,0,true)
		
		WaitForMove(TreePiece[i],x_axis)
		WaitForMove(TreePiece[i],y_axis)
		WaitForMove(TreePiece[i],z_axis)
		
		Turn(TreePiece[i],z_axis,math.rad(i*val),0,true)
		WaitForTurn(TreePiece[i],z_axis)
		
		GrowPointTable[#GrowPointTable+1]=EndPiece[i-1]
	end
	
	
	
	for j=math.ceil(#TreePiece/3)+1,#TreePiece-1,2 do
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,GrowPointTable[clampMod(j-20,1,table.getn(GrowPointTable))])
		ox=ox*-1
		Move(TreePiece[j],x_axis,ox,0)
		Move(TreePiece[j],y_axis,oy,0)
		Move(TreePiece[j],z_axis,oz,0,true)
		
		WaitForMove(TreePiece[j],x_axis)
		WaitForMove(TreePiece[j],y_axis)
		WaitForMove(TreePiece[j],z_axis)
		Turn(TreePiece[j],x_axis,math.rad(90+(j-20)*0.1),0)
		if Director==true then
			Turn(TreePiece[j],z_axis,math.rad(360-(j*0.5)),0)
		end
		
		Move(TreePiece[j+1],x_axis,ox,0)
		Move(TreePiece[j+1],y_axis,oy,0)
		Move(TreePiece[j+1],z_axis,oz,0)
		
		WaitForMove(TreePiece[j+1],x_axis)
		WaitForMove(TreePiece[j+1],y_axis)
		WaitForMove(TreePiece[j+1],z_axis)
		Turn(TreePiece[j+1],x_axis,math.rad(-90-(j*0.1)),0)
		if Director==true then
			Turn(TreePiece[j],z_axis,math.rad((j)*-0.5),0)
		end
	end
	
	
	return true	
end

--"Fern Function"
fixFunctionTabel[15]= function (NUMBEROFPIECES)
	Spring.Echo("Fern Function")
	resetT(TreePiece)
	showT(TreePiece)
	showT(EndPiece)
	
	GrowPointTable={}
	val=math.random(5,12)
	
	for i=2,math.ceil(#TreePiece/3) do
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[i-1])
		ox=ox*-1
		Move(TreePiece[i],x_axis,ox,0)
		Move(TreePiece[i],y_axis,oy,0)
		Move(TreePiece[i],z_axis,oz,0,true)
		
		WaitForMove(TreePiece[i],x_axis)
		WaitForMove(TreePiece[i],y_axis)
		WaitForMove(TreePiece[i],z_axis)
		
		Turn(TreePiece[i],z_axis,math.rad(i*val),0,true)
		WaitForTurn(TreePiece[i],z_axis)
		
		GrowPointTable[#GrowPointTable+1]=EndPiece[i-1]
	end
	
	
	
	for j=math.ceil(#TreePiece/3)+1,#TreePiece,2 do
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,GrowPointTable[clamp(j-20,1,table.getn(GrowPointTable))])
		ox=ox*-1
		Move(TreePiece[j],x_axis,ox,0)
		Move(TreePiece[j],y_axis,oy,0)
		Move(TreePiece[j],z_axis,oz,0,true)
		
		WaitForMove(TreePiece[j],x_axis)
		WaitForMove(TreePiece[j],y_axis)
		WaitForMove(TreePiece[j],z_axis)
		Turn(TreePiece[j],y_axis,90+(j-20)*0.1,0)
		if 	TreePiece[j+1] then
			Move(TreePiece[j+1],x_axis,ox,0)
			Move(TreePiece[j+1],y_axis,oy,0)
			Move(TreePiece[j+1],z_axis,oz,0)
			
			WaitForMove(TreePiece[j+1],x_axis)
			WaitForMove(TreePiece[j+1],y_axis)
			WaitForMove(TreePiece[j+1],z_axis)
			Turn(TreePiece[j+1],y_axis,-90-(j*0.1),0)
			GrowPointTable[#GrowPointTable+1]=EndPiece[j+1]
		end
		GrowPointTable[#GrowPointTable+1]=EndPiece[j]
	end
	
	
	return true	
end


fixFunctionTabel[16]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::BowTie")
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	
	const=math.random(9,18)*randSign()
	spirallength=math.floor(math.random(5,12))
	for j=2,#TreePiece-spirallength, spirallength do
		
		sval=math.random(25,95)
		
		endpointOffset=math.ceil(math.random(1,j))
		for i=j, j+spirallength,1 do
			
			ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[endpointOffset+(i-j)])
			ox=ox*-1
			Move(TreePiece[i],x_axis,ox,0)
			Move(TreePiece[i],y_axis,oy,0)
			Move(TreePiece[i],z_axis,oz,0,true)
			
			WaitForMove(TreePiece[i],x_axis)
			WaitForMove(TreePiece[i],y_axis)
			WaitForMove(TreePiece[i],z_axis)
			degval=const*(i)
			Turn(TreePiece[i],y_axis,math.rad(degval),0)
			Turn(TreePiece[i],z_axis,math.rad((sval)),0)
			WaitForTurn(TreePiece[i],z_axis)
			Sleep(100)
		end
		if j+spirallength > #TreePiece then spirallength= #TreePiece-j end
	end
	
	
	return true	
end


fixFunctionTabel[17]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::TriTree")
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	offSet={[1]={x=5,y=-5},[2]={x=5,y=5},[3]={x=-5,y=0}}
	
	--Trunk
	BranchPoints={}
	
	for i=1,6 do
		Move(TreePiece[i],z_axis,offSet[i%3+1].y,0)
		Move(TreePiece[i],x_axis,offSet[i%3+1].x,0)
		if i > 3 then
			Move(TreePiece[i],y_axis,42,0)
			BranchPoints[#BranchPoints+1]=EndPiece[i]
		end
	end
	
	Sleep(1)
	--Branches
	LeavePoints={}
	BranchLength=math.ceil(math.random(2,5))
	CurrEndPoint=BranchPoints[math.floor(math.random(1,#BranchPoints))] or BranchPoints[1]
	for i=7,25, BranchLength do
		currDeg=math.random(0,360)
		for j=i,i+BranchLength,1 do
			currDeg=currDeg+math.random(-15,15)
			
			ox,oy,oz=Spring.GetUnitPiecePosition(unitID,CurrEndPoint)
			ox=ox*-1
			
			Move(TreePiece[j],x_axis,ox,0)
			Move(TreePiece[j],y_axis,oy,0)
			Move(TreePiece[j],z_axis,oz,0,true)
			
			WaitForMove(TreePiece[j],x_axis)
			WaitForMove(TreePiece[j],y_axis)
			WaitForMove(TreePiece[j],z_axis)
			
			
			
			
			Turn(TreePiece[j],y_axis,math.rad(currDeg),0)
			Turn(TreePiece[j],z_axis,math.rad(math.random(80,100)),0,true)
			Sleep(1)
			CurrEndPoint=EndPiece[j]
			LeavePoints[#LeavePoints+1]=EndPiece[j]
		end
		CurrEndPoint=BranchPoints[math.ceil(math.random(1,#BranchPoints))]	 or BranchPoints[2]
	end
	Sleep(1)
	--Leaves 
	CurrEndPoint=LeavePoints[math.ceil(math.random(1,#LeavePoints))]	
	for i=26,#TreePiece-3, 3 do
		CurrEndPoint=LeavePoints[math.ceil(math.random(1,#LeavePoints))]	
		
		offSet=math.random(0,360)
		for j=i,i+3,1 do	
			movePieceToPiece(unitID,TreePiece[j],CurrEndPoint,0)
			--Turn(TreePiece[j],y_axis,math.rad(offSet+(j-i+1)*120),0)
			--Turn(TreePiece[j],x_axis,math.rad(90),0,true)
			--WaitForMove(TreePiece[j],x_axis)
			--WaitForMove(TreePiece[j],y_axis)
			--WaitForMove(TreePiece[j],z_axis)
			CurrEndPoint=EndPiece[j]
		end
		CurrEndPoint=LeavePoints[math.ceil(math.random(1,#LeavePoints))]	
	end
	
	return true	
end

--Function produces a plant that spreads along the ground	
fixFunctionTabel[18]= function (NUMBEROFPIECES)
	Spring.Echo("FixFunction:Crawl Plant")
	Threads={}
	showT(TreePiece)
	resetT(TreePiece)
	boolForkRoot=maRa()==true
	many=math.ceil(math.random(5,12))
	
	function inRangeOfPrevDeg(val,PrevDeg,Range)
		
		if math.abs(val-PrevDeg) > Range then return false else return true end
		
	end
	
	
	for i=2,many do Threads[#Threads+1]={End=EndPiece[1],Deg=math.random(0,360), PrevDeg=0} end
	
	for i=3,#TreePiece, 1 do
		pieceToCon=Threads[(i%#Threads)+1].End or EndPiece[1]
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,pieceToCon )
		ox=ox*-1
		
		Move(TreePiece[i],x_axis,ox,0)
		Move(TreePiece[i],y_axis,oy,0)
		Move(TreePiece[i],z_axis,oz,0,true)
		
		WaitForMove(TreePiece[i],x_axis); WaitForMove(TreePiece[i],z_axis); WaitForMove(TreePiece[i],y_axis);
		
		
		
		
		Turn(TreePiece[i],y_axis,math.rad(Threads[i%#Threads+1].Deg),0)
		Turn(TreePiece[i],x_axis,math.rad(90+Threads[i%#Threads+1].PrevDeg),0)
		WaitForTurn(TreePiece[i],y_axis)
		Sleep(1)
		
		x,y,z=Spring.GetUnitPiecePosition(unitID,EndPiece[i])
		h=Spring.GetGroundHeight(x,z)+10
		val=0
		boolBreakReady=false
		timer=0
		while val > -90 and val < 90 and math.abs( val) < 36 and timer < 20 do
			result=90+Threads[i%#Threads+1].PrevDeg+val
			Turn(TreePiece[i],x_axis,math.rad(result+0.1),0,true)
			WaitForTurn(TreePiece[i],x_axis) 
			timer=timer+1
			x,y,z=Spring.GetUnitPiecePosDir(unitID,EndPiece[i])
			h=Spring.GetGroundHeight(x,z)
			if y -h < 10 then break end
			
			if y < 10 then 
				val=val-5
				
			else
				val=val+5
			end
			
			
			
		end
		
		
		
		
		if math.random(1,#TreePiece) -i < 0 and i > NUMBEROFPIECES* (0.5) then 
			Threads[#Threads+1]={End=EndPiece[i],Deg=Threads[i%#Threads+1].Deg+math.random(90,90), PrevDeg=val}
		end
		Threads[i%#Threads+1].PrevDeg=val
		Threads[i%#Threads+1].Deg=Threads[i%#Threads+1].Deg+math.random(-25,25)
		Threads[i%#Threads+1].End=EndPiece[i]
	end
	
	return false
end

--Airroot
fixFunctionTabel[20]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Airroot")
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	trueAirRoot=maRa()==true
	
	const=1.66
	baseVal=0
	if trueAirRoot==true then baseVal=90 end
	spirallength=math.floor(math.random(4,8))
	
	for j=1,#TreePiece-spirallength, spirallength do
		Deg=math.random(0,360)
		
		currEndPoint=center
		
		for i=j, j+spirallength,1 do
			
			ox,oy,oz=Spring.GetUnitPiecePosition(unitID,currEndPoint)
			ox=ox*-1
			
			Move(TreePiece[i],x_axis,ox,0)
			Move(TreePiece[i],y_axis,oy,0)
			Move(TreePiece[i],z_axis,oz,0,true)
			
			WaitForMove(TreePiece[i],x_axis)
			WaitForMove(TreePiece[i],y_axis)
			WaitForMove(TreePiece[i],z_axis)
			degval=const*(i-j+1)
			
			
			Turn(TreePiece[i],z_axis,math.rad(baseVal+(const^(i-j+1))*-1),0,true)
			Turn(TreePiece[i],y_axis,math.rad(Deg+i),0,true)
			WaitForTurn(TreePiece[i],y_axis)
			
			currEndPoint=EndPiece[i]
			
		end
		
	end
	
	
	return true	
end

--Cylinderplant
fixFunctionTabel[21]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Cylinder")
	
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	
	
	TotalPieces=#TreePiece
	DensityDivisor=math.ceil(math.random(1,8))
	PiecesPerLayer=math.floor(TotalPieces/DensityDivisor)
	--Circumference / (PieceCircumference*PiecesPerLayer)
	--Radius= sqrt(x^2 +y ^2)
	--sqrt(x^2 +y ^2)*2*PI=Circumference
	
	--Remainder(0)= Radius *2*PI - (PieceCircumference*PiecesPerLayer)
	--Solved for Radius= (PieceCircumference*PiecesPerLayer)/(2*PI)
	Radius= (RADOFPIECE*PiecesPerLayer)/(2*3.14159)
	--DegStep= 360 / PiecesPerLayer
	DegStep= 360/PiecesPerLayer	
	ContinuosRing={}
	ContinusDeg={}
	boolDeformed=maRa()==true
	ContinusDeg={defDegX=math.random(-15,15),defDegY=math.random(0,360),defDegZ=math.random(-15,15) }
	for i=1, PiecesPerLayer,1 do
		
		x,y= RotationMatrice (0,Radius, i*DegStep)
		moveUnitPieceToGroundPos(unitID,TreePiece[i],x,y,0,0)
		ContinuosRing[i]=EndPiece[i]
		Show(TreePiece[i])
	end
	
	for i=PiecesPerLayer+1, #TreePiece,1 do
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,ContinuosRing[i%PiecesPerLayer+1])
		ox=ox*-1
		
		Move(TreePiece[i],x_axis,ox,0)
		Move(TreePiece[i],y_axis,oy,0)
		Move(TreePiece[i],z_axis,oz,0,true)
		
		
		WaitForMove(TreePiece[i],x_axis); WaitForMove(TreePiece[i],z_axis); WaitForMove(TreePiece[i],y_axis);
		
		if boolDeformed==true then
			Turn(TreePiece[i],x_axis,math.rad(ContinusDeg.defDegX),0)
			Turn(TreePiece[i],y_axis,math.rad(ContinusDeg.defDegY),0)
			Turn(TreePiece[i],z_axis,math.rad(ContinusDeg.defDegZ),0)
		end
		ContinuosRing[i%PiecesPerLayer+1]=EndPiece[i]
		Sleep(1)
		if i%PiecesPerLayer==0 then
			ContinusDeg.defDegX=ContinusDeg.defDegX+math.random(-30,30)
			ContinusDeg.defDegZ=ContinusDeg.defDegZ+math.random(-30,30)
			
		end
	end
	
	return false	
end

--Float
fixFunctionTabel[19]= function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Floater")
	
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	
	Deg={x=0,y=0,z=0}
	
	floaterStem=math.ceil(math.random(5,10))
	for i=2,floaterStem do
		movePieceToPiece(unitID,TreePiece[i],EndPiece[i-1],0)
		Turn(TreePiece[i],x_axis,math.rad(Deg.x),0)
		Turn(TreePiece[i],y_axis,math.rad(Deg.y),0)
		Turn(TreePiece[i],z_axis,math.rad(Deg.z),0,true)
		Deg.z=Deg.z+math.random(-5,5)
	end
	
	--buildfloater
	halfWay= ((#TreePiece -1+floaterStem )/2 )+floaterStem
	half= ((#TreePiece -1+floaterStem )/2 )
	for i=1+floaterStem,#TreePiece do
		
		ox,oy,oz=Spring.GetUnitPiecePosition(unitID,EndPiece[floaterStem])
		ox=ox*-1
		sanitizedI=i-floaterStem
		if i > halfWay then sanitizedI =sanitizedI-halfWay end
		
		if i <= halfWay then
			oz=oz+( i-floaterStem)*4
		else
			oz=oz+( i-floaterStem -half)*-4
		end
		
		if i <= halfWay then
			ox=ox+ 1.12^( i-floaterStem)
			oy=oy+sanitizedI*3
		else
			ox=ox-(1.17^( i-floaterStem -half))		
			oy=oy+sanitizedI*-3					
		end
		
		Move(TreePiece[i],x_axis,ox,0)
		Move(TreePiece[i],y_axis,oy,0)
		Move(TreePiece[i],z_axis,oz,0,true)
		
		val=(i-floaterStem)/(half*2) *(360)
		
		
		Turn(TreePiece[i],z_axis,(val),0)
		
		Deg.z=Deg.z+math.random(-5,5)
	end
	
	
	return true	
end

-- Helix tree
fixFunctionTabel[22]=	function (NUMBEROFPIECES)
	Spring.Echo("fixFunctionTabel::Helixtree")
	
	spiralDensity= math.random(2,4)
	
	FullCircle=3.14159*spiralDensity
	
	DeltaV=FullCircle/math.ceil(#TreePiece/2)
	showT(TreePiece)
	showT(EndPiece)
	resetT(EndPiece)
	resetT(TreePiece)
	Turn(center,y_axis,0,0)
	Turn(center,x_axis,0,0)
	Turn(center,z_axis,0,0)
	left=0
	right=3.14159
	for i=1,#TreePiece, 2 do
		dist=7*i
		Move(TreePiece[i],y_axis,dist,0)
		Move(TreePiece[i+1],y_axis,dist,0)
		
		Turn(TreePiece[i],x_axis,math.rad(90),0)
		Turn(TreePiece[i+1],x_axis,math.rad(90),0)
		Turn(TreePiece[i],y_axis	,left,0)
		Turn(TreePiece[i+1],y_axis	,right,0)
		left=left+DeltaV
		right=right+DeltaV
	end
	
	return true
end

function buildLTree(center, NUMBEROFPIECES,Treename,Sensoryname,fixedFuncNumber)
	
	for i=1, NUMBEROFPIECES do
		name=Treename..i
		namet=Sensoryname..i
		TreePiece[#TreePiece+1]=piece(name)
		EndPiece[#EndPiece+1]=piece(namet)
	end
	
	boolTakeATurn=true
	--	if not GG.TestNumber then GG.TestNumber= 1 else GG.TestNumber=(GG.TestNumber%#fixFunctionTabel)+1 end
	if math.random(0,3)==1 and boolVaryFooTree == false or fixedFuncNumber then 
		fmax=#fixFunctionTabel+0.4999 
		--boolTakeATurn=fixFunctionTabel[18]()
		fixedFunctionNumber= fixedFuncNumber or math.floor(math.random(1,fmax))
		boolTakeATurn=fixFunctionTabel[fixedFunctionNumber](NUMBEROFPIECES)

	else
		
		dice=math.random(1,#gramarTable)
		Spring.Echo("Gramar Tree: "..dice)
		x,y,z=Spring.GetUnitPosition(unitID)
		
		--Spring.Echo("JLTREE:GramaNr"..dice.. " - "..gramarTable[dice].name)
		startBend=math.random(-45,45)			
		degToAdd=math.random(12,35)
		
		if math.abs(startBend) < 22 then startBend=22 end	
		
		if math.abs(startBend)-math.abs(degToAdd) < 10 then degToAdd=degToAdd*2 end
		--Spring.Echo(startBend.." -> "..degToAdd)
		if gramarTable[dice].degreeFilter then
			startBend,degToAdd=gramarTable[dice].degreeFilter(	startBend,degToAdd)
		end
		globalStep=1
		
		Show(TreePiece[1])
		executeLindeMayerSystem( 
		gramarTable[dice],
		gramarTable[dice].startElement,									
		startBend,
		degToAdd,
		NUMBEROFPIECES,
		math.ceil(math.random(9,22)),
		1,
		EndPiece[1]
		)
		
		
		
		fruitIt=1
		for i=1,#RecursionEnd do	
			if math.random(0,1)==1 then
				relX,relY,relZ=Spring.GetUnitPiecePosition(unitID,EndPiece[RecursionEnd[i]])
				if relX then	
					Move(fruits[fruitIt],x_axis,relX,0)
					Move(fruits[fruitIt],y_axis,relY,0)
					Move(fruits[fruitIt],z_axis,relZ,0,true)
					MovePieceToRelativeWorldPos(unitID,fruits[fruitIt], relX,relY,relZ,0)
					fruitIt=fruitIt+1
					if fruitIt == 5 then break end
				end
			end
		end
	end
	
	
	
	for i=1,#globalInCurrentStep, 1 do
		if globalInCurrentStep[i] and globalInCurrentStep[i] ~= 0 then
			--Spring.Echo("Still somebody at Recursionlevel"..i)
			Sleep(2000)
			i=1
		end
		
	end
	--Spring.Echo("TotalPieces used"..globalTotalItterator)
	
	if boolTakeATurn==true then
		Turn(center,y_axis,math.rad(math.random(0,360)),0,true)
		Turn(center,x_axis,math.rad(math.random(-5,5)),0,true)
	end
	
	globalTotalItterator=1
	RecursionEnd={}
	globalStepd=1
	globalInCurrentStep={}
	TreePiece={}
	EndPiece={}
end