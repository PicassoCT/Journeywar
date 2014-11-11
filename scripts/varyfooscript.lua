	include "suddenDeath.lua"
	include "toolKit.lua"
	
	AllReadyUsed={}
	center=piece"center"
	--BODY
	--all the yet unused BodyPieces
	BodyPieces={}
	ConPieces={}
	DoubleBodyPieces={}
	BodyID=1
	DoubleMax=16
	BodyMax=22
	
	--Connection pieces for linear Connections only
	for i=1,BodyMax,1 do
		
		bodyPieceName="body"..i.."s2"
		BodyPieces[i]=piece(bodyPieceName)
		
		--add the linear connections
		ConPieces[BodyPieces[i]]={}
		ConPieces[BodyPieces[i]].Symetric={}
		ConPieces[BodyPieces[i]].Linear={}
		
			for j=1,4,1 do
			name="lcon"..i..j
			ConPieces[BodyPieces[i]].Linear[j]={}
			ConPieces[BodyPieces[i]].Linear[j]=piece(name)
			end
		--add the symetric connections
			
			for j=1,2,1 do
			name="scon"..i..j
			ConPieces[BodyPieces[i]].Symetric[j]=piece(name)
			end
			
	--	--Spring.Echo("JW:VaryFoo:SymetricConections"..table.getn(ConPieces[BodyPieces[i]].Symetric))
			
		Move(BodyPieces[i],x_axis,0,0)
		Move(BodyPieces[i],z_axis,0,0)
		Move(BodyPieces[i],y_axis,0,0)
		
		if i < DoubleMax and i %2 ==0 then
		DoubleBodyPieces[BodyPieces[i-1]]=BodyPieces[i]		
											
		end
	end
	
	--ARM
	ArmPieces={}
	DoubleArmPieces={}
	ArmCon={}
	ArmMax=12
	LinArmMax=4 --arms that can be used for linear expansion
	ExclusiveSymmetricArm={}
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
		
			if i < ArmMax and i %2 ==0 then
			DoubleArmPieces[ArmPieces[i-1]]=ArmPieces[i]													
			end
		
	
		end

	--HEAD
	HeadPieces={}
	DoubleHeadPieces={}
	HeadCon={}
	HeadMax=8
	
		for i=1,HeadMax,1 do
		
		bodyPieceName="Head"..i
		HeadPieces[i]=piece(bodyPieceName)
		Hide(HeadPieces[i])
		bodyPieceName="HeadCon"..i
		HeadCon[i]=piece(bodyPieceName)
		--add the linear connections
		
		if i < HeadMax and i %2 ==0 then
		DoubleHeadPieces[HeadPieces[i-1]]=HeadPieces[i]													
		end
		

		end

	--DECO
	DecoPieces={}
	DoubleDecoPieces={}
	
	DecoMax=16
	DecoDouble=4
	for i=1,DecoMax,1 do
		
		bodyPieceName="Deco"..i
		DecoPieces[i]=piece(bodyPieceName)
		--add the linear connections
		
		if i < DecoMax and i %2 ==0 then
		DoubleDecoPieces[DecoPieces[i-1]]=DecoPieces[i]													
		end
	Hide(DecoPieces[i])

	end
-------------------------------------------------------------------EndOfPieceDelcarations-----------
	--Contains all Connections exposed by allready used BodyParts 
	--every added Symetric ConnectionPoint is parallel such as [1] <-> [2] form a symetric pair
	SymBodyCon={}
	LinBodyCon={}


	function turnPieceInRandDir(pie,dirVec,SymSideVal,symPiece)
	minx,maxx,miny,maxy,minz,maxz=dirVec.minx,dirVec.maxx,dirVec.miny,dirVec.maxy,dirVec.minz,dirVec.maxz
	
	x=math.random(minx,maxx)
	z=math.random(minz,maxz)%180
	y=math.random(miny,maxy)
	offSetX= dirVec.offSetX or 0
	
	Turn(pie,y_axis,math.rad(y),0,true)

	if  symPiece == nil then
	--Turn(pie,z_axis,math.rad(0),0,true)
	Turn(pie,x_axis,math.rad(x+offSetX),0,true)
	else --if a Sympiece exists
		val=y*-1
		Turn(symPiece,y_axis,math.rad(val),0,true)
		
		Turn(pie,x_axis,math.rad(x+offSetX),0,true)
		Turn(symPiece,x_axis,math.rad(x+offSetX),0,true)
		--val=(x+offSetX)*SymSideVal
		--Turn(pie,z_axis,math.rad(val),0,true)
		--dx,dy,dz= mirrorMatriceXAxis(x+offSetX,y,z)
		--x,y,z=math.atan2(1-dx,dx),math.atan2(1-dy,dy),math.atan2(1-dz,dz)
		-- val=x+offSetX
		-- Turn(pie,x_axis,math.rad(SymSideVal*x+offSetX),0,true)
		
		-- Turn(pie,z_axis,math.rad(z*SymSideVal),0,true)
	end
	
		
	return x,y,z
	end

--								Socket,ConectionSocket,BodyPiece
	function conPieceCon2Socket(Con,Pie,dirVec, boolLeftRight)
	x,y,z=Spring.GetUnitPiecePosition(unitID,Con)
	
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
				turnPieceInRandDir(Pie,dirVec,SymSideVal)
				end
				
	end
	
	function sconPieceCon2Socket(Con,Pie,dirVec, boolLeftRight)
	x,y,z=Spring.GetUnitPiecePosition(unitID,Con)
--	--Spring.Echo("JW:SymetricConPiece:"..Pie.." to Con "..Con)
	SymSideVal=1	
	if boolLeftRight and boolLeftRight==true  then SymSideVal=-1 end
	
		Show(Pie)
	
		Move(Pie,x_axis,x,0,true)
		Move(Pie,z_axis,z,0,true)
		Move(Pie,y_axis,y,0,true)
		--Now the piece is at the exact location of the connection piece

				if dirVec then				
				turnPieceInRandDir(Pie,dirVec,SymSideVal)
				end
	end
---------------------------

	function script.Create()
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

	init()
	StartThread(buildAVaryFoo)
	StartThread(walk)
	StartThread(sound)
	end
	
	function existsParts(tablename)
	return table.getn(tablename)~= 0
	end
	
	function LinAddPieceSocketsToPool(piece,boolAddSymetrics)
		LinearCon=ConPieces[piece].Linear
	SymCon=ConPieces[piece].Symetric
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
	
	function SymAddPieceSocketsToPool(piece,sympiece)
	local LinearCon=ConPieces[piece].Linear
	local LinearConS=ConPieces[sympiece].Linear
	local SymCon=ConPieces[piece].Symetric
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
	
	function makeDirVecFromDeg(degx,valx,degy,valy,degz,valz,offSetX)
	dirVec={}
	dirVec.minx,dirVec.maxx=degx-valx,degx+valx
	dirVec.miny,dirVec.maxy=degy-valy,degy+valy
	dirVec.minz,dirVec.maxz=degz-valz,degz+valz
	if offSetX then	dirVec.offSetX=offSetX end
	return dirVec
	end
	
	function init()
	
		Move(BodyPieces[1],x_axis,0,0,true)	
		Move(BodyPieces[1],y_axis,0,0,true)	
		Move(BodyPieces[1],z_axis,0,0,true)	
		Show(BodyPieces[1])
		LinAddPieceSocketsToPool(BodyPieces[1],true)
		turnPieceInRandDir(BodyPieces[1],makeDirVecFromDeg(180,180,0,0,0,0),1)
		
		usedPiece(BodyPieces[1])
		
    end
	
	function DoubleCheckPiece(tablename)
	for k,v in pairs(tablename) do
		if k and v and  AllReadyUsed[k]==nil and  AllReadyUsed[v]==nil then
		tablename[k]=nil
		return k,v
		end
	end
	--exists a symetric pair- and a symetric socket pair

	end

	
	function rollDice(max)
	return math.random(1,max),math.random(1,max)
	end
	
	--FindPiece -FindSocket -- LinAddPieceSocketsToPool
	function LinearExpandPiece()
	BodyDice	= math.random(1,table.getn(BodyPieces))
	BodyPiece	= BodyPieces[BodyDice]
	SocketDice	= math.random(1,table.getn(LinBodyCon))
	Socket 	  	= LinBodyCon[SocketDice]
	
		if  not AllReadyUsed[BodyPiece] and not AllReadyUsed[Socket] then
		randomVec=makeDirVecFromDeg(180,180,0,0,0,0)
		Show(BodyPiece)

		conPieceCon2Socket(Socket,BodyPiece,randomVec)
		LinAddPieceSocketsToPool(BodyPiece,true)	
		
		Show(BodyPiece)
		usedPiece(BodyPiece)
		usedPiece(Socket)
		return 1
		end
		
	return 0
	end
	
	function getPairNrSymBodyCon(nr)
		if SymBodyCon[nr] and not AllReadyUsed[SymBodyCon[nr][1]] and not AllReadyUsed[SymBodyCon[nr][2]] then
		return SymBodyCon[nr][1],SymBodyCon[nr][2]	
		end
	end
	
	
	function SymmetricExpand(pieceA,pieceB,dirVec)
	--Spring.Echo("JW:VaryFoo:SymetricExpanding_1 >>"..table.getn(SymBodyCon))
	rEchoTable(SymBodyCon)
	--TODO
		if  SymBodyCon and table.getn(SymBodyCon) > 0 then
		--Spring.Echo("JW:SymetricExpand_1.5")
		dice=math.floor(math.random(1,math.max(1,table.getn(SymBodyCon)	)))
		socketA,socketB=getPairNrSymBodyCon(dice)
		--assert(socketA)
			if socketA then 
			--Spring.Echo("JW:VaryFoo:SymetricExpanding_2")
					
				if  AllReadyUsed[pieceA] == nil and AllReadyUsed[pieceB] ==  nil then
				--Spring.Echo("JW:VaryFoo:SymetricExpanding_3")
				Show(pieceA)
				Show(pieceB)	
				
				dirVec=makeDirVecFromDeg(90,45,180,90,90,35)

				sconPieceCon2Socket(socketA,pieceA, dirVec, true)
				sconPieceCon2Socket(socketB,pieceB, dirVec, false)
				
				turnPieceInRandDir(pieceA,dirVec,1,pieceB)
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
	

	function findInSymBodyCon(piecename)
		for i=1,table.getn(SymBodyCon),1 do
			if SymBodyCon[i][1]==piecename or SymBodyCon[i][2]==piecename then
			return i
			end
		end
	end
	
	function usedPiece(piecename)
	AllReadyUsed[piecename]=true
	table.remove(LinBodyCon,piecename)
	i=findInSymBodyCon(piecename)	
	if i then table.remove(SymBodyCon,i) end
	end
	

	local PiecePositionCache={}
	
	function  accessCache(key)
		if PiecePositionCache[key] then
		return PiecePositionCache[key].x, PiecePositionCache[key].y, PiecePositionCache[key].z,PiecePositionCache[key].piecename
		end
	end
	
	function insertCache(key,x,y,z)
	PiecePositionCache[key]={x=x,y=y,z=z,piecename=key}
	return true
	end
 
	function LinFindFrontCon()
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
	
	function getSymHeadCon()
	--find two SymBodyCon who are frontal 
	end
	
	function DeBugPieceLight(piecename)
		while true do
		EmitSfx(piecename,1025)
		Sleep(250)
		end
	end
	
	--attaches a Alienhead linear to the body
	function LinearExpandHead(offSetX)
		HeadDice=math.random(1,table.getn(HeadPieces))
		Head=HeadPieces[HeadDice]

		Socket=LinFindFrontCon()
	
		if  AllReadyUsed[Head] == nil and AllReadyUsed[Socket]== nil then
		randomVec=makeDirVecFromDeg(0,25,0,0,0,0,offSetX)
		Show(Head)

		conPieceCon2Socket(Socket,Head,randomVec)
		usedPiece(Head)
		usedPiece(Socket)
		return 1
		end
		
	return 0
	end

	function SymmetricExpandHead(pieceA,pieceB,offSetX)
		if SymBodyCon and table.getn(SymBodyCon) > 0 then
		
			socketA,socketB=getSymHeadCon()
		
		

			if socketA  and AllReadyUsed[pieceA] == nil and AllReadyUsed[pieceB] ==  nil then
			Show(pieceA)
			Show(pieceB)	
			
			dirVec=makeDirVecFromDeg(0,25,90,45,0,0,offSetX)

			sconPieceCon2Socket(socketA,pieceA, dirVec, true)
			sconPieceCon2Socket(socketB,pieceB, dirVec, false)
			
			turnPieceInRandDir(pieceA,dirVec,1,pieceB)
			usedPiece(socketA)
			usedPiece(socketB)
			usedPiece(pieceA)
			usedPiece(pieceB)
			return 2
			end
		
		end
	return 0
	end

function LinearExpandArm()
		ArmDice=math.random(1,LinArmMax)
		Arm=ArmPieces[ArmDice]
		SocketDice=math.random(1,table.getn(LinBodyCon))
		Socket=LinBodyCon[SocketDice]
	
		if  AllReadyUsed[Arm] == nil and AllReadyUsed[Socket]== nil then
		randomVec=makeDirVecFromDeg(0,0,0,0,0,0,0)
		Show(Arm[1])
		Show(Arm[2])

		conPieceCon2Socket(Socket,Arm[1],randomVec)
		usedPiece(Arm[1])
		usedPiece(Arm[2])
		usedPiece(Socket)
		return Arm
		end
		
	return -1

	end

	function SymetricExpandArm(ArmTableA,ArmTableB )

		if SymBodyCon and table.getn(SymBodyCon) > 0 then
			dice=math.floor(math.random(1,math.max(1,#SymBodyCon)	))
			socketA,socketB=getPairNrSymBodyCon(dice)
			
				if socketA then 
				table.remove(SymBodyCon,socketA)
				table.remove(SymBodyCon,socketB)

						
				
					if  AllReadyUsed[ArmTableA[1]] == nil and AllReadyUsed[ArmTableB[1]] ==  nil then
					--Spring.Echo("JW:VaryFoo:SymetricExpanding_3")
					Show(ArmTableA[1])
					Show(ArmTableA[2])
					Show(ArmTableB[1])	
					Show(ArmTableB[2])	
					
					dirVec=makeDirVecFromDeg(0,0,0,0,0,0)

					sconPieceCon2Socket(socketA,ArmTableA[1], dirVec, true)
					sconPieceCon2Socket(socketB,ArmTableB[1], dirVec, false)
					
					turnPieceInRandDir(ArmTableA[1],dirVec,1,ArmTableB[1])
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
	
	function buildAVaryFoo()
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
	
	linConLimit=rollDice(Max)
	symConLimit=rollDice(Max/2)
	--Body
	while bodyNum < bodydice and existsParts(BodyPieces)==true do
	-- while there exist  BodyParts2 and numberOfBodyPiecesUsed <bodydice
		--dice usage as a linear connector
		if  linConLimit < math.random(1,Max) then
		--FindPiece -FindSocket -- LinAddPieceSocketsToPool
		bodyNum=bodyNum+LinearExpandPiece()
		else
			--Check if on of them is existing twice
	-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
			pieceA,pieceB=DoubleCheckPiece(DoubleBodyPieces)		
			if pieceA and pieceB and symConLimit < math.random(1,Max)  then
			bodyNum=bodyNum+SymmetricExpand(pieceA,pieceB)	
				else -- apply remainging BodyParts linear			
				bodyNum=bodyNum+LinearExpandPiece()			
				end
		end

	end

	--Arm
	Armdice=math.ceil(math.random(3,ArmMax))
	ArmNum=0
	
	--Add at least one symetric Pair
	pieceA,pieceB=DoubleCheckPiece(DoubleArmPieces)		
	ArmA,ArmB=SymetricExpandArm(pieceA,pieceB)	
	table.insert(ArmTable,ArmA)
	table.insert(ArmTable,ArmB)
	ArmNum=ArmNum+2
	
		while ArmNum < Armdice and existsParts(ArmPieces)==true do
		-- while there exist  BodyParts2 and numberOfBodyPiecesUsed <Armdice
		--Spring.Echo("Exit the Loop2")
			--dice usage as a linear connector
			if  boolAtLeastOnePair== true and linConLimit < math.random(1,Max) then
			--FindPiece -FindSocket -- LinAddPieceSocketsToPool
			--Spring.Echo("JW:LinearExpand")
				res=LinearExpandArm()
				if res then
				ArmNum=ArmNum+1
					if res ~= -1 then table.insert(ArmTable,res)	end
				end
			else
				--Check if on of them is existing twice
				-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=DoubleCheckPiece(DoubleArmPieces)		
				if  pieceA and pieceB and symConLimit < math.random(1,Max)  then
				--Spring.Echo("JW:SymetricExpand")
				ArmA,ArmB=SymetricExpandArm(pieceA,pieceB)	
				table.insert(ArmTable,ArmA)
				table.insert(ArmTable,ArmB)
				ArmNum=ArmNum+2
				boolAtLeastOnePair=true
				else -- apply remainging BodyParts linear			
					res=LinearExpandArm()
					if res then
					ArmNum=ArmNum+1
						if res ~= -1 then table.insert(ArmTable,res)	end
					end
			
				end
			end
		end
	alignLegsToGround()
	processAddedArms()

	
	headdice=math.ceil(math.random(1,HeadMax))
	headNum=0
	Max=HeadMax
	--Head
			
	linConLimit,symConLimit=rollDice(Max)
	
	while headNum < headdice and existsParts(HeadPieces)==true do
	headNum=headNum+1
		if  linConLimit < math.random(1,Max) then
		headNum=headNum+LinearExpandHead(offSetX)
		else
			--Check if on of them is existing twice
	-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
			pieceA,pieceB=DoubleCheckPiece(DoubleHeadPieces)		
			if pieceA and pieceB and symConLimit < math.random(1,Max)  then
			headNum=headNum+SymmetricExpandHead(pieceA,pieceB,offSetX)	
			else -- apply remainging BodyParts linear			
			headNum=headNum+LinearExpandHead(offSetX)			
			end
		end
	end

--Not every Varyfoo needs deco	
	if math.random(0,1)==1 then
	decodice=math.ceil(math.random(1,DecoMax))
		decoNum=0
		Max=HeadMax
		--Head
				
		linConLimit,symConLimit=rollDice(Max)
		
		while decoNum < decodice and existsParts(HeadPieces)==true do
			if  linConLimit < math.random(1,Max) then
			decoNum=decoNum+LinearExpandDeco(offSetX)
			else
				--Check if on of them is existing twice
		-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=DoubleCheckPiece(DoubleDecoPieces)		
				if pieceA and pieceB and symConLimit < math.random(1,Max)  then
				decoNum=decoNum+SymmetricExpandDeco(pieceA,pieceB,offSetX)	
				else 			
				decoNum=decoNum+LinearExpandDeco(offSetX)			
				end
			end
		end		
	end		
		
end		

function getSymDecoCon()

end

--StartPoint
local linDecP={}
boolFoundSomething=false
function LinFindDecoCon()
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
		if dist < tdist and poinTable[i].y > theight then
		 tx,ty,tz,tdist,theight = poinTable[i].x,poinTable[i].y,poinTable[i].z,dist, poinTable[i].y
		 index=i
		 --if we found nothing, we need to start again, at another lowest point
		 boolFoundSomething=true
		end
	end
	linDecP.x,linDecP.y,linDecP.z,linDecP.index= tx,ty,tz,index
	
return LinBodyCon[index] 
end

function LinearExpandDeco(offSet)
	DecoDice=math.random(1,table.getn(DecoPieces))
		Deco=DecoPieces[DecoDice]

		Socket=LinFindDecoCon()
	
		if  AllReadyUsed[Deco] == nil and AllReadyUsed[Socket]== nil then
		randomVec=makeDirVecFromDeg(90,45,0,0,0,0,offSet)
		Show(Deco)

		conPieceCon2Socket(Socket,Deco,randomVec)
		usedPiece(Deco)
		usedPiece(Socket)
		return 1
		end
		
	return 0
end

function SymmetricExpandDeco(pieceA, pieceB)
	if SymBodyCon and table.getn(SymBodyCon) > 0 then
		
			socketA,socketB=getSymDecoCon()
		
			if socketA  and AllReadyUsed[pieceA] == nil and AllReadyUsed[pieceB] ==  nil then
			Show(pieceA)
			Show(pieceB)	
			
			dirVec=makeDirVecFromDeg(180,180,180,180,180,180)

			sconPieceCon2Socket(socketA,pieceA, dirVec, true)
			sconPieceCon2Socket(socketB,pieceB, dirVec, false)
			
			turnPieceInRandDir(pieceA,dirVec,1,pieceB)
			usedPiece(socketA)
			usedPiece(socketB)
			usedPiece(pieceA)
			usedPiece(pieceB)
			return 2
			end
		
		end
	return 0
end
		
	function findLowestOfSet(Table)
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
		
	
	function alignLegsToGround()
		if #ArmTable > 0 then
		rEchoTable(ArmTable)
		local spGetUnitPiecePos=Spring.GetUnitPiecePosition
		oldMaxDif=99999
		smallestIntervallSoFar=1	
		
			for i=1,360,3 do
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
	

	function script.Killed(recentDamage,_)

	suddenDeathjBigCorpse(recentDamage)
	return 1
	end

	local SymPairArms={}
	local LinArms={}
	
	function processAddedArms()
	temp={}
		for i=1,#ArmTable,1 do
		temp[ArmTable[i]]={}
		temp[ArmTable[i]]=ArmTable[i]
		end
	
		for i=1,#ArmTable,1 do
		--check wether the Arm is in DoubleArmPieces and its counterpart is in 
			if DoubleArmPieces[ArmTable[i]] and temp[DoubleArmPieces[ArmTable[i]]] and not AllReadyUsed[temp[DoubleArmPieces[ArmTable[i]]]] then
			SymPairArms={[1]=ArmTable[i],
						 [2]= temp[DoubleArmPieces[ArmTable[i]]],}
			else
			LinArms[#LinArms+1]=ArmTable[i]
			end
		end
		
	
	end
	


	function moveLeg(delay, speed,  degvec, pieceA,pieceB, spieceA,spieceB)
		dspeed=speed*2
		qspeed=speed*1.25
		qinspeed=speed*1.6
		hspeed=speed/2
		Sleep(delay)
	
	local OffSetMinus=offSetX*-1
			
		if sPieceA then
			while true do
		
				while boolWalk== true do
				Sleep(200)
				val=OffSetMinus+math.random(-42,-36)+math.random(1,degvec)
				Turn(pieceA,x_axis,math.rad(val),speed)
				Turn(spieceA,x_axis,math.rad(val),speed)
				val=math.random(-42,-36)
				Turn(pieceB,x_axis,math.rad(val),speed)
				Turn(spieceB,x_axis,math.rad(val),speed)
				
				WaitForTurn(pieceA,x_axis)	
				vh=OffSetMinus+val/2
				Turn(pieceA,x_axis,math.rad(vh),hspeed)
				Turn(spieceA,x_axis,math.rad(vh),hspeed)
				Turn(spieceA,x_axis,math.rad(0),qspeed)
				Turn(pieceB,x_axis,math.rad(0),	qspeed)
				Turn(spieceB,x_axis,math.rad(0),qspeed)
				WaitForTurn(pieceA,x_axis)	
				
				val=OffSetMinus+math.random(36,42)+math.random(1,degvec)
				Turn(pieceA,x_axis,math.rad(val),qinspeed)
				Turn(spieceA,x_axis,math.rad(val),qinspeed)
				
				val=math.random(36,50)
				Turn(pieceB,x_axis,math.rad(val),dspeed)
				Turn(spieceB,x_axis,math.rad(val),dspeed)
				Turn(pieceB,x_axis,math.rad(val/2),hspeed)	
				Turn(spieceB,x_axis,math.rad(val/2),hspeed)	
				Turn(pieceA,x_axis,		math.rad(OffSetMinus),speed)
				Turn(spieceA,x_axis,	math.rad(OffSetMinus),speed)
				Turn(pieceB,x_axis,		math.rad(OffSetMinus),speed)
				Turn(spieceB,x_axis,	math.rad(OffSetMinus),speed)
				WaitForTurn(pieceA,x_axis)	
				end
				
			Sleep(200)	
			end
		else
		
			while true do
				while boolWalk==true do
				Sleep(200)
				val=OffSetMinus+(math.random(-42,-36)+math.random(1,degvec))*-1
				Turn(pieceA,x_axis,math.rad(val),speed)		
				val=math.random(-42,-36)*-1
				Turn(pieceB,x_axis,math.rad(val),speed)			
				WaitForTurn(pieceA,x_axis)	
				valA=OffSetMinus+val/2
				Turn(pieceA,x_axis,math.rad(valA),hspeed)		
				Turn(pieceB,x_axis,math.rad(0),	qspeed)		
				WaitForTurn(pieceA,x_axis)	
				
				val=OffSetMinus+(math.random(36,42)+math.random(1,degvec))*-1
				Turn(pieceA,x_axis,math.rad(val),qinspeed)
			
				val= math.random(36,50)*-1
				Turn(pieceB,x_axis,math.rad(val),dspeed)		
				Turn(pieceB,x_axis,math.rad(val/2),hspeed)		
				Turn(pieceA,x_axis,math.rad(OffSetMinus),speed)
				Turn(pieceB,x_axis,math.rad(OffSetMinus),speed)
				
				WaitForTurn(pieceA,x_axis)	
				end	
				
		
			--Turn(pieceA,x_axis,math.rad(0),speed)
			Turn(pieceB,x_axis,math.rad(0),speed)	
			Sleep(250)	
			end
		end
	end
	
	function walk()

	for i=1,#SymPairArms,1 do
	StartThread(moveLeg,300*i, 3,  9, SymPairArms[i][1][1],SymPairArms[i][1][2], SymPairArms[i][2][1],SymPairArms[i][2][2])
	end
	for i=1,#LinArms,1 do
	StartThread(moveLeg,300*i, 3,  9, LinArms[i][1],LinArms[i][2])
	end
	
		while true do
			while boolWalk==true do
			Turn(center,x_axis,math.rad(offSetX+math.random(3,7)),0.9)
			WaitForTurn(center,x_axis)
			Turn(center,x_axis,math.rad(offSetX-math.random(3,7)),0.9)
			WaitForTurn(center,x_axis)
			end
			
		Sleep(500)
		end
	end
	

	local SIG_DELAYSTOP=4
	
	function script.StartMoving()
	boolWalk=true
	Signal(SIG_DELAYSTOP)

	end

	function delayedStop()
	SetSignalMask(SIG_DELAYSTOP)
	Sleep(500)
	boolWalk=false

	end
	
	function script.StopMoving()
			Signal(SIG_DELAYSTOP)
			StartThread(delayedStop)
			
	end

local 	boolWalk= false
local	boolAttack=false
------------------------------------------------------------------------------------UNITCODE	
weaponTable={}
local spCreateUnit=Spring.CreateUnit
 teamID=Spring.GetUnitTeam(unitID)
 gaiaID=Spring.GetGaiateamID

function script.HitByWeapon ( x, z, weaponDefID, damage )
if boolAttack==false then boolAttack=true end
	if WeaponDefID and not weaponTable[weaponDefIDj] and math.random(0,damage) < damage/2 then
		x,y,z=Spring.GetUnitPosition(unitID)
		if math.random(0,1)==0 then -- GaiaVaryfoo
		spCreateUnit("jvaryfoo",x,y,z, math.random(1,3), teamID)
		else --playerVaryFoo
		spCreateUnit("jvaryfoo",x,y,z, math.random(1,3), gaiaID)
		end
	end
return damage
end 
	
	function sound()
	local unitdef=Spring.GetUnitDefID(unitID)
	loudness=0.52
	local signum=-1
	local strings="sounds/VaryFoo/VaryFoo"
	local nrOfUnitsParallel=3
		while true do
		time=math.random(7000,12000)
		loudness=math.min(1,loudness+0.01*signum)
		
		
		if loudness >= 1 then signum=signum*-1 end
		if loudness < 0.52 then signum = 1 end
		
			if boolWalk ==true and boolAttack==false then
			
			dice=math.ceil(math.random(4,6))
			soundfile=strings..dice..".ogg"
			PlaySoundByUnitType(unitdef, soundfile,loudness, time, nrOfUnitsParallel)
				elseif boolAttack==true then
				boolAttack=false
				dice=math.ceil(math.random(2,3))
				soundfile=strings..dice..".ogg"
				PlaySoundByUnitType(unitdef, soundfile,loudness, time, nrOfUnitsParallel)
				end
		Sleep(16000)
		end
	end
	
	local BITDISTCONSTANT		=84
	local SNACKDISTANCECONSTANT	=42
	
	function eatThemAliveWhenNotWalking()
	--if the varyfoo is of team Gaia its allready taken care of by the ecology gadget
	if gaiaID== teamID then return end

	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	local spGetUnitNearestAlly=Spring.GetUnitNearestAlly
	local localGetUnitDistance=GetUnitDistance
	local spGetUnitDefID=Spring.GetUnitDefID
	local spGetUnitPosition=Spring.GetUnitPosition
	local spGetUnitsInCylinder=Spring.GetUnitsInCylinder

	local boolCannibalism=false
	
	local tabooTable={
					  [UnitDefNames["jvaryfoo"].id]=true,
					  [UnitDefNames["varyfootemple"].id]=true
					  }
		while true do
			--if walking, chew on everything within range
			if boolWalk==true then
			x,y,z=spGetUnitPosition(unitID)
			T=spGetUnitsInCylinder(x,z,SNACKDISTANCECONSTANT)
			
			table.remove(T,unitID)
				if T and #T > 0 then
				for i=1,#T do
					if tabooTable[spGetUnitDefID(T[i])] then T[i]=nil end 
				end

					if T and table.getn(T) > 0 then
					biteAnimation(T[math.random(1,#T)])	
					end
				end
			end
			
			--go and find yourself a nice snack
				if boolWalk==false then
				allyID, allyDistance=spGetUnitNearestAlly(unitID),0
				enemyID, enemyDistance=spGetUnitNearestEnemy(unitID),0
				
					if allyID or enemyID then
						if allyID and not tabooTable[spGetUnitDefID(allyID)]then
						allyDistance=localGetUnitDistance(unitID,allyID)	
						else
						--Find other things to eat- 
						-- if that fails eat another Varyfoo
						end
							--if enemy is infantry and moma is know then carryHimHomeLoop
							if GG.jAbyss_Moma and GG.jAbyss_Moma[unitID] and isInfantry[spGetUnitDefID(enemyID)] then
							MomaWillBeSoProud(enemyID,GG.jAbyss_Moma[unitID])	
							end
						
							if enemyID and not tabooTable[spGetUnitDefID(enemyID)]then
							enemyDistance=localGetUnitDistance(unitID,allyID)	
							end
							
							
						if allyDistance > enemyDistance then allyID=enemyID end
						
						x,y,z= spGetUnitPosition(allyID)
						ux,uy,uz= spGetUnitPosition(unitID)
							if x and ux then
							dist =GetTwoPointDistance(x,y,z,ux,uy,uz)
								if dist < BITDISTCONSTANT then
								biteAnimation(allyID)
								else
								Spring.SetUnitMoveGoal(x,y,z,unitID)
								end
							end
					end
				end
		Sleep(2047)	
		end
	end
	
	isInfantry=getTypeTable({
		"bg",
		"vort",
		"skinfantry",
		"css",
		"tiglil",
		"gcivillian"
	},UnitDefNames)
	
	
	local spSpawnCEG=Spring.SpawnCEG
	if not GG.VaryFooFeeding then GG.VaryFooFeeding={} end
	
	function MomaWillBeSoProud(enemyID, MomaID)
	local spValidUnitID=Spring.ValidUnitID
	local spGetUnitPosition=Spring.GetUnitPosition
	local spUnitIsDead=Spring.GetUnitIsDead
	
	x,y,z=spGetUnitPosition(MomaID)
		while (spValidUnitID(enemyID) and spUnitIsDead(enemyID)==false) do	
			
		Spring.SetUnitMoveGoal(unitID,x,y,z)
		Sleep(500)
		mx,my,mz=spGetUnitPosition(unitID)
			--we are there --suppertime
			if math.abs(x-mx)+ math.abs(y-my)+math.abs(z-mz) <75 then
			Spring.DestroyUnit(enemyID,true,false)
			end
		end
	end
	
	function biteAnimation(victimID)
		if not GG.VaryFooFeeding[unitID] then 
		GG.VaryFooFeeding[unitID] = 0.001 
			else
			GG.VaryFooFeeding[unitID] =math.min(1,GG.VaryFooFeeding[unitID] +0.05) 
			end
	-- we set the unit to attack the victim 
	ox,oy,oz=Spring.GetUnitPosition(unitID)
	vx,vy,vz=Spring.GetUnitPosition(victimID)
	-- Set a Projectile Racing Towards the  Victim
		dx,dy,dz=(ox-vx)/8,(oy-vy)/8,(oz-vz)/8	
		for i=1,8 do
			midX,midY,midZ=vx+dx*i,vy+dy*i,vz+dz*i
			spSpawnCEG("gdshadows",midX,midY,midZ,0,1,0,50)
		end
		
		for i=1,8 do
			if math.random(0,1)==1 then
				spSpawnCEG("bloodsplat",vx+math.random(-25,25),vy+math.random(0,75),vz+math.random(-25,25),0,1,0,50)
			else
				spSpawnCEG("jvaryfoohit",vx+math.random(-25,25),vy+math.random(0,75),vz+math.random(-25,25),0,1,0,50)
			end
		end
		

	end
	
	----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center 
end

function script.AimWeapon1( heading ,pitch)	

	return true

end

function script.FireWeapon1()	
	return true
end

	