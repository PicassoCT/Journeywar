--Define the wheel pieces
--TODO:Get The Mobile Factory to work
--Define the pieces of the weapon

deathpivot=piece"deathpivot"
teamID=Spring.GetUnitTeam(unitID)
center=piece"Main"
stair =piece "stair"
dother =piece "dother"
roof =piece "roof"
blarot1 =piece "blarot1"
blarot2 =piece "blarot2"
blarot3 =piece "blarot3"
blarot4 =piece "blarot4"
flare=piece"flare"
blakblade1 =piece "blakblade1"
blakblade2 =piece "blakblade2"
blakblade3 =piece "blakblade3"
blakblade4 =piece "blakblader4"

AllPiecesArray= {
center=piece"Main",
stair =piece "stair",
dother =piece "dother",
roof =piece "roof",
blarot1 =piece "blarot1",
blarot2 =piece "blarot2",
blarot3 =piece "blarot3",
blarot4 =piece "blarot4",

blakblade1 =piece "blakblade1",
blakblade2 =piece "blakblade2",
blakblade3 =piece "blakblade3",
blakblade4 =piece "blakblader4"
}

function HideAllPieces()
for k in pairs( AllPiecesArray )do
Hide(k)
end
end
SIG_FOLD=2
SIG_MOVE=4
SIG_RESET=8
SIG_UNFOLD=16
SIG_BREATH=32
SIG_UPGRADE=64


boolBuilding=false
dotter={}
eggs={}
for i=1,5,1 do
dotter[i]={}
eggs[i]={}

temp1="dotter"..i
temp2="egg0"..i

dotter[i]=piece(temp1)
eggs[i]=piece(temp2)


end
leaveAbsence={}
for i=1,35,1 do
	leaveAbsence[i]={}
	tempEL="leaf"..i
	leaveAbsence[i]=piece(tempEL)

	end

appendix={}
for i=1,7,1 do
appendix[i]={}
appendix[i+7]={}
temp1="apendix0"..i
temp2="sloptec0"..i
appendix[i]=piece(temp1)
appendix[i+7]=piece(temp2)

end

feetFetish={}
for i=1, 6, 1 do
feetFetish[i]={}
feetFetish[i][1]={}-- the Upper joint
feetFetish[i][2]={} -- upper leg
feetFetish[i][3]={} --lower joint
feetFetish[i][4]={} --lower leg
feetFetish[i][5]={} --dirt emitter

temp1= "UpJoin0"..i
temp2= "UpLeg0"..i
temp3= "LoJoin0"..i
temp4= "LoLeg0"..i
temp5= "DirEmit"..i

feetFetish[i][1]=piece(temp1)-- the Upper joint
feetFetish[i][2]=piece(temp2) -- upper leg
feetFetish[i][3]=piece(temp3) --lower joint
feetFetish[i][4]=piece(temp4) --lower leg
feetFetish[i][5]=piece(temp5) --dir emitter
end

function UpdateUnitPosition(ParentID, UnitID, attach)
   local px, py, pz, _, _, _ = Spring.GetUnitPiecePosDir(ParentID, attach)
   local rx, ry, rz = Spring.GetUnitPieceRotation(ParentID, attach)
    Spring.MoveCtrl.SetPhysics(UnitID, px, py, pz+4, 0, 0, 0, rx, ry, rz)
end
      
function GetUnitPieceRotation(unitID, piece)
   local rx, ry, rz = Spring.UnitScript.CallAsUnit(unitID, spGetPieceRotation, piece)
   local Heading = Spring.GetUnitHeading(unitID) --COB format
   local dy = rad(Heading / 182)
   return rx, dy + ry, rz
end



factoryID=nil
----aimining & fire weapon
function newFactory ()
  if GG.JFactorys == nil then GG.JFactorys={} end
   local x,y,z = Spring.GetUnitPosition(unitID)
   teamID = Spring.GetUnitTeam (unitID)
   factoryID = Spring.CreateUnit ("jtrafactory", x,y+40,z+20, 0, teamID) 
   GG.JFactorys[factoryID]={}
   GG.JFactorys[factoryID][1]= unitID 
   GG.JFactorys[factoryID][2]= false
   Spring.SetUnitNoSelect(unitID,true)
   Spring.MoveCtrl.Enable(factoryID,true)  
   Spring.SetUnitNeutral(factoryID,true)
   Spring.SetUnitBlocking (factoryID,false,false)
   
end



function ThreadLauncher()
local time=math.ceil(math.random(1500,8000))
	while true do
		while not GG.jJourneyWon or GG.jJourneyWon == false do
		Sleep(time)
		end


	StartThread(LaunchSkywards)
	Sleep(100000)
	end
end




--Launches the factory after gameend
function LaunchSkywards()
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitBlocking(unitID,false)

--Dust
Turn(stair,z_axis,math.rad(124),2.9)
Sleep(delTime)
Signal(SIG_MOVE)
Turn(stair,z_axis,math.rad(0),5)
CountDown=9
naptime=4500
Signal(SIG_BREATH)
	while naptime > 0 do
		--launchEcho()
		for i=1,6,1 do
		EmitSfx(feetFetish[i][5],1024)	
		end

	naptime=naptime-50
	Sleep(50)
	end
	Signal(SIG_MOVE)
--Lights
Sleep(350)
speed=0.60
distanceMax=19000
--launchEcho()


	--launchEcho()
	Move(deathpivot,y_axis,distanceMax,speed)
		while(true==Spring.UnitScript.IsInMove(deathpivot, y_axis)) do
		Signal(SIG_BREATH)
		Signal(SIG_MOVE)
		EmitSfx(flare,1028)		
		Sleep(250)
		speed=math.min(speed+speed,42)
		Move(deathpivot,y_axis,distanceMax,speed)
		end

		
	HideAllPieces()
end

function updateBoolisBuilding()
while  GG.JFactorys== nil or GG.JFactorys[factoryID]== nil do
Sleep(150)
end

	while true do
		if GG.JFactorys[factoryID][2]==true then
		--Spring.Echo("JW:Firstborn:Building")
		boolBuilding=true
		else 
		--Spring.Echo("JW:Firstborn:Not building")
		boolBuilding=false
		end


	Sleep(500)
	end

end

function moveFactory ()
local spGetUnitPosition=Spring.GetUnitPosition
local spMovCtrlSetPos=Spring.MoveCtrl.SetPosition
local spValidUnitID=Spring.ValidUnitID
local LGetUnitPieceRotation=GetUnitPieceRotation
local LUpdateUnitPosition=UpdateUnitPosition

   while (true) do
      if (not spValidUnitID (factoryID)) then newFactory () end
      local x,y,z = spGetUnitPosition (unitID)	 
	 spMovCtrlSetPos(factoryID,x,y+50,z+2)
      Sleep (5)
   end
end

lightEmit=piece "lightEmit"
function emitLight()
	while(true) do
	EmitSfx(lightEmit,1026)
	Sleep(50)
	end
end

function fruitLoop()
	while(boolBuilding==true) do
	EmitSfx(lightEmit,1027)
	Sleep(50)
	end
end


function dropLeave(i)
Spin(leaveAbsence[i],y_axis,math.rad(62),0.1)
Move(leaveAbsence[i],y_axis,-12,2.81)
WaitForMove(leaveAbsence[i],y_axis)
Move(leaveAbsence[i],y_axis,-32,5.81)
WaitForMove(leaveAbsence[i],y_axis)
Move(leaveAbsence[i],y_axis,-92,9.81)
WaitForMove(leaveAbsence[i],y_axis)
Hide(leaveAbsence[i])
StopSpin(leaveAbsence[i],y_axis)
Move(leaveAbsence[i],y_axis,0,0)
randtime=math.ceil(math.random(100,1600))
Sleep(randtime)

x=math.random(0,360)
y=math.random(0,360)
z=math.random(0,360)
randSpeed=math.random(0.01,0.05)
Turn(leaveAbsence[i],x_axis,math.rad(x),randSpeed)
Turn(leaveAbsence[i],y_axis,math.rad(y),randSpeed)
Show(leaveAbsence[i])


end

function growth()
	for i=1,35,1 do
	x=math.random(0,360)
	y=math.random(0,360)
	z=math.random(0,360)
	randSpeed=math.random(0.01,0.05)
	one=math.random(0,7)
		if one== 1 then 
		deCidre=math.ceil(math.random(1,34))
		StartThread(dropLeave,deCidre)
		end
	Turn(leaveAbsence[i],x_axis,math.rad(x),randSpeed)
	Turn(leaveAbsence[i],y_axis,math.rad(y),randSpeed)
	Turn(leaveAbsence[i],z_axis,math.rad(z),randSpeed)
	end


end

function wiggleEggs()
	while(true) do
		
		for i=1,table.getn(eggs) do
		diceBeNice=math.random(0,1)
			if diceBeNice==1 then
			randspeed=math.random(0.5,5)
			x=math.random(-20,20)
			Turn(eggs[i],x_axis,math.rad(randspeed),randspeed)
			z=math.random(-20,20)
			Turn(eggs[i],z_axis,math.rad(randspeed),randspeed)
			end
		end

	randI=math.ceil(math.random(100,400))
	Sleep(randI)
	end
end

function script.Killed(recentDamage, maxHealth)
Spring.DestroyUnit(factoryID,true,false)
GG.JFactorys[factoryID]=nil
return 0
	----Spring.Echo ("He is dead, Jim!")
end
--Building


comonValue=0
comonSpeed=0.04


lightEmit=piece "lightEmit"
function emitLight()
local spEmitSfx=EmitSfx
	while(true) do
	spEmitSfx(lightEmit,1026)
	Sleep(50)
	end
end


boolOnlyOnce=true
function circler()
----Spring.Echo("Wee Im alive!")

----Spring.Echo("Not dead yet!")
	while(true) do
----Spring.Echo("Wonna go for a walk!")
	if boolBuilding==true then 	
		Signal(SIG_FOLD)
		StartThread(unfold)

		
----Spring.Echo("I feel happy!")
					
					templ=0
					while(boolBuilding==true) do
					Spin(dother,y_axis,math.rad(0.2),0.02)
					rand=math.random(-2,2)
					Sleep(50)
					Move(dotter[1],y_axis,-75+rand,0.15)
					Turner=math.random(-3,3)
					Turn(dotter[5],x_axis,math.rad(Turner),0.05)
					Turner=math.random(-3,3)
					Turn(dotter[5],z_axis,math.rad(Turner),0.05)
					Turner=math.random(-3,3)
					Turn(dotter[5],y_axis,math.rad(Turner),0.05)
					WaitForTurn(dotter[1],y_axis)
					Spin(dother,y_axis,math.rad(-0.2),0.02)
					rand=math.random(-2,2)
					Move(dotter[1],y_axis,-72+rand,0.15)
					Turn(dotter[5],x_axis,math.rad(Turner),0.05)
					Turner=math.random(-3,3)
					Turn(dotter[5],z_axis,math.rad(Turner),0.05)
					Turner=math.random(-3,3)
					Turn(dotter[5],y_axis,math.rad(Turner),0.05)
					WaitForTurn(dotter[1],y_axis)		
					Sleep(50)
----Spring.Echo(budProgress)
							if templ%100== 0 then
							StartThread(fruitLoop)							
							StartThread(growth)	
							end
							if templ > 1000 then templ=0 end
					templ=templ+10						
						
					Sleep(templ)
					end
		else
			Signal(SIG_UNFOLD)
			StartThread(fold,false)	
			
		end
	
	Sleep(25)
	end
end

--[[ function positionSetter(handedOverBuildprogress)
boolOnlyOnce=false
Move(buildMove,y_axis,-40,45)
Move(buildMove,x_axis,-113,55)


WaitForMove(buildMove,y_axis)
WaitForMove(buildMove,x_axis)
	while handedOverBuildprogress > budProgress do
	Sleep(50)
	end

Move(buildMove,x_axis,0,0)
Move(buildMove,y_axis,0,0)
Sleep(10)
boolOnlyOnce=true
end ]]

function limitComonValue(comonValue)
	sign=comonValue/math.abs(comonValue)
--	Spring.Echo("JW_FIRSTBORN::Limit"..math.min(43,math.abs(comonValue))*sign)
	return math.min(43,math.abs(comonValue))*sign
end

function sloppyTechLoop()
StartThread(emitLight)
	while(true) do
		for i=1,table.getn(appendix),1 do
		Turn(appendix[i],x_axis,math.rad(comonValue),comonSpeed)
		end
		WaitForTurn(appendix[#appendix],x_axis)
		comonValue= -0.981*comonValue
		
		--Spring.Echo("Comon Values we hold high!", comonValue)
		
	for i=1,table.getn(appendix),1 do
	Turn(appendix[i],x_axis,math.rad(limitComonValue(comonValue)),comonSpeed)
	end

		if math.abs(comonValue) < 0.05 then
		
		WaitForTurn(appendix[#appendix],x_axis)
		Sleep(50)
		else
		WaitForTurn(appendix[#appendix],x_axis)
		end

	comonValue= -0.981*comonValue
	comonSpeed=0.989*comonSpeed
	Sleep(50)
	end

end

function calSpeed()
return  math.sqrt(math.abs(2*comonValue)+0.3)/50
end

function breath()
SetSignalMask(SIG_BREATH)
--initstuff
Move(center,y_axis,-30,0)
Move(center,y_axis,-20,8.7)
Turn(center,x_axis,math.rad(7),0.5)
comonValue=comonValue+7
Turn(roof,x_axis,math.rad(0.5),0.035)

WaitForTurn(center,x_axis)
WaitForMove(center,y_axis)
Turn(center,x_axis,math.rad(-7),0.5)
comonValue=comonValue-7
Move(center,y_axis,-10,8.7)
WaitForTurn(center,x_axis)
WaitForMove(center,y_axis)
Turn(center,x_axis,math.rad(0),0.5)
Turn(roof,x_axis,math.rad(0),0.035)
Move(center,y_axis,0,8.7)
WaitForMove(center,y_axis)


	while(true) do
	Turn(stair,z_axis,math.rad(-11),0.055)
	Turn(center,x_axis,math.rad(1),0.005)
	Turn(roof,x_axis,math.rad(-0.5),0.0025)

	comonValue=comonValue-1.411
	comonSpeed=calSpeed()



	Move(center,y_axis,-0.75,0.2)

	Move(blakblade1,z_axis,-5,1.3)
	Move(blakblade2,z_axis,-5,1.3)
	Move(blakblade3,z_axis,-5,1.3)
	Move(blakblade4,z_axis,-5,1.3)

	StartThread(leave)
	WaitForMove(center,y_axis)
	Turn(center,x_axis,math.rad(-1),0.005)
	Turn(roof,x_axis,math.rad(0.5),0.0025)
	Turn(stair,z_axis,math.rad(0),0.055)
	comonValue=comonValue+1.5
	Move(center,y_axis,0.5,0.2)

	Move(blakblade1,z_axis,0,1.3)
	Move(blakblade2,z_axis,0,1.3)
	Move(blakblade3,z_axis,0,1.3)
	Move(blakblade4,z_axis,0,1.3)
	Sleep(50)
	WaitForMove(center,y_axis)
	StartThread(leave)
	end
end

function leave()
	for i=1,35,1 do
	x=math.random(0,360)
	y=math.random(0,360)
	z=math.random(0,360)
	tempEL="leaf"..i
	tempEL=piece(tempEL)
	Turn(tempEL,x_axis,math.rad(x),0.34)
	Turn(tempEL,y_axis,math.rad(y),0.34)
	Turn(tempEL,z_axis,math.rad(z),0.34)
	end
end

function unfold()
--Spring.Echo("Reaching UNFolD")
SetSignalMask(SIG_UNFOLD)
		Move(dotter[1],y_axis,-65,0)
		for i=1, #dotter do
		Hide(dotter[i])
		end




Move(dotter[5],y_axis,0,12)
Show(dotter[5])
Show(dotter[4])

Move(dotter[1],y_axis,-55,22.5)
WaitForMove(dotter[1],y_axis) 
Show(dotter[3])

Move(dotter[1],y_axis,-45,22.5)
WaitForMove(dotter[1],y_axis) 
Show(dotter[2])

Move(dotter[1],y_axis,-34,22.5)
 WaitForMove(dotter[1],y_axis) 

Show(dotter[1])

Move(dotter[1],y_axis,0,22.5)
WaitForMove(dotter[1],y_axis) 

boolFolded=false
end

function fold(boolInstant)
--Spring.Echo("ReachingFolD")
SetSignalMask(SIG_FOLD)
	
		
	if boolInstant==true then
	Move(dotter[1],y_axis,-65,0)

		for i=1, #dotter do
		Hide(dotter[i])
		end

	else
	Move(dotter[1],y_axis,-17,35.5)
	WaitForMove(dotter[1],y_axis) 
	Hide(dotter[1])
	
	Move(dotter[1],y_axis,-34,35.5)
	WaitForMove(dotter[1],y_axis) 
	Hide(dotter[2])

	Move(dotter[1],y_axis,-45,37.5)
	WaitForMove(dotter[1],y_axis) 
	Hide(dotter[3])

	Move(dotter[1],y_axis,-55,35.5)
	WaitForMove(dotter[1],y_axis) 
	Hide(dotter[4])

	Move(dotter[1],y_axis,-65,35.5)
	WaitForMove(dotter[1],y_axis)

	Hide(dotter[5])
	end
boolFolded=true
end

function script.Create()
Spring.SetUnitNoSelect(unitID,true)
x,y,z=Spring.GetUnitPosition(unitID)
Spring.SetUnitMoveGoal(unitID,x-20,y,z)
Hide(flare)

Turn(blarot1,y_axis,math.rad(28.3),0)
Turn(blarot2,y_axis,math.rad(-31.5),0)
Turn(blarot3,y_axis,math.rad(-149.7),0)
Turn(blarot4,y_axis,math.rad(-210),0)
StartThread(wiggleEggs)
StartThread(updateBoolisBuilding)
leave()

Move(dotter[1],y_axis,-70,0)
	for i=1,5,1 do
	Hide(dotter[i])
	end

StartThread(sloppyTechLoop)
StartThread(breath)
StartThread(circler)
StartThread(ThreadLauncher)


end

function liftFeet(nr)
signed=1
	if nr== 3 or nr ==6 or nr==1 then
	signed=-1
	end
Turn(feetFetish[nr][1],z_axis,math.rad(19*signed),1.7)
Turn(feetFetish[nr][3],z_axis,math.rad(9*signed),1.7)

end

function TurnF(nr,deg,boolWait)
Turn(feetFetish[nr][1],y_axis,math.rad(deg),2)
if boolWait== nil or boolWait==true then
WaitForTurn(feetFetish[nr][1],y_axis)
end

end

function lowerFeet(nr,boolWait)
Turn(feetFetish[nr][1],z_axis,math.rad(0),1.7)
Turn(feetFetish[nr][3],z_axis,math.rad(0),1.7)
	if boolWait== nil or boolWait==true then
	WaitForTurn(feetFetish[nr][1],x_axis)
	WaitForTurn(feetFetish[nr][3],x_axis)
	end

EmitSfx(feetFetish[nr][5],1024)

end

function moveIt()
SetSignalMask(SIG_MOVE)
comonSpeed=0.2
	while(true) do

	lowerFeet(1,false)

	liftFeet(3)
	liftFeet(5)
	lowerFeet(2,true)
	Turn(center,y_axis,math.rad(2),0.1)
	Turn(roof,x_axis,math.rad(0.5),0.025)
	comonValue=comonValue-5

	TurnF(3,40,false)
	TurnF(5,-30,true)
	lowerFeet(3,false)
	lowerFeet(5,false)
	TurnF(1,0,false)
	TurnF(2,0,false)
	liftFeet(4)
	liftFeet(6)
	WaitForTurn(center,y_axis)
	Turn(center,y_axis,math.rad(-2),0.1)
	Turn(roof,x_axis,math.rad(-0.5),0.025)
	comonValue=comonValue+5
	comonSpeed=0.2
	TurnF(4,-56,false)
	TurnF(6,57,true)
	
	lowerFeet(4,false)
	lowerFeet(6,false)
	TurnF(3,0,false)
	TurnF(5,0,false)
	liftFeet(1)
	liftFeet(2)
	TurnF(1,56,false)
	TurnF(2,-50,true)
	TurnF(4,0,false)
	TurnF(6,0,false)
	Sleep(50)
	WaitForTurn(center,y_axis)
	Sleep(10)
	end
end
justOnce=true
function script.StartMoving()
Signal(SIG_MOVE)
StartThread(moveIt)								
	if justOnce==true then
	StartThread(moveFactory)
	justOnce=false
	end																		
end

function legs_down()
	for i=1,table.getn(feetFetish),1 do
		for j=1,4, 1 do
		Turn(feetFetish[i][j],x_axis,math.rad(0),3.141)
		Turn(feetFetish[i][j],y_axis,math.rad(0),3.141)
		Turn(feetFetish[i][j],z_axis,math.rad(0),3.141)
		end
		Turn(roof,x_axis,math.rad(0),0.025)
	end

end



function script.StopMoving()
Turn(center,y_axis,math.rad(0),0.2)
Signal(SIG_MOVE)

legs_down()
end




function script.Activate()

return 1
end

function script.Deactivate()

return 0
end