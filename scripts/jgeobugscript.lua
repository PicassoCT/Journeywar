
include "lib_UnitScript.lua" 
 include "lib_anim.lua"


local jbug = piece "jbug"
local jbugleg1 = piece "bugleg1"
local jbugleg2 = piece "bugleg2"
local jbugleg3 = piece "bugleg3"
local jbugleg4 = piece "bugleg4"
local Turner = piece "center"

pieceTable={
[1] = jbug , 
[2] = jbugleg1,
[3] =  jbugleg2 ,
[4] =  jbugleg3 ,
[5] =  jbugleg4 ,
[6] =  Turner
}


--define other pieces

local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_LEG=4
local SIG_STOP= 8
local SIG_AIM2=16
local SIG_DEFAULT=32

DeathTurner=piece"DeathTurner"
FrontLeg ={
[1] = {Up =jbugleg3 },
[2] = {Up =jbugleg1 }
}
RearLeg={
[1] = {Up =jbugleg2 },
[2] = {Up =jbugleg4 }
}

function legs_down()
	Sleep(550)
	Move(Turner,x_axis,0,12)
	Move(Turner,y_axis,0,12)
	Move(Turner,z_axis,0,12)
	Turn(Turner,x_axis,math.rad(0),12)
	Turn(Turner,y_axis,math.rad(0),12)
	Turn(Turner,z_axis,math.rad(0),12)
	
	Turn(jbug,x_axis,math.rad(0),12)
	Turn(jbug,y_axis,math.rad(0),12)
	Turn(jbug,z_axis,math.rad(0),12)
	Turn(jbugleg1,x_axis,math.rad(0),12)
	Turn(jbugleg1,y_axis,math.rad(0),12)
	Turn(jbugleg1,z_axis,math.rad(0),12)
	Turn(jbugleg2,x_axis,math.rad(0),12)
	Turn(jbugleg2,y_axis,math.rad(0),12)
	Turn(jbugleg2,z_axis,math.rad(0),12)
	Turn(jbugleg3,x_axis,math.rad(0),12)
	Turn(jbugleg3,y_axis,math.rad(0),12)
	Turn(jbugleg3,z_axis,math.rad(0),12)
	Turn(jbugleg4,x_axis,math.rad(0),12)
	Turn(jbugleg4,y_axis,math.rad(0),12)
	Turn(jbugleg4,z_axis,math.rad(0),12)
	WaitForTurn(jbugleg1,x_axis)
	WaitForTurn(jbugleg1,y_axis)
	WaitForTurn(jbugleg1,z_axis)
	WaitForTurn(jbugleg2,x_axis)
	WaitForTurn(jbugleg2,y_axis)
	WaitForTurn(jbugleg2,z_axis)
	WaitForTurn(jbugleg3,x_axis)
	WaitForTurn(jbugleg3,y_axis)
	WaitForTurn(jbugleg3,z_axis)
	WaitForTurn(jbugleg4,x_axis)
	WaitForTurn(jbugleg4,y_axis)
	WaitForTurn(jbugleg4,z_axis)
	
	
end

function animationLoop()
	while true do

		while boolWalking == true do
		 walk() 
		end
		
		legs_down()
		
		while boolWalking == false do
			if math.random(0,6)==1 then
				idle()
			else
			Sleep(500)
			end
		end
		legs_down()
	Sleep(100)

	end

end

function walk()
	

		
		--left forwards back left down
		Turn(jbug,x_axis,math.rad(7),7)
		Turn(jbug,y_axis,math.rad(-8),4)
		
		Turn(jbugleg1,x_axis,math.rad(-12),3)
		Turn(jbugleg1,y_axis,math.rad(-18),16)
		Turn(jbugleg1,z_axis,math.rad(6),7)
		
		Turn(jbugleg2,x_axis,math.rad(28),3)
		Turn(jbugleg2,y_axis,math.rad(-57),12)
		Turn(jbugleg2,z_axis,math.rad(0),6)
		
		Turn(jbugleg3,x_axis,math.rad(18),3)
		Turn(jbugleg3,y_axis,math.rad(-73),14)
		Turn(jbugleg3,z_axis,math.rad(-14),15)
		
		Turn(jbugleg4,x_axis,math.rad(3),8)
		Turn(jbugleg4,y_axis,math.rad(-26),7)
		Turn(jbugleg4,z_axis,math.rad(-34),6)
		
		WaitForTurn(jbugleg3,y_axis)
		WaitForTurn(jbugleg4,x_axis)
		WaitForTurn(jbugleg1,y_axis)
		Sleep(10)
		--middle Up -- feet back together
		Turn(jbug,x_axis,math.rad(-9),7)
		Turn(jbug,y_axis,math.rad(8),4)
		
		
		
		Turn(jbugleg2,x_axis,math.rad(29),3)
		Turn(jbugleg2,y_axis,math.rad(-12),7)
		Turn(jbugleg2,z_axis,math.rad(30),6)
		
		Turn(jbugleg3,x_axis,math.rad(-24),3)
		Turn(jbugleg3,y_axis,math.rad(15),14)
		Turn(jbugleg3,z_axis,math.rad(1),15)
		
		Turn(jbugleg1,x_axis,math.rad(-8),3)
		Turn(jbugleg1,y_axis,math.rad(45),5)
		Turn(jbugleg1,z_axis,math.rad(8),7)
		
		Turn(jbugleg4,x_axis,math.rad(4),12)
		Turn(jbugleg4,y_axis,math.rad(37),7)
		Turn(jbugleg4,z_axis,math.rad(-5),6)
		
		
		WaitForTurn(jbugleg1,z_axis)
		WaitForTurn(jbugleg4,z_axis)
		WaitForTurn(jbugleg1,y_axis)
		Sleep(10)
		
		Turn(jbugleg2,x_axis,math.rad(0),3)
		Turn(jbugleg2,y_axis,math.rad(-12),7)
		Turn(jbugleg2,z_axis,math.rad(30),6)
		
		Turn(jbugleg3,x_axis,math.rad(-24),3)
		Turn(jbugleg3,y_axis,math.rad(15),14)
		Turn(jbugleg3,z_axis,math.rad(1),15)
		
		Turn(jbugleg1,x_axis,math.rad(5),3)
		Turn(jbugleg1,y_axis,math.rad(45),5)
		Turn(jbugleg1,z_axis,math.rad(8),7)
		
		Turn(jbugleg4,x_axis,math.rad(13),12)
		Turn(jbugleg4,y_axis,math.rad(37),7)
		Turn(jbugleg4,z_axis,math.rad(-5),6)
		
		
		WaitForTurn(jbugleg1,z_axis)
		WaitForTurn(jbugleg4,z_axis)
		WaitForTurn(jbugleg1,y_axis)
		Sleep(10)
		
		Turn(jbugleg1,x_axis,math.rad(0),9)
		Turn(jbugleg1,y_axis,math.rad(0),9)
		Turn(jbugleg1,z_axis,math.rad(0),9)
		
		Turn(jbugleg3,x_axis,math.rad(0),9)
		Turn(jbugleg3,y_axis,math.rad(0),9)
		Turn(jbugleg3,z_axis,math.rad(0),9)
		
		Turn(jbugleg2,x_axis,math.rad(0),9)
		Turn(jbugleg2,y_axis,math.rad(0),9)
		Turn(jbugleg2,z_axis,math.rad(0),7)
		
		Turn(jbugleg4,x_axis,math.rad(0),9)
		Turn(jbugleg4,y_axis,math.rad(0),9)
		Turn(jbugleg4,z_axis,math.rad(0),9)
		
		WaitForTurn(jbugleg1,z_axis)
		WaitForTurn(jbugleg4,z_axis)
		WaitForTurn(jbugleg1,y_axis)
	end

boolWalking = false

function script.StartMoving()
	Signal(SIG_STOP)
	boolWalking = true
	
end

function idle()

	speed=math.random(3.5,9)
	Turn(jbug,z_axis,math.rad(-36),speed)
	Turn(jbugleg3,z_axis,math.rad(53),speed*2)
	Turn(jbugleg2,z_axis,math.rad(46),speed*2)
	Turn(jbugleg1,z_axis,math.rad(57),speed*2)
	Turn(jbugleg4,z_axis,math.rad(42),speed*2)
	Sleep(570)
	t=math.random(0,5)
	auslenkung=math.random(10,16)
	for i=1,t,1 do
		Turn(jbug,x_axis,math.rad(auslenkung),6)
		Turn(Turner,y_axis,math.rad(auslenkung*-1),6)
		Turn(jbugleg3,z_axis,math.rad(46),speed*2)
		Turn(jbugleg1,z_axis,math.rad(63),speed*2)
		Turn(jbugleg2,z_axis,math.rad(23),speed*2)
		Turn(jbugleg4,z_axis,math.rad(53),speed*2)
		WaitForTurn(jbug,x_axis)
		
		Turn(jbug,x_axis,math.rad(auslenkung*-1),6)
		Turn(Turner,y_axis,math.rad(auslenkung),6)
		WaitForTurn(jbug,x_axis)
	end
	
	Sleep(600)
	time = 0.1
	for i= 1, 3 do
			factor= math.abs(math.cos(time))
			value= factor *47
			time = time +0.2
			dice= math.ceil(math.random(0,3))
			if dice == 1 then
			idleLoop(jbug,x_axis, FrontLeg, RearLeg, value *-1, value * 0.5,  value/9, 500, true)		
			end
			if dice == 2 then
			idleLoop(jbug, x_axis,FrontLeg, RearLeg, math.random(-23,23), math.random(-13,13),  value/9 , 700, true)				
			end
			if dice == 3 then
			randsign = math.random(-1,1)
			randsign= randsign/math.abs(randsign) * value
			if math.abs(randsign) < 47 and math.abs(randsign) > 3.14159 then
			
			idleLoop(jbug, y_axis,FrontLeg, RearLeg, randsign, 1  ,  value/9 , 700, true)				
			end
			end
	
		reseT(pieceTable,1 , true, true)
		
		if math.random(0,7)== 3 then
		Sleep(7000)
		end
	end

end

function delayedStop()
SetSignalMask(SIG_STOP)
Sleep(600)
boolWalking = false
end

function script.StopMoving()
Signal(SIG_STOP)
StartThread(delayedStop)	
end


function defaultEnemy()

x,y,z = Spring.GetUnitPosition(unitID)
oldX, oldZ = x+1,z+1
	while x ~= oldX and z ~= oldZ do
	oldX, oldZ = x,z
	x,y,z=Spring.GetUnitPosition(unitID)
	Sleep(500)
	end

	
	while true do
		Sleep(10000)
		ed=Spring.GetUnitNearestEnemy(unitID)
		if ed then
			x,y,z=Spring.GetUnitPosition(ed)
			if x then
				Spring.SetUnitMoveGoal(unitID,x,y,z)
			end
		end
	end
	
	
	
end




aimpoint= piece "aimpoint"
----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpoint 
end

function script.QueryWeapon1() 
	return jbug 
end

function script.AimWeapon1( heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)

	
	Signal(SIG_AIM2)
	SetSignalMask(SIG_AIM2)
	
	return true
end

function script.FireWeapon1()	
	
	de=math.random(1,4)
	Soundgame="sounds/jGeoCreeper/jBugAttack"..de..".wav"
	Spring.PlaySoundFile(Soundgame)
	Turn(jbugleg1,x_axis,math.rad(35),35)
	Turn(jbugleg1,y_axis,math.rad(74),35)
	Turn(jbugleg1,z_axis,math.rad(45),35)
	
	Turn(jbugleg3,x_axis,math.rad(2),35)
	Turn(jbugleg3,y_axis,math.rad(-57),34)
	Turn(jbugleg3,z_axis,math.rad(34),35)
	
	Turn(jbugleg2,x_axis,math.rad(-30),35)
	Turn(jbugleg2,y_axis,math.rad(29),35)
	Turn(jbugleg2,z_axis,math.rad(35),7)
	
	Turn(jbugleg4,x_axis,math.rad(15),34)
	Turn(jbugleg4,y_axis,math.rad(-8),35)
	Turn(jbugleg4,z_axis,math.rad(0),37)
	Turn(Turner,x_axis,math.rad(12),15)
	Move(jbug,z_axis,7,55)
	
	Sleep(450)
	Move(jbug,z_axis,0,25)
	Turn(jbug,x_axis,math.rad(-50),25)
	Turn(Turner,x_axis,math.rad(-5),7)
	Turn(jbugleg1,x_axis,math.rad(0),35)
	Turn(jbugleg1,y_axis,math.rad(0),35)
	Turn(jbugleg1,z_axis,math.rad(0),35)
	
	Turn(jbugleg3,x_axis,math.rad(0),35)
	Turn(jbugleg3,y_axis,math.rad(0),34)
	Turn(jbugleg3,z_axis,math.rad(0),35)
	
	Turn(jbugleg2,x_axis,math.rad(0),35)
	Turn(jbugleg2,y_axis,math.rad(0),35)
	Turn(jbugleg2,z_axis,math.rad(0),7)
	
	Turn(jbugleg4,x_axis,math.rad(0),34)
	Turn(jbugleg4,y_axis,math.rad(0),35)
	Turn(jbugleg4,z_axis,math.rad(0),37)
	Sleep(500)
	Turn(jbug,x_axis,math.rad(0),25)
	Turn(Turner,x_axis,math.rad(0),7)
	
	return true
end

function script.Killed(recentDamage, _)
	

	--legs_down()
	Turn(DeathTurner,x_axis,math.rad(-179),120)
	Sleep(400)
	shake=math.random(2,5)
	flopFlip=-1
	for i=1,shake,1 do
		Turn(jbugleg1,x_axis,math.rad(104),8)
		Turn(jbugleg1,y_axis,math.rad(-162),12)
		
		
		Turn(jbugleg3,x_axis,math.rad(65),5)
		Turn(jbugleg3,y_axis,math.rad(-30),4)
		
		
		Turn(jbugleg2,x_axis,math.rad(71),7)
		Turn(jbugleg2,y_axis,math.rad(-32),4)
		
		
		Turn(jbugleg4,x_axis,math.rad(-30),4)
		Turn(jbugleg4,y_axis,math.rad(57),5)
		
		WaitForTurn(jbugleg1,x_axis)
		WaitForTurn(jbugleg1,y_axis)
		
		WaitForTurn(jbugleg2,x_axis)
		WaitForTurn(jbugleg2,y_axis)
		
		WaitForTurn(jbugleg3,x_axis)
		WaitForTurn(jbugleg3,y_axis)
		
		WaitForTurn(jbugleg4,x_axis)
		WaitForTurn(jbugleg4,y_axis)
		
		Sleep(120)
	
		
		Turn(jbugleg1,x_axis,math.rad(0),6)
		Turn(jbugleg1,y_axis,math.rad(0),6)
		Turn(jbugleg1,z_axis,math.rad(0),6)
		Turn(jbugleg2,x_axis,math.rad(0),6)
		Turn(jbugleg2,y_axis,math.rad(0),6)
		Turn(jbugleg2,z_axis,math.rad(0),6)
		Turn(jbugleg3,x_axis,math.rad(0),6)
		Turn(jbugleg3,y_axis,math.rad(0),6)
		Turn(jbugleg3,z_axis,math.rad(0),6)
		Turn(jbugleg4,x_axis,math.rad(0),6)
		Turn(jbugleg4,y_axis,math.rad(0),6)
		Turn(jbugleg4,z_axis,math.rad(0),6)
		WaitForTurn(jbugleg1,x_axis)
		WaitForTurn(jbugleg1,y_axis)
		WaitForTurn(jbugleg1,z_axis)
		WaitForTurn(jbugleg2,x_axis)
		WaitForTurn(jbugleg2,y_axis)
		WaitForTurn(jbugleg2,z_axis)
		WaitForTurn(jbugleg3,x_axis)
		WaitForTurn(jbugleg3,y_axis)
		WaitForTurn(jbugleg3,z_axis)
		WaitForTurn(jbugleg4,x_axis)
		WaitForTurn(jbugleg4,y_axis)
		WaitForTurn(jbugleg4,z_axis)
		Sleep(120)
		
		
		
		
	end
	Turn(jbugleg1,x_axis,math.rad(0),6)
	Turn(jbugleg1,y_axis,math.rad(0),6)
	Turn(jbugleg1,z_axis,math.rad(0),6)
	Turn(jbugleg2,x_axis,math.rad(0),6)
	Turn(jbugleg2,y_axis,math.rad(0),6)
	Turn(jbugleg2,z_axis,math.rad(0),6)
	Turn(jbugleg3,x_axis,math.rad(0),6)
	Turn(jbugleg3,y_axis,math.rad(0),6)
	Turn(jbugleg3,z_axis,math.rad(0),6)
	Turn(jbugleg4,x_axis,math.rad(0),6)
	Turn(jbugleg4,y_axis,math.rad(0),6)
	Turn(jbugleg4,z_axis,math.rad(0),6)

	
	
	
	return 0
end

function script.Create()
	i=math.random(1,3) 
	Soundname="sounds/jGeoCreeper/jBugSpawn"..i..".wav"
	Spring.PlaySoundFile(Soundname) 
	StartThread(animationLoop)
end