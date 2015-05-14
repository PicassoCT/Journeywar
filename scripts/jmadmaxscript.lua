	include "suddenDeath.lua"
	include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 

	
	AllReadyUsed={}
	center=piece"center"
	--Lego
	--all the yet unused LegoPieces
	LegoPieces={}
	ConPieces={}
	DoubleLegoPieces={}
	LegoID=1
	DoubleMax=16
	LegoMax=22
	
	--Connection pieces for linear Connections only
	for i=1,LegoMax,1 do
		
		LegoPieceName="Lego"..i.."s2"
		LegoPieces[i]=piece(LegoPieceName)
		
		--add the linear connections
		ConPieces[LegoPieces[i]]={}
		ConPieces[LegoPieces[i]].Symetric={}
		ConPieces[LegoPieces[i]].Linear={}
		
			for j=1,4,1 do
			name="lcon"..i..j
			ConPieces[LegoPieces[i]].Linear[j]={}
			ConPieces[LegoPieces[i]].Linear[j]=piece(name)
			end
		--add the symetric connections
			
			for j=1,2,1 do
			name="scon"..i..j
			ConPieces[LegoPieces[i]].Symetric[j]=piece(name)
			end
			
	--	--Spring.Echo("JW:VaryFoo:SymetricConections"..table.getn(ConPieces[LegoPieces[i]].Symetric))
			
		Move(LegoPieces[i],x_axis,0,0)
		Move(LegoPieces[i],z_axis,0,0)
		Move(LegoPieces[i],y_axis,0,0)
		
		if i < DoubleMax and i %2 ==0 then
		DoubleLegoPieces[#DoubleLegoPieces+1]={k=LegoPieces[i-1],v=LegoPieces[i]}
	
											
		end
	end
	
	--Wheel
	WheelPieces={}
	DoubleWheelPieces={}
	WheelCon={}
	WheelMax=12
	LinWheelMax=4 --Wheels that can be used for linear expansion
	ExclusiveSymmetricWheel={}
	WheelTable={}
		for i=1,WheelMax,1 do
		
		LegoPieceName1="Wheel"..i.."1"   --Uper  Wheel
		LegoPieceName2="Wheel"..i.."2"   --Lower Wheel
		LegoPieceName3="WheelPoM"..i
		WheelPieces[i]={}
		WheelPieces[i][1]=	piece(LegoPieceName1)
		WheelPieces[i][2]=	piece(LegoPieceName2)
		WheelPieces[i][3]=	piece(LegoPieceName3)
		Hide(WheelPieces[i][1])
		Hide(WheelPieces[i][2])
	
		
		--add the linear connections
		
			if i < WheelMax and i %2 ==0 then
			DoubleWheelPieces[#DoubleWheelPieces+1]={k=WheelPieces[i-1],v=WheelPieces[i]			}
			end
		
	
		end

	--CockPit
	CockPitPieces={}
	DoubleCockPitPieces={}
	CockPitCon={}
	CockPitMax=8
	
		for i=1,CockPitMax,1 do
		
		LegoPieceName="CockPit"..i
		CockPitPieces[i]=piece(LegoPieceName)
		Hide(CockPitPieces[i])
		LegoPieceName="CockPitCon"..i
		CockPitCon[i]=piece(LegoPieceName)
		--add the linear connections
		
		if i < CockPitMax and i %2 ==0 then
		DoubleCockPitPieces[#DoubleCockPitPieces+1]={k=CockPitPieces[i-1],v=CockPitPieces[i]			}											
		end
		

		end

	--DECO
	DecoPieces={}
	DoubleDecoPieces={}
	
	DecoMax=16
	DecoDouble=4
	for i=1,DecoMax,1 do
		
		LegoPieceName="Deco"..i
		DecoPieces[i]=piece(LegoPieceName)
		--add the linear connectionsk
		
		if i < DecoMax and i %2 ==0 then
		DoubleDecoPieces[#DoubleDecoPieces+1]={k=DecoPieces[i-1],v=DecoPieces[i]			}							
		end
	Hide(DecoPieces[i])

	end
-------------------------------------------------------------------EndOfPieceDelcarations-----------
	--Contains all Connections exposed by allready used LegoParts 
	--every added Symetric ConnectionPoint is parallel such as [1] <-> [2] form a symetric pair
	SymLegoCon={}
	LinLegoCon={}


	function turnPieceInRandDir(pie,dirVec,SymSideVal,symPiece)
	
	minx,maxx,miny,maxy,minz,maxz=dirVec.minx,dirVec.maxx,dirVec.miny,dirVec.maxy,dirVec.minz,dirVec.maxz
	
	x=(math.random(minx,maxx)%8)*45
	z=(math.random(minz,maxz)%8)*45
	y=(math.random(miny,maxy)%8)*45
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
	end
	
		
	return x,y,z
	end

--								Socket,ConectionSocket,LegoPiece
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
		for i=1,WheelMax,1 do
		Hide(WheelPieces[i][1])
		Hide(WheelPieces[i][2])
		end
	hideT(LegoPieces)
	
	--hideT(CockPitPieces)
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
			LinLegoCon[#LinLegoCon+1]=LinearCon[i]	
			end
		end
		
		if SymCon and (boolAddSymetrics==nil or boolAddSymetrics==true ) then
				--	--Spring.Echo("JW:LinearSymetricSockets Added")
					num=table.getn(SymLegoCon)+1
					SymLegoCon[num]={}
					SymLegoCon[num][1]=SymCon[2]
					SymLegoCon[num][2]=SymCon[1]		
		end	
	end
	
	function SymAddPieceSocketsToPool(piece,sympiece)
	local LinearCon=ConPieces[piece].Linear
	local LinearConS=ConPieces[sympiece].Linear
	local SymCon=ConPieces[piece].Symetric
	local SymConS=ConPieces[sympiece].Symetric
	
		if LinearCon then
			for i=1,#LinearCon, 1 do
			SymLegoCon[#SymLegoCon+1]=	{
										[1]=LinearCon[i],
										[2]=LinearConS[i]	
										}
			end
		end
	
		if SymCon then
			for i=1,#SymCon, 1 do
			SymLegoCon[#SymLegoCon+1]=	{
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
	
		Move(LegoPieces[1],x_axis,0,0,true)	
		Move(LegoPieces[1],y_axis,0,0,true)	
		Move(LegoPieces[1],z_axis,0,0,true)	
		Show(LegoPieces[1])
		LinAddPieceSocketsToPool(LegoPieces[1],true)
		turnPieceInRandDir(LegoPieces[1],makeDirVecFromDeg(180,180,0,0,0,0),1)
		
		usedPiece(LegoPieces[1])
		
    end
	
	function DoubleCheckPiece(tablename)
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

	
	function rollDice(max)
	return math.random(1,max),math.random(1,max)
	end
	
	--FindPiece -FindSocket -- LinAddPieceSocketsToPool
	function LinearExpandPiece()
	LegoDice	= math.random(1,table.getn(LegoPieces))
	LegoPiece	= LegoPieces[LegoDice]
	SocketDice	= math.random(1,table.getn(LinLegoCon))
	Socket 	  	= LinLegoCon[SocketDice]
	
		if  not AllReadyUsed[LegoPiece] and not AllReadyUsed[Socket] then
		randomVec=makeDirVecFromDeg(180,180,0,0,0,0)
		Show(LegoPiece)

		conPieceCon2Socket(Socket,LegoPiece,randomVec)
		LinAddPieceSocketsToPool(LegoPiece,true)	
		
		Show(LegoPiece)
		usedPiece(LegoPiece)
		usedPiece(Socket)
		return 1
		end
		
	return 0
	end
	
	function getPairNrSymLegoCon(nr)
		if SymLegoCon[nr] and not AllReadyUsed[SymLegoCon[nr][1]] and not AllReadyUsed[SymLegoCon[nr][2]] then
		return SymLegoCon[nr][1],SymLegoCon[nr][2]	
		end
	end
	
	
	function SymmetricExpand(pieceA,pieceB,dirVec)
	--Spring.Echo("JW:VaryFoo:SymetricExpanding_1 >>"..table.getn(SymLegoCon))
	rEchoTable(SymLegoCon)
	--TODO
		if  SymLegoCon and table.getn(SymLegoCon) > 0 then
		--Spring.Echo("JW:SymetricExpand_1.5")
		dice=math.floor(math.random(1,math.max(1,table.getn(SymLegoCon)	)))
		socketA,socketB=getPairNrSymLegoCon(dice)
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
	

	function findInSymLegoCon(piecename)
		for i=1,table.getn(SymLegoCon),1 do
			if SymLegoCon[i][1]==piecename or SymLegoCon[i][2]==piecename then
			return i
			end
		end
	end
	
	function usedPiece(piecename)
	AllReadyUsed[piecename]=true
	table.remove(LinLegoCon,piecename)
	i=findInSymLegoCon(piecename)	
	if i then table.remove(SymLegoCon,i) end
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
	
		for i=1,#LinLegoCon, 1 do
			x,y,z,piecename=accessCache(LinLegoCon[i])
			if z then
				if z > X  then
				X=z			
				ShorTerMem=piecename
				end
			else
			x,y,z=Spring.GetUnitPiecePosition(unitID,LinLegoCon[i])
			insertCache(LinLegoCon[i],z,y,x)
			
				if z > X then
				X=z
				ShorTerMem=LinLegoCon[i]
				end
			end
		end
	--StartThread(DeBugPieceLight,ShorTerMem)
	return ShorTerMem
	end
	
	function getSymCockPitCon()
	--find two SymLegoCon who are frontal 
	end
	
	function DeBugPieceLight(piecename)
		while true do
		EmitSfx(piecename,1025)
		Sleep(250)
		end
	end
	
	--attaches a AlienCockPit linear to the Lego
	function LinearExpandCockPit(offSetX)
		CockPitDice=math.random(1,table.getn(CockPitPieces))
		CockPit=CockPitPieces[CockPitDice]

		Socket=LinFindFrontCon()
	
		if  AllReadyUsed[CockPit] == nil and AllReadyUsed[Socket]== nil then
		randomVec=makeDirVecFromDeg(0,25,0,0,0,0,offSetX)
		Show(CockPit)

		conPieceCon2Socket(Socket,CockPit,randomVec)
		usedPiece(CockPit)
		usedPiece(Socket)
		return 1
		end
		
	return 0
	end

	function SymmetricExpandCockPit(pieceA,pieceB,offSetX)
		if SymLegoCon and table.getn(SymLegoCon) > 0 then
		
			socketA,socketB=getSymCockPitCon()
		
		

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

function LinearExpandWheel()
		WheelDice=math.random(1,LinWheelMax)
		Wheel=WheelPieces[WheelDice]
		SocketDice=math.random(1,table.getn(LinLegoCon))
		Socket=LinLegoCon[SocketDice]
	
		if  AllReadyUsed[Wheel] == nil and AllReadyUsed[Socket]== nil then
		randomVec=makeDirVecFromDeg(0,0,0,0,0,0,0)
		Show(Wheel[1])
		Show(Wheel[2])

		conPieceCon2Socket(Socket,Wheel[1],randomVec)
		usedPiece(Wheel[1])
		usedPiece(Wheel[2])
		usedPiece(Socket)
		return Wheel
		end
		
	return -1

	end

	function SymetricExpandWheel(WheelTableA,WheelTableB )

		if SymLegoCon and table.getn(SymLegoCon) > 0 then
			dice=math.floor(math.random(1,math.max(1,#SymLegoCon)	))
			socketA,socketB=getPairNrSymLegoCon(dice)
			
				if socketA then 
				table.remove(SymLegoCon,socketA)
				table.remove(SymLegoCon,socketB)
			
					if  AllReadyUsed[WheelTableA[1]] == nil and AllReadyUsed[WheelTableB[1]] ==  nil then
					Show(WheelTableA[1])
					Show(WheelTableA[2])
					Show(WheelTableB[1])	
					Show(WheelTableB[2])	
					
					dirVec=makeDirVecFromDeg(0,0,0,0,0,0)

					sconPieceCon2Socket(socketA,WheelTableA[1], dirVec, true)
					sconPieceCon2Socket(socketB,WheelTableB[1], dirVec, false)
					
					turnPieceInRandDir(WheelTableA[1],dirVec,1,WheelTableB[1])
					usedPiece(socketA)
					usedPiece(socketB)
					usedPiece(WheelTableA[1])
					usedPiece(WheelTableA[2])
					usedPiece(WheelTableB[1])
					usedPiece(WheelTableB[2])
					return WheelTableA,WheelTableB
					end
				end
		end

	end
	
	function buildAVaryFoo()
	--Nr of Pieces Used to build this VaryFoo
	Legodice=3

	if not GG.VaryFooPieceMax then GG.VaryFooPieceMax={} end

	if not GG.VaryFooPieceMax[teamID] then 
	GG.VaryFooPieceMax[teamID]=6 
	end
	
	LegoMax=GG.VaryFooPieceMax[teamID]
	hp, maxhp=Spring.GetUnitHealth(unitID)
	Spring.SetUnitHealth(unitID,hp,maxhp*math.ceil(6/GG.VaryFooPieceMax[teamID]))
	
	if math.random(0,1)==1 then
	Legodice=math.ceil(math.random(3,LegoMax))
	else
	Legodice=math.ceil(math.random(3,math.ceil(LegoMax/2)))
	end
	LegoNum=1
		
	Max=math.random(4,#LegoPieces)
	
	linConLimit=rollDice(Max)
	symConLimit=rollDice(Max/2)
	--Lego
	while LegoNum < Legodice and existsParts(LegoPieces)==true do
	-- while there exist  LegoParts2 and numberOfLegoPiecesUsed <Legodice
		--dice usage as a linear connector
		if  linConLimit < math.random(1,Max) then
		--FindPiece -FindSocket -- LinAddPieceSocketsToPool
		LegoNum=LegoNum+LinearExpandPiece()
		else
			--Check if on of them is existing twice
	-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
			pieceA,pieceB=DoubleCheckPiece(DoubleLegoPieces)		
			if pieceA and pieceB and symConLimit < math.random(1,Max)  then
			LegoNum=LegoNum+SymmetricExpand(pieceA,pieceB)	
				else -- apply remainging LegoParts linear			
				LegoNum=LegoNum+LinearExpandPiece()			
				end
		end

	end

	--Wheel
	Wheeldice=math.ceil(math.random(3,WheelMax))
	WheelNum=0
	
	--Add at least one symetric Pair
	pieceA,pieceB=DoubleCheckPiece(DoubleWheelPieces)		
	WheelA,WheelB=SymetricExpandWheel(pieceA,pieceB)	
	table.insert(WheelTable,WheelA)
	table.insert(WheelTable,WheelB)
	WheelNum=WheelNum+2
	
		while WheelNum < Wheeldice and existsParts(WheelPieces)==true do
		-- while there exist  LegoParts2 and numberOfLegoPiecesUsed <Wheeldice
		--Spring.Echo("Exit the Loop2")
			--dice usage as a linear connector
			if  boolAtLeastOnePair== true and linConLimit < math.random(1,Max) then
			--FindPiece -FindSocket -- LinAddPieceSocketsToPool
			--Spring.Echo("JW:LinearExpand")
				res=LinearExpandWheel()
				if res then
				WheelNum=WheelNum+1
					if res ~= -1 then table.insert(WheelTable,res)	end
				end
			else
				--Check if on of them is existing twice
				-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
				pieceA,pieceB=DoubleCheckPiece(DoubleWheelPieces)		
				if  pieceA and pieceB and symConLimit < math.random(1,Max)  then
				--Spring.Echo("JW:SymetricExpand")
				WheelA,WheelB=SymetricExpandWheel(pieceA,pieceB)	
				table.insert(WheelTable,WheelA)
				table.insert(WheelTable,WheelB)
				WheelNum=WheelNum+2
				boolAtLeastOnePair=true
				else -- apply remainging LegoParts linear			
					res=LinearExpandWheel()
					if res then
					WheelNum=WheelNum+1
						if res ~= -1 then table.insert(WheelTable,res)	end
					end
			
				end
			end
		end
	alignLegsToGround()
	processAddedWheels()

	
	CockPitdice=math.ceil(math.random(1,CockPitMax))
	CockPitNum=0
	Max=CockPitMax
	--CockPit
			
	linConLimit,symConLimit=rollDice(Max)
	
	while CockPitNum < CockPitdice and existsParts(CockPitPieces)==true do
	CockPitNum=CockPitNum+1
		if  linConLimit < math.random(1,Max) then
		CockPitNum=CockPitNum+LinearExpandCockPit(offSetX)
		else
			--Check if on of them is existing twice
	-- if true then roll a dice for linear or symetric expansion (-maybe add linear rings later)
			pieceA,pieceB=DoubleCheckPiece(DoubleCockPitPieces)		
			if pieceA and pieceB and symConLimit < math.random(1,Max)  then
			CockPitNum=CockPitNum+SymmetricExpandCockPit(pieceA,pieceB,offSetX)	
			else -- apply remainging LegoParts linear			
			CockPitNum=CockPitNum+LinearExpandCockPit(offSetX)			
			end
		end
	end

--Not every Varyfoo needs deco	
	if math.random(0,1)==1 then
	decodice=math.ceil(math.random(1,DecoMax))
		decoNum=0
		Max=CockPitMax
		--CockPit
				
		linConLimit,symConLimit=rollDice(Max)
		
		while decoNum < decodice and existsParts(CockPitPieces)==true do
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
poinTable=piec2Point(LinLegoCon)
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
	
return LinLegoCon[index] 
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
	if SymLegoCon and table.getn(SymLegoCon) > 0 then
		
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
		if #WheelTable > 0 then
		rEchoTable(WheelTable)
		local spGetUnitPiecePos=Spring.GetUnitPiecePosition
		oldMaxDif=99999
		smallestIntervallSoFar=1	
		
			for i=1,360,3 do
			----Spring.Echo("JW:VaryFoo:Align"..i)
			Turn(center,x_axis,math.rad(i),0,true)
			
			IntervallMax,IntervallMin=0,0
			
					for j=1,#WheelTable, 1 do
					if WheelTable[j] and WheelTable[j][1] then
					Turn(WheelTable[j][1],x_axis,math.rad(-1*i),0,true)
					x,y,z=spGetUnitPiecePos(unitID,WheelTable[j][3])
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
				for i=1,table.getn(WheelTable), 1 do
				Turn(WheelTable[i][1],x_axis,math.rad(negVal),0,true)			
				end
				Turn(center,x_axis,math.rad(smallestIntervallSoFar),0,true)			
				WaitForTurn(center,x_axis)
				
					i=findLowestOfSet(WheelTable)
					_,centHeight,_=Spring.GetUnitPiecePosDir(unitID,center)
					x,y,z=Spring.GetUnitPiecePosDir(unitID,WheelTable[i][3])
					
					Move(center,y_axis,centHeight-y,0,true)
					
					
		offSetX=smallestIntervallSoFar
		end
	end
	

	function script.Killed(recentDamage,_)

	suddenDeathjBigCorpse(recentDamage)
	return 1
	end

	local SymPairWheels={}
	local LinWheels={}
	
	function processAddedWheels()
	temp={}
		for i=1,#WheelTable,1 do
		temp[WheelTable[i]]={}
		temp[WheelTable[i]]=WheelTable[i]
		end
	
		for i=1,#WheelTable,1 do
		--check wether the Wheel is in DoubleWheelPieces and its counterpart is in 
			if getValByKeyObj(DoubleWheelPieces,WheelTable[i]) and temp[getValByKeyObj(DoubleWheelPieces,WheelTable[i])] and not AllReadyUsed[temp[getValByKeyObj(DoubleWheelPieces,WheelTable[i])]] then
			SymPairWheels={[1]=WheelTable[i],
						 [2]= temp[getValByKeyObj(DoubleWheelPieces,WheelTable[i])],}
			else
			LinWheels[#LinWheels+1]=WheelTable[i]
			end
		end
		
	
	end
	
	function getValByKeyObj(Table,key)
	local T= Table
		for i=1,#T do
			if T.k== key then return T.v end
		end
	end

	
	function walk()

	
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

	
	----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function script.QueryWeapon1() 
	return center 
end

function script.AimWeapon1( CockPiting ,pitch)	

	return true

end

function script.FireWeapon1()	
	return true
end

	