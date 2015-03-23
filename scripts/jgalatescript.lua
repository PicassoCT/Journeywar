include "suddenDeath.lua"
include "toolKit.lua"

--4 Legs a 2 pieces + 1 centrall Piece + Cannon



fireGalate=piece"FireGalatea"
SailGalatea=piece"SailGalatea"
Tails={}
Tails=makeTableOfPieceNames("tail",16)
for i=1,#Tails do
Tails[i]=piece(Tails[i])
end
Pumps=makeTableOfPieceNames("coTail0",4)
for i=1,#Pumps do
Pumps[i]=piece(Pumps[i])
end

Legs=makeTableOfPieceNames("Leg",4)
for i=1,#Legs do
Legs[i]=piece(Legs[i])
end

LegLs=makeTableOfPieceNames("LegL",4)
for i=1,#LegLs do
LegLs[i]=piece(LegLs[i])
end


pieces=generateKeyPiecesTable(unitID,piece)
pieces["wholeBodyCenter"]=piece("wholeBodyCenter")
pieces["fireGalate"]=fireGalate
pieces.pumps=Pumps
pieces.leg=Legs
pieces.legl=LegLs
pieces.tails=Tails

PivotPoints={}
for i=1,9 do 
PivotPoints[#PivotPoints+1]=pieces["Medusa"..i]
end


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
return damage
end

center=piece"center"

function ImSailing()
	while true do
	Heading=Spring.GetUnitHeading(unitID)
	Heading=(Heading/32768)*3.14159
	TurnTowardsWind(SailGalatea,0.5,Heading)
	Sleep(250)
	end
end


nlswimAnimation = function (PivotPoints,pieces) 

local spGetUnitPiecePosDir		=	Spring.GetUnitPiecePosDir
local spGetUnitPiecePosition	=	Spring.GetUnitPiecePosition

	--lets keep the unit under water

	spinT(pieces.tails,2,-42,42)
	spinT(pieces.pumps,2,-42,42)
	
	wx,wy,wz=Spring.GetUnitPiecePosDir(unitID,pieces["wholeBodyCenter"])
	lx,ly,lz=Spring.GetUnitPiecePosition(unitID,pieces["wholeBodyCenter"])
	if   wy  > 0 then ly=ly-1 else ly=ly+1 end
	Move(pieces["wholeBodyCenter"],2,ly,1.35)
	
	mul =math.sin(Spring.GetGameFrame()/3000)      
	for i=2,#PivotPoints do
	Turn(PivotPoints[i],1,math.rad(90),0.2)
	Turn(PivotPoints[i],2,math.rad(27*mul),1.2)
	end
	showT(pieces.pumps)
	showT(pieces.tails)
	--Pump Animation
	for i=1, #pieces.pumps do
		if math.abs(mul) < 0.3 then
		Move(pieces.pumps[i],2,5,0.4)
		else
		Move(pieces.pumps[i],2,0,0.9)	
		end
	end
	
	mappedMul=math.max(1,math.min(math.abs(mul)/0.25,4))
	for i=1, #pieces.tails do
		if i%5 -mappedMul==0 then
		Show(pieces.tails[i])
		else
		Hide(pieces.tails[i])
		end
	end
Sleep(300) 
end

nlstopSwimAnimation= function (PivotPoints,pieces) 
	frame=Spring.GetGameFrame()
	--lets keept it afloat
	wx,wy,wz=Spring.GetUnitPiecePosDir(unitID,pieces["wholeBodyCenter"])
	lx,ly,lz=Spring.GetUnitPiecePosition(unitID,pieces["wholeBodyCenter"])
	if   wy  > 0 then ly=ly-1 else ly=ly+1 end
	Move(pieces["wholeBodyCenter"],2,ly,1.15)
	
	for i=2,#PivotPoints do
	mul =math.sin((i*300+frame)/3000)      
	Turn(PivotPoints[i],1,math.rad(0),0.2)

	Turn(PivotPoints[i],2,math.rad(mul*360),0.2)
	Move(PivotPoints[i],2,math.random(-17,3)-32,1.2)
	end
	stopSpinT(pieces.tails,2,0.3)
end

function nloutOfWaterAnimation   (PivotPoints,pieces)
recReseT(pieces,0.3)
reseT(PivotPoints,1.5)
WaitForMove(PivotPoints[1],2)
hideT(PivotPoints)
Show(PivotPoints[1])
hideT(pieces.tails)
hideT(pieces.pumps)
showT(pieces.leg)
showT(pieces.legl)

end
nlbackIntoWaterAnimation= function (PivotPoints,pieces)
reseT(pieces.leg,0.3)
reseT(pieces.legl,0.3)
WaitForTurn(pieces["LegL1"],2)
hideT(PivotPoints)
Show(PivotPoints[1])
hideT(pieces.leg)
hideT(pieces.legl)
showT(PivotPoints)
	for i=2,#PivotPoints do
	val=math.random(20,65)* (-1^math.random(1,i))
	Move(PivotPoints[i],1, val,3)
	val=math.random(-20,0)
	Move(PivotPoints[i],2, val,3)
	val=math.random(20,55)* (-1^math.random(1,i))
	Move(PivotPoints[i],3, val,3)
	Spin(PivotPoints[i],2,math.rad(math.random(-22,22)),0.01)
	Turn(PivotPoints[i],1,math.rad(90),0.2)
	end
	
end
nlwalkAnimation= function   (PivotPoints,pieces)
  hideT(pieces.pumps)
  hideT(pieces.tails)
  frame= (Spring.GetGameFrame()%250)
  boolHalfTime=frame > 125
  boolQuart= frame% 60  > 25
  
  if boolQuart==true then
    WaitForTurn(pieces["Leg3"],2)
    WaitForTurn(pieces["Leg3"],2)
    WaitForTurn(pieces["Leg1"],2)
    WaitForTurn(pieces["Leg4"],2)
  Move(PivotPoints[1],2,0,0.7)
  reseT(pieces.legl,0,0.7)
  reseT(pieces.leg,0,0.7)
  else
  Move(PivotPoints[1],2,-8,1.7)
  
  if boolHalfTime ==true then
  
  Turn(pieces["Leg1"],3,math.rad(0),0.4)
  Turn(pieces["Leg4"],3,math.rad(0),0.4)
  Turn(pieces["LegL1"],3,math.rad(0),0.3)
  Turn(pieces["LegL4"],3,math.rad(0),0.3)
  val=math.random(64,83)
  Turn(pieces["Leg1"],2,math.rad(val),0.4)
  Turn(pieces["Leg4"],2,math.rad(-1*val),0.4)
  
 
  Turn(pieces["Leg2"],3,math.rad(44),0.4)
  Turn(pieces["Leg3"],3,math.rad(-44),0.4)
  Turn(pieces["LegL2"],3,math.rad(-54),0.3)
  Turn(pieces["LegL3"],3,math.rad(54),0.3)
  val=math.random(55,80)+180
  Turn(pieces["Leg2"],2,math.rad(-1*val),0.4)
  Turn(pieces["Leg3"],2,math.rad(val),0.4)
 
  else
  
  Turn(pieces["Leg2"],3,math.rad(0),0.4)
  Turn(pieces["Leg3"],3,math.rad(0),0.4)
  Turn(pieces["LegL2"],3,math.rad(0),0.3)
  Turn(pieces["LegL3"],3,math.rad(0),0.3)
  val=math.random(64,83)
  Turn(pieces["Leg2"],2,math.rad(val),0.4)
  Turn(pieces["Leg3"],2,math.rad(-1*val),0.4)
  
 
  Turn(pieces["Leg1"],3,math.rad(44),0.4)
  Turn(pieces["Leg4"],3,math.rad(-44),0.4)
  Turn(pieces["LegL1"],3,math.rad(-54),0.3)
  Turn(pieces["LegL4"],3,math.rad(54),0.3)
  val=math.random(55,80)
  Turn(pieces["Leg1"],2,math.rad(-1*val),0.4)
  Turn(pieces["Leg4"],2,math.rad(val),0.4)

  end
  end
end

nlstopWalkAnimation= function   (PivotPoints,pieces)    
Turn(fireGalate,1,math.rad(90),0.3)
    WaitForTurn(pieces["Leg3"],2)
    WaitForTurn(pieces["Leg3"],2)
    WaitForTurn(pieces["Leg1"],2)
    WaitForTurn(pieces["Leg4"],2)

reseT(PivotPoints,0.3)
reseT(pieces.legl,0.3)
reseT(pieces.leg,0.3)
end

local stundamage=700
local stunRange=60
local feedingDamage=100
function InWaterFeedingFrenzy()

stunFunc= function (id) 
		  Spring.SetUnitHealth(id, {paralyze=700})
		  return id
		  end
	
Cache={}	
	while true do
	x,y,z=Spring.GetUnitPosition(unitID)
	
		while y < 0 do
		T=grabEveryone(unitID,x,z, stunRange)
		T,Cache=filterOutUnitsOfType(T, {[UnitDefNames["jgalatea"].id]=true},Cache)
			if T and #T > 0 then
			
			T=forTableUseFunction(T, stunFunc)
			theLuckOne=math.floor(math.random(1,#T))
			hp=Spring.GetUnitHealth(T[theLuckOne])
				if hp then hp=math.max(0,hp-feedingDamage)
				Spring.SetUnitHealth(T[theLuckOne],hp)
				hp=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(unitID,hp+feedingDamage/2)
				end
			ox,oy,oz=Spring.GetUnitPiecePosition(unitID,pieces["fireGalate"])
			Spring.SpawnCEG("jgalateatend",ox,oy,oz,0,1,0,70,0)
			
			end
		Sleep(500)
		x,y,z=Spring.GetUnitPosition(unitID)
		
		end
	Sleep(1000)
	end
end

tail1=piece("tail1")
tail2=piece("tail2")
tail3=piece("tail3")
tail4=piece("tail4")

function script.Create()

hideT(Tails)
hideT(Pumps)
StartThread(ImSailing)
StartThread(InWaterFeedingFrenzy)
StartThread( AmphibMoveThread
						 ,unitID
						 ,PivotPoints
						 ,pieces
						 ,200
						 ,10
						 ,nlswimAnimation
						 ,nlstopSwimAnimation
						 ,nloutOfWaterAnimation
						 ,nlbackIntoWaterAnimation
						 ,nlwalkAnimation
						 ,nlstopWalkAnimation)
end


function script.Killed(recentDamage,_)
--stop movement of unit
Signal(SIG_AIM)
	for k,v in pairs(pieces) do
	if type(v)=="number" then
	if maRa()==true then
	Hide(v)
	Explode(v,SFX.NO_HEATCLOUD+SFX.FALL)
		else
		StartThread(PieceDropTillStop,unitID,v,0.1,22)
		end
	elseif(type(v)=="table") then
	hideT(v)
	end
	end
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return fireGalate 
end



function script.QueryWeapon1() 
	return fireGalate
end

SIG_AIM=2
SIG_RESET=4
function script.AimWeapon1( heading ,pitch)	
Signal(SIG_AIM)
SetSignalMask(SIG_AIM)

	--aiming animation: instantly turn the gun towards the enemy
	Turn(fireGalate,y_axis,heading,3)
	Turn(fireGalate,x_axis,-pitch,3)
	WaitForTurn(fireGalate,y_axis)
	Signal(SIG_RESET)
	WaitForTurn(fireGalate,x_axis)
	return true

end
 function reset()
SetSignalMask(SIG_RESET)
Sleep(1500) 
Turn(fireGalate,x_axis,math.rad(90),1.2)
 
 end

function script.FireWeapon1()	
StartThread(reset)
	return true
end



function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end
