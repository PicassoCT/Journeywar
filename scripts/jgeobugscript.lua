


local jhoney = piece "jbug"
local jhoneyleg1 = piece "bugleg1"
local jhoneyleg2 = piece "bugleg2"
local jhoneyleg3 = piece "bugleg3"
local jhoneyleg4 = piece "bugleg4"
local Turner = piece "center"


--define other pieces

local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_LEG=4
local SIG_IDLE= 8
local SIG_AIM2=16
local SIG_DEFAULT=32

DeathTurner=piece"DeathTurner"

function legs_down()
SetSignalMask(SIG_LEG)
Sleep(550)
Move(Turner,x_axis,0,12)
Move(Turner,y_axis,0,12)
Move(Turner,z_axis,0,12)
Turn(Turner,x_axis,math.rad(0),12)
Turn(Turner,y_axis,math.rad(0),12)
Turn(Turner,z_axis,math.rad(0),12)

Turn(jhoney,x_axis,math.rad(0),12)
Turn(jhoney,y_axis,math.rad(0),12)
Turn(jhoney,z_axis,math.rad(0),12)
Turn(jhoneyleg1,x_axis,math.rad(0),12)
Turn(jhoneyleg1,y_axis,math.rad(0),12)
Turn(jhoneyleg1,z_axis,math.rad(0),12)
Turn(jhoneyleg2,x_axis,math.rad(0),12)
Turn(jhoneyleg2,y_axis,math.rad(0),12)
Turn(jhoneyleg2,z_axis,math.rad(0),12)
Turn(jhoneyleg3,x_axis,math.rad(0),12)
Turn(jhoneyleg3,y_axis,math.rad(0),12)
Turn(jhoneyleg3,z_axis,math.rad(0),12)
Turn(jhoneyleg4,x_axis,math.rad(0),12)
Turn(jhoneyleg4,y_axis,math.rad(0),12)
Turn(jhoneyleg4,z_axis,math.rad(0),12)
		WaitForTurn(jhoneyleg1,x_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		WaitForTurn(jhoneyleg1,z_axis)
		WaitForTurn(jhoneyleg2,x_axis)
		WaitForTurn(jhoneyleg2,y_axis)
		WaitForTurn(jhoneyleg2,z_axis)
		WaitForTurn(jhoneyleg3,x_axis)
		WaitForTurn(jhoneyleg3,y_axis)
		WaitForTurn(jhoneyleg3,z_axis)
		WaitForTurn(jhoneyleg4,x_axis)
		WaitForTurn(jhoneyleg4,y_axis)
		WaitForTurn(jhoneyleg4,z_axis)
end
function walk()

	SetSignalMask(SIG_WALK)
	
	
	while (true) do

	
		--left forwards back left down
		Turn(jhoney,x_axis,math.rad(7),7)
		Turn(jhoney,y_axis,math.rad(-8),4)
		
		Turn(jhoneyleg1,x_axis,math.rad(-12),3)
		Turn(jhoneyleg1,y_axis,math.rad(-18),16)
		Turn(jhoneyleg1,z_axis,math.rad(6),7)
	
		Turn(jhoneyleg2,x_axis,math.rad(28),3)
		Turn(jhoneyleg2,y_axis,math.rad(-57),12)
		Turn(jhoneyleg2,z_axis,math.rad(0),6)
		
		Turn(jhoneyleg3,x_axis,math.rad(18),3)
		Turn(jhoneyleg3,y_axis,math.rad(-73),14)
		Turn(jhoneyleg3,z_axis,math.rad(-14),15)
	
		Turn(jhoneyleg4,x_axis,math.rad(3),8)
		Turn(jhoneyleg4,y_axis,math.rad(-26),7)
		Turn(jhoneyleg4,z_axis,math.rad(-34),6)

		WaitForTurn(jhoneyleg3,y_axis)
		WaitForTurn(jhoneyleg4,x_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		Sleep(10)
		--middle Up -- feet back together
		Turn(jhoney,x_axis,math.rad(-9),7)
		Turn(jhoney,y_axis,math.rad(8),4)
		
		
	
		Turn(jhoneyleg2,x_axis,math.rad(29),3)
		Turn(jhoneyleg2,y_axis,math.rad(-12),7)
		Turn(jhoneyleg2,z_axis,math.rad(30),6)
		
		Turn(jhoneyleg3,x_axis,math.rad(-24),3)
		Turn(jhoneyleg3,y_axis,math.rad(15),14)
		Turn(jhoneyleg3,z_axis,math.rad(1),15)
		
		Turn(jhoneyleg1,x_axis,math.rad(-8),3)
		Turn(jhoneyleg1,y_axis,math.rad(45),5)
		Turn(jhoneyleg1,z_axis,math.rad(8),7)
		
		Turn(jhoneyleg4,x_axis,math.rad(4),12)
		Turn(jhoneyleg4,y_axis,math.rad(37),7)
		Turn(jhoneyleg4,z_axis,math.rad(-5),6)
	

		WaitForTurn(jhoneyleg1,z_axis)
		WaitForTurn(jhoneyleg4,z_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		Sleep(10)
		
		Turn(jhoneyleg2,x_axis,math.rad(0),3)
		Turn(jhoneyleg2,y_axis,math.rad(-12),7)
		Turn(jhoneyleg2,z_axis,math.rad(30),6)
		
		Turn(jhoneyleg3,x_axis,math.rad(-24),3)
		Turn(jhoneyleg3,y_axis,math.rad(15),14)
		Turn(jhoneyleg3,z_axis,math.rad(1),15)
		
		Turn(jhoneyleg1,x_axis,math.rad(5),3)
		Turn(jhoneyleg1,y_axis,math.rad(45),5)
		Turn(jhoneyleg1,z_axis,math.rad(8),7)
		
		Turn(jhoneyleg4,x_axis,math.rad(13),12)
		Turn(jhoneyleg4,y_axis,math.rad(37),7)
		Turn(jhoneyleg4,z_axis,math.rad(-5),6)
	

		WaitForTurn(jhoneyleg1,z_axis)
		WaitForTurn(jhoneyleg4,z_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		Sleep(10)
		
		Turn(jhoneyleg1,x_axis,math.rad(0),9)
		Turn(jhoneyleg1,y_axis,math.rad(0),9)
		Turn(jhoneyleg1,z_axis,math.rad(0),9)
		
		Turn(jhoneyleg3,x_axis,math.rad(0),9)
		Turn(jhoneyleg3,y_axis,math.rad(0),9)
		Turn(jhoneyleg3,z_axis,math.rad(0),9)
		
		Turn(jhoneyleg2,x_axis,math.rad(0),9)
		Turn(jhoneyleg2,y_axis,math.rad(0),9)
		Turn(jhoneyleg2,z_axis,math.rad(0),7)
					
		Turn(jhoneyleg4,x_axis,math.rad(0),9)
		Turn(jhoneyleg4,y_axis,math.rad(0),9)
		Turn(jhoneyleg4,z_axis,math.rad(0),9)
		
		WaitForTurn(jhoneyleg1,z_axis)
		WaitForTurn(jhoneyleg4,z_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		end
	end

	function script.StartMoving()
	 Signal(SIG_DEFAULT)
	 Signal(SIG_LEG)
	Signal(SIG_WALK)
	StartThread(walk)
	Signal(SIG_IDLE)
		Turn(Turner,y_axis,math.rad(0),12)
		Turn(jhoney,y_axis,math.rad(0),12)
		Turn(jhoney,x_axis,math.rad(0),12)
		Turn(jhoney,z_axis,math.rad(0),12)
	
	end

	function idle()
	SetSignalMask(SIG_IDLE)
	zZzZzZ=math.random(400,1800)
	Sleep(zZzZzZ)
	speed=math.random(3.5,9)
	Turn(jhoney,z_axis,math.rad(-36),speed)
	Turn(jhoneyleg3,z_axis,math.rad(53),speed*2)
	Turn(jhoneyleg2,z_axis,math.rad(46),speed*2)
	Turn(jhoneyleg1,z_axis,math.rad(57),speed*2)
	Turn(jhoneyleg4,z_axis,math.rad(42),speed*2)
	Sleep(570)
	t=math.random(0,5)
	auslenkung=math.random(10,16)
	for i=1,t,1 do
	Turn(jhoney,x_axis,math.rad(auslenkung),6)
	Turn(Turner,y_axis,math.rad(auslenkung*-1),6)
	Turn(jhoneyleg3,z_axis,math.rad(46),speed*2)
	Turn(jhoneyleg1,z_axis,math.rad(63),speed*2)
	Turn(jhoneyleg2,z_axis,math.rad(23),speed*2)
	Turn(jhoneyleg4,z_axis,math.rad(53),speed*2)
	WaitForTurn(jhoney,x_axis)
	
	Turn(jhoney,x_axis,math.rad(auslenkung*-1),6)
	Turn(Turner,y_axis,math.rad(auslenkung),6)
	WaitForTurn(jhoney,x_axis)
	end
	Signal(SIG_IDLE)
	StartThread(legs_down)
	end
	
	function script.StopMoving()
	Signal(SIG_WALK)
	StartThread(legs_down)
	StartThread(defaultEnemy)
	dice=math.random(1,4)
		if dice==4 then
		StartThread(idle)
		end
	
	end
	
	
	function defaultEnemy()
	SetSignalMask(SIG_DEFAULT)
	Sleep(25000)
	
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
	return jhoney 
end

function script.AimWeapon1( heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)
	Signal(SIG_IDLE)

	Signal(SIG_AIM2)
	SetSignalMask(SIG_AIM2)
	
	return true
end

function script.FireWeapon1()	

de=math.random(1,4)
Soundgame="sounds/jGeoCreeper/jBugAttack"..de..".wav"
Spring.PlaySoundFile(Soundgame)
		Turn(jhoneyleg1,x_axis,math.rad(35),35)
		Turn(jhoneyleg1,y_axis,math.rad(74),35)
		Turn(jhoneyleg1,z_axis,math.rad(45),35)
		
		Turn(jhoneyleg3,x_axis,math.rad(2),35)
		Turn(jhoneyleg3,y_axis,math.rad(-57),34)
		Turn(jhoneyleg3,z_axis,math.rad(34),35)
		
		Turn(jhoneyleg2,x_axis,math.rad(-30),35)
		Turn(jhoneyleg2,y_axis,math.rad(29),35)
		Turn(jhoneyleg2,z_axis,math.rad(35),7)
					
		Turn(jhoneyleg4,x_axis,math.rad(15),34)
		Turn(jhoneyleg4,y_axis,math.rad(-8),35)
		Turn(jhoneyleg4,z_axis,math.rad(0),37)
		Turn(Turner,x_axis,math.rad(12),15)
		Move(jhoney,z_axis,7,55)
		
		Sleep(450)
		Move(jhoney,z_axis,0,25)
		Turn(jhoney,x_axis,math.rad(-50),25)
		Turn(Turner,x_axis,math.rad(-5),7)
		Turn(jhoneyleg1,x_axis,math.rad(0),35)
		Turn(jhoneyleg1,y_axis,math.rad(0),35)
		Turn(jhoneyleg1,z_axis,math.rad(0),35)
		
		Turn(jhoneyleg3,x_axis,math.rad(0),35)
		Turn(jhoneyleg3,y_axis,math.rad(0),34)
		Turn(jhoneyleg3,z_axis,math.rad(0),35)
		
		Turn(jhoneyleg2,x_axis,math.rad(0),35)
		Turn(jhoneyleg2,y_axis,math.rad(0),35)
		Turn(jhoneyleg2,z_axis,math.rad(0),7)
					
		Turn(jhoneyleg4,x_axis,math.rad(0),34)
		Turn(jhoneyleg4,y_axis,math.rad(0),35)
		Turn(jhoneyleg4,z_axis,math.rad(0),37)
		Sleep(500)
			Turn(jhoney,x_axis,math.rad(0),25)
		Turn(Turner,x_axis,math.rad(0),7)

	return true
end

function script.Killed(recentDamage, _)

Signal(SIG_IDLE)
--legs_down()
Turn(DeathTurner,x_axis,math.rad(-179),120)
Sleep(400)
shake=math.random(2,5)
flopFlip=-1
	for i=1,shake,1 do
			Turn(jhoneyleg1,x_axis,math.rad(104),8)
			Turn(jhoneyleg1,y_axis,math.rad(-162),12)
	
			
			Turn(jhoneyleg3,x_axis,math.rad(65),5)
			Turn(jhoneyleg3,y_axis,math.rad(-30),4)
	
			
			Turn(jhoneyleg2,x_axis,math.rad(71),7)
			Turn(jhoneyleg2,y_axis,math.rad(-32),4)
	
						
			Turn(jhoneyleg4,x_axis,math.rad(-30),4)
			Turn(jhoneyleg4,y_axis,math.rad(57),5)
		
			WaitForTurn(jhoneyleg1,x_axis)
			WaitForTurn(jhoneyleg1,y_axis)

			WaitForTurn(jhoneyleg2,x_axis)
			WaitForTurn(jhoneyleg2,y_axis)

			WaitForTurn(jhoneyleg3,x_axis)
			WaitForTurn(jhoneyleg3,y_axis)

			WaitForTurn(jhoneyleg4,x_axis)
			WaitForTurn(jhoneyleg4,y_axis)

			Sleep(120)
			if flopFlip== -1 then
			posItive=math.random(12,20)-179
			Turn(DeathTurner,z_axis,math.rad(posItive),3)
			else
			negAtive=math.random(-20,-12)-179
			Turn(DeathTurner,z_axis,math.rad(negAtive),3)		
			end
			flopFlip=flopFlip*-1
		
			
			Turn(jhoneyleg1,x_axis,math.rad(0),6)
			Turn(jhoneyleg1,y_axis,math.rad(0),6)
			Turn(jhoneyleg1,z_axis,math.rad(0),6)
			Turn(jhoneyleg2,x_axis,math.rad(0),6)
			Turn(jhoneyleg2,y_axis,math.rad(0),6)
			Turn(jhoneyleg2,z_axis,math.rad(0),6)
			Turn(jhoneyleg3,x_axis,math.rad(0),6)
			Turn(jhoneyleg3,y_axis,math.rad(0),6)
			Turn(jhoneyleg3,z_axis,math.rad(0),6)
			Turn(jhoneyleg4,x_axis,math.rad(0),6)
			Turn(jhoneyleg4,y_axis,math.rad(0),6)
			Turn(jhoneyleg4,z_axis,math.rad(0),6)
			WaitForTurn(jhoneyleg1,x_axis)
			WaitForTurn(jhoneyleg1,y_axis)
			WaitForTurn(jhoneyleg1,z_axis)
			WaitForTurn(jhoneyleg2,x_axis)
			WaitForTurn(jhoneyleg2,y_axis)
			WaitForTurn(jhoneyleg2,z_axis)
			WaitForTurn(jhoneyleg3,x_axis)
			WaitForTurn(jhoneyleg3,y_axis)
			WaitForTurn(jhoneyleg3,z_axis)
			WaitForTurn(jhoneyleg4,x_axis)
			WaitForTurn(jhoneyleg4,y_axis)
			WaitForTurn(jhoneyleg4,z_axis)
			Sleep(120)
			 
			 
			 

	end
		Turn(jhoneyleg1,x_axis,math.rad(0),6)
		Turn(jhoneyleg1,y_axis,math.rad(0),6)
		Turn(jhoneyleg1,z_axis,math.rad(0),6)
		Turn(jhoneyleg2,x_axis,math.rad(0),6)
		Turn(jhoneyleg2,y_axis,math.rad(0),6)
		Turn(jhoneyleg2,z_axis,math.rad(0),6)
		Turn(jhoneyleg3,x_axis,math.rad(0),6)
		Turn(jhoneyleg3,y_axis,math.rad(0),6)
		Turn(jhoneyleg3,z_axis,math.rad(0),6)
		Turn(jhoneyleg4,x_axis,math.rad(0),6)
		Turn(jhoneyleg4,y_axis,math.rad(0),6)
		Turn(jhoneyleg4,z_axis,math.rad(0),6)
Turn(DeathTurner,x_axis,math.rad(-206),25)	



return 0
end

function script.Create()
i=math.random(1,3)  
Soundname="sounds/jGeoCreeper/jBugSpawn"..i..".wav"
Spring.PlaySoundFile(Soundname) 
end