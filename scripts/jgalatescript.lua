include "suddenDeath.lua"
include "toolKit.lua"

--4 Legs a 2 pieces + 1 centrall Piece + Cannon

 

fireGalate=piece"FireGalatea"
SailGalatea=piece"SailGalatea"
IndivPoints={}
pieces=generateKeyPiecesTable(unitID,piece)

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

	mul =math.sin(Spring.GetGameFrame()/3000)      
	for i=2,#PivotPoints do
	Turn(PivotPoints[i],x_ais,math.rad(90),0.2)
	Turn(PivotPoints[i],y_axis,math.rad(27*mul),1.2)
	end
	
	--Pump Animation
	for i=1, #PumpPieces do
	if math.abs(mul) < 0.3 then
	
	else
	
	
	ende
	end

Sleep(300) 
end

function nlstopSwimAnimation(PivotPoints,pieces) 
	frame=Spring.GetGameFrame()
	for i=1,#PivotPoints do
	mul =math.sin((i*300+frame)/3000)      
	Turn(PivotPoints[i],x_ais,math.rad(0),0.2)
	Turn(PivotPoints[i],y_axis,math.rad(mul*360),0.2)
	Move(PivotPoints[i],y_axis,math.random(-7,7),1.2)
	end

end
function nloutOfWaterAnimation   (PivotPoints,pieces)

resT(PivotPoints,5)


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
function nlwalkAnimation  (PivotPoints)
       
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
