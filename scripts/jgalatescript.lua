include "suddenDeath.lua"
include "toolKit.lua"

--4 Legs a 2 pieces + 1 centrall Piece + Cannon

 

fireGalate=piece"FireGalatea"
SailGalatea=piece"SailGalatea"
IndivPoints={}
Tails=makeTableOfPieceNames("tail",1,16)
Tails=forTableUseFunction(Tails,piece,function(get)return get end)
Pumps=makeTableOfPieceNames("coTail0",1,4)
Pumps=forTableUseFunction(Pumps,piece,function(get)return get end)
Legs=makeTableOfPieceNames("Leg",1,4)
Legs=forTableUseFunction(Legs,piece,function(get)return get end)
LegLs=makeTableOfPieceNames("LegL",1,4)
LegLs=forTableUseFunction(LegLs,piece,function(get)return get end)


pieces=generateKeyPiecesTable(unitID,piece)
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
	TurnTowardsWind(SailGalatea,0.5,1.57079632679)
	Sleep(250)
	end
end


function nlswimAnimation(PivotPoints,pieces) 
spinT(pieces.tails,y_axis,-42,42)
	mul =math.sin(Spring.GetGameFrame()/3000)      
	for i=2,#PivotPoints do
	Turn(PivotPoints[i],x_ais,math.rad(90),0.2)
	Turn(PivotPoints[i],y_axis,math.rad(27*mul),1.2)
	end
	
	--Pump Animation
	for i=1, #pieces.pumps do
		if math.abs(mul) < 0.3 then
		Move(pieces.pumps[i],y_axis,5,0.4)
		else
		Move(pieces.pumps[i],y_axis,0,0.9)	
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

function nlstopSwimAnimation(PivotPoints,pieces) 
	frame=Spring.GetGameFrame()
	for i=1,#PivotPoints do
	mul =math.sin((i*300+frame)/3000)      
	Turn(PivotPoints[i],x_ais,math.rad(0),0.2)
	Turn(PivotPoin ts[i],y_axis,math.rad(mul*360),0.2)
	Move(PivotPoints[i],y_axis,math.random(-17,3),1.2)
	end
	stopSpinT(pieces.tails,y_axis,0.3)
end

function nloutOfWaterAnimation   (PivotPoints,pieces)
reseT(pieces,0.3)
reseT(PivotPoints,5)
WaitForMove(PivotPoints[1],y_axis)
hideT(PivotPoints)
hideT(pieces.tails)
hideT(pieces.pumps)
showT(pieces.leg)
showT(pieces.legl)

end
function nlbackIntoWaterAnimation(PivotPoints,pieces)
	for i=1,#PivotPoints do
	val=math.random(20,65)* (-1^math.random(1,i))
	Move(PivotPoints[i],x_axis, val,3)
	val=math.random(20,65)* (-1^math.random(1,i))
	Move(PivotPoints[i],z_axis, val,3)
	Spin(PivotPoints[i],y_axis,math.rad(math.random(-22,22)),0.01)
	Turn(PivotPoints[i],x_ais,math.rad(90),0.2)
	end
end
function nlwalkAnimation  (PivotPoints,pieces)
  
  frame= (Spring.GetGameFrame()%150)
  boolHalfTime=frame > 75
  boolQuart= frame% 37 < 15
  
  if boolQuart==true then
  Move(PivotPoints[1],y_axis,0,0.7)
  reseT(pieces.legl,1.3)
  reset(pieces.leg,1.3)
  else
  Move(PivotPoints[1],y_axis,-8,1.7)
  
  if boolHalfTime ==true then
  
  Turn(pieces["Leg1"],z_axis,math.rad(0),12)
  Turn(pieces["Leg4"],z_axis,math.rad(0),12)
  Turn(pieces["LegL1"],z_axis,math.rad(0),9)
  Turn(pieces["LegL4"],z_axis,math.rad(0),9)
  val=math.random(64,83)
  Turn(pieces["Leg1"],y_axis,math.rad(val),4)
  Turn(pieces["Leg4"],y_axis,math.rad(-1*val),4)
  
 
  Turn(pieces["Leg2"],z_axis,math.rad(44),12)
  Turn(pieces["Leg3"],z_axis,math.rad(-44),12)
  Turn(pieces["LegL2"],z_axis,math.rad(-54),9)
  Turn(pieces["LegL3"],z_axis,math.rad(54),9)
  val=math.random(55,80)
  Turn(pieces["Leg2"],y_axis,math.rad(-1*val),4)
  Turn(pieces["Leg3"],y_axis,math.rad(val),4)
  
  else
  
  Turn(pieces["Leg2"],z_axis,math.rad(0),12)
  Turn(pieces["Leg3"],z_axis,math.rad(0),12)
  Turn(pieces["LegL2"],z_axis,math.rad(0),9)
  Turn(pieces["LegL3"],z_axis,math.rad(0),9)
  val=math.random(64,83)
  Turn(pieces["Leg2"],y_axis,math.rad(val),4)
  Turn(pieces["Leg3"],y_axis,math.rad(-1*val),4)
  
 
  Turn(pieces["Leg1"],z_axis,math.rad(44),12)
  Turn(pieces["Leg4"],z_axis,math.rad(-44),12)
  Turn(pieces["LegL1"],z_axis,math.rad(-54),9)
  Turn(pieces["LegL4"],z_axis,math.rad(54),9)
  val=math.random(55,80)
  Turn(pieces["Leg1"],y_axis,math.rad(-1*val),4)
  Turn(pieces["Leg4"],y_axis,math.rad(val),4)
  end
  end
end
function nlstopWalkAnimation  (PivotPoints)    
end

function script.Create()

StartThread(ImSailing)
StartThread( AmphibMoveThread
						 ,PivotPoints
						 ,pieces
						 ,200
						 ,32
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
	for i=1,#ActualPieces do
	if maRa()==true then
	Hide(ActualPieces[i])
	Explode(ActualPieces[i],SFX.NO_HEATCLOUD+SFX.FALL)
		else
		StartThread(PieceDropTillStop,unitID,ActualPieces[i],0.1,22)
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

local SIG_AIM=2

function script.AimWeapon1( Heading ,pitch)	
Signal(SIG_AIM)
SetSignalMask(SIG_AIM)
	--aiming animation: instantly turn the gun towards the enemy
	Turn(fireGalate,y_axis,-heading,3)
	Turn(fireGalate,x_axis,pitch,3)
	WaitForTurn(fireGalate,y_axis)
	WaitForTurn(fireGalate,x_axis)
	return true

end
 

function script.FireWeapon1()	

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
