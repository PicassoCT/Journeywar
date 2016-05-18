
include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

--The Pack
Pack={}
for i=1,9,1 do
	Pack[i]={}
	Pack[i][1]={} -- current Degree of this Wulf
	Pack[i][1]=0
	
	Pack[i][2]={} -- Rotator
	temp= "wulfRotate"..i
	Pack[i][2]= piece (temp)
	
	Pack[i][3]={} -- WulfInternRotator
	temp= "snoopDoggyDog"..i
	Pack[i][3]= piece (temp)
	
	Pack[i][4]={} -- Wulfbody
	temp= "dec"..i
	Pack[i][4]= piece (temp)
	
	for o=1,2,1 do
		
		Pack[i][4+o]={} -- Wulfbody
		temp= "decleg"..i
		x=o*2
		temp=temp..x
		Pack[i][4+o]= piece (temp)
	end
end
--/The Pack
GTits={}
HTits={}
for i=1, 6,1 do
	GTits[i]={}
	HTits[i]={}
	temp= "GTit"..i
	temp2= "HTit"..i
	GTits[i]=piece (temp)
	HTits[i]=piece (temp2)
	
end



deathpivot=piece"deathpivot"

-- Dangling Dangle

inertiaSwingX=0 --6
inertiaSwingZ=0 --7
inertiaSwingY=0 --8

inertiaSwingSpeedX=1.81 --6
inertiaSwingSpeedY=1.81 --7
inertiaSwingSpeedZ=2.41 --8
--pieces
allPieces={}
body = piece "body"
allPieces[#allPieces+1]=body
BHip = piece "BHip"
allPieces[#allPieces+1]=BHip
MomaT1 = piece "MomaT1"
allPieces[#allPieces+1]=MomaT1 
MomaT2	 = piece "MomaT2"
allPieces[#allPieces+1]=MomaT2	 
MomaT3 = piece "MomaT3"
allPieces[#allPieces+1]=MomaT3 
bUpR = piece "bUpR"
allPieces[#allPieces+1]=bUpR
bfootR	 = piece "bfootR"
allPieces[#allPieces+1]=bfootR
bfootL	 = piece "bfootL"
allPieces[#allPieces+1]=bfootL	 
bUpL	 = piece "bUpL"
allPieces[#allPieces+1]=bUpL	 
FHip = piece "FHip"
allPieces[#allPieces+1]=FHip
fUpL = piece "fUpL"
allPieces[#allPieces+1]=fUpL 
ffootL = piece "ffootL"
allPieces[#allPieces+1]=ffootL 
fUpR = piece "fUpR"
allPieces[#allPieces+1]=fUpR
ffootR	 = piece "ffootR"
allPieces[#allPieces+1]=ffootR
Head = piece "Head"
allPieces[#allPieces+1]=Head
jaw = piece "jaw"
allPieces[#allPieces+1]=jaw
EarL = piece "EarL"
allPieces[#allPieces+1]=EarL 
EarR = piece "EarR"
allPieces[#allPieces+1]=EarR
--/pieces
--Concept HiveHounds --add the
local SIG_HOWL=1
local SIG_MOVE=2
local SIG_LEG=4
local SIG_PACK=8
local SIG_IDLE=16
local SIG_HUNGRY=32

--var
local HiveHoundTable={}
--Definition HiveHoundTable [1]=UnitID
--Definition HiveHoundTable [2]=UnitDefID
local hiveHoundMax=5
local teamID=Spring.GetUnitTeam(unitID)

local ex,ey,ez= 0
local ux,uy,uz=Spring.GetUnitPosition(unitID)
local AttackDistance=400
local AvoidDistance=100
local DissolveRange=50

local fullHealth=Spring.GetUnitHealth(unitID)
local MeatRange=420
--var
nrOfDangle=12
currTur=0
otherColumnStartValue=6
Dangle={}

--embryo saugling wulfling teenager
for i=1, nrOfDangle,1 do
	Dangle[i]={}
	Dangle[i][1]={}
	tempPiece="Tit"..i
	Dangle[i][1]=piece (tempPiece)
	if (i > 0 and i < 4 ) or ( i > 6 and i < 10) then
		--add embryos and sucklings to the dangle
		Dangle[i][2]={}
		tempPiece="emb"..i
		Dangle[i][2]=piece (tempPiece)
		Dangle[i][3]={}
		tempPiece="Suk"..i
		Dangle[i][3]=piece (tempPiece)
		
		Dangle[i][14]={}
		tempPiece="Tail1"..i
		Dangle[i][14]=piece (tempPiece)
		
		
	else
		--add Wulfling and GrownUps
		
		Dangle[i][4]={}
		tempPiece="Wul"..i
		Dangle[i][4]=piece (tempPiece)
		Dangle[i][5]={}
		tempPiece="Grow"..i
		Dangle[i][5]=piece (tempPiece)
		Dangle[i][15]={}
		tempPiece="Tail2"..i
		Dangle[i][15]=piece (tempPiece)
		
		
		Dangle[i][16]={}
		tempPiece="Tail3"..i
		Dangle[i][16]=piece (tempPiece)
		
		
	end
	
	--the Dangles Future Turn
	Dangle[i][6]={}
	Dangle[i][6]=0
	Dangle[i][7]={}
	Dangle[i][7]=0
	Dangle[i][8]={}
	Dangle[i][8]=0
	--the young ones FutureTurn
	Dangle[i][9]={}
	Dangle[i][9]=0
	Dangle[i][10]={}
	Dangle[i][10]=0
	Dangle[i][11]={}
	Dangle[i][11]=0
	
	Dangle[i][13]={}
	tempPiece="AttachPoint"..i
	Dangle[i][13]=piece (tempPiece)
	Dangle[i][17]=0 --Actuall StartAge
	
	
	
end

totalOfDangles=18
for i=1,6,1 do
	Dangle[nrOfDangle+i]={}
	Dangle[nrOfDangle+i][1]={}
	
	tempPiece="HTit"..i
	Dangle[nrOfDangle+i][1]=piece (tempPiece)
	Dangle[nrOfDangle+i][13]={}
	tempPiece="GTit"..i
	Dangle[nrOfDangle+i][13]=piece (tempPiece)
	Dangle[nrOfDangle+i][17]=0 --We pretend its a tit, that has not yet a Puppy
end



function walkAnimations()
	local TurnP=TurnPiece
	SetSignalMask(SIG_PACK)
	Sleep(50)
	for i=1, #Pack, 1 do
		Move(Pack[i][4],y_axis,0,29)
		TurnPiece(Pack[i][5],0,0,0,9)
		TurnPiece(Pack[i][6],0,0,0,9)
	end
	
	while true do
		for i=1, #Pack, 1 do
			--even legs forward
			
			TurnP(Pack[i][4],-2,0,-4,9)
			
			TurnP(Pack[i][5],-14,17,6,9)
			TurnP(Pack[i][6],14,2,7,9)
			
		end
		WaitForTurn(Pack[3][6],x_axis)
		for i=1, #Pack, 1 do
			--even legs forward
			TurnP(Pack[i][4],2,0,4,9)
			TurnP(Pack[i][6],-14,-14,7,9)
			TurnP(Pack[i][5],13,-5,6,9)
		end
		WaitForTurn(Pack[#Pack][6],x_axis)
		Sleep(10)
	end
end

function PackInMotion ()
	SetSignalMask(SIG_PACK)
	
	
	StartThread(walkAnimations)
	local isPieceInTurn= Spring.UnitScript.IsInTurn
	
	while(true) do
		for i=1,#Pack,1 do --itterate over the Pack
			if isPieceInTurn(Pack[i][2],y_axis)== false then
				dego=math.random(Pack[i][1],Pack[i][1]+179)
				Turn(Pack[i][2],y_axis,math.rad(dego),3)
				Turn(Pack[i][3],y_axis,math.rad(-dego),3)
				Pack[i][1]=dego
			end
		end
		Sleep(500)
	end
	
end



function clampY(nr,degree)
	if math.abs(degree) > 45 then return (degree/math.abs(degree))*45 else return degree end
end


function clampZ(nrOfTit,degree)
	if nrOfTit <4 or (nrOfTit >6 and nrOfTit < 10) then-- (obere Reihe)
		if nrOfTit > 4 then 
			if degree > 67 then
				return 66 
			elseif degree < -33 then 
				return -33 
			else 
				return degree 
			end
		else
			if degree < -67 then 
				return -66 
			elseif degree > 33 then
				return 33 
			else 
				return degree 
			end
		end
	else
		if nrOfTit < 7 then 
			if degree > 19 then 
				return 19
			elseif degree < -42 then 
				return -42
			else 
				return degree
			end
		else
			if degree > -19 then 
				return -19 
			elseif degree < 42 then 
				return 42 
			else 
				return degree 
			end
		end
		
		
	end
	
end


-- inertiaSwingSpeedX=0 --6
-- inertiaSwingSpeedY=0 --7
-- inertiaSwingSpeedZ=0 --8


function TurnBody(axis,degree,speed,boolwait)
	Turn(body,axis,degree,speed)
	singleMultiplikator=1
	if degree < 0 then singleMultiplikator=-1 end
	
	if axis== x_axis then
		-- inertiaSwingSpeedZ=inertiaSwingSpeedZ+singleMultiplikator*speed
		
		inertiaSwingX=inertiaSwingX + 45
	elseif axis== z_axis then
		--inertiaSwingSpeedZ=inertiaSwingSpeedZ+singleMultiplikator*speed
		
		inertiaSwingZ=inertiaSwingZ+ 12
	else -- if y_axis then
		-- inertiaSwingSpeedY=inertiaSwingSpeedY+singleMultiplikator*speed
		inertiaSwingY=inertiaSwingY+ 12
	end
	
	
	if boolwait == true then WaitForTurn(body,axis)end
	
	
end

-- inertiaSwingX=0 --6
-- inertiaSwingZ=0 --7
-- inertiaSwingY=0 --8

function MoveBody(axis, distance, speed,boolwait)
	Move(body,axis,distance,speed)
	
	singleMultiplikator=1
	if distance < 0 then singleMultiplikator=-1 end
	
	
	if axis== x_axis then
		inertiaSwingZ=inertiaSwingZ+ math.sqrt(distance*speed)
		-- inertiaSwingSpeedX=inertiaSwingSpeedX+singleMultiplikator*speed
		
	elseif axis== z_axis then
		inertiaSwingZ=inertiaSwingZ+ math.sqrt(distance*speed)
		
		--inertiaSwingSpeedZ=inertiaSwingSpeedZ+singleMultiplikator*speed
	else -- if y_axis then
		
		--inertiaSwingSpeedY=inertiaSwingSpeedY+singleMultiplikator*speed
		inertiaSwingY=inertiaSwingY+ math.sqrt(distance*speed)
	end
	
	if boolwait==true then WaitForMove(body,axis) end
end

function withinLimits(val,limit)
	if val > limit or val < -limit then return false else return true end
end



function TurnPiece(piecename,xval,yval,zval,speed)
	if pieceName== body then
		TurnBody(y_axis,math.rad(yval),speed,false)
		TurnBody(x_axis,math.rad(xval),speed,false)
		TurnBody(z_axis,math.rad(zval),speed,false)
		
	else
		Turn(piecename,x_axis,math.rad(xval),speed)
		Turn(piecename,y_axis,math.rad(yval),speed)
		Turn(piecename,z_axis,math.rad(zval),speed)
	end
end

nrHiveHounds=9
GSpeed=2.5
--/var
function raiseGSpeed()
	for i=1,8,1 do
		Sleep(450)
		GSpeed=GSpeed+1
	end
end
--Get Distance to next Enemy, if within target Range, spawn subunits, send towards.. if subunits die spawn new subunits
boolAttackTargetDefined=false
boolIsMoving=false


function moveThing()
	
	local TurnerP= TurnPiece
	SetSignalMask(SIG_MOVE)
	StartThread(raiseGSpeed)
	inForAWalk=0
	
	while(true) do
		
		if GSpeed < 7 or inForAWalk > 0 then
			inertiaSwingZ=inertiaSwingZ+32
			inertiaSwingX=inertiaSwingX+12
			inertiaSwingY=inertiaSwingY+12
			
			inForAWalk=inForAWalk-1
			yrand=math.random(4,7)
			TurnerP(Head,8,yrand,-5,GSpeed)	
			TurnerP(jaw,6,0,0,GSpeed)	
			TurnerP(bfootL,85,0,0,GSpeed)	
			TurnerP(bfootR,-16,0,0,GSpeed)
			TurnerP(bUpL,19,0,0,GSpeed)
			TurnerP(bUpR,-65,0,0,GSpeed)
			TurnerP(FHip,0,3,-3,1.5)
			TurnerP(BHip,-3,-5,-5,1.5)
			
			
			TurnerP(ffootL,30,0,0,2*GSpeed)	
			
			TurnerP(ffootR,33,0,0,GSpeed)
			TurnerP(fUpL,-26,0,0,GSpeed)
			TurnerP(fUpR,20,0,0,GSpeed)
			
			WaitForTurn(bUpR,x_axis)
			randTailx=math.random(-5,5)
			randTaily=math.random(-5,5)
			randTailz=math.random(-5,5)
			TurnerP(MomaT1,randTailx,randTaily,randTailz,2)
			randTailx=math.random(-5,5)
			randTaily=math.random(-5,5)
			randTailz=math.random(-5,5)
			TurnerP(MomaT2,randTailx,randTaily,randTailz,2)
			randTailx=math.random(-5,5)
			randTaily=math.random(-5,5)
			randTailz=math.random(-5,5)
			
			TurnerP(MomaT3,randTailx,randTaily,randTailz,2)
			--Step
			yrand=math.random(-7,-4)
			TurnerP(Head,8,yrand,-5,GSpeed)	
			TurnerP(jaw,2,0,0,GSpeed)	
			TurnerP(bfootL,85,0,0,GSpeed*2)	
			TurnerP(bfootR,83,0,0,GSpeed*2)
			trix=math.random(-5,5)
			TurnerP(ffootL,85,0,0,2*GSpeed)	
			TurnerP(bUpL,-22+trix,0,0,GSpeed)
			xrand=math.random(3,27)
			TurnerP(bUpR,xrand,27,0,GSpeed)
			TurnerP(FHip,0,-8,12,2)
			TurnerP(BHip,-3,6,6,2)
			
			
			
			del=math.random(11,64)
			TurnerP(ffootR,del,0,0,GSpeed)
			TurnerP(fUpL,-4,0,0,GSpeed)
			
			trix=math.random(-5,5)
			TurnerP(fUpR,-55+trix,0,-6,GSpeed)
			
			
			WaitForTurn(bUpL,x_axis)
			
			TurnerP(ffootR,0,0,0,22)	
			TurnerP(bfootL,0,0,0,22)	
			TurnerP(fUpR,0,0,0,22)
			TurnerP(bUpL,0,0,0,GSpeed)
			--tail
			randTailx=math.random(-5,5)
			randTaily=math.random(-5,5)
			randTailz=math.random(-5,5)
			TurnerP(MomaT1,randTailx,randTaily,randTailz,2)
			randTailx=math.random(-5,5)
			randTaily=math.random(-5,5)
			randTailz=math.random(-5,5)
			TurnerP(MomaT2,randTailx,randTaily,randTailz,2)
			randTailx=math.random(-5,5)
			randTaily=math.random(-5,5)
			randTailz=math.random(-5,5)
			TurnerP(MomaT3,randTailx,randTaily,randTailz,2)
			
			
			
			WaitForTurn(bUpR,x_axis)
			--MoveAnimation on Speed
		else
			if inForAWalk<=0 then	inForAWalk=math.random(1,3) end
			inertiaSwingZ=inertiaSwingZ+52	
			inertiaSwingX=inertiaSwingX+47
			
			MoveBody(y_axis,4,17,false)
			TurnerP(MomaT1,18,0,0,3)
			randTailz=math.random(-5,5)
			TurnerP(MomaT2,-10,randTailz,0,3)
			TurnerP(MomaT3,0,0,0,3)
			TurnerP(body,-4,0,0,GSpeed)
			
			
			TurnerP(jaw,2,0,0,GSpeed)	
			TurnerP(bfootL,67,0,0,GSpeed*2)	
			TurnerP(bfootR,95,0,0,GSpeed*2)
			TurnerP(bUpL,57,0,0,GSpeed)
			TurnerP(bUpR,42,0,0,GSpeed)
			
			TurnerP(FHip,11,0,0,GSpeed/2)
			TurnerP(BHip,-22,0,0,GSpeed/2)
			
			TurnerP(Head,5,0,0,GSpeed)	
			TurnerP(ffootL,85,0,0,GSpeed)	
			TurnerP(ffootR,52,0,-10,GSpeed)
			TurnerP(fUpL,26,0,-5,GSpeed)
			TurnerP(fUpR,41,0,-8,GSpeed)
			
			WaitForTurn(bUpL,x_axis)
			WaitForTurn(bUpR,x_axis)
			WaitForTurn(fUpR,x_axis)
			WaitForTurn(fUpL,x_axis)
			TurnerP(MomaT1,9,0,0,3)
			randTailz=math.random(-5,5)
			TurnerP(MomaT2,5,randTailz,0,3)
			TurnerP(MomaT3,5,0,0,3)
			TurnerP(body,7,0,0,GSpeed)
			
			TurnerP(Head,-4,0,0,GSpeed)	
			TurnerP(jaw,12,0,0,GSpeed)	
			
			TurnerP(bfootL,179,0,29,GSpeed*2)	
			TurnerP(bfootR,161,0,0,GSpeed*2)
			TurnerP(bUpL,-30,0,-12,GSpeed)
			TurnerP(bUpR,-24,0,-13,GSpeed)
			
			TurnerP(FHip,0,0,0,GSpeed/2)
			TurnerP(BHip,-48,0,0,GSpeed/2)
			
			TurnerP(ffootL,75,0,0,3*GSpeed)	
			TurnerP(ffootR,35,0,5,3*GSpeed)
			TurnerP(fUpL,-67,0,-5,GSpeed)
			TurnerP(fUpR,-46,0,-8,GSpeed)
			
			MoveBody(y_axis,0,17,false)
			WaitForTurn(fUpR,x_axis)
			WaitForTurn(fUpL,x_axis)
			WaitForTurn(fUpR,x_axis)
			WaitForTurn(fUpL,x_axis)
			
			
		end		
	end
end


function layDownIdle()
	Signal(SIG_PACK)
	for i=1, nrHiveHounds, 1 do
		--even legs forward
		TurnPiece(Pack[i][4],0,-1*Pack[i][1],0,9)
		TurnPiece(Pack[i][5],0,0,0,9)
		TurnPiece(Pack[i][6],0,0,0,9)
		
	end	
	
	
	Sleep(1200)
	dice=math.random(1,9)
	Move(Pack[dice][4],y_axis,-11,29)
	TurnPiece(Pack[dice][5],-72,0,0,9)
	TurnPiece(Pack[dice][6],-76,0,0,9)
	Sleep(2000)
	Move(Pack[dice][4],y_axis,0,29)
	TurnPiece(Pack[dice][5],0,0,0,9)
	TurnPiece(Pack[dice][6],0,0,0,9)
	
end

function legs_down()
	MoveBody(y_axis,0,19,false) 
	Sleep(250)
	SetSignalMask(SIG_LEG)
	
	for i=1, table.getn(allPieces),1 do
		Turn(allPieces[i],y_axis,math.rad(0),12)
		Turn(allPieces[i],x_axis,math.rad(0),12)
		Turn(allPieces[i],z_axis,math.rad(0),12)
	end
	
	Turn(MomaT1,x_axis,math.rad(-16),12)
	Turn(MomaT2,x_axis,math.rad(-20),12)
	Turn(MomaT3,x_axis,math.rad(14),12)
	
	
	
	
end



function script.StartMoving()
	Signal(SIG_IDLE)
	Signal(SIG_HOWL)
	Signal(SIG_LEG)
	Signal(SIG_PACK)
	StartThread(moveThing)
	StartThread(PackInMotion)
end


function getIntoHowlingPosture()
	Sleep(250)
	SetSignalMask(SIG_HOWL)
	if boolAttackTargetDefined== true then
		--get into a howling posture
		
		
	else
		--classic legs_down &| idle
		
	end
	
end


function script.StopMoving()
	GSpeed=2.5
	Signal(SIG_HOWL)
	Signal(SIG_MOVE)
	Signal(SIG_LEG)
	Signal(SIG_PACK)
	StartThread(circleHungry)
	StartThread(legs_down)
end

function circle()
	Signal(SIG_PACK)
	StartThread(walkAnimations)
	
				sign=math.random(-1,1)
				if sign==0 then sign = -1 end
				sign=sign/math.abs(sign)
				
	for i=1,#Pack,1 do --itterate over the Pack
	
			
				uniquesign=1
				if  i%2 == 0 then uniquesign = -1 end
				val=179*sign*uniquesign				
				Turn(Pack[i][2],y_axis,math.rad(val),1)	
				
				dir=180
				if  uniquesign < 0 then dir = 0 end
				Turn(Pack[i][3],y_axis,math.rad(dir),3)
			
	end
		for i=1,#Pack,1 do 
		WaitForTurn(Pack[i][3],y_axis)
		WaitForTurn(Pack[i][2],y_axis)
		end
		
	for i=1,#Pack,1 do --itterate over the Pack
	
			

				uniquesign=1
				if  i%2 == 0 then uniquesign = -1 end
				val=359*sign*uniquesign			
				Turn(Pack[i][2],y_axis,math.rad(val),1)
				
				dir= 180
				if  uniquesign < 0 then dir = 0 end				
				Turn(Pack[i][3],y_axis,math.rad(dir),3)
			
	end	
		
		for i=1,#Pack,1 do 
		WaitForTurn(Pack[i][3],y_axis)
		WaitForTurn(Pack[i][2],y_axis)
		end
		
		for i=1,#Pack,1 do 
		Turn(Pack[i][3],y_axis,math.rad(0),1)
		Turn(Pack[i][2],y_axis,math.rad(0),1)
		WaitForTurn(Pack[i][3],y_axis)
		WaitForTurn(Pack[i][2],y_axis)
		end
end

function circleHungry()
SetSignalMask(SIG_IDLE)

	while true do
	if math.random(0,1)==1 then
for i=1, 6, 1 do
	circle()
end
	Sleep(500)
	else
	layDownIdle()
	end
	Sleep(1000)

	end

end


function main()
	
	local spGetUPosition=Spring.GetUnitPosition
	local spGetNearestEnemy=Spring.GetUnitNearestEnemy
	local spIsValidUnitID=Spring.ValidUnitID
	
	while true do
		ux,uy,uz=spGetUPosition(unitID)
		eneID=spGetNearestEnemy(unitID)
		
		if eneID ~=nil and spIsValidUnitID(eneID)==true then
			ex,ey,ez=spGetUPosition(eneID)
			distance=math.sqrt((ex-ux)^2+(ez-uz)^2)
			if distance <= AttackDistance then 
				--if enemy is in attackrange, set boolAttackTargetDefined to true and set spawned HiveHounds after some rest to move towards target
				boolAttackTargetDefined=true
			else
				boolAttackTargetDefined=false
			end
			
			if distance < AvoidDistance then
				-- if enemy is within AvoidDistance then set MotherUnit into Motion away from target
				
			end
			--else retract HiveHounds (dissamsemble HiveHounds within DissolveRange or if HiveHounds are all retracted/undeployed devour meat
			
		end
		
		Sleep(260)	 
	end
end


function devourMeat()
	
	
end




local arbitraryMeatMagicValue=185
function isHiveHoundInMeatRange(id,mx,my,mz)
	hx,hy,hz=Spring.GetUnitPosition(id)
	hx=math.abs(mx-hx)
	----Spring.Echo(hx)
	hz=math.abs(mz-hz)
	----Spring.Echo(hz)
	if hx < arbitraryMeatMagicValue or hz < arbitraryMeatMagicValue then return true else return false end
	
end
--sfx for the hungrys
function tearingOffSomeFlash(meatId)
	x,y,z=Spring.GetUnitPosition(meatId)
	Spring.AddUnitDamage(meatId,235)
	Spring.SpawnCEG("bloodspray",x,y+10,z+5,0,1,0,50,0)
	
end

function findHoundInHiveHOundTable(houndID)
	for i=1,table.getn(HiveHoundTable),1 do
		if HiveHoundTable[i][1]== houndID then return true end
	end
return false end

function checkForHiveHoundsToDissolve()
	tableToCheck={}
	
	local spGetUnitDefID=Spring.GetUnitDefID
	tableToCheck=Spring.GetUnitsInCylinder(ux,uz,DissolveRange,teamID)
	local ffHH=findHoundInHiveHOundTable
	
	table.remove(tableToCheck,unitID)
	if tableToCheck~=nil and table.getn(tableToCheck)~= 0 then
		for i=1,#tableToCheck,1 do
			boolCheckson= (spGetUnitDefID(tableToCheck[i])== UnitDefNames["jmeathivehound"].id)
			if ffHH(tableToCheck[i])== true or spGetUnitDefID(tableToCheck[i])== UnitDefNames["jmeathivehound"].id then
				
				if spGetUnitDefID(tableToCheck[i])== UnitDefNames["jmeathivehound"].id then
					tempH,_,_,_,_,_=Spring.GetUnitHealth(unitID)
					Spring.SetUnitHealth(unitID,tempH+256) 
				end
				Spring.DestroyUnit(tableToCheck[i],false,true)
			end
		end
	end
	
end


function vegetarianDiscrimination(tableName)
	
	
	table.remove(tableName,unitID)
	if tableName~=nil and table.getn(tableName)> 0 then
		local spGetUnitDefID=Spring.GetUnitDefID
		local spValid=Spring.ValidUnitID
		tempTable={}
		for i=1,table.getn(tableName),1 do
			if spValid(tableName[i])==true then
				areyouDeafID=spGetUnitDefID(tableName[i])
				if (areyouDeafID== UnitDefNames["gjbigbiowaste"].id or areyouDeafID== UnitDefNames["gjmedbiogwaste"].id) then
					table.insert(tempTable,tableName[i])
				end
			end
		end
		
		
		return tempTable
	end
	
end

boolOnlyOnce=false	
function huntSound()
	Turn(Head,x_axis,math.rad(-34),9)
	Turn(jaw,x_axis,math.rad(34),9)
	Sleep(1000)
	boolOnlyOnce=true
	Spring.PlaySoundFile("sounds/jhivehound/wulfMoma.wav")
	Sleep(7000)
	dice=math.random(1,5)
	if dice== 2 then
		Spring.PlaySoundFile("sounds/jhivehound/wulf2.wav")
	elseif dice==3 then
		Spring.PlaySoundFile("sounds/jhivehound/wulf3.wav")
	end
	Sleep(33000)
	Turn(Head,x_axis,math.rad(0),19)
	Turn(jaw,x_axis,math.rad(0),19)
	boolOnlyOnce=false
end



function bigMoma()
	local spIsValidUnitID=Spring.ValidUnitID
	local spSetUnitMoveGoal=Spring.SetUnitMoveGoal
	local spCreaUnit= Spring.CreateUnit
	local spGetUnitHealth=Spring.GetUnitHealth
	local spGetUnitsInCylinder=Spring.GetUnitsInCylinder
	HiveHoundTable={}
	--Spring.SetUnitMoveGoal(monsterTable[i],ex,ey,ez)
	while(true) do
		--warmode
		if boolAttackTargetDefined== true then
			-- itterate over the HiveHoundTable
			if boolOnlyOnce==false then
				StartThread(huntSound)
			end
			
			for i=1,hiveHoundMax,1 do
				--if the UnitStillExists, set it towards the enemysCoords
				if HiveHoundTable[i]~=nil and Spring.GetUnitIsDead(HiveHoundTable[i][1])==false then
					if spIsValidUnitID(HiveHoundTable[i][1])==true then
						spSetUnitMoveGoal(HiveHoundTable[i][1],ex,ey,ez)
					end
				else
					--else respawn the unit and set the coords accordingly
					HiveHoundTable[i]={}
					HiveHoundTable[i][1]={}
					HiveHoundTable[i][2]={}
					HiveHoundTable[i][1]=spCreaUnit("jhivehound",ux+math.ceil(math.random(-12,12)),uy,uz+math.ceil(math.random(-12,12)),0,teamID)
					HiveHoundTable[i][2]=UnitDefNames["jhivehound"].id
					spSetUnitMoveGoal(HiveHoundTable[i][1],ex,ey,ez)
					
				end
			end
		else
			
			--dostojewskimode no john Lockemode, life is short and bruthis, thus the wulf is a wulf to the wulf
			if spGetUnitHealth(unitID) < fullHealth then
				-- --Spring.Echo("DamagedCaseReached 1")
				IsItMeat={}
				
				
				IsItMeat=spGetUnitsInCylinder(ux,uz,MeatRange)
				----Spring.Echo("MeatHowMany:",table.getn(IsItMeat))
				IsItMeat=vegetarianDiscrimination(IsItMeat)
				local spGetUPosition=Spring.GetUnitPosition
				local spIsUnitIDValid=Spring.ValidUnitID
				
				if IsItMeat~=nil and table.getn(IsItMeat)~=0 then
					--	--Spring.Echo("MeatFound")
					dice=1
					
					if table.getn(IsItMeat) > 2 then dice= math.ceil(math.random(1,table.getn(IsItMeat)-1)) end
					
					mx,my,mz=Spring.GetUnitPosition(IsItMeat[dice])
					--	--Spring.Echo("A")
					--spawn every active HiveHound
					--Iterate through all active HiveHounds Activate every Unit in HiveHoundTable
					for i=1,table.getn(HiveHoundTable),1 do
						if spIsUnitIDValid(HiveHoundTable[i][1])==false then
							--unit is dead, spawn a new HiveHound
							HiveHoundTable[i][1]=Spring.CreateUnit("jhivehound",ux,uy,uz, 0, teamID) 
							HiveHoundTable[i][2]=UnitDefNames["jhivehound"].id
							
						end
						Spring.SetUnitMoveGoal(HiveHoundTable[i][1],mx,my,mz)
						
					end
					--	--Spring.Echo("B")
					-- Send them towards meat
					
					for i=1,table.getn(HiveHoundTable),1 do
						--	--Spring.Echo("SendInTheHiveHounds")
						if spIsUnitIDValid(HiveHoundTable[i][1])==true and isHiveHoundInMeatRange(HiveHoundTable[i][1],mx,my,mz)==true then
							-- if Hivehounds are in MeatRange... respawn as MeatHoldingHiveHound at that to the table
							ax,ay,az=Spring.GetUnitPosition(HiveHoundTable[i][1])
							
							Spring.DestroyUnit(HiveHoundTable[i][1],false,false)
							StartThread(tearingOffSomeFlash,IsItMeat[dice])
							HiveHoundTable[i][1]=Spring.CreateUnit("jmeathivehound",ax,ay,az, 0, teamID) 
							HiveHoundTable[i][2]=UnitDefNames["jmeathivehound"].id
							-- send MeatHivehound home
							
							Spring.SetUnitMoveGoal(HiveHoundTable[i][1],ux,uy,uz) --TODO replace home with the updated move coordinates
						end
						
					end
					
				end
				
				checkForHiveHoundsToDissolve()		
				
				
			end
			if spGetUnitHealth(unitID) >= fullHealth then
				--check For MeatHive
				
				--case unit has full health or no meat in reach
				--piecemode
				--itterate over the HiveHoundTable
				--if a id is found still valid, then send it towards the momas coordinates
				--call checkForHiveHoundsToDissolve
				for i=1,hiveHoundMax,1 do
					--if the UnitStillExists, set it towards wulf muma
					
					if HiveHoundTable[i]~=nil and HiveHoundTable[i][1]~=nil and spIsValidUnitID(HiveHoundTable[i][1])==true then
						spSetUnitMoveGoal(HiveHoundTable[i][1],ux,uy,uz)
					end
				end
				checkForHiveHoundsToDissolve()
				
			end
			
			
		end
		Sleep(650)
		
	end
	
	
end	



function script.Create()	
	StartThread(main)
	StartThread(bigMoma)
	StartThread(danglinDangle)
	StartThread(showAndAgePuppy)
	
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--in addition


--


function turnTail(pieceNr,axis,Value,speed)
	
	
	if pieceNr < 4 or (pieceNr > 6 and pieceNr < 10 ) then
		
		Turn(Dangle[pieceNr][14],axis,math.rad(Value),speed)
		
	else	
		
		
		
		for i=15,16, 1 do --turns the tails into the opposite direction
			
			Turn(Dangle[pieceNr][i],axis,math.rad(Value),speed)
			
		end
		
	end		
	
	
end






function howAreTheyHangingBabe(val)
	if math.abs(val) < 1 then return 0 else return val end
end

--HelloTittyPhysixs
function danglinDangle()
	local downDangleConstant= -0.75
	local spGetPieceRotation= Spring.UnitScript.GetPieceRotation --x,y,z
	local spPieceInTurn=Spring.UnitScript.IsInTurn
	local wiLim=withinLimits
	while true do
		
		
		inertiaSwingX=howAreTheyHangingBabe(inertiaSwingX)
		inertiaSwingY=howAreTheyHangingBabe(inertiaSwingY)
		inertiaSwingZ=howAreTheyHangingBabe(inertiaSwingZ)
		
		inertiaSwingX=inertiaSwingX*downDangleConstant
		inertiaSwingY=inertiaSwingY*downDangleConstant
		inertiaSwingZ=inertiaSwingZ*downDangleConstant
		
		for i=1,nrOfDangle,1 do
			signBit=1
			if i > 6 then signBit= -1 end
			--if piece is allready in Turn and inertiaSwing is out of bounds-- get current Rotation --add the new Rotation upon /\ + set into motion with math.abs(speed)
			rand=math.random(-5,5)
			
			if titTable[i]== 0 then rand=0 end
			
			--sumUpAndApplyInertiaTurn(pieceNr,oldValue,newValue,axis,speed)
			if spPieceInTurn(Dangle[i][1],x_axis) == false then
				
				Turn(Dangle[i][1],x_axis,math.rad(inertiaSwingX *	0.25), inertiaSwingSpeedX)
				Turn(Dangle[i][13],x_axis,math.rad(inertiaSwingX *	0.75 ), inertiaSwingSpeedX)
				turnTail(i,x_axis,inertiaSwingX*-0.75,inertiaSwingSpeedX)
				--sumUpAndApplyInertiaTurn(i,x,inertiaSwingX,x_axis,inertiaSwingSpeedX) 
				
			end
			if spPieceInTurn(Dangle[i][1],y_axis) == false then 
				
				Turn(Dangle[i][1],y_axis,math.rad(inertiaSwingY *	0.25), inertiaSwingSpeedY)
				Turn(Dangle[i][13],y_axis,math.rad(inertiaSwingY *	0.75 +rand), inertiaSwingSpeedY)
				turnTail(i,y_axis,inertiaSwingY*-0.75,inertiaSwingSpeedY)
				
				if titTable[i]~= 0 then	rand=math.random(-5,5) end
			end
			if spPieceInTurn(Dangle[i][1],z_axis) == false then-- and math.abs(inertiaSwingZ) > 3
				
				Turn(Dangle[i][1],z_axis,math.rad(inertiaSwingZ * 	0.25*signBit +rand), inertiaSwingSpeedZ)
				Turn(Dangle[i][13],z_axis,math.rad(inertiaSwingZ *	0.75*signBit), inertiaSwingSpeedZ)
				turnTail(i,z_axis,inertiaSwingZ*-0.75*signBit,inertiaSwingSpeedZ)
			end
			--if inertiaSwing is near Zero take the normal and piece is no longer in turn -- take counter degree *-0.75 with standardspeed
			-- if spPieceInTurn(Dangle[i][1],x_axis)==false and wiLim(inertiaSwingX,12)==true then turnDown(i,6,x_axis,inertiaSwingSpeedX) end
			-- if spPieceInTurn(Dangle[i][1],y_axis)==false and wiLim(inertiaSwingY,12)==true then turnDown(i,7,y_axis,inertiaSwingSpeedY) end
			-- if spPieceInTurn(Dangle[i][1],z_axis)==false and wiLim(inertiaSwingZ,12)==true then turnDown(i,8,z_axis,inertiaSwingSpeedZ) end
			
			-- if the orgdegree is below treshold turn it towards zero
			
			
		end
		
		
		Sleep(150) 
	end
end

function showThemTooMe()
	--TODO
end



columpointLeft=piece "columpointLeft"
columpointRight=piece "columpointRight"

function giveBirth()
	for i=1,6 do
		Hide(GTits[i])
		x=i
		if i > 3 then x =i+3 end
		sign=1
		if i< 4 then sign= -1 end
		
		Turn(Dangle[x][2],y_axis,math.rad(179),0) 
		Turn(Dangle[x][2],z_axis,math.rad(68*sign),0) 
		
		Turn(Dangle[x][1],z_axis,math.rad(51*sign),9) 
		Show(Dangle[x][2])
	end
	WaitForTurn(Dangle[3][1],z_axis)
	WaitForTurn(Dangle[3][2],z_axis)
	for i=1,6 do
		x=i
		if i > 3 then x =i+3 end
		Turn(Dangle[x][2],y_axis,math.rad(0),0.3) 
		Turn(Dangle[x][2],z_axis,math.rad(0),0.3) 
		Turn(Dangle[x][1],z_axis,math.rad(0),0.3) 
	end
	WaitForTurn(Dangle[3][2],y_axis)
	WaitForTurn(Dangle[3][2],z_axis)
	WaitForTurn(Dangle[3][1],z_axis)
	
end

function headShake()
	randVal=math.random(34,55)
	rando=math.random(2,5)
	speed=math.random(2,6)
	
	for i=1,rando,1 do
		Turn(Head,y_axis,math.rad((randVal*-1)/i),speed+i)
		WaitForTurn(Head,y_axis)
		Turn(Head,y_axis,math.rad((randVal*-1)/i),speed+i)
		WaitForTurn(Head,y_axis)
		
	end
	
end

function expandUpTits()
	for i=1,6, 1 do 
		Show(GTits[i])
		Show(HTits[i])
		Move(GTits[i],x_axis,0,0.15)
		Move(GTits[i],y_axis,0,0.15)
		Move(GTits[i],z_axis,0,0.15)
		
		Move(HTits[i],x_axis,0,0.15)
		Move(HTits[i],y_axis,6,0.15)
		Move(HTits[i],z_axis,0,0.15)
	end
	WaitForMove(HTits[6],y_axis)
	WaitForMove(HTits[6],z_axis)
	WaitForMove(HTits[6],x_axis)
	WaitForMove(GTits[6],x_axis)
	WaitForMove(GTits[6],z_axis)
	WaitForMove(GTits[6],y_axis)
	
	
	
	Turn(columpointLeft,z_axis,math.rad(0),0)
	Turn(columpointRight,z_axis,math.rad(0),0)
	for i=4,6 do
		x=i+6
		Show(Dangle[i][4])
		Show(Dangle[i][15])
		Show(Dangle[x][4])
		Show(Dangle[x][15])
		
		Hide(Dangle[i][5])
		Hide(Dangle[i][16])
		Hide(Dangle[x][5])
		Hide(Dangle[x][16])
		
	end
	
	for i=1,6,1 do
		x=i
		if i > 3 then x =i+3 end
		Show(Dangle[x][2])
		Hide(Dangle[x][3])
		Hide(Dangle[x][14])
	end
	StartThread(headShake)
	giveBirth()
	for i=1,6, 1 do 
		Hide(GTits[i])
		Hide(HTits[i])
		if i < 4 then
			Move(GTits[i],x_axis,0,0)
			Move(GTits[i],y_axis,-6,0)
			Move(GTits[i],z_axis,0,0)
		else
			Move(GTits[i],x_axis,0,0)
			Move(GTits[i],y_axis,-6,0)
			Move(GTits[i],z_axis,0,0)
		end
		Move(HTits[i],x_axis,0,0)
		Move(HTits[i],y_axis,0,0)
		Move(HTits[i],z_axis,0,0)
	end
	
end 
-- nr1:1-5 - 21-26 + 1-4
function showAndAgePuppy()
	while true do
		Turn(columpointLeft,z_axis,math.rad(55),0.015)
		Turn(columpointRight,z_axis,math.rad(-55),0.015)
		
		Sleep(8000)
		
		for i=1,6, 1 do 
			Show(GTits[i])			
			Move(GTits[i],x_axis,0,0.3)
			Move(GTits[i],y_axis,0,0.33)
			Move(GTits[i],z_axis,0,0.33)
			
			--downBelowWulfs
			
		end
		
		for i=4,6 do
			x=i+6
			Hide(Dangle[i][4])
			Hide(Dangle[i][15])
			Hide(Dangle[x][4])
			Hide(Dangle[x][15])
			
			Show(Dangle[i][5])
			Show(Dangle[i][16])
			Show(Dangle[x][5])
			Show(Dangle[x][16])
			randoVal=math.ceil(math.random(400,1200))
			Sleep(randoVal)
		end
		
		
		
		for i=1,6,1 do
			x=i
			if i > 3 then x =i+3 end
			
			Hide(Dangle[x][2])
			Show(Dangle[x][3])
			Show(Dangle[x][14])
			rand=math.ceil(math.random(600,1200))
			Sleep(rand)
		end
		
		WaitForTurn(columpointLeft,z_axis)
		WaitForTurn(columpointRight,z_axis)
		
		
		expandUpTits()
		
		Sleep(350)
	end
end

--1-4

titTable={}
for i=1,12, 1 do
	titTable[i]=1
end

--Moves the starter replacement back out


function script.Killed(recentDamage,maxHealth)
	Turn(deathpivot,z_axis,math.rad(75),37)
	
	for i=1,24,1 do
		EmitSfx(jaw,1024)
		Sleep(250)
	end
	
	return 0
end