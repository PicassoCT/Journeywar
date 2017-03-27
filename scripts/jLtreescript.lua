include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_jw.lua" 



local INFLUENCERADIUS=120
NUMBEROFPIECES=56
damagePerSecond=1

udef=Spring.GetUnitDefID(unitID)
boolVaryFooTree=false
if udef and udef == UnitDefNames["jtree49"].id then
	NUMBEROFPIECES=30
	boolVaryFooTree=true
end
-->>PieceDefinitions<<--

center=piece"center"

fruits={}
for i=1,4 do
	name="fruit"..i
	fruits[i]=piece(name)
end

TreePiece={}
EndPiece={}

for i=1, NUMBEROFPIECES do
	name="Treepiec"..i
	namet="E"..i
	TreePiece[#TreePiece+1]=piece(name)
	EndPiece[#EndPiece+1]=piece(namet)
end


function divcompare(it,val,pos)
	if math.abs(val-pos)>500 then Spring.Echo("Node behaving badly"..it-1) end
	
end


function TreeTrample()
	
	for i=1, NUMBEROFPIECES do
		if maRa()==true then 
			StartThread(DropPieceToGround,
			unitID,TreePiece[i],
			35,
			true,
			true,
			Spring.UnitScript.Explode ,
			SFX.FALL+SFX.NO_HEATCLOUD)
			--drop to the ground
		end
	end
	
	Spring.DestroyUnit(unitID,true,false)
end

RADOFPIECE=15
SIZEOFPIECE=math.random(10,22)
-->>/PieceDefinitions<<--



function script.Create()
	
	--functions to hide Tables
	hideT(TreePiece)
	hideT(EndPiece)
	--reset Table of Pieces
	resetT(TreePiece)
	reset(center,0)
	StartThread(BuildLtree)
	StartThread(foulTheSurroundings)
	StartThread(playSoundByUnitTypOS,unitID,0.5,{
		{name="sounds/jtree/accidtrees.ogg",Time=15000}
	})
	
	StartThread(delayedActivation)
	StartThread(deactivateAndReturnCosts,unitID,UnitDefs,0.25+0.125)
end
function placeFollowUps(X,Z,sizeOfPlant,maxDist,i)
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
FixFunctionTabel={}

-- Turn the whole plant into a Ball Weed
FixFunctionTabel[1]=	function ()
	Spring.Echo("FixFunctionTabel::BallWheed")
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
FixFunctionTabel[2]= function ()
	resetT(TreePiece)
	Spring.Echo("FixFunctionTabel::Centrallized Colony")
	
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
FixFunctionTabel[3]= function ()
	Spring.Echo("FixFunctionTabel::FruitArcs")
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
FixFunctionTabel[4]= function ()
	resetT(TreePiece)
	
	Spring.Echo("FixFunctionTabel::FruitField")
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
FixFunctionTabel[5]= function ()
	
	Spring.Echo("FixFunctionTabel::FruitTongue")
	local spGetGroundHeight=Spring.GetGroundHeight
	totalIndex=0
	relativeIndex=11
	HeightIndex=0
	halfHeight,quarterheight=SIZEOFPIECE/2,SIZEOFPIECE/4
	PrevPosTable={}
	PrevPosTable[1]={x=0,y=0,z=0}
	for i=2,relativeIndex, 1 do
		PrevPosTable[i]={x=PrevPosTable[i-1].x 	+math.random(-1* quarterheight,quarterheight), 
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
FixFunctionTabel[6]=	function ()
	Spring.Echo("FixFunctionTabel::Spiraltree")
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
		
		AddOn=math.random(15,50)/10
		
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
		--MovePieceoPieceUnitSpace(unitID, TreePiece[i+1],PrevPiece,0,true)					
		Sleep(1)
	end
	
	return false
end


-- Turn the whole plant into a Ground Ball Weed(s)
FixFunctionTabel[7]=	function ()
	Spring.Echo("FixFunctionTabel::GroundBallWheed")
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
FixFunctionTabel[8]=	function ()
	Spring.Echo("FixFunctionTabel::RingWeed")
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
			movePieceToPiece(TreePiece[k],AddonPiece,0)
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
FixFunctionTabel[9]=	function ()
	Spring.Echo("FixFunctionTabel::Suckyball")
	showT(TreePiece)
	showT(EndPiece)
	x,y,z=Spring.GetUnitPosition(unitID)
	
	PiecesToGrowUpon={}
	PiecesToGrowUpon={EndPiece[1],EndPiece[2]}
	
	--first and last row have equal number of pentagons and hexagons
	--2:1 hexagons : pentagons 
	for i=3,NUMBEROFPIECES,1 do
		movePieceToPiece(TreePiece[i],PiecesToGrowUpon[math.random(1,#PiecesToGrowUpon)],0)
		turnPieceRandDir(TreePiece[i],0, 90,0,360,0,90,0)
		WaitForTurn(TreePiece[i],x_axis)
		WaitForTurn(TreePiece[i],y_axis)
		WaitForTurn(TreePiece[i],z_axis)
		table.insert(PiecesToGrowUpon,EndPiece[i])
	end
	
	return true
end

--StarPlants
FixFunctionTabel[10]=	function ()
	Spring.Echo("FixFunctionTabel::StarPlants")
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
FixFunctionTabel[11]= function ()
	Spring.Echo("FixFunctionTabel::Spiraltree")
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


FixFunctionTabel[12]= function ()
	Spring.Echo("FixFunctionTabel::CircleTree")
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


ux,uy,uz= Spring.GetUnitPosition(unitID)
EndPointReservoir={}
--free Form Function function
FixFunctionTabel[13]= function ()
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

--"Bow Fern Function"
FixFunctionTabel[14]= function ()
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
FixFunctionTabel[15]= function ()
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


FixFunctionTabel[16]= function ()
	Spring.Echo("FixFunctionTabel::BowTie")
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


FixFunctionTabel[17]= function ()
	Spring.Echo("FixFunctionTabel::TriTree")
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
			movePieceToPiece(TreePiece[j],CurrEndPoint,0)
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
FixFunctionTabel[18]= function ()
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
FixFunctionTabel[20]= function ()
	Spring.Echo("FixFunctionTabel::Airroot")
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
FixFunctionTabel[21]= function ()
	Spring.Echo("FixFunctionTabel::Cylinder")
	
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
FixFunctionTabel[19]= function ()
	Spring.Echo("FixFunctionTabel::Floater")
	
	showT(TreePiece)
	showT(EndPiece)
	resetT(TreePiece)
	
	Deg={x=0,y=0,z=0}
	
	floaterStem=math.ceil(math.random(5,10))
	for i=2,floaterStem do
		movePieceToPiece(TreePiece[i],EndPiece[i-1],0)
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
FixFunctionTabel[22]=	function ()
	Spring.Echo("FixFunctionTabel::Helixtree")
	
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
		distance=7*i
		Move(TreePiece[i],y_axis,distance,0)
		Move(TreePiece[i+1],y_axis,distance,0)
		
		Turn(TreePiece[i],x_axis,math.rad(90),0)
		Turn(TreePiece[i+1],x_axis,math.rad(90),0)
		Turn(TreePiece[i],y_axis	,left,0)
		Turn(TreePiece[i+1],y_axis	,right,0)
		left=left+DeltaV
		right=right+DeltaV
	end
	
	return true
end

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
		detTurnStoreTable[index]= math.random(maxindex,180)	/maxindex
		return detTurnStoreTable[index]*4, (detTurnStoreTable[index]*360) %(index*270)+math.random(0,10)
	end
end

detMoveStoreTable={}
function deterministicMove(index,maxindex)
	if index > maxindex and detMoveStoreTable[(index%maxindex)+1] then --not first round
		index=(index%maxindex)+1
		return detMoveStoreTable[index]
	else
		detMoveStoreTable[index]= math.floor(math.random(1,maxindex))	
		return detMoveStoreTable[index]
	end
	return math.floor(math.random(1,maxindex))	
end



--concatenates some random gramarRules, thus really creating new form of plants
function getRandomGramarProcution(ElementTable, NrOfElements, Recursionstart, RecursionEnd)
	Product=""
	for i=1,NrOfElements do
		if maRa()==true then 
			
			if maRa()==true then 
				Product=Product..(ElementTable[math.random(1,#ElementTable)])
			else
				Product=(ElementTable[math.random(1,#ElementTable)])..Product
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
				Turn(Tpiece,x_axis,math.random(-1*math.abs(olddeg),math.abs(degree)))
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

GlobalTotalItterator=1
RecursionEnd={}
GlobalStepd=1

--this table works as a lock - [recursionstep] = number of threads in it
GlobalInCurrentStep={}




--	this function needs a global Itterator and but is threadsafe, as in only one per unit
--	it calls itself, waits for all other threads running parallel to reach the same recursion Depth
-- 	once hitting the UpperLimit it ends
function executeLindeMayerSystem( gramarTable,String, oldDeg, Degree , UpperLimit, recursionDepth,recursiveItterator,PredPiece)
	
	-- this keeps all recursive steps on the same level waiting for the last one - who releases the herd
	gainLock(recursiveItterator)
	
	--we made it into the next step and get our piece
	GlobalTotalItterator=GlobalTotalItterator+1
	local hit=GlobalTotalItterator
	
	if not hit or TreePiece[hit] == nil or hit > UpperLimit then 
		releaseLocalLock(recursiveItterator)
		return 
	end
	
	
	--DebugInfo
	--Spring.Echo("Level "..recursiveItterator.." Thread waiting for Level "..(recursiveItterator-1).. " to go from ".. GlobalInCurrentStep[recursiveItterator-1].." to zero so String:"..String.." can be processed")
	
	while GlobalInCurrentStep[recursiveItterator-1] > 0 do	
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
	--Recursion Lock - the last one steps the Global Itteration a level up
	
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
	if GlobalInCurrentStep[recursiveItterator]== nil then GlobalInCurrentStep[recursiveItterator]= 0 end
	GlobalInCurrentStep[recursiveItterator]=GlobalInCurrentStep[recursiveItterator]+1
	--this muders the recursion start case
	if not GlobalInCurrentStep[recursiveItterator-1] then 
		GlobalInCurrentStep[math.max(0,recursiveItterator-1)] =0 
	end
end

function releaseLocalLock(recursiveItterator)
	if GlobalInCurrentStep[recursiveItterator]== nil then GlobalInCurrentStep[recursiveItterator]=0 end
	GlobalInCurrentStep[recursiveItterator]= GlobalInCurrentStep[recursiveItterator]-1
	if GlobalInCurrentStep[recursiveItterator] <= 0 then	GlobalStep=recursiveItterator+1 end
end

local amountToStore=900

function materialShowHide()
	local it=GlobalTotalItterator
	teamID=Spring.GetUnitTeam(unitID)
	local aNibble=math.ceil(amountToStore/it)
	local NrOfNibblesStored=0
	
	local spGetTeamRessources=Spring.GetTeamResources
	while true and boolJustOnceDeny ==true do 	 
		currentLevel,storage,pull,income,expense,share,sent,received =spGetTeamRessources(teamID,"metal")
		--surplus store
		while currentLevel >= storage-aNibble do 
			currentLevel,storage,pull,income,expense,share,sent,received =spGetTeamRessources(teamID,"metal")
			--consume a Nibble
			if NrOfNibblesStored < it and boolJustOnceDeny ==true then
				if Spring.UseUnitResource(unitID,"m",aNibble)==true then
					NrOfNibblesStored=math.min(it,NrOfNibblesStored+1)
				end
			end
			showT(TreePiece,1,NrOfNibblesStored,600)
			
			--ShowTheCorrespondingPiece
			Sleep(1900)
		end
		
		--surplus release
		while currentLevel < storage-12*aNibble and NrOfNibblesStored > 0 and boolJustOnceDeny ==true do
			currentLevel,storage,pull,income,expense,share,sent,received =spGetTeamRessources(teamID,"metal")
			if NrOfNibblesStored > 1 then
				NrOfNibblesStored=math.max(1,NrOfNibblesStored-1)
				Spring.AddUnitResource(unitID,"m",aNibble)
			end
			hideT(TreePiece,NrOfNibblesStored,#TreePiece,400)
			Sleep(1900)
		end
		Sleep(1900)
	end
end

function script.Killed(recentDamage,_)
	
	createCorpseJBuilding(unitID, recentDamage)
	return 1
end

HP=Spring.GetUnitHealth(unitID)
aChunk=math.ceil(HP/NUMBEROFPIECES)
lastChunk=NUMBEROFPIECES
function script.HitByWeapon ( x, z, weaponDefID, damage )
	hp=Spring.GetUnitHealth(unitID)
	currentChunk=math.ceil(hp/aChunk)
	if currentChunk < lastChunk then
		lastChunk=currentChunk
		Explode(TreePiece[currentChunk],SFX.FALL+SFX.NO_HEATCLOUD)
		Hide(TreePiece[currentChunk])
	end
	return damage
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

function BuildLtree()
	
	boolTakeATurn=true
	--	if not GG.TestNumber then GG.TestNumber= 1 else GG.TestNumber=(GG.TestNumber%#FixFunctionTabel)+1 end
	if math.random(0,3)==1 and boolVaryFooTree == false then 
		max=#FixFunctionTabel+0.4999 
		--boolTakeATurn=FixFunctionTabel[18]()
		boolTakeATurn=FixFunctionTabel[math.floor(math.random(1,max))]()
		--boolTakeATurn=FixFunctionTabel[22]()
		--	boolTakeATurn=FixFunctionTabel[GG.TestNumber]()
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
		GlobalStep=1
		
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
	
	
	
	for i=1,#GlobalInCurrentStep, 1 do
		if GlobalInCurrentStep[i] and GlobalInCurrentStep[i] ~= 0 then
			--Spring.Echo("Still somebody at Recursionlevel"..i)
			Sleep(2000)
			i=1
		end
		
	end
	--Spring.Echo("TotalPieces used"..GlobalTotalItterator)
	
	if boolTakeATurn==true then
		Turn(center,y_axis,math.rad(math.random(0,360)),0,true)
		Turn(center,x_axis,math.rad(math.random(-5,5)),0,true)
	end
	
	StartThread(materialShowHide)
end

accidTreeDefID=Spring.GetUnitDefID(unitID)
imuneIDs=getFungiImuneUnitTypeTable(UnitDefNames)



function foulTheSurroundings ()
	
	while true do
		T= getInCircle(unitID,255)
		if T and table.getn(T) > 0 then
			process(T, function (unit)
				defID=Spring.GetUnitDefID(unit)
				if defID and not imuneIDs[defID] then
					hp=Spring.GetUnitHealth(unit)
					Spring.SetUnitHealth(unit,hp-math.abs(damagePerSecond))
				end
			end)	
		end
		Sleep(900)
	end
	
	
end

boolDenialActive=false

function delayedActivation()
	health, maxHealth, paralyzeDamage, captureProgress, bp=Spring.GetUnitHealth(unitID)
	
	while bp and bp < 1 do
		health, maxHealth, paralyzeDamage, captureProgress, bp=Spring.GetUnitHealth(unitID)
		Sleep(200)
	end
	Sleep(1000)
	boolDenialActive=true
end



function script.Activate()
	if boolDenialActive == true then
		setDenial(unitID)
		return 1
	end
end

function script.Deactivate()
	
	
	return 0
end