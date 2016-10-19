include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

--this is the rewrite of the conTrain
--the pieces of the train and the pillars

--GPL goes in all fields


--needs a updaterOnSituations in every Circle.
-- needs albionCliffLevel to test.


ctgoresub={}

cargo=0
passengertable={}

function script.TransportDrop(passengerID, x, y, z)
	if loaded == false then return end
	--if unit not loaded
	loaded=false
	for i=1,cargo,1 do
		if passengertable[i] == passengerID then
			loaded=true
		end
	end
	
	if loaded == false then return end
	
	SetUnitValue(COB.BUSY, 1)
	
	Spring.SetUnitNoDraw(passengerID,false) 	
	
	
	DropUnit(passengerID)
	cargo=cargo-1
	
	if cargo<= 0 then
		loaded = false
	end
	
	SetUnitValue(COB.BUSY, 0)
end

eatItAlive={
	[UnitDefNames["gcivillian"].id]=true,
	[UnitDefNames["gseastar"].id]=true,
	[UnitDefNames["ghohymen"].id]=true	
}


function script.TransportPickup(passengerID)
	--onlycivilians
	local defIDPassenger = Spring.GetUnitTeam(passengerID)
	
	if not eatItAlive[defIDPassenger] then return end
	
	--if opera has full house
	if cargo >= cargoMax then return end
	SetUnitValue(COB.BUSY, 1)
	
	--openBayDoors
	
	if dist >128 then return end
	
	AttachUnit(center, passengerID)
	
	table.insert(passengertable,passengerID)
	
	cargo=cargo+1
	
	
	Spring.SetUnitNoDraw(passengerID,true) 
	loaded=true
	SetUnitValue(COB.BUSY, 0)
end


local iWantAHug=piece "iWantAHug"
local goreSub =piece "ctGoreSub"
local dontKillHeavyUnits=600



local ctmagnet= piece "ctGoreSub"
local trainSpotThere= piece "trainSpotThere"
local center = piece "center"
local cCTrain0 = piece "cCTrain0"
local cCTrain01 = piece "cCTrain01"
local cCTrain02 = piece "cCTrain02"
local cCTrain03 = piece "cCTrain03"
local cRailTurn= piece "cRailTurn"
local uCanTurnMeOn= piece "uCanTurnMeOn"

railCirc ={}
pillar1 = {}
pillar2 = {}
pillar3 = {}

pillar4 = {}
pillar5 = {}
pillar6 = {}

usul={}
function initPieces()
	for i=1,7,1 do
		ctgoresub[i]={}
		ctgore= "ctgore"..i
		ctgoresub[i]=piece (ctgore)
	end
	--the Ring Rail
	cRailCirc0 = piece "cRailCirc0"
	railCirc[1]=cRailCirc0 
	cRailCirc1 = piece "cRailCirc1"
	railCirc[2]=cRailCirc1 
	cRailCirc2= piece "cRailCirc2"
	railCirc[3]=cRailCirc2 
	cRailCirc3= piece "cRailCirc3"
	railCirc[4]=cRailCirc3 
	cRailCirc4= piece "cRailCirc4"
	railCirc[5]=cRailCirc4 
	cRailCirc5= piece "cRailCirc5"
	railCirc[6]=cRailCirc5 
	cRailCirc6= piece "cRailCirc6"
	railCirc[7]=cRailCirc6 
	cRailCirc7= piece "cRailCirc7"
	railCirc[8]=cRailCirc7 
	cRailCirc8= piece "cRailCirc8"
	railCirc[9]=cRailCirc8 
	cRailCirc9= piece "cRailCirc9"
	railCirc[10]=cRailCirc9 
	cRailCirc10= piece "cRailCirc10"
	railCirc[11]=cRailCirc10 
	cRailCirc11= piece "cRailCirc11"
	railCirc[12]=cRailCirc11 
	
	-----------------------------------------------------------------------------------
	--pillars : the pieces on which the train moves. The folding Pillar is not part of this, it is spawned seperate later upon.
	
	cPilar1 =piece"cPilar1"
	pillar1[#pillar1+1]=cPilar1 
	cRstealthC1= 	piece"cRstealthC1"
	pillar1[#pillar1+1]= cRstealthC1 
	cPillarCro1= 	piece"cPillarCro1"
	pillar1[#pillar1+1]=cPillarCro1 
	cPilarMech1=	piece"cPilarMech1"
	pillar1[#pillar1+1]= cPilarMech1 
	cRailWay11 = 	piece"cRailWay11"
	pillar1[#pillar1+1]= cRailWay11 
	cRailFold11 = 	piece"cRailFold11"
	pillar1[#pillar1+1]=cRailFold11 
	cRailR11 =piece"cRailR11"
	pillar1[#pillar1+1]= cRailR11 
	cRailL11 =piece"cRailL11"
	pillar1[#pillar1+1]=cRailL11 
	cRailWay12 = 	piece"cRailWay12"
	pillar1[#pillar1+1]= cRailWay12 
	cRailFold12 =	 piece"cRailFold12"
	pillar1[#pillar1+1]= cRailFold12 
	cRailR12 =piece"cRailR12"
	pillar1[#pillar1+1]= cRailR12 
	cRailL12 =piece"cRailL12"
	pillar1[#pillar1+1]=cRailL12 
	intFeetUnder=0
	pillar1[#pillar1+1]=intFeetUnder 
	
	
	
	cPilar2 = 	 	piece"cPilar2"
	pillar2[#pillar2+1]=cPilar2 
	cRstealthC2= 	piece"cRstealthC2"
	pillar2[#pillar2+1]=cRstealthC2 
	cPillarCro2= 	piece"cPillarCro2"
	pillar2[#pillar2+1]=cPillarCro2 
	cPilarMech2= 	piece"cPilarMech2"
	pillar2[#pillar2+1]= cPilarMech2 
	cRailWay21 = 	piece"cRailWay21"
	pillar2[#pillar2+1]= cRailWay21 
	cRailFold21 = 	piece"cRailFold21"
	pillar2[#pillar2+1]=cRailFold21 
	cRailR21 =piece"cRailR21"
	pillar2[#pillar2+1]= cRailR21 
	cRailL21 =piece"cRailL21"
	pillar2[#pillar2+1]=cRailL21 
	cRailWay22 = 	piece"cRailWay22"
	pillar2[#pillar2+1]= cRailWay22 
	cRailFold22 = 	piece"cRailFold22"
	pillar2[#pillar2+1]= cRailFold22 
	cRailR22 =piece"cRailR22"
	pillar2[#pillar2+1]= cRailR22 
	cRailL22 =piece"cRailL22"
	pillar2[#pillar2+1]=cRailL22 
	intFeetUnder=0
	pillar2[#pillar2+1]=intFeetUnder 
	
	
	cPilar3 = 	 	piece"cPilar3"
	pillar3[#pillar3+1]=cPilar3 
	cRstealthC3= 	piece"cRstealthC3"
	pillar3[#pillar3+1]=cRstealthC3 
	cPillarCro3= 	piece"cPillarCro3"
	pillar3[#pillar3+1]=cPillarCro3 
	cPilarMech3= 	piece"cPilarMech3"
	pillar3[#pillar3+1]= cPilarMech3 
	cRailWay31 = 	piece"cRailWay31"
	pillar3[#pillar3+1]= cRailWay31 
	cRailFold31 = 	piece"cRailFold31"
	pillar3[#pillar3+1]=cRailFold31 
	cRailR31 =piece"cRailR31"
	pillar3[#pillar3+1]= cRailR31 
	cRailL31 =piece"cRailL31"
	pillar3[#pillar3+1]=cRailL31 
	cRailWay32 = 	piece"cRailWay32"
	pillar3[#pillar3+1]= cRailWay32 
	cRailFold32 = 	piece"cRailFold32"
	pillar3[#pillar3+1]= cRailFold32 
	cRailR32 =piece"cRailR32"
	pillar3[#pillar3+1]= cRailR32 
	cRailL32 =piece"cRailL32"
	pillar3[#pillar3+1]=cRailL32 
	intFeetUnder=0
	pillar3[#pillar3+1]=intFeetUnder 
	
	
	cPilar4 = 	 	piece"cPilar4"
	pillar4[#pillar4+1]=cPilar4 
	cRstealthC4= 	piece"cRstealthC4"
	pillar4[#pillar4+1]= cRstealthC4 
	cPillarCro4= 	piece"cPillarCro4"
	pillar4[#pillar4+1]=cPillarCro4 
	cPilarMech4= 	piece"cPilarMech4"
	pillar4[#pillar4+1]= cPilarMech4 
	cRailWay41 = 	piece"cRailWay41"
	pillar4[#pillar4+1]= cRailWay41 
	cRailFold41 = 	piece"cRailFold41"
	pillar4[#pillar4+1]=cRailFold41 
	cRailR41 =piece"cRailR41"
	pillar4[#pillar4+1]= cRailR41 
	cRailL41 =piece"cRailL41"
	pillar4[#pillar4+1]=cRailL41 
	cRailWay42 = 	piece"cRailWay42"
	pillar4[#pillar4+1]= cRailWay42 
	cRailFold42 = 	piece"cRailFold42"
	pillar4[#pillar4+1]= cRailFold42 
	cRailR42 =piece"cRailR42"
	pillar4[#pillar4+1]= cRailR42 
	cRailL42 =piece"cRailL42"
	pillar4[#pillar4+1]=cRailL42 
	intFeetUnder=0
	pillar4[#pillar4+1]=intFeetUnder 
	
	
	cPilar5 = 	 	piece"cPilar5"
	pillar5[#pillar5+1]=cPilar5 
	cRstealthC5= 	piece"cRstealthC5"
	pillar5[#pillar5+1]= cRstealthC5 
	cPillarCro5= 	piece"cPillarCro5"
	pillar5[#pillar5+1]=cPillarCro5 
	cPilarMech5= 	piece"cPilarMech5"
	pillar5[#pillar5+1]= cPilarMech5 
	cRailWay51 = 	piece"cRailWay51"
	pillar5[#pillar5+1]= cRailWay51 
	cRailFold51 = 	piece"cRailFold51"
	pillar5[#pillar5+1]=cRailFold51 
	cRailR51 =piece"cRailR51"
	pillar5[#pillar5+1]= cRailR51 
	cRailL51 =piece"cRailL51"
	pillar5[#pillar5+1]=cRailL51 
	cRailWay52 = 	piece"cRailWay52"
	pillar5[#pillar5+1]= cRailWay52 
	cRailFold52 = 	piece"cRailFold52"
	pillar5[#pillar5+1]= cRailFold52 
	cRailR52 =piece"cRailR52"
	pillar5[#pillar5+1]= cRailR52 
	cRailL52 =piece"cRailL52"
	pillar5[#pillar5+1]=cRailL52 
	intFeetUnder=0
	pillar5[#pillar5+1]=intFeetUnder 
	
	
	cPilar6 = piece"cPilar6"
	pillar6[#pillar6+1]=cPilar6 
	cRstealthC6= piece"cRstealthC6"
	pillar6[#pillar6+1]= cRstealthC6 
	cPillarCro6= piece"cPillarCro6"
	pillar6[#pillar6+1]=cPillarCro6 
	cPilarMech6= piece"cPilarMech6"
	pillar6[#pillar6+1]= cPilarMech6 
	cRailWay61 = 	piece"cRailWay61"
	pillar6[#pillar6+1]= cRailWay61 --5
	cRailFold61 = 	piece"cRailFold61"
	pillar6[#pillar6+1]=cRailFold61 --6
	cRailR61 =piece"cRailR61"
	pillar6[#pillar6+1]= cRailR61 --7
	cRailL61 =piece"cRailL61"
	pillar6[#pillar6+1]=cRailL61 
	cRailWay62 = 	piece"cRailWay62"
	pillar6[#pillar6+1]= cRailWay62 --9
	cRailFold62 = 	piece"cRailFold62"
	pillar6[#pillar6+1]= cRailFold62 --10
	cRailR62 =piece"cRailR62"
	pillar6[#pillar6+1]= cRailR62 --11
	cRailL62 =piece"cRailL62"
	pillar6[#pillar6+1]=cRailL62 
	intFeetUnder=0
	pillar6[#pillar6+1]=intFeetUnder 
	
	usul[#usul+1]=pillar1
	usul[#usul+1]=pillar2
	usul[#usul+1]=pillar3
	usul[#usul+1]=pillar4
	usul[#usul+1]=pillar5
	usul[#usul+1]=pillar6
	
end
------------------------------------------------------------------------------------
--train



--booleans
--MoveDetector
local boolIsMoving=false
--local boolConstantMove=false
local speedCompareTolerance=1.1
local minSpeed=0.43
--TurnDetector
local headTolerance=1.00002
local headChangeTolerance=40
local negativeTolerance=2-headTolerance
local boolIsTurning=false
--local boolConstantTurn=false
local unitTeam=Spring.GetUnitTeam(unitID)
--ThreadStarter
virginBool=true
--MovementThreads
local boolStopDetectInUse=false
local boolMoveDetectInUse=false
local boolFinnish=true
local 	newSpeed	=0
--storeValues
local currentSpeed=0
local comonPillarSpeed=0
local speedLimit=3.14
local lowestHeight=0
local savedSpeed=0
local saveSpeedCounter=3

--Situations Enumeration
local SStop=1 -- Situation Train has stopped
local STurn=2 -- Situation Train is turning
local SMove=4 -- Situation Train is moving

--SignalMaks
SIG_MOVE=2
SIG_MDETEC=4
SIG_PIL1=8
SIG_PIL2=16
SIG_PIL3=32
SIG_PIL4=64
SIG_PIL5=128
SIG_PIL6=256
SIG_WIP=512

siGnall ={}

siGnall[1]=true 
siGnall[2]=true 
siGnall[3]=true 
siGnall[4]=true 
siGnall[5]=true 
siGnall[6]=true 

selectRange=10
SIG_UNFPIL1=1024
SIG_UNFPIL2=2048
SIG_UNFPIL3=4096
SIG_UNFPIL4=8192
SIG_UNFPIL5=16384
SIG_UNFPIL6=32768
SIG_RAZOR	=262144


SigTableUnfold={}

SigTableUnfold[1]=true
SigTableUnfold[2]=true
SigTableUnfold[3]=true
SigTableUnfold[4]=true
SigTableUnfold[5]=true
SigTableUnfold[6]=true

boolConstantMove=false
boolCMLock=false
boolConstantTurn=false
boolCTLock=false
boolRazorSoundInUse=false
local boolLocks={}
local globalBooleans={}
table.insert(globalBooleans,1,boolConstantMove)
table.insert(boolLocks,1,boolCMLock)
table.insert(globalBooleans,2,boolConstantTurn)
table.insert(boolLocks,2,boolCTLock)


function workInProgress()
	
	
	
	
	SetSignalMask(SIG_WIP)
	local spGetUnitHealth=Spring.GetUnitHealth
	local spSetUnitNoSelect=Spring.SetUnitNoSelect 
	local spSetUnitHealth=Spring.SetUnitHealth
	while(true)do
		
		actualHealth=spGetUnitHealth(unitID)
		if actualHealth == 1 then
			actualHealth=actualHealth-1
			spSetUnitNoSelect (unitID, true)
			--makes the Unit go home, to the place it was born- west Virginia
			Spring.DestroyUnit(unitID,false,true)		
		end
		actualHealth=actualHealth-1
		spSetUnitHealth(unitID,actualHealth)
		
		Sleep(250)
		
	end
end

function script.StopBuilding()
	Signal(SIG_WIP)
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)
	
	Signal(SIG_WIP)
	--Signal(SIG_CHECK)
	StartThread(workInProgress)
	
	SetUnitValue(COB.INBUILDSTANCE, 1)
end



local function getConstantMove()
	return globalBooleans[1]
end

local function getConstantTurn()
	return globalBooleans[2]
end
--function checks if plane is above
function canYouTakeMeHigher(targetId)
	targetPosX,targetPosY,targetPosZ=Spring.GetUnitPosition(targetId)
	unitPosX,unitPosY,unitPosZ=Spring.GetUnitPosition(unitID)
	
	if targetPosY > unitPosY then
		return false
	else
		return true
	end
end

function hardReset()
	Move(iWantAHug,z_axis,0, 0)
	Move(iWantAHug,x_axis,0, 0)
	Move(iWantAHug,y_axis,0, 0)
	Turn(goreSub,x_axis,math.rad(0),0)
	Turn(goreSub,z_axis,math.rad(0),0)
	Turn(goreSub,y_axis,math.rad(0),0)
end

--plays the sound that a unit is done for
function playThatFunkyHorn()
	Signal(SIG_RAZOR)
	SetSignalMask(SIG_RAZOR)
	Sleep(500)
	boolRazorSoundInUse=true
	PlaySoundByUnitType(contrainDef, "sounds/conTrain/razortrain_horn1.wav",0.9,10000,1,0)
	Sleep(5000)
	boolRazorSoundInUse=false
	
end

sparedTable={}
sparedTable[UnitDefNames["contrain"].id]=true
sparedTable[UnitDefNames["mdigg"].id]=true
sparedTable[UnitDefNames["mdiggmex"].id]=true
sparedTable[UnitDefNames["contruck"].id]=true
sparedTable[UnitDefNames["citadell"].id]=true
sparedTable[UnitDefNames["beanstalk"].id]=true

--this function kills Units who get in the way of the driving train..
function goTooKillThemAllPicaMon()
	----Spring.Echo("Enter:The Murderer")
	piecePosX,piecePosY,piecePosZ=0
	piecePosX,piecePosY,piecePosZ,dx, dy, dz =Spring.GetUnitPiecePosDir(unitID, piece "ctGoreSub")
	----Spring.Echo("PiecePosX:",piecePosX.." | PiecePosZ:",piecePosZ)
	--get Piece Position
	proChoice={}
	proChoice=Spring.GetUnitsInCylinder(piecePosX, piecePosZ,selectRange )--no idea why 2.9 but satan told me so
	
	--get UnitsWithinCone
	youAreTheOneAndOnly=0
	proLife=table.getn(proChoice)
	
	
	
	----Spring.Echo("proLife:",proLife)
	if proLife > 0 then
		if boolRazorSoundInUse==false then
			Signal(SIG_RAZOR)
			StartThread(playThatFunkyHorn)
		end
		
		
		----Spring.Echo("NumberOftheChosen:",proLife)
		if proLife == 1 then
			youAreTheOneAndOnly=1
			--	--Spring.Echo("function goTooKillThemAllPicaMon(): Invalid Unit selected!")
		else
			youAreTheOneAndOnly=math.random(1,proLife)
		end
		
		trainFullDeathID=proChoice[youAreTheOneAndOnly]
		
		defID=Spring.GetUnitDefID(trainFullDeathID)
		if not defID or sparedTable[defID]==true then return end
		
		--getting the Units health- waiting for the green Pile
		likeAFreakTrainGoingNoWhere, maxHealth, paralyzeDamage, captureProgress, buildProgress=Spring.GetUnitHealth(trainFullDeathID)
		----Spring.Echo("HealthValue:",likeAFreakTrainGoingNoWhere)
		vicTeamId=Spring.GetUnitTeam(trainFullDeathID)
		
		--get MetallCosts if below threshold < kill
		if canYouTakeMeHigher(trainFullDeathID)== true and likeAFreakTrainGoingNoWhere < dontKillHeavyUnits and trainFullDeathID ~=nil and teamID ~= vicTeamId then --if --then --and currentSpeed > 0.5 then
			Spring.UnitScript.AttachUnit(goreSub, trainFullDeathID)
			--	--Spring.Echo("UnitAttached")
			--atach Unit to Piece
			--while piece is in move wait for execution
			timers=0
			while (true==Spring.UnitScript.IsInMove (cPilar4, y_axis) and timers < 3) do
				allign=math.random(-25,25)
				if allign%2==0 then
					Turn(goreSub,x_axis,math.rad(allign),7)
				else
					Turn(goreSub,z_axis,math.rad(allign),7)
				end
				Sleep(150)
				timers=timers+1
			end
			
			Spring.UnitScript.AttachUnit(iWantAHug, trainFullDeathID)
			
			headsYouLifeTailYoudie=math.random(0,1)
			
			if headsYouLifeTailYoudie== 0 then
				Spring.UnitScript.DropUnit(trainFullDeathID)
			end
			
			tempSpeed=currentSpeed
			Move(iWantAHug,x_axis,-132.04, tempSpeed)
			Spring.SetUnitNoDraw(trainFullDeathID,true)
			Spring.UnitScript.DropUnit(trainFullDeathID)
			--Explode the GorePieces with no effects
			PlaySoundByUnitType(contrainDef, "sounds/conTrain/conbump.wav",0.5,10000,1,0)
			for i=1,7,1 do
				Show(ctgoresub[i])
				Explode(ctgoresub[i], SFX.FALL )
				EmitSfx(ctgoresub[i], 1025)
				EmitSfx(ctgoresub[i], 1025)
				Hide(ctgoresub[i])
			end
			
			--Kill the Unit
			if (Spring.ValidUnitID(trainFullDeathID)==true) then
				Spring.SetUnitNoDraw(trainFullDeathID,false)					
				Spring.DestroyUnit(trainFullDeathID,false,true) --leave no wreck
				boolYouBroughtThisOnYourself= true
			end
			
			
			
			
			--Reset the Parts
			
			
		end
	end
	hardReset()
	----Spring.Echo("MurderousFunction has left the build")
end

boolYouBroughtThisOnYourself= false

function threadSafety(globalBoolNr,value2ChangeInto,boolLockedNR)
	while(true) do
		if boolLocks[boolLockedNR]==true then
			Sleep(5)
		else
			boolLocks[boolLockedNR]=true
			globalBooleans[globalBoolNr]=value2ChangeInto
			boolLocks[boolLockedNR]=false
			return
		end
		Sleep(5)
	end
	
end




--ROCKON
local velX,velY,velZ =0
--function gets speed from the engine
function speedUpdater()
	local spGetUnitVelocity=Spring.GetUnitVelocity
	while(true) do
		velX,velY,velZ=Spring.GetUnitVelocity(unitID)
		
		while (velX==nil or velZ== nil) do
			
			velX,velY,velZ=spGetUnitVelocity(unitID)
			Sleep(100)
		end
		
		Sleep(15)
		currentSpeed= math.sqrt(velX*velX + velZ*velZ)
		Sleep(300)
	end
	
end





--function compares old speed and new speed, returns false if speed is out of tolerances or speed is zero
local function speedCompare(speedOfOld,newSpeed,tolerance,boolInstReset)
	
	
	if newSpeed==0 and speedOfOld==0 then
		return true
	end
	
	if newSpeed==0 or boolInstReset==true then
		return false
	end
	
	speedNegativeTolerance=2-tolerance
	
	if newSpeed > (speedOfOld*tolerance) or newSpeed < (speedOfOld*speedNegativeTolerance) then
		return false
	else
		return true
	end
	
end

local function speedBiggerThenMin(speedIR)
	if speedIR > minSpeed then
		return true
	else
		return false
	end
	
end



function motionDetec()
	----Spring.Echo("ComeAlive")
	boolFirstCompare=false
	
	while(true) do
		
		if speedBiggerThenMin(currentSpeed) == true then
			boolFirstCompare=true
		end
		Sleep(150)
		if speedBiggerThenMin(currentSpeed) == true and boolFirstCompare == true then
			threadSafety(1,true,1)
		else
			boolFirstCompare=false
			threadSafety(1,false,1)
		end
		
		Sleep(150)
	end
end

--function: transforms the speed of the train in the unfold-movement speed of the pillars
--that is necessary to have the pillars unfold just in time
local function speedTransForm(boolT_PillarMov_F_MoveSpeed,speed, pillarNumber)
	if boolT_PillarMov_F_MoveSpeed == true then --or pillarNumber~= nil
		local depth=usul[pillarNumber][13]
		depth=nilCheck(depth)
		depth=negZero(depth)
		
		local distance2Bridge=477+depth --thats correct Grisha
		
		
		totalSpeed=((speed/0.072)*2.16)
		
		local howManyPilPerS=((speed/0.072)*2.16)/62
		
		
		
		local framesPerPillar=math.ceil(0.3*(1/(howManyPilPerS/100)))
		local speedTotal=math.ceil(((distance2Bridge) /framesPerPillar)*30)
		return speedTotal
	else
		--determine the speed
		--TempSpeed=currentSpeed
		--STspeed=currentSpeed/7.2 --between 0 -1
		--then deterinate the range the unit makes at max in one second
		--range=STspeed*216 --distance the unit gets across in one second
		--nrOfPillars=range/61 -- 0.1 - 3.1 --how many pillars the unit does cross in one second
		--	splitSecond=1/nrOfPillars
		--distance/time = velocity
		veloCity=61/(1/(((speed/7.2)*216 )/61))
		--61
		return veloCity
	end
end




--folds the pillar - into a Polygon Origami Pillar
function foldPillar(number,callingSituation,boolInstReset)
	--	case one or six, wait till pillar is folded, then move it Under
	
	
	local speedO=0
	
	speed=currentSpeed
	if speed== nil then speed=0 end
	
	-- this function uses comonPillarSpeed update in the situation-While-loop to save performance
	-- that would otherwise go to waste by 6 threads constantly querying spring for speedInfos.
	
	-- transform the speed into the pillarMoveSpeed, the speed nessecary to move all the components, to arrive Just-in-Time
	if speed ~= 0 and speed > speedLimit then
		speedO=speedTransForm(true,speed,number)
	elseif speed ~= 0 then
		speedO= speedTransForm(true,speedLimit,number)
	end
	
	
	
	
	--fold Rails
	
	if speedCompare(speedO,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedO=comonPillarSpeed
	end
	if boolInstReset == true then speedO=0 end
	
	Turn(usul[number][7],z_axis,math.rad(50),speedO)
	Turn(usul[number][11],z_axis,math.rad(50),speedO)
	WaitForTurn(usul[number][11],z_axis)
	WaitForTurn(usul[number][6],z_axis)
	--update the speed if bool
	if speedCompare(speedO,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedO=comonPillarSpeed
	end
	if boolInstReset == true then speedO=0 end
	--fold railways
	Turn(usul[number][5],y_axis,math.rad(65),speedO)
	Turn(usul[number][9],y_axis,math.rad(-69),speedO)--
	Turn(usul[number][6],z_axis,math.rad(85),speedO)
	Turn(usul[number][10],z_axis,math.rad(87),speedO)--
	
	WaitForTurn(usul[number][6],z_axis)
	WaitForTurn(usul[number][10],z_axis)
	--raise Railways
	if speedCompare(speedO,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedO=comonPillarSpeed
	end
	if boolInstReset == true then speedO=0 end
	Turn(usul[number][5],x_axis,math.rad(90),speedO)
	Turn(usul[number][9],x_axis,math.rad(-90),speedO)
	WaitForMove(usul[number][5],x_axis)
	WaitForMove(usul[number][9],x_axis)
	if speedCompare(speedO,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedO=comonPillarSpeed
	end
	if boolInstReset == true then speedO=0 end
	--retract pillar
	Move(usul[number][3],y_axis,-50,speedO*2)
	WaitForMove(usul[number][3],y_axis)
	Hide(usul[number][5])
	Hide(usul[number][9])
	Hide(usul[number][6])
	Hide(usul[number][10])
	if speedCompare(speedO,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedO=comonPillarSpeed
	end
	if boolInstReset == true then speedO=0 end
	--cap Pillar
	Turn(usul[number][2],z_axis,math.rad(0),speedO)
	WaitForTurn(usul[number][2],z_axis)
	
	
	
	
	Move(usul[number][1],y_axis,lowestHeight,speedO)
	
	local storeHeightAwayTemp=lowestHeight
	--This loop wont end, before the pillar is underground)
	while(siGnall[number]==true and true==Spring.UnitScript.IsInMove (piece ("cPilar"..number), y_axis)) do
		--check if speed has changed
		currentSpeed=currentSpeed
		currentSpeed=currentSpeed-speed --calc the Difference
		if speedCompare(currentSpeed,speedO,speedCompareTolerance) == true then
			currentSpeed=currentSpeed+speed
			speedO=estimateSpeedConstant(number,currentSpeed)
			Move(usul[number][1],y_axis,lowestHeight,speedO)
			storeHeightAwayTemp=lowestHeight
			
		else
			
		end
		Sleep(72)
	end
	usul[number][13]=lowestHeight
	siGnall[number]=true
	
end

--unfolds the pillar - is hated by the function above
local function unfoldPillar(number, callingSituation,boolInstReset)
	
	local speedU=0
	if number== nil then
		--Spring.Echo("Error:Nil-Number handed over to a UnfoldPillar-Method")
	end
	speed=currentSpeed
	if speed== nil or speed== 0 then speed=0 end
	
	if number == 4 and callingSituation== SMove then
		--	StartThread(goTooKillThemAllPicaMon)
	end
	-- this function uses comonPillarSpeed update in the situation-While-loop to save performance
	-- that would otherwise go to waste by 6 threads constantly querying spring for speedInfos.
	
	-- transform the speed into the pillarMoveSpeed, the speed nessecary to move all the components, to arrive Just-in-Time
	if speed ~= 0 and speed > speedLimit then
		speedU=speedTransForm(true,speed,number)
	elseif speed ~= 0 or callingSituation== STurn then
		speedU= speedTransForm(true,speedLimit,number)
	end
	if boolInstReset == true then
	speedU=0 end
	
	
	
	Move(usul[number][1],y_axis,0,speedU)
	while(SigTableUnfold[number]==true and true==Spring.UnitScript.IsInMove (piece ("cPilar"..number), y_axis)) do
		--check if speed has changed
		if speedCompare(speedU,comonPillarSpeed,speedCompareTolerance)==true then
			speedU=comonPillarSpeed
			Move(usul[number][1],y_axis,0,speedU)
		end
		if boolInstReset== true
		then speedU= 0 end
		Sleep(172)
	end
	SigTableUnfold[number]=true
	if speedCompare(speedU,comonPillarSpeed,speedCompareTolerance)==true then
		speedU=comonPillarSpeed
	end
	
	
	--decap Pillar
	EmitSfx(usul[number][2], 1024)
	Turn(usul[number][2],z_axis,math.rad(-200),speedU)
	WaitForTurn(usul[number][2],z_axis)
	Show(usul[number][5])
	Show(usul[number][9])
	Show(usul[number][6])
	Show(usul[number][10])
	if speedCompare(speedU,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedU=comonPillarSpeed
	end
	if boolInstReset == true then speedU=0 end
	--stick up pillar
	Move(usul[number][3],y_axis,0,speedU*2)
	WaitForMove(usul[number][3],y_axis)
	--lower Railways
	if speedCompare(speedU,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedU=comonPillarSpeed
	end
	if boolInstReset == true then speedU=0 end
	
	Turn(usul[number][5],x_axis,math.rad(0),speedU)
	Turn(usul[number][9],x_axis,math.rad(0),speedU)
	WaitForMove(usul[number][5],x_axis)
	WaitForMove(usul[number][9],x_axis)
	--unfold FoldRails
	if speedCompare(speedU,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedU=comonPillarSpeed
	end
	if boolInstReset == true then speedU=0 end
	Turn(usul[number][5],y_axis,math.rad(0),speedU)
	Turn(usul[number][9],y_axis,math.rad(0),speedU)
	Turn(usul[number][6],z_axis,math.rad(0),speedU)
	Turn(usul[number][10],z_axis,math.rad(0),speedU)
	WaitForTurn(usul[number][5],y_axis)
	WaitForTurn(usul[number][9],y_axis)
	WaitForTurn(usul[number][6],z_axis)
	WaitForTurn(usul[number][10],z_axis)
	if speedCompare(speedU,comonPillarSpeed,speedCompareTolerance,boolInstReset)==true then
		speedU=comonPillarSpeed
	end
	if boolInstReset == true then speedU=0 end
	
	Turn(usul[number][7],z_axis,math.rad(0),speedU)
	Turn(usul[number][11],z_axis,math.rad(0),speedU)
	WaitForTurn(usul[number][11],z_axis)
	WaitForTurn(usul[number][6],z_axis)
end




--this function replaces a returned NilValue with a Zero
function nilCheck(value)
	if value== nil then
		return 0
	else
		return value
	end
	
end
--this function turns a negative value
function negZero(value)
	
	if value < 0 then
		value=value*-1
		return value
	else
		return value
	end
end


--function takes the position of the last pillar, and spawns a retract pillar there.. sounds complicated but was the easiest part in this meduso of OS-Loops and Sensor-Loops
local function spawnRetractPillar()
	local posX, posY, posZ, _, _, _=Spring.GetUnitPiecePosDir(unitID, piece "cPilar6")
	local heading = Spring.GetUnitHeading (unitID)
	local u = Spring.CreateUnit ("conTrainPillar", posX,posY,posZ, -heading* math.pi / 32768, unitTeam)
	Spring.SetUnitBlocking(u, false)
	Spring.SetUnitRotation (u, 0, -heading* math.pi / 32768, 0)
	return
end


--function: initialises train
function initScript()
	Spring.SetUnitBlocking(unitID,false)
	--sets the PillarSpeed at which parts of the Pillar Move
	comonPillarSpeed=speedTransForm(true,3,1)
	--hide unit completely, during the intialisation
	Spring.SetUnitNoDraw(unitID,true)
	--Hide all the rails instantly
	lowestHeight=-42
	for i=1,6,1 do
		for a=1,12,1 do
			Hide(usul[i][a])
		end
	end
	
	for i=1,12,1 do
		Hide(railCirc[i])
	end
	
	
	
	--fold all the pillars in
	for i=1,6,1 do
		foldPillar(i,SStop,true)
	end
	
	--Moves Pillars below the lowest ground
	
	--unhide unit
	Spring.SetUnitNoDraw(unitID,false)
	
	--pop them, unfold them when they reached origin.
	for i=1,6,1 do
		for a=1,12,1 do
			Show(usul[i][a])
		end
		unfoldPillar(i,SStop,false)
	end
	
	
	
end
boolSelfRepairedToDeath=false 

function healWhileStandingStill()
	Sleep(3000)
	
	teamid=Spring.GetUnitTeam(unitID)
	conTypeTable= getTypeTable(UnitDefNames,{"contrain","contruck","conair","citadell"})
	local ud=UnitDefs
	
	while true do
		while boolHealingActive==true do
			
			StartThread(playThatFunkyHorn)
			while boolHealingActive==true do
				boolHealedOne=false
				x,y,z=Spring.GetUnitPosition(unitID)
				hp=Spring.GetUnitHealth(unitID)
				if hp then
					
					T=getAllInCircle(x,z,300,unitID,teamID)
					hp=math.ceil(math.ceil(hp*0.5)/#T)
					hpcopy=hp
					for i=1,#T do
						defID=Spring.GetUnitDefID(T[i])
						if defID and ud[defID].isBuilding ==false and not conTypeTable[defID] then
							p,maxhp,_,bP=Spring.GetUnitHealth(T[i])

							if  p and p < maxhp and maxhp > 400 then
								
								Spring.SetUnitHealth(T[i],p+hp)
								sx,sy,sz=Spring.GetUnitPosition(T[i])
								Spring.SpawnCEG("healtrain",sx,sy+10,sz,0,1,0,0)
								if hpcopy-hp <0 then 	boolYouBroughtThisOnYourself =true end
								Spring.AddUnitDamage(unitID,hp)
							
							end
						end
					end
				end
				
				Sleep(750)
			end
			Sleep(100)
		end
		Sleep(100)
	end
end

--Set PillarHeight Block

-- function: Sensor-Loop gets the Height around the train filters out the heighest value. Expensive. Use with Caution.
function getRelativePillarMovement()
	
	local unitX,unitY,unitZ=Spring.GetUnitPosition(unitID)
	midHeight=unitY
	frontHeight=(Spring.GetGroundHeight(unitX+150,unitZ))-midHeight
	rearHeight=(Spring.GetGroundHeight(unitX-150,unitZ))-midHeight
	upHeight=(Spring.GetGroundHeight(unitX,unitZ+150))-midHeight
	downHeight=(Spring.GetGroundHeight(unitX,unitZ-150))-midHeight
	kingOfTheHill=(math.max(frontHeight,rearHeight,upHeight,downHeight)) +20
	lowestHeight=(math.min(frontHeight,rearHeight,upHeight,downHeight,midHeight))-kingOfTheHill -40
	----Spring.Echo("LowestHeight",lowestHeight)
	----Spring.Echo("KingOfTheHill",kingOfTheHill)
	--should the train be on a mountaintop
	if kingOfTheHill < 0 then
		return 0
	else
		return kingOfTheHill
	end
	
	
end
--this OS-Loop gets the heightdifference, and moves the train up or down
function AdjustPillarHeight()
	
	
	while(true) do
		----Spring.Echo("Pillar Loop Reportin In")
		tempCurrSpeed=currentSpeed--gets the currentspeed
		
		
		if tempCurrSpeed < 1 then
			tempCurrSpeed=4
		end
		
		
		heightDifference=getRelativePillarMovement()--gets the height the pillar has to be moved up
		--WORKON
		local halfSpeed=tempCurrSpeed*2 --the speedvalue the pillar is moved up to
		
		if heightDifference ~= 0 then
			Signal(SIG_HEIGHT)
			StartThread(setHeight,heightDifference,halfSpeed)
		else
			Sleep(50)
		end
		Sleep(400) --relative long sleep, because the called function is expensive
	end
	
end

--Function: Moves up the whole unit depending on the surrounding landscape
function setHeight(heightDifference,halfSpeed)
	SetSignalMask(SIG_HEIGHT)
	--Move the CenterPillar + train up or down.
	Move(center,y_axis,heightDifference,comonPillarSpeed)
	Move(cCTrain0,y_axis,heightDifference,comonPillarSpeed)
	WaitForMove(center,y_axis)
	
end



--MOVEMENT BLOCK

--Function:
--It hides the centerpillars away, but doese that quite slow
--It then sets the boolean that this operation is not yet finnished, and activates the Pillarspawner
--the last step is to reset the center to its original position..
--finally boolFinnish is set to true, the operation? was succesfull...
local function moveIt(transferedRailSpeed)
	boolFinnish=false
	SetSignalMask(SIG_MOVE)
	StartThread(unfoldPillar,4, SMove,false)
	Move(center,z_axis,-61.2717,transferedRailSpeed)
	WaitForMove(center,z_axis)
	Sleep(25)
	spawnRetractPillar()
	foldPillar(4,SMove,true)
	
	Move(center,z_axis,0,0)
	boolFinnish=true
end


--function: OS-Loop which if the contrain moves constantly, makes sure moveIt Threads are called constantly
function movMent()
	local 	speedOfOld	=speedTransForm(false,currentSpeed)
	
	Sleep(75)
	--local 	newSpeed	=0
	--local boolFinnish=true
	--local boolDontMove
	local lgetConstantMove=getConstantMove
	
	local lspeedCompare=speedCompare
	local lresetTracks=resetTracks
	while(true) do
		--if no movement occurs just hang around idling
		
		
		if lgetConstantMove()==true then
			
			while lgetConstantMove()==true and currentSpeed > 0.05 do-- added the currentSpeed compare to avoid it getting into Movement with zeroSpeed
				
				newSpeed=speedTransForm(false,currentSpeed)
				
				
				
				
				if boolFinnish==true or lspeedCompare(speedOfOld,newSpeed,speedCompareTolerance)== false then
					----Spring.Echo("Firing Off New Pillar",boolFinnish)
					Signal(SIG_MOVE)
					siGnall[4]=false
					SigTableUnfold[4]=false
					
					StartThread(moveIt,newSpeed)
					----Spring.Echo("MoveItFunction Executed. Off with its over-head")
				end
				
				
				
				
				Sleep(88)
				
				speedOfOld=newSpeed
				
			end
			
		else
			lresetTracks()
		end
		
		Sleep(95)
	end
end



--function resets the center instantaniously
function resetTracks()
	while(boolFinnish==false) do
		Sleep(15)
	end
	Move(center,z_axis,0,0)
end


--turn detection block

--funktion : compares the heading , returns true if the heading has changed, returns false if it is within the treshold
local function compareHeading(currentHead,headingOld)
	
	while (headingOfOld==nil) do
		Sleep(90)
		headingOfOld=Spring.GetUnitHeading(unitID)
	end
	
	
	while(currentHead== nil) do
		currentHeading=Spring.GetUnitHeading(unitID)
		Sleep(90)
	end
	
	--assert(currentHead)
	--assert(headingOld)
	----Spring.Echo("currentHead",currentHead)
	----Spring.Echo("HeadingOfOld",headingOld)
	--unneg the value
	headingOld=negZero(headingOld)
	currentHead=negZero(currentHead)
	--assert(currentHead)
	--assert(headingOld)
	
	
	headChange=currentHead-headingOld
	--unneg the headChange
	
	headChange=negZero(headChange)
	----Spring.Echo(headChange.." "..headChangeTolerance)
	
	
	if headChange > headChangeTolerance then --or currentHeading < headingOfOld*negativeTolerance
		return true
	else
		return false
	end
	--Spring.Echo("Heading Detector doing strange Stuff-Error!")
	
end


--function: Sensor Loop detects turning Train
local function turnDetector()
	--local headTolerance=1.00002
	local currentHeading=0
	local headingOfOld=Spring.GetUnitHeading(unitID)
	
	--assert(headingOfOld)
	Sleep(90)
	local boolCompareOnce=false
	local boolCompareTwice=false
	local spGetUnitHeading=Spring.GetUnitHeading
	local lthreadSafety=threadSafety
	local lcompareHeading=compareHeading
	
	while(true) do
		----Spring.Echo("TurnDetector still alive!")
		
		currentHeading=spGetUnitHeading(unitID)--updates heading
		--	assert(currentHeading)
		
		
		boolCompareOnce=lcompareHeading(currentHeading,headingOfOld)
		if boolCompareOnce == true then
			headingOfOld=currentHeading
			Sleep(90)
			currentHeading=spGetUnitHeading(unitID)
			
			
			boolCompareTwice=lcompareHeading(currentHeading,headingOfOld)
			if boolCompareTwice==true then
				--boolConstantTurn=true
				lthreadSafety(2,true,2)
				
			else
				lthreadSafety(2,false,2)
				boolCompareOnce=false
				boolCompareTwice=false
			end
			
			
		else
			boolCompareTwice=false
		end
		
		
		
		
		
		Sleep(90)
		headingOfOld=currentHeading
		--assert(headingOfOld)
		
	end
	--Spring.Echo("Im leaving the TurnDetector. You mad, Modfag?")
end

-- this Situation Object bundles all the Actions necessary in the StopSituation and
-- the changes necessary to get a smoth transition out of the former Situation
function constantCompare()
	if getConstantMove() == false and getConstantTurn() == false then
		return true
	else
		return false
	end
	
end

local function sitStop(previousSituation)
	local lconstantCompare=constantCompare
	local lspeedTransform=speedTransForm
	Hide(cRailTurn)
	if previousSituation == SMove then --if this Situation stops from Moving
		--boolDontMove=true 	 --this should have the train drop out of
		resetTracks()
		--reset Pillar
		foldPillar(4,SStop,true)	--folds the pillar at the front instantaniously
		
	elseif previousSituation == STurn then
		--raise Pillars
		
		-- boolDontMove=true --centers the rails
		for i=1,12,1 do	--hide the RailCircle
			Hide(railCirc[i])
		end
		
		for i=2,5,1 do
			if i~=4 then --for all pillars except one and six, stop all folding or unfolding
				tempSig=siGnall[i]
				siGnall[i]=false
				SigTableUnfold[i]=false
				
				StartThread(unfoldPillar,i,SStop,false) --unfold said Pillars
			end
		end
		
	else
		
		--if previous Situation was Stop, do nothing
	end
	
	while (lconstantCompare()==true) do
		Sleep(175)
		comonPillarSpeed=lspeedTransform(true,6,1) --setting the pillar un/foldspeed fixxed with a comonvalue
	end
end


--function: describes the Turnsituation, and how to translate from the previous Situation
function sitTurn(previousSituation)
	local lspeedTransForm=speedTransForm
	boolDontMove=true
	if previousSituation== SStop then
		resetTracks()
		
		for i=2,6,1 do
			siGnall[i]=false
			SigTableUnfold[i]=false
			StartThread(foldPillar,i,STurn,false)
			
		end
		
		for i=1,12,1 do
			Show(railCirc[i])
			Turn(railCirc[i],y_axis,math.rad(15),15)
		end
		
		WaitForTurn(railCirc[12],y_axis)
		Show(cRailTurn)
		
		
	elseif previousSituation==SMove then
		resetTracks()
		
		for i=2,6,1 do
			siGnall[i]=false
			SigTableUnfold[i]=false
			
			
			
			StartThread(foldPillar,i,STurn,false)
			
		end
		
		for i=1,12,1 do
			Show(railCirc[i])
			Turn(railCirc[i],y_axis,math.rad(15),15)
		end
		
		WaitForTurn(railCirc[12],y_axis)
		Show(cRailTurn)
		
		
	else-- previously turning
		--therefore no Situation Alteration required
	end
	
	
	while((getConstantTurn()==true and getConstantMove()==false))==true and currentSpeed < minSpeed do --as long as Turn detector doesent see a way out
		----Spring.Echo("SitTurn")
		Sleep(175)
		comonPillarSpeed=lspeedTransForm(true,6,1)--fixxedSpeed
	end
	
end

--function: Object represents the MovementSituation and the Transition to it
local function sitMove(previousSituation,currentSpeed)
	local lspeedTransForm=speedTransForm
	boolDontMove=false
	
	if previousSituation	== STurn then
		--raise Pillars
		for i=1,12,1 do
			Hide(railCirc[i])
			Turn(railCirc[i],x_axis,math.rad(0),0)
		end
		
		for i=2,6,1 do
			if i~=4 then
				siGnall[i]=false
				SigTableUnfold[i]=false
				StartThread(unfoldPillar,i,SMove,false)
			end
		end
		Hide(cRailTurn)
		
	elseif previousSituation == SStop then
		--Do Nothing
	end
	
	
	
	while(getConstantMove()==true and getConstantTurn()==false)==true do
		--loop updates the comonPillarSpeed
		comonPillarSpeed=lspeedTransForm(true,currentSpeed,1)
		
		----Spring.Echo("SitMove")
		Sleep(175)
	end
end


--Pillar Managment
--function: basically detects the current movement Situation and activates the corresponding SitObjects
-- triggerVariables are: boolConstMove/boolConstantTurn, those end the situations and cause a drop back into this
-- OS-Loop

function PillarManager()
	
	local newSituation=SStop
	local oldSituation=SStop
	
	local speedOfOld=currentSpeed
	local lgetConstantMove=getConstantMove
	local lsitStop=sitStop
	local lsitTurn=sitTurn
	local lsitMove=sitMove
	Sleep(75)
	local currySpeed=0
	while(true) do
		Sleep(75)	 --getSituation
		
		----Spring.Echo("	 boolConstantMove:",getConstantMove())
		----Spring.Echo("	 boolConstantTurn:",getConstantTurn())
		
		if lgetConstantMove()==false and getConstantTurn() ==false then
			newSituation=SStop--train stops
		elseif getConstantTurn()==true and lgetConstantMove() == false and currentSpeed < minSpeed then
			
			newSituation=STurn--train turns
		else
			newSituation=SMove--train moves
		end
		----Spring.Echo("new Situation:",newSituation)
		--speedUpdate
		currySpeed=currentSpeed
		--if speed changes out of tolerance
		if newSituation ~= oldSituation or (speedCompare(currySpeed,speedOfOld,1.08,false)== true) then
			
			if newSituation == SStop then
				--case stopped
				--boolDontMove=true
				lsitStop(oldSituation)
				Sleep(50)
			elseif newSituation == SMove then
				--case moves
				--boolDontMove=false
				lsitMove(oldSituation,currySpeed)
				Sleep(50)
			elseif newSituation==STurn then
				--case turned
				--boolDontMove=true
				
				lsitTurn(oldSituation)
				Sleep(50)
				
			end
			
			
			
		end
		oldSituation=newSituation
		speedOfOld=currySpeed
		Sleep(275)
		
	end
end
contrainDef=Spring.GetUnitDefID(unitID)
function soundOSLoop()
	partTime=500
	while true do
		
		if getConstantMove()==true then
			PlaySoundByUnitType(contrainDef, "sounds/conTrain/razor_train_wheels_loop2.wav",0.35,10000,1,0)
			Sleep(4000)
			z=math.random(0,12)
			if z==9 then
				PlaySoundByUnitType(contrainDef, "sounds/conTrain/train_freight_loop2.wav",0.35,10000,1,0)
				Sleep(5000)
			end
			if z==4 then
				
				PlaySoundByUnitType(contrainDef, "sounds/conTrain/train_freight_loop1.wav",0.35,10000,1,0)
				Sleep(19000)
			end
		else
			zZzZzZ=math.random(2000,17000)
			
			while zZzZzZ > 0 and getConstantMove()== false do Sleep(partTime); zZzZzZ = zZzZzZ-partTime end
			if getConstantMove()==false then
				--he is snorring, but it could be sleep(apnoe) he should see the thread-doctor
				PlaySoundByUnitType(contrainDef, "sounds/conTrain/train_idle.wav",0.05,10000,1,0)
			end
			zZzZzZ=math.random(2000,17000)		
			while zZzZzZ > 0 and getConstantMove()== false do Sleep(partTime); zZzZzZ = zZzZzZ-partTime end
			
			
			
		end
		
		Sleep(50)
		
	end
	
end



--compares Positions, recives a Tolerancelevel, returns eiter true -> within tolerance or false -> below or above tolerance
local function positionComPair(oldPosX,newPosX,oldPosZ,newPosZ,inTolerAnceLvl)
	boolXWithinTol=false
	boolZWithinTol=false
	xTolPos=(oldPosX*inTolerAnceLvl)
	xTolNeg=oldPosX-(xTolPos-oldPosX)
	
	if newPosX < xTolPos and newPosX > xTolNeg then
		boolXWithinTol=true
	end
	
	zTolPos=(oldPosZ*inTolerAnceLvl)
	zTolNeg=oldPosZ-(zTolPos-oldPosZ)
	
	if newPosZ < zTolPos and newPosZ > zTolNeg then
		boolZWithinTol=true
	end
	
	if boolXWithinTol ==true and boolZWithinTol== true then
		return true
	else
		return false
	end
	
	
end





boolHealingActive=true
function script.StartMoving()
	boolHealingActive=false
	
end

function script.StopMoving()
	boolHealingActive=true
	
	
end


function script.Killed()
	
	if boolYouBroughtThisOnYourself ==true then return 0 end
	
	if getConstantMove()==true then
		for i=5,12,1 do
			Hide(usul[1][i])
			Hide(usul[5][i])
		end
		Turn(uCanTurnMeOn,z_axis,math.rad(-25),17)
		Turn(trainSpotThere,z_axis,math.rad(58),27)
		Show(cRailTurn)
		Move(cCTrain0,z_axis,92,30)
		for i=5,12,1 do
			
			Explode((usul[1][i]),SFX.FIRE)
			Explode((usul[5][i]),SFX.FIRE)
		end
		for i=1,6,1 do
			for a=2,12,1 do
				Explode((usul[i][a]),SFX.FALL)
				Sleep(120)
			end
		end
		WaitForMove(cCTrain0,z_axis)
	else
		for i=5,12,1 do
			Explode((usul[1][i]),SFX.FIRE)
			Explode(usul[5][i],SFX.FIRE)
		end
		for i=1,6,1 do
			for a=2,12,1 do
				Explode((usul[i][a]),SFX.FALL)
			end
		end
		
		createCorpseCUnitGeneric(recentDamage)
	end
	
	
	Explode( center , SFX.FALL)
	Explode( cCTrain0 , SFX.FALL)
	Explode( cCTrain01 , SFX.FALL)
	Explode( cCTrain02 , SFX.FALL)
	Explode( cCTrain03 , SFX.FALL)
	Explode( cRailTurn, SFX.FALL)
end

--create Script: called when the train is created/ similar to all other vehicels in Spring
function script.Create()
	initPieces()
	StartThread(healWhileStandingStill)
	Hide(cRailTurn) --hides the Piece of Railway that turns, when the train goes into turnmode
	for i=1,7,1 do
		Hide(ctgoresub[i])
	end
	
	StartThread(soundOSLoop)
	StartThread(speedUpdater)
	StartThread(turnDetector)-- starts the turndetector SENSORIC
	StartThread(movMent) -- starts the MovMentThread (OS spawning the endPillars, moving the rail in movemode)
	StartThread(AdjustPillarHeight)--the general Height Adjustmentfunction
	StartThread(PillarManager) --the SituationManager OS that retracts and unfolds Pillars depending on the Situation and the previousSituation
	StartThread(motionDetec)
	
	initScript() -- calls the intiatlisation script
	
end