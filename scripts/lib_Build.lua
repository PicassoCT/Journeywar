

function mirrorMapCenter(x,y,z)
mx,mz=Game.mapSizeX,Game.mapSizeZ
mx,mz= mx/2,mz/2

return x-1*(x-mx), y, z-1*(z-mz)
end

-->In absence of symmetric pieces, the buildpieces are paired with one example of connection sockets on exploration to add the 3d point
function buildVehicle(center,Arm_Max,Leg_Max, Body_Double_Max,Head_Max, Deco_Max, DecoD,Body_Max, symDegFilterFunction, linDegFilterFunction)
    ConCenter=piece("ConCenter")
	SymCon={}
	LinCom={}
	for i=1,4 do
	dynString="SymCon"..i
	SymCon[i]=piece(dynString)
	end
	LinCom[1]=piece"LinCom1"
	LinCom[2]=piece"LinCom2"
	

	AllReadyUsed={}
	--BODY
	--all the yet unused BodyPieces
	BodyPieces={}
	ConPieces={}
	DoubleBodyPieces={}
	BodyID=1
	DoubleMax=Body_Double_Max or 16
	BodyMax=Body_Max or 22
	ArmMax= Arm_Max or 12
	LinArmMax=Leg_Max or 4 --arms that can be used for linear expansion
	
	HeadMax= Head_Max or 8
	DecoMax=Body_Double_Max or 16
	DecoDouble= DecoD or 4
	
	
	--Connection pieces for linear Connections only
	for i=1,BodyMax,1 do
		
		bodyPieceName="body"..i.."s2"
		BodyPieces[i]=piece(bodyPieceName)
		nr=echoNr(nr);assert(BodyPieces[i])
		--Spring.Echo("JW:VaryFoo:SymetricConections"..table.getn(ConPieces[BodyPieces[i]].Symetric))
			
		Move(BodyPieces[i],x_axis,0,0)
		Move(BodyPieces[i],z_axis,0,0)
		Move(BodyPieces[i],y_axis,0,0)
		
		if i < DoubleMax and i %2 ==0 then
		DoubleBodyPieces[#DoubleBodyPieces+1]={k=BodyPieces[i-1],v=BodyPieces[i]}									
		end
	end
	
	--ARM
	ArmPieces={}
	DoubleArmPieces={}
	
	ArmTable={}
		for i=1,ArmMax,1 do
		
		bodyPieceName1="Arm"..i.."1"   --Uper  Arm
		bodyPieceName2="Arm"..i.."2"   --Lower Arm
		bodyPieceName3="ArmPoM"..i
		ArmPieces[i]={}
		ArmPieces[i][1]=	piece(bodyPieceName1)
		ArmPieces[i][2]=	piece(bodyPieceName2)
		ArmPieces[i][3]=	piece(bodyPieceName3)
		Hide(ArmPieces[i][1])
		Hide(ArmPieces[i][2])
	
		
		--add the linear connections
		
			if i < LinArmMax and i %2 ==0 then
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
		bodyPieceName="HeadCon"..i
		HeadCon[i]=piece(bodyPieceName)
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
	SymBodyCon={}
	LinBodyCon={}

	
	function bd_turnPieceInRandDir(pie,dirVec,SymSideVal,symPiece)
	minx,maxx,miny,maxy,minz,maxz=dirVec.minx,dirVec.maxx,dirVec.miny,dirVec.maxy,dirVec.minz,dirVec.maxz
	
	x=math.random(minx,maxx)
	z=math.random(minz,maxz)%180
	y=math.random(miny,maxy)
	offSetX= dirVec.offSetX or 0
	_,y,_=linDegFilterFunction(0,y,0)
	Turn(pie,y_axis,math.rad(y),0,true)

	if  symPiece == nil then
	--Turn(pie,z_axis,math.rad(0),0,true)
		x,_,_=linDegFilterFunction(x,0,0)
	Turn(pie,x_axis,math.rad(x+offSetX),0,true)
	else --if a Sympiece exists
	
		val=y*-1
		x,y,_=symDegFilterFunction(x,val,0)
		Turn(symPiece,y_axis,math.rad(val),0,true)
		
		Turn(pie,x_axis,math.rad(x+offSetX),0,true)
		Turn(symPiece,x_axis,math.rad(x+offSetX),0,true)

		
	end
	
		
	return x,y,z
	end

--								Socket,ConectionSocket,BodyPiece
	function bd_conPieceCon2Socket(Con,Pie,dirVec, boolLeftRight)
	x,y,z=Con.x,Con.y,Con.z
	
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
				bd_turnPieceInRandDir(Pie,dirVec,SymSideVal)
				end
				
	end
	
	function bd_sconPieceCon2Socket(Con,Pie,dirVec, boolLeftRight)
	x,y,z=Con.x,Con.y,Con.z
--	--Spring.Echo("JW:SymetricConPiece:"..Pie.." to Con "..Con)
	SymSideVal=1	
	if boolLeftRight and boolLeftRight==true  then SymSideVal=-1 end
	
		Show(Pie)
	
		Move(Pie,x_axis,x,0,true)
		Move(Pie,z_axis,z,0,true)
		Move(Pie,y_axis,y,0,true)
		--Now the piece is at the exact location of the connection piece

				if dirVec then				
				bd_turnPieceInRandDir(Pie,dirVec,SymSideVal)
				end
	end
---------------------------

	function bd_initVehicleCreation()
--DEBUG
	--Move(center,y_axis,90,0,true)
--DEBUG
		for i=1,ArmMax,1 do
		Hide(ArmPieces[i][1])
		Hide(ArmPieces[i][2])
		end
	hideT(BodyPieces)
	
	--hideT(HeadPieces)
	--hideT(DecoPieces)

	bd_init()
	StartThread(buildRandomizedVehicle)
	
	end
	
	function bd_existsParts(tablename)
	return table.getn(tablename)~= 0
	end
	
	
	function getSocketsAsPoints(part, sympart)
	getLinPoints= function (piecename)
					retTable={}
					table.insert(retTable,makePiecePoint(LinCom[1]))
					table.insert(retTable,makePiecePoint(LinCom[2]))
					return retTable
				  end

	getSynPoints= function(piecename)
					retTable={}
						for i=1,4 do
						table.insert(retTable,makePiecePoint(SymCon[i]))
						SymCon[i]=piece(dynString)
						end
					return retTable
				  end
				  
		LinCon=	{}
		SLinCon=	{}
		SynCon={}
		SSynCon={}
		-- we move the ConCenter to the part
		MovePieceToPiece(ConCenter,part)
		x,y,z=Spring.GetUnitPieceDirection(unitID,part)
		TurnPiece(ConCenter,x,y,z,0)
		--get the points Coordinates
		LinCon=getLinPoints(part)
		SynCon=getSynPoints(part)
		
		if sympart then	
		-- we move the ConCenter to the part
		MovePieceToPiece(ConCenter,sympart)
		x,y,z=Spring.GetUnitPieceDirection(unitID,sympart)
		TurnPiece(ConCenter,x,y,z,0)
		--get the points Coordinates
		SLinCon=getLinPoints(sympart)
		SSynCon=getSynPoints(sympart)
		end
	 
	 if table.getn(SLinCon) > 0 or table.getn(SSynCon) > 0 then 
	  return LinCon, SynCon, SLinCon, SSynCon 
	  else
	  return LinCon,SynCon
	  end
	end
	
	function bd_LinAddPieceSocketsToPool(part,boolAddSymetrics)
	
	--> we add the Points that this part holds to the pool
	 ConPieces[part].Linear,ConPieces[part].Symetric=getSocketsAsPoints(part)
		LinearCon=ConPieces[part].Linear
		SymCon=ConPieces[part].Symetric
		
		if LinearCon then
			for i=1,table.getn(LinearCon), 1 do
			LinBodyCon[#LinBodyCon+1]=LinearCon[i]	
			end
		end
		
		if SymCon and (boolAddSymetrics==nil or boolAddSymetrics==true ) then
				--	--Spring.Echo("JW:LinearSymetricSockets Added")
					num=table.getn(SymBodyCon)+1
					SymBodyCon[num]={}
					SymBodyCon[num][1]=SymCon[2]
					SymBodyCon[num][2]=SymCon[1]		
		end	
	end
	
	function bd_SymAddPieceSocketsToPool(part,sympiece)
	--we add the points into the table for symmmetric expansion
	--all the sockects are to be replaced by points--> implicating that 
	ConPieces[part].Linear,ConPieces[part].Symetric,	ConPieces[sympiece].Linear,	ConPieces[sympiece].Symetric=	getSocketsAsPoints(part,sympiece)
	
	local LinearCon=ConPieces[part].Linear
	local LinearConS=ConPieces[sympiece].Linear
	local SymCon=ConPieces[part].Symetric
	local SymConS=ConPieces[sympiece].Symetric
	
		if LinearCon then
			for i=1,#LinearCon, 1 do
			SymBodyCon[#SymBodyCon+1]=	{
										[1]=LinearCon[i],
										[2]=LinearConS[i]	
										}
			end
		end
	
		if SymCon then
			for i=1,#SymCon, 1 do
			SymBodyCon[#SymBodyCon+1]=	{
										[1]=SymCon[i],
										[2]=SymConS[i]	
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
	
		Move(BodyPieces[1],x_axis,0,0,true)	
		Move(BodyPieces[1],y_axis,0,0,true)	
		Move(BodyPieces[1],z_axis,0,0,true)	
		Show(BodyPieces[1])
		bd_LinAddPieceSocketsToPool(BodyPieces[1],true)
		bd_turnPieceInRandDir(BodyPieces[1],bd_makeDirVecFromDeg(180,180,0,0,0,0),1)
		
		usedPiece(BodyPieces[1])
		
    end
	
	function bd_DoubleCheckPiece(tablename)
	--Rewrite
	local SymPairedPieces= tablename
		for i=1, #SymPairedPieces, 1 do
			if SymPairedPieces[i] then
			k,v=SymPairedPieces[i].k , SymPairedPieces[i].v
			
				if k and v and not AllReadyUsed[k] and not AllReadyUsed[v] then
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
	
	--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
	function bd_LinearExpandPiece()
	BodyDice	= math.random(1,table.getn(BodyPieces))
	BodyPiece	= BodyPieces[BodyDice]
	SocketDice	= math.random(1,table.getn(LinBodyCon))
	Socket 	  	= LinBodyCon[SocketDice]
	
		if  not AllReadyUsed[BodyPiece] and not AllReadyUsed[Socket] then
		randomVec=bd_makeDirVecFromDeg(180,180,0,0,0,0)
		Show(BodyPiece)

		bd_conPieceCon2Socket(Socket,BodyPiece,randomVec)
		bd_LinAddPieceSocketsToPool(BodyPiece,true)	
		
		Show(BodyPiece)
		usedPiece(BodyPiece)
		usedPiece(Socket)
		return 1
		end
		
	return 0
	end
	
	function bd_getPairNrSymBodyCon(nr)
		if SymBodyCon[nr] and not AllReadyUsed[SymBodyCon[nr][1]] and not AllReadyUsed[SymBodyCon[nr][2]] then
		return SymBodyCon[nr][1],SymBodyCon[nr][2]	
		end
	end
	
	
	function bd_SymmetricExpand(pieceA,pieceB,dirVec)
	--Spring.Echo("JW:VaryFoo:SymetricExpanding_1 >>"..table.getn(SymBodyCon))
	--rEchoTable(SymBodyCon)
	--TODO
		if  SymBodyCon and table.getn(SymBodyCon) > 0 then
		--Spring.Echo("JW:SymetricExpand_1.5")
		dice=math.floor(math.random(1,math.max(1,table.getn(SymBodyCon)	)))
		socketA,socketB=bd_getPairNrSymBodyCon(dice)
		--nr=echoNr(nr);assert(socketA)
			if socketA then 
			--Spring.Echo("JW:VaryFoo:SymetricExpanding_2")
					
				if  AllReadyUsed[pieceA] == nil and AllReadyUsed[pieceB] ==  nil then
				--Spring.Echo("JW:VaryFoo:SymetricExpanding_3")
				Show(pieceA)
				Show(pieceB)	
				
				dirVec=bd_makeDirVecFromDeg(90,45,180,90,90,35)
					bd_turnPieceInRandDir(pieceA,dirVec,1,pieceB)
				bd_sconPieceCon2Socket(socketA,pieceA, dirVec, true)
				bd_sconPieceCon2Socket(socketB,pieceB, dirVec, false)
				--add symmetric expansion points to the pool
					bd_SymAddPieceSocketsToPool(pieceA,pieceB)
				
				usedPiece(socketA)
				usedPiece(socketB)
				usedPiece(pieceA)
				usedPiece(pieceB)
				return 2
				end
			end
		end
	return 0
	end
	

	function bd_findInSymBodyCon(point)
		for i=1,table.getn(SymBodyCon),1 do
			if SymBodyCon[i][1]==point or SymBodyCon[i][2]==point then
			return i
			end
		end
	end
	
	function bd_usedPiece(piecename)
	AllReadyUsed[piecename]=true
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
	X=-8192
	
	ShorTerMem=0
	
		for i=1,#LinBodyCon, 1 do
			x,y,z,piecename=accessCache(LinBodyCon[i])
			if z then
				if z > X  then
				X=z			
				ShorTerMem=piecename
				end
			else
			x,y,z=Spring.GetUnitPiecePosition(unitID,LinBodyCon[i])
			insertCache(LinBodyCon[i],z,y,x)
			
				if z > X then
				X=z
				ShorTerMem=LinBodyCon[i]
				end
			end
		end
	--StartThread(DeBugPieceLight,ShorTerMem)
	return ShorTerMem
	end
	
	function bd_getSymHeadCon()
	Spring.Echo("TODO: bd_getSymHeadCon")
	--find two SymBodyCon who are frontal 
	end
	
	function bd_DeBugPieceLight(piecename)
		while true do
		EmitSfx(piecename,1025)
		Sleep(250)
		end
	end
	
	--attaches a Alienhead linear to the body
	function bd_LinearExpandHead(offSetX)
		HeadDice=math.random(1,table.getn(HeadPieces))
		Head=HeadPieces[HeadDice]

		Socket=bd_LinFindFrontCon()
	
		if  AllReadyUsed[Head] == nil and AllReadyUsed[Socket]== nil then
		randomVec=bd_makeDirVecFromDeg(0,25,0,0,0,0,offSetX)
		Show(Head)

		bd_conPieceCon2Socket(Socket,Head,randomVec)
		usedPiece(Head)
		usedPiece(Socket)
		return 1
		end
		
	return 0
	end

	function bd_SymmetricExpandHead(pieceA,pieceB,offSetX)
		if SymBodyCon and table.getn(SymBodyCon) > 0 then
		
			socketA,socketB=bd_getSymHeadCon()
		
		

			if socketA  and AllReadyUsed[pieceA] == nil and AllReadyUsed[pieceB] ==  nil then
			Show(pieceA)
			Show(pieceB)	
			
			dirVec=bd_makeDirVecFromDeg(0,25,90,45,0,0,offSetX)

			bd_sconPieceCon2Socket(socketA,pieceA, dirVec, true)
			bd_sconPieceCon2Socket(socketB,pieceB, dirVec, false)
			
			bd_turnPieceInRandDir(pieceA,dirVec,1,pieceB)
			usedPiece(socketA)
			usedPiece(socketB)
			usedPiece(pieceA)
			usedPiece(pieceB)
			return 2
			end
		
		end
	return 0
	end

function bd_LinearExpandArm()
		ArmDice=math.random(1,LinArmMax)
		Arm=ArmPieces[ArmDice]
		SocketDice=math.random(1,table.getn(LinBodyCon))
		Socket=LinBodyCon[SocketDice]
	
		if  AllReadyUsed[Arm] == nil and AllReadyUsed[Socket]== nil then
		randomVec=bd_makeDirVecFromDeg(0,0,0,0,0,0,0)
		Show(Arm[1])
		Show(Arm[2])

		bd_conPieceCon2Socket(Socket,Arm[1],randomVec)
		usedPiece(Arm[1])
		usedPiece(Arm[2])
		usedPiece(Socket)
		return Arm
		end
		
	return -1

	end

	function bd_SymetricExpandArm(ArmTableA,ArmTableB )

		if SymBodyCon and table.getn(SymBodyCon) > 0 then
			dice=math.floor(math.random(1,math.max(1,#SymBodyCon)	))
			socketA,socketB=bd_getPairNrSymBodyCon(dice)
			
				if socketA then 
				table.remove(SymBodyCon,socketA)
				table.remove(SymBodyCon,socketB)

						
				
					if  AllReadyUsed[ArmTableA[1]] == nil and AllReadyUsed[ArmTableB[1]] ==  nil then
					--Spring.Echo("JW:VaryFoo:SymetricExpanding_3")
					Show(ArmTableA[1])
					Show(ArmTableA[2])
					Show(ArmTableB[1])	
					Show(ArmTableB[2])	
					
					dirVec=bd_makeDirVecFromDeg(0,0,0,0,0,0)

					bd_sconPieceCon2Socket(socketA,ArmTableA[1], dirVec, true)
					bd_sconPieceCon2Socket(socketB,ArmTableB[1], dirVec, false)
					
					bd_turnPieceInRandDir(ArmTableA[1],dirVec,1,ArmTableB[1])
					usedPiece(socketA)
					usedPiece(socketB)
					usedPiece(ArmTableA[1])
					usedPiece(ArmTableA[2])
					usedPiece(ArmTableB[1])
					usedPiece(ArmTableB[2])
					return ArmTableA,ArmTableB
					end
				end
		end

	end
	
	function bd_buildRandomizedVehicle()
	--Nr of Pieces Used to build this VaryFoo
	bodydice=3

	if not GG.VaryFooPieceMax then GG.VaryFooPieceMax={} end

	if not GG.VaryFooPieceMax[teamID] then 
	GG.VaryFooPieceMax[teamID]=6 
	end
	
	BodyMax=GG.VaryFooPieceMax[teamID]
	hp, maxhp=Spring.GetUnitHealth(unitID)
	Spring.SetUnitHealth(unitID,hp,maxhp*math.ceil(6/GG.VaryFooPieceMax[teamID]))
	
	if math.random(0,1)==1 then
	bodydice=math.ceil(math.random(3,BodyMax))
	else
	bodydice=math.ceil(math.random(3,math.ceil(BodyMax/2)))
	end
	bodyNum=1
		
	Max=math.random(4,#BodyPieces)
	
	linConLimit=bd_rollDice(Max)
	symConLimit=bd_rollDice(Max/2)
	--Body
	while bodyNum < bodydice and bd_existsParts(BodyPieces)==true do
	Spring.Echo("vehicular::bodybuilding")
	-- while there exist  BodyParts2 and numberOfBodyPiecesUsed <bodydice
		--dice usage as a linear connector
		if  linConLimit < math.random(1,Max) then
		--FindPiece -FindSocket -- bd_LinAddPieceSocketsToPool
		bodyNum=bodyNum+bd_LinearExpandPiece()
		else
			--Check if on of them is existing twice
	-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
			pieceA,pieceB=bd_DoubleCheckPiece(DoubleBodyPieces)		
			if pieceA and pieceB and symConLimit < math.random(1,Max)  then
			bodyNum=bodyNum+bd_SymmetricExpand(pieceA,pieceB)	
				else -- apply remainging BodyParts linear			
				bodyNum=bodyNum+bd_LinearExpandPiece()			
				end
		end

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
		Spring.Echo("jvaryfoo::arms")
		-- while there exist  BodyParts2 and numberOfBodyPiecesUsed <Armdice
		--Spring.Echo("Exit the Loop2")
			--dice usage as a linear connector
			if  boolAtLeastOnePair== true and linConLimit < math.random(1,Max) then
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
				if  pieceA and pieceB and symConLimit < math.random(1,Max)  then
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
			
	linConLimit,symConLimit=bd_rollDice(Max)
	
	while headNum < headdice and bd_existsParts(HeadPieces)==true do
	Spring.Echo("jvaryfoo::giving head")
	headNum=headNum+1
		if  linConLimit < math.random(1,Max) then
		headNum=headNum+bd_LinearExpandHead(offSetX)
		else
			--Check if on of them is existing twice
	-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
			pieceA,pieceB=bd_DoubleCheckPiece(DoubleHeadPieces)		
			if pieceA and pieceB and symConLimit < math.random(1,Max)  then
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
				
		linConLimit,symConLimit=bd_rollDice(Max)
		
		while decoCounter < DecoMax and decoNum < decodice and bd_existsParts(HeadPieces)==true do
		
			if  linConLimit < math.random(1,Max) then
			Spring.Echo("jvaryfoo::Linear_decoration")
			decoNum=decoNum+LinearExpandDeco(offSetX)
			else
				--Check if on of them is existing twice
		-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=bd_DoubleCheckPiece(DoubleDecoPieces)		
				if pieceA and pieceB and symConLimit < math.random(1,Max) then
				decoNum=decoNum+SymmetricExpandDeco(pieceA,pieceB,offSetX)	
				Spring.Echo("jvaryfoo::Sym_decoration")
				else 			
				Spring.Echo("jvaryfoo::Linear_decoration")
				decoNum=decoNum+LinearExpandDeco(offSetX)			
				end
			end
		if decoNum== oldDecoNum then decoCounter=decoCounter+1 end
		oldDecoNum=decoNum
		end		
	end		
	
	alignLegsToGround()
	processAddedArms()	
end		

function bd_getSymDecoCon()
Spring.Echo("TODO: getSymDecoCon")
end

--StartPoint
local linDecP={}
boolFoundSomething=false
function bd_LinFindDecoCon()
--we find a startpoint by finding start and endpoint and choosing the lowest
poinTable=piec2Point(LinBodyCon)
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
		if dist < tdist and poinTable[i].y > theight and not AllReadyUsed[LinBodyCon[i]] then
		 tx,ty,tz,tdist,theight = poinTable[i].x,poinTable[i].y,poinTable[i].z,dist, poinTable[i].y
		 index=i
		 --if we found nothing, we need to start again, at another lowest point
		 boolFoundSomething=true
		end
	end
	linDecP.x,linDecP.y,linDecP.z,linDecP.index= tx,ty,tz,index
	
return LinBodyCon[index] 
end

function bd_LinearExpandDeco(offSet)
	DecoDice=math.random(1,table.getn(DecoPieces))
		Deco=DecoPieces[DecoDice]

		Socket=LinFindDecoCon()
	
	
	
	
	if AllReadyUsed[Socket]== nil then
	Spring.Echo("Socket allready used")
	end		
		
		if  AllReadyUsed[Deco] == nil and AllReadyUsed[Socket]== nil then
	
	randomVec=bd_makeDirVecFromDeg(90,45,0,0,0,0,offSet)
		Show(Deco)

		bd_conPieceCon2Socket(Socket,Deco,randomVec)
		usedPiece(Deco)
		usedPiece(Socket)
		Spring.Echo("jvaryfoo::LinearDecoExpansion Success")
		return 1
		end
	Spring.Echo("jvaryfoo::LinearDecoExpansion Phail")
	return 0
end

function bd_SymmetricExpandDeco(pieceA, pieceB)
	if SymBodyCon and table.getn(SymBodyCon) > 0 then
		
			socketA,socketB=getSymDecoCon()
		
			if socketA  and AllReadyUsed[pieceA] == nil and AllReadyUsed[pieceB] ==  nil then
			Show(pieceA)
			Show(pieceB)	
			
			dirVec=bd_makeDirVecFromDeg(180,180,180,180,180,180)

			bd_sconPieceCon2Socket(socketA,pieceA, dirVec, true)
			bd_sconPieceCon2Socket(socketB,pieceB, dirVec, false)
			
			bd_turnPieceInRandDir(pieceA,dirVec,1,pieceB)
			usedPiece(socketA)
			usedPiece(socketB)
			usedPiece(pieceA)
			usedPiece(pieceB)
				Spring.Echo("jvaryfoo::SymDecoExpansion Success")
			return 2
			end
		
		end
	Spring.Echo("jvaryfoo::SymDecoExpansion Phail")
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
		--rEchoTable(ArmTable)
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
						
							if  y < IntervallMin then IntervallMin=y end
							if  y > IntervallMax then IntervallMax=y end		
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
				
					i=findLowestOfSet(ArmTable)
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
			if getValByKeyObj(DoubleArmPieces,ArmTable[i]) and temp[getValByKeyObj(DoubleArmPieces,ArmTable[i])] and not AllReadyUsed[temp[getValByKeyObj(DoubleArmPieces,ArmTable[i])]] then
			SymPairArms={[1]=ArmTable[i],
						 [2]= temp[getValByKeyObj(DoubleArmPieces,ArmTable[i])],}
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


function PlanetNameGenerator(llenght, lNamingSamples,  lBreakers, lLetterTable,lBoolPrecursor, lBoolPostPoner)
function PreCurse() return math.random(0,1)==1 end
function PostPone() return math.random(0,1)==1 end


length = llenght or 3
NamingSamples= lNamingSamples or 10
LetterTable= lLetterTable or {[1]="A",[2]="O",[3]="E",[4]="U",[5]="I",[6]="K",[7]="C",[8]="L",[9]="N",[10]="R",[11]="S",[12]="Y",[13]="G",[14]="H",[15]="T"}
Breakers=lBreakers or math.floor(math.random(0,2))
Precursor=""
PostPoner=""

PrecursorTable={"Prime ", "Sigma ", "Alpha ", "Al' ", "New ", "Colony "}

   if PreCurse() ==true then
   Precursor=PrecursorTable[math.random(1,#PrecursorTable)]
   end
   
PostPonerTable={" Hope", " Landfell", " Edge", " VIII ", " Paradise", " <HellClass>" }

   if PostPone()==true then
   PostPoner=PostPonerTable[math.random(1,#PostPonerTable)]
   end

NameEndingTable={"this","iel","ora","os","cia","ash","esh","ill","illa","esh","dor","ran",
               "spin","dia","bah","cant","sen","ino","ine","vin","eese","oga",
               "alla","ico","rah","kel","nis","gam","hell","den","rado","yss","hnoss"}
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