include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | Number newDamage 

piecesTable={}
center = piece"center"

piecesTable[#piecesTable+1]= center
mestorage3DS = piece"mestorage.3DS"

piecesTable[#piecesTable+1]= mestorage3DS
body = piece"body"

piecesTable[#piecesTable+1]= body
p10 = piece"10"

piecesTable[#piecesTable+1]= p10
p100 = piece"100"

piecesTable[#piecesTable+1]= p100
p20 = piece"20"

piecesTable[#piecesTable+1]= p20
p30 = piece"30"

piecesTable[#piecesTable+1]= p30
p40 = piece"40"

piecesTable[#piecesTable+1]= p40
p50 = piece"50"

piecesTable[#piecesTable+1]= p50
p60 = piece"60"

piecesTable[#piecesTable+1]= p60
p70 = piece"70"

piecesTable[#piecesTable+1]= p70
p80 = piece"80"

piecesTable[#piecesTable+1]= p80
p90 = piece"90"



feetFetish={}
for i=1, 4, 1 do
	feetFetish[i]={}
	feetFetish[i][1]={}-- the Upper joint
	feetFetish[i][2]={} -- upper leg
	feetFetish[i][3]={} --lower joint
	feetFetish[i][4]={} --lower leg
	
	
	temp1= "UpJoin0"..i
	temp2= "UpLeg0"..i
	temp3= "LoJoin0"..i
	temp4= "LoLeg0"..i
	temp5= "DirEmit"..i
	
	feetFetish[i][1]=piece(temp1)-- the Upper joint
	feetFetish[i][2]=piece(temp2) -- upper leg
	feetFetish[i][3]=piece(temp3) --lower joint
	feetFetish[i][4]=piece(temp4) --lower leg
	
end

Number={}
for i=10,100,10 do
	
	piecename = piece(""..i)
	Number[#Number+1]= piecename
	
end

piecesTable[#piecesTable+1]= p90
UpJoin03 = piece"UpJoin03"

piecesTable[#piecesTable+1]= UpJoin03
UpLeg03 = piece"UpLeg03"

piecesTable[#piecesTable+1]= UpLeg03
LoJoin03 = piece"LoJoin03"

piecesTable[#piecesTable+1]= LoJoin03
LoLeg03 = piece"LoLeg03"

piecesTable[#piecesTable+1]= LoLeg03
UpJoin01 = piece"UpJoin01"

piecesTable[#piecesTable+1]= UpJoin01
UpLeg01 = piece"UpLeg01"

piecesTable[#piecesTable+1]= UpLeg01
LoJoin01 = piece"LoJoin01"

piecesTable[#piecesTable+1]= LoJoin01
LoLeg01 = piece"LoLeg01"

piecesTable[#piecesTable+1]= LoLeg01
DropLet = piece"DropLet"

piecesTable[#piecesTable+1]= DropLet
UpJoin04 = piece"UpJoin04"

piecesTable[#piecesTable+1]= UpJoin04
UpLeg04 = piece"UpLeg04"

piecesTable[#piecesTable+1]= UpLeg04
LoJoin04 = piece"LoJoin04"

piecesTable[#piecesTable+1]= LoJoin04
LoLeg04 = piece"LoLeg04"

piecesTable[#piecesTable+1]= LoLeg04
UpJoin02 = piece"UpJoin02"

piecesTable[#piecesTable+1]= UpJoin02
UpLeg02 = piece"UpLeg02"

piecesTable[#piecesTable+1]= UpLeg02
LoJoin02 = piece"LoJoin02"

piecesTable[#piecesTable+1]= LoJoin02
LoLeg02 = piece"LoLeg02"

piecesTable[#piecesTable+1]= LoLeg02
local SIG_MOVE=4

function liftFeet(nr,yVal)
	sigNum=1
	if nr%2 == 1 then sigNum=-1 end
	movingLegsCounter=movingLegsCounter+1
	Turn(feetFetish[nr][1],y_axis,math.rad(yVal),2.7)
	sigNum=sigNum*45
	Turn(feetFetish[nr][1],x_axis,math.rad(sigNum),6)
	--Turn(feetFetish[nr][3],x_axis,math.rad(9),2)
	WaitForTurns(feetFetish[nr][1],feetFetish[nr][3])
	movingLegsCounter=movingLegsCounter-1
end

function TurnF(nr,yVal)
	movingLegsCounter=movingLegsCounter+1
	Turn(feetFetish[nr][1],y_axis,math.rad(yVal),2.7)
	WaitForTurns(feetFetish[nr][1])
	movingLegsCounter=movingLegsCounter-1
end

function lowerFeet(nr,yVal)
	movingLegsCounter=movingLegsCounter+1
	Turn(feetFetish[nr][1],y_axis,math.rad(yVal),2.7)
	WaitForTurns(feetFetish[nr][1])
	Turn(feetFetish[nr][1],x_axis,math.rad(0),2.7)
	Turn(feetFetish[nr][3],x_axis,math.rad(0),2.7)
	WaitForTurns(feetFetish[nr][1],feetFetish[nr][3])
	movingLegsCounter=movingLegsCounter-1
end


function script.Create()
	
	Spin(DropLet,y_axis,math.rad(42),0)
	
	StartThread(gyroScopic)
	StartThread(dropIn)
	StartThread(walk)
end

function HideEnergy()
	for i=1,#Number,1 do
		Hide(Number[i])
	end
end

local MyEnergStorage=10
local Capacity=UnitDefNames["jestorage"].energyStorage or 2400
local prevEnergyStorage=10
local boolDrippIn=false
itterator=1
local teamid=Spring.GetUnitTeam(unitID)
percenTage=0
function updateMyEnergyStorage()
	currentLevel,storage, pull, income, expense, share,sent, received=Spring.GetTeamResources(teamid,"energy")
	
	if storage then
		percenTage=math.ceil((currentLevel/storage)*100)
		
		itterator=math.floor(math.max(1,math.min(10,percenTage/10)))
		MyEnergStorage=math.max(10,math.min(100,percenTage))
		HideEnergy()
		Show(Number[itterator])
		boolDrippIn= (income-pull) > 0
		prevEnergyStorage=percenTage
	end
end

function dropRealistic(startPos, endDistance, startspeed,endspeed, chunks,pieceMoving)
	
	speedup=(endspeed-startspeed)/chunks
	distChunk=(math.abs(endDistance)-math.abs(startPos))/chunks
	if endDistance < startPos then distChunk=math.min(distChunk,distChunk*-1) else distChunk=math.abs(distChunk) end
	Pos,Speed=startPos,startspeed
	for i=1,chunks,1 do
		Pos=Pos+distChunk
		Speed=Speed+speedup
		Move(pieceMoving,y_axis,Pos,Speed)
		WaitForMove(pieceMoving,y_axis)
	end
end

--are vectors equal
function vecEqual(a,b,intervall)
	if not intervall then
		return a.x==b.x and a.y==b.y and a.z==b.z
	else 
		return math.abs(a.x-b.x)< intervall and math.abs(a.y-b.y)< intervall and math.abs(a.z-b.z) < intervall
	end
end

liqCenter=piece"liqCenter"

--break the normalized vectors down into rad
function makeDegFromVec(vec)
	radX=math.acos(1/(math.sqrt(vec.x^2+1)))
	radZ=math.acos(1/(math.sqrt(vec.z^2+1)))
	return radX,radZ
end

function relativeUpRight(bodyVec)
	bodyVec.x=bodyVec.x*-1
	bodyVec.y=bodyVec.y
	bodyVec.z=bodyVec.z*-1
	return bodyVec
	--return vec3MulMatrice3x3(bodyVec,YRotationMatrice(180))
end

--controlls the "fluid" moving around in the jestorage
function gyroScopic()
	local 	spGetUnitPiePosDir=Spring.GetUnitPiecePosDir
	local 	bodyVec={x=0,y=1,z=0}
	local 	oldBodyVec={x=0,y=1,z=0}
	local 	dVec={x=0,y=1,z=0}
	local 	TargVec={x=0,y=0,z=0}
	local 	LiquidVec={x=0,y=1,z=0}
	local UpRightVec={x=0,y=1,z=0}
	
	while true do

	ux,_,uz= Spring.GetUnitPosition(unitID)
	bodyVec.x, bodyVec.y, bodyVec.z =Spring.GetGroundNormal(ux,uz)	
	bodyVec= normVector(bodyVec)
	TargVec=makeVector(0,1,0)
	
	_,_,_,LiquidVec.x, LiquidVec.y, LiquidVec.z =spGetUnitPiePosDir(unitID,Number[1])

		--if the LiquidVec is not resting and the Target is still not the UpRightVec 
		
		--updating the relative UpRightVector, means, we take the bodyvec and turn it by 180 around y_axis
		UpRightVec=relativeUpRight(bodyVec)
		if true or vecEqual(TargVec,LiquidVec,0.5)==true and vecEqual(TargVec,UpRightVec,0.5)==true then
			
			-- if the unit takes a step, add that change of bodyvec as a opposite force to the targetvec
			--TargVec={x= (-1*(bodyVec.x-oldBodyVec.x)),y= (-1*(bodyVec.y-oldBodyVec.y)),z=(-1*(bodyVec.z-oldBodyVec.z))}
			
			--TargVec=addVector(mulVector(TargVec,0.5),mulVector(LiquidVec,0.5))
			TargVec=addVector(mulVector(TargVec,0.85),mulVector(UpRightVec,0.15))		
			
			RadX,RadZ=makeDegFromVec(TargVec)
			-- Spring.Echo("JW:jestorage - TurnVecX:"..RadX.. " - TurnVecZ: "..RadZ)
			Turn(liqCenter,x_axis,RadX,0.1,true)
			Turn(liqCenter,z_axis,RadZ,0.1,true) 
			
			while Spring.UnitScript.IsInTurn (liqCenter,x_axis) and Spring.UnitScript.IsInTurn (liqCenter,z_axis) do --Spring.UnitScript --both are still Turning WaitForMove
				Sleep(150)
			end
			--flip the TargVec we have reached the highest Point and everything tell us to go backwards..
			TargVec=mulVector(TargVec,-0.9)
			rVal=math.random(-42,42)
			Spin(liqCenter,y_axis,math.rad(rVal),0)
			
			
		end
		oldBodyVec=bodyVec
		updateMyEnergyStorage()
		Sleep(150)
		StopSpin(liqCenter,y_axis,0.1)
	end
	
end

function dropIn()
	local ldropReal=dropRealistic
	
	while true do
		distance=-27
		amount=math.random(10,52)
		cosDiv=3.14159/(amount)
		cosStart=3.14159/-2
		if boolDrippIn==false then
			for i=1,amount, 1 do
				Move(DropLet,y_axis,distance,0)
				ldropReal(-25, 0, 18.1 , 42, 10,DropLet)
				cosStart=cosStart+cosDiv
				Time= math.ceil(500*math.cos(cosStart))
				Sleep(Time)
			end
		else
			
			for i=1,amount, 1 do
				cosStart=cosStart+cosDiv
				Move(DropLet,y_axis,0,0)
				ldropReal(0, -25, 18.1 , 42, 10,DropLet)
				Time= math.ceil(500*math.cos(cosStart))
				Sleep(Time)
			end
		end
		Sleep(5000)
	end
end


explosionRange=1.5
function script.Killed(recentDamage,_)
	Spring.PlaySoundFile("sounds/jestorage/good_explosion.ogg",1) 
	if percenTage then
		Range=math.ceil(percenTage*explosionRange)
		x,y,z=Spring.GetUnitPosition(unitID)
		T=getAllInCircle(x,z,Range,unitID)
		defID=Spring.GetUnitDefID(unitID)	
		Spring.SpawnCEG("factory_explosion",x,y+15,z,0,1,0,50,0)
		for i=1,#T do 
			thyID=Spring.GetUnitDefID(T[i])
			if thyID ~=defID then
				Spring.AddUnitDamage(T[i],math.ceil(percenTage*4))
			else
				Spring.DestroyUnit(T[i],true,false,unitID)
			end
		end	
		
	end
	--createCorpseJBuilding(unitID, recentDamage)
	return 1
end

movingLegsCounter=0
function walk()
	
	comonSpeed=0.2

	
	while(true) do
		
		while boolMoving==true do 
		Turn(center,y_axis,math.rad(45),15)
			while(movingLegsCounter > 0) do Sleep(12) end

			StartThread(lowerFeet,1,22)
			StartThread(lowerFeet,4,-22)
			Sleep(1)
				Turn(center,x_axis,math.rad(2.5),0.15)
				Turn(center,z_axis,math.rad(2.5),0.15)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(lowerFeet,3,82)
			StartThread(lowerFeet,2,-81)
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(liftFeet,3,62 )
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(lowerFeet,3,-42)
			StartThread(lowerFeet,1,49)
			StartThread(lowerFeet,4,-49)
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(liftFeet,2,-62 )
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(lowerFeet,2,42)
			Sleep(1)

			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(liftFeet,1,62 )
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(lowerFeet,1,-42)
				Turn(center,x_axis,math.rad(-1.5),0.15)
				Turn(center,z_axis,math.rad(-1.5),0.15)
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(liftFeet,4,-62 )
			Sleep(1)
			while(movingLegsCounter > 0) do Sleep(12) end
			StartThread(lowerFeet,4,42)
			StartThread(lowerFeet,3,0)
			StartThread(lowerFeet,2,0)
			Sleep(10)
		end
		
		legs_down()
		while boolMoving== false do 
			Sleep(20)
		end
		
		Sleep(20)
	end
end



function script.StartMoving()
	Signal(SIG_MOVE)
	boolMoving=true								
	
end

function legs_down()
	Turn(center,y_axis,math.rad(0),5)
	for i=1,table.getn(feetFetish),1 do
		for j=1,4, 1 do
			Turn(feetFetish[i][j],x_axis,math.rad(0),3.141)
			Turn(feetFetish[i][j],y_axis,math.rad(0),3.141)
			Turn(feetFetish[i][j],z_axis,math.rad(0),3.141)
		end
		
	end
	
end

function timeDelayedReset()
	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)
	Sleep(250)
	boolMoving=false
end


function script.StopMoving()
	StartThread(timeDelayedReset)
end