

function mirrorMapCenter(x,y,z)
	mx,mz=Game.mapSizeX,Game.mapSizeZ
	mx,mz= mx/2,mz/2
	
	return x-1*(x-mx), y, z-1*(z-mz)
end


--Rule of Order
--Rule of Shape by Absence
--Rule of Symmetry
--Rule of ReverseAtEnd

--Rule of Symmetry+ Rule of Order => Selbstähnlichkeit Mirroring of Order

bd_AlgoBeautyRule={}
-->Select from a Pool with a BuildRule
function SelectFromPoolWithRule(RangeStart,RangeEnd,PiecePool, HigherOrderCriterias, ParallelCriterias, DepthOfRecursion)
	
	-- if DepthOfRecursion > 0 then 
	--{
		--
		--merge the Recursive Selection deeper Down into s
	--}
	--if DepthOfRecursion==0 then return bd_AlgoBeautyRule[math.floor(math.random(1,#bd_AlgoBeautyRule](PiecePool) end
	
end
-->Returns a Ordered Queue of Pieces that conform 

-->In absence of symmetric pieces, the buildpieces are paired with one example of connection sockets on exploration to add the 3d point
function buildVehicle(center,Arm_Max,Leg_Max, Body_Double_Max,Head_Max, lDeco_Max, DecoD,Body_Max, symDegFilterFunction, linDegFilterFunction,lexpandWeightTable, lMinPieces)
	ConCenter=piece("ConCenter")
	ConLinPiece={}
	ConSynPiece={}
	--Debug 
	expandWeightTable=lexpandWeightTable or {[1]=2, 	--front
		[2]=2, 	--rear
		[3]=1, 	--side left
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
	resetP(ConCenter)
	for i=1,4 do
		dynString="LinCon"..i
		ConLinPiece[i]=piece(dynString)
		LinConCoord[i]=bd_makePointFromPiece(ConLinPiece[i])
		--AllDynamicSockets[#AllDynamicSockets+1]=ConLinPiece[i]
	end	
	ConSynPiece[1]=piece"SymCon1"
	ConSynPiece[2]=piece"SymCon2"
	
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
	ConPieces={}
	
	DoubleBodyPieces={}
	BodyID=1
	DoubleMax=Body_Double_Max or 16
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
		
		--Spring.Echo("JW:VaryFoo:SymetricConections"..table.getn(ConPieces[BodyPieces[i]].Symetric))
		ConPieces[BodyPieces[i]]={}
		ConPieces[BodyPieces[i]].Linear={}
		
		--add the symetric connections			
		ConPieces[BodyPieces[i]].Symetric={}
		
		
		if i < DoubleMax and i %2 ==0 then
			DoubleBodyPieces[#DoubleBodyPieces+1]={k=BodyPieces[i-1],v=BodyPieces[i]}									
		end
		
	end
	resetT(BodyPieces)
	
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
	
	--								Socket,ConectionSocket,BodyPiece
	function bd_conPieceCon2Socket(Socket,Pie,dirVec, boolLeftRight)
	

		x,y,z=Socket.x*-1,Socket.y,Socket.z
		Spring.Echo("Socket Coordinates Relative (X):"..Socket.x .." (Y):"..Socket.y.." (Z):"..Socket.z)
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
			AlignPieceToPiece(ConCenter,piecename,0,true,true,AllDynamicSockets)
			retTable={}
			
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[1]))
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[2]))
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[3]))
			table.insert(retTable,bd_makePointFromPiece(ConLinPiece[4]))
			
			return retTable
		end
		
		getSynCoords= function(piecename)
			AlignPieceToPiece(ConCenter,piecename,0)
			retTable={}
			
			table.insert(retTable,bd_makePointFromPiece(ConSynPiece[1]))
			table.insert(retTable,bd_makePointFromPiece(ConSynPiece[2]))
			
			return retTable
		end
		
		RetLinConCoord=	{}
		SLinConCoord=	{}
		RetSynConCoords={}
		SSynCon={}
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
			return RetLinConCoord,RetSynConCoords
		end
	end
	
	--Continue here TODO
	function bd_LinAddPieceSocketsToPool(partnr,boolAddSymetrics)
		--> we move the conCenter to the piece
		AlignPieceToPiece(ConCenter,BodyPieces[partnr],0)
		ConSynPiece =ConPieces[partnr].Linear
		ConLinPiece =ConPieces[partnr].Symetric
		--Add the Linear connction spots
		--add the point from ConLinPiece
		LinBodyConCoords[#LinBodyConCoords+1]=bd_makePointFromPiece(ConLinPiece[1])
		LinBodyConCoords[#LinBodyConCoords+1]=bd_makePointFromPiece(ConLinPiece[2])
		LinBodyConCoords[#LinBodyConCoords+1]=bd_makePointFromPiece(ConLinPiece[3])
		LinBodyConCoords[#LinBodyConCoords+1]=bd_makePointFromPiece(ConLinPiece[4])
		
		--> Add the Symmetric connectionspots
		if (not boolAddSymetrics and boolAddSymetrics ==true) then
			SymBodyConCoords[#SymBodyConCoords+1][1]=bd_makePointFromPiece(ConSynPiece[1])
			SymBodyConCoords[#SymBodyConCoords ][2]=bd_makePointFromPiece(ConSynPiece[2])
			
		end
		
	end
	
	function bd_SymAddPieceSocketsToPool(part,sympiece)
		--we add the points into the table for symmmetric expansion
		--all the sockects are to be replaced by points--> implicating that 
		ConPieces[part].Linear,ConPieces[part].Symetric,	ConPieces[sympiece].Linear,	ConPieces[sympiece].Symetric=	getSocketsAsPoints(part,sympiece)
		
		
		
		local LinearCon=ConPieces[part].Linear
		local LinearConS=ConPieces[sympiece].Linear
		local SymConCoord=ConPieces[part].Symetric
		local SymConCoordS=ConPieces[sympiece].Symetric
		
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
	
	function bd_makeDirVecFromDeg(degx,valx,degy,valy,degz,valz,offSetX)
		dirVec={}
		dirVec.minx,dirVec.maxx=degx-valx,degx+valx
		dirVec.miny,dirVec.maxy=degy-valy,degy+valy
		dirVec.minz,dirVec.maxz=degz-valz,degz+valz
		if offSetX then	dirVec.offSetX=offSetX end
		return dirVec
	end
	
	function bd_init()
		hideAllPieces(unitID)
		Move(BodyPieces[1],x_axis,0,0,true)	
		Move(BodyPieces[1],y_axis,0,0,true)	
		Move(BodyPieces[1],z_axis,0,0,true)	
		bd_turnPieceInRandDir(BodyPieces[1],bd_makeDirVecFromDeg(180,180,0,0,0,0),1,linDegFilterFunction,symDegFilterFunction)
		
		Show(BodyPieces[1])
		if not ConPieces[1] then ConPieces[1]={}end
		ConPieces[1].Linear,ConPieces[1].Symetric={},{}
		
		bd_LinAddPieceSocketsToPool(1,true)
		
		
		bd_usedPiece(BodyPieces[1])
		
	end
	
	function bd_DoubleCheckPiece(tablename)
		--Rewrite
		local SymPairedPieces= tablename
		for i=1, #SymPairedPieces, 1 do
			if SymPairedPieces[i] then
				k,v=SymPairedPieces[i].k , SymPairedPieces[i].v
				
				if k and v and not AllReadyUsedPieces[k] and not AllReadyUsedPieces[v] then
					retA,retB= SymPairedPieces[i].k, SymPairedPieces[i].v
					SymPairedPieces[i]=nil
					return retA,retB
				end
			end
		end
		--exists a symetric pair- and a symetric socket pair
	end
	
	
	function bd_rollDice(max)
		return math.random(1,max),math.random(1,max)
	end
	
	--DEBUG DELME
	function bd_LinearExpandPieceCopy(bodyNumber)
		boolFirstOfPair	=	bodyNumber%2==1
		BodyDice	=		 math.ceil(math.random(bodyNumber,table.getn(BodyPieces)))
		BodyPiece	=		BodyPieces[BodyDice]
		SocketDice	=		1 or math.random(1,table.getn(LinBodyConCoords))
		if not LinBodyConCoords[SocketDice] then return end
		Socket 	 	=		LinBodyConCoords[SocketDice]
		
		if not AllReadyUsedPieces[BodyPiece] and not AllReadyUsedCoords[Socket.Piece] then
			
			randomVec={	boolFixedDegree=true, x=0, y=0, z=0 }
			
			Show(BodyPiece)
			assert(type(Socket)=="table")
			bd_conPieceCon2Socket(Socket,BodyPiece,randomVec)
			bd_LinAddPieceSocketsToPool(BodyDice,true)	
			
			Show(BodyPiece)
			bd_usedPiece(BodyPiece)
			bd_usedPiece(LinBodyConCoords[SocketDice].Piece)
			
			if boolFirstOfPair== true then return 2 else return 1 end
		end
		
		return 0
	end
	--DEBUG DELME
	
	
	
	--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
	function bd_LinearExpandPiece(bodyNumber)
		boolFirstOfPair=bodyNumber%2==0
		BodyDice	= math.ceil(math.random(bodyNumber,table.getn(BodyPieces)))
		BodyPiece	= BodyPieces[BodyDice]
		if table.getn(LinBodyConCoords) < 1 then return end
		SocketDice	= math.random(1,table.getn(LinBodyConCoords))
		Socket 	 	= LinBodyConCoords[SocketDice]
		
		if not AllReadyUsedPieces[BodyPiece] and not AllReadyUsedCoords[Socket.Piece] then
			randomVec=bd_makeDirVecFromDeg(180,180,0,0,0,0)
			Show(BodyPiece)
			assert(type(Socket)=="table")
			bd_conPieceCon2Socket(Socket,BodyPiece,randomVec)
			bd_LinAddPieceSocketsToPool(BodyDice,true)	
			
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
	
	
	function bd_SymmetricExpand(pieceA,pieceB,dirVec)
		--Spring.Echo("JW:VaryFoo:SymetricExpanding_1 >>"..table.getn(SymBodyConCoords))
		--rEchoT(SymBodyConCoords)
		--TODO
		-->Align Piece A -- add all pieces as symmetrics
		AlignPieceToPiece(ConCenter,pieceA,0)
		--> Align PiecB --add all pieces as symmetrics
		
		
		if SymBodyConCoords and table.getn(SymBodyConCoords) > 0 then
			--Spring.Echo("JW:SymetricExpand_1.5")
			dice=math.floor(math.random(1,math.max(1,table.getn(SymBodyConCoords)	)))
			socketA,socketB=bd_getPairNrSymBodyConCoords(dice)
			--nr=echoNr(nr);assert(socketA)
			if socketA then 
				--Spring.Echo("JW:VaryFoo:SymetricExpanding_2")
				
				if AllReadyUsedPieces[pieceA] == nil and AllReadyUsedPieces[pieceB] == nil then
					--Spring.Echo("JW:VaryFoo:SymetricExpanding_3")
					Show(pieceA)
					Show(pieceB)	
					
					dirVec=bd_makeDirVecFromDeg(90,45,180,90,90,35)
					bd_turnPieceInRandDir(pieceA,dirVec,1,linDegFilterFunction,symDegFilterFunction,pieceB)
					bd_sconPieceCon2Socket(socketA,pieceA, dirVec, true)
					bd_sconPieceCon2Socket(socketB,pieceB, dirVec, false)
					--add symmetric expansion points to the pool
					bd_SymAddPieceSocketsToPool(pieceA,pieceB)
					
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
		for i=1,table.getn(SymBodyConCoords),1 do
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
			return PiecePositionCache[key].x, PiecePositionCache[key].y, PiecePositionCache[key].z,PiecePositionCache[key].piecename
		end
	end
	
	function bd_insertCache(key,x,y,z)
		PiecePositionCache[key]={x=x,y=y,z=z,piecename=key}
		return true
	end
	
	function bd_LinFindFrontCon()
		X=-math.huge
		
		ShorTerMem=LinBodyConCoords[#LinBodyConCoords]
		
		for i=1, #LinBodyConCoords, 1 do
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
		--find two SymBodyConCoords who are frontal 
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
		bodydice=3
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
		SymConCoordLimit=bd_rollDice(Max/2)
		--Body
		for i=1,12 do 
			bd_LinearExpandPieceCopy(i)
		end
		--DEBUG DELME
		
		
		
		
		-- DEBUG DELME 
		attempts=0
		while bodyNum < bodydice and bd_existsParts(BodyPieces)==true and attempts < bodydice do
			Sleep(100)
			Spring.Echo("vehicular::bodybuilding")
			-- while there exist BodyParts2 and numberOfBodyPiecesUsed <bodydice
			--dice usage as a linear connector
			if  LinConCoordLimit < math.random(1,Max) then
				--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
				bodyNum=bodyNum+ (bd_LinearExpandPiece(bodyNum) or 0)
			else
				--Check if on of them is existing twice
				-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=bd_DoubleCheckPiece(DoubleBodyPieces)		
				if pieceA and pieceB and SymConCoordLimit < math.random(1,Max) then
					bodyNum=bodyNum+bd_SymmetricExpand(pieceA,pieceB)	
				else -- apply remainging BodyParts linear			
					bodyNum=bodyNum+ (bd_LinearExpandPiece(bodyNum) or 0)	
				end
			end
			
			attempts=attempts+1
		end
		
		
		
	
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
						Spring.Echo("libbuild::Linear_decoration")
						decoNum=decoNum+bd_LinearExpandDeco(offSetX)			
					end
				end
				if decoNum== oldDecoNum then decoCounter=decoCounter+1 end
				oldDecoNum=decoNum
			end		
		end		
		
		bd_alignLegsToGround()
		bd_processAddedArms()	

		
	end		
	
	function bd_getSymDecoCon()
		Spring.Echo("TODO: getSymDecoCon")
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
			--rEchoT(ArmTable)
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
function jw_AddTerrainDeformation(x,z, size, shapeFunction, ldepth, lblendType,lfilterType)
	blendType=lblendType or "melt"
	filterType=lfilterType or "borderblur"
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