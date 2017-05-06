
include "lib_jw.lua"
include "lib_type.lua"
include "lib_Animation.lua"

jhoney = piece "jhoney"
jhoneyleg1 = piece "jhoneyleg1"
jhoneyleg2 = piece "jhoneyleg2"
jhoneyleg3 = piece "jhoneyleg3"
jhoneyleg4 = piece "jhoneyleg4"
Turner = piece "Turner"


--define other pieces

SIG_WALK = 1	--signal for the walk animation thread
SIG_AIM = 2 --signal for the weapon aiming thread
SIG_LEG=4
SIG_AIM2 = 8
SIG_DEFAULT=32
function script.Create()
	StartThread(defaultEnemyAttack,unitID,SIG_DEFAULT, 33000)
	StartThread(stuckInPlaceAvoidance,unitID, 500,300)
end

function legs_down()
	SetSignalMask(SIG_LEG)
	Sleep(550)
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
	Signal(SIG_LEG)
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	
	
	while (true) do
		
		
		--left forwards back left down
		Turn(jhoney,x_axis,math.rad(-17),7)
		Turn(jhoney,y_axis,math.rad(8),4)
		
		Turn(jhoneyleg1,x_axis,math.rad(10),3)
		Turn(jhoneyleg1,y_axis,math.rad(62),16)
		Turn(jhoneyleg1,z_axis,math.rad(23),7)
		
		Turn(jhoneyleg2,x_axis,math.rad(0),3)
		Turn(jhoneyleg2,y_axis,math.rad(23),7)
		Turn(jhoneyleg2,z_axis,math.rad(-19),6)
		
		Turn(jhoneyleg3,x_axis,math.rad(0),3)
		Turn(jhoneyleg3,y_axis,math.rad(38),14)
		Turn(jhoneyleg3,z_axis,math.rad(31),15)
		
		Turn(jhoneyleg4,x_axis,math.rad(39),8)
		Turn(jhoneyleg4,y_axis,math.rad(9),7)
		Turn(jhoneyleg4,z_axis,math.rad(0),6)
		
		WaitForTurn(jhoneyleg3,y_axis)
		WaitForTurn(jhoneyleg4,x_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		Sleep(10)
		--middle Up -- feet back together
		Turn(jhoney,x_axis,math.rad(9),7)
		Turn(jhoney,y_axis,math.rad(0),4)
		
		
		
		Turn(jhoneyleg2,x_axis,math.rad(-18),3)
		Turn(jhoneyleg2,y_axis,math.rad(1),7)
		Turn(jhoneyleg2,z_axis,math.rad(-19),6)
		
		Turn(jhoneyleg3,x_axis,math.rad(-18),3)
		Turn(jhoneyleg3,y_axis,math.rad(1),14)
		Turn(jhoneyleg3,z_axis,math.rad(19),15)
		
		Turn(jhoneyleg1,x_axis,math.rad(4),3)
		Turn(jhoneyleg1,y_axis,math.rad(25),5)
		Turn(jhoneyleg1,z_axis,math.rad(33),7)
		Turn(jhoneyleg4,x_axis,math.rad(4),12)
		Turn(jhoneyleg4,y_axis,math.rad(25),7)
		Turn(jhoneyleg4,z_axis,math.rad(-33),6)
		
		
		WaitForTurn(jhoneyleg1,z_axis)
		WaitForTurn(jhoneyleg4,z_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		Sleep(10)
		
		--right forward back right down
		Turn(jhoney,x_axis,math.rad(-17),7)
		Turn(jhoney,y_axis,math.rad(-8),4)
		
		Turn(jhoneyleg4,x_axis,math.rad(10),2)
		Turn(jhoneyleg4,y_axis,math.rad(-62),12)
		Turn(jhoneyleg4,z_axis,math.rad(-23),5)
		Turn(jhoneyleg3,x_axis,math.rad(0),3)
		Turn(jhoneyleg3,y_axis,math.rad(1),5)
		Turn(jhoneyleg3,z_axis,math.rad(19),5)
		
		Turn(jhoneyleg2,x_axis,math.rad(0),3)
		Turn(jhoneyleg2,y_axis,math.rad(-38),7)
		Turn(jhoneyleg2,z_axis,math.rad(-31),3)
		
		Turn(jhoneyleg1,x_axis,math.rad(39),6)
		Turn(jhoneyleg1,y_axis,math.rad(9),3.5)
		Turn(jhoneyleg1,z_axis,math.rad(0),3)
		
		WaitForTurn(jhoneyleg1,x_axis)
		WaitForTurn(jhoneyleg2,y_axis)
		WaitForTurn(jhoneyleg1,y_axis)
		Sleep(10)
	end
end

function script.StartMoving()
	StartThread(walk)

end

function script.StopMoving()
	Signal(SIG_WALK)
	StartThread(legs_down)

end






----aimining & fire weapon
function script.AimFromWeapon1() 
	return jhoney 
end

function script.QueryWeapon1() 
	return jhoney 
end

function script.AimWeapon1( heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)
	
	Signal(SIG_AIM2)
	SetSignalMask(SIG_AIM2)
	
	return true
end
boolOnlyOnce=true

function script.HitByWeapon ( x, z, weaponDefID, damage )
	if weaponDefID ~= WeaponDefNames["jhoneypotw"].id then return damage
		
	elseif boolOnlyOnce==true then
		boolOnlyOnce=false
		EmitSfx(jhoney,4096)
		if Spring.GetUnitIsDead(unitID)==false then
			Spring.DestroyUnit(unitID,false,false)
		end
		return damage
	end
	
	
	return damage
end


function script.FireWeapon1()	
	Hide( jhoney )
	Hide( jhoneyleg1)
	Hide( jhoneyleg2 )
	Hide( jhoneyleg3 )
	Hide( jhoneyleg4 )
	
	
	Spring.PlaySoundFile("sounds/jhoney/jhoney.ogg")
	Spring.DestroyUnit(unitID,false,false)
	return true
end

function script.Killed(recentDamage, maxHealth)
	SetUnitValue(COB.MAX_SPEED,1)
	Signal(SIG_WALK)
	Signal(SIG_AIM) 
	Signal(SIG_IDLE)
	
	Turn(Turner,x_axis,math.rad(-206),25)
	Move(Turner,y_axis,-3,3)
	WaitForTurn(Turner,x_axis)
	shake=math.random(2,6)
	flopFlip=-1
	for i=1,shake,1 do
		Turn(jhoneyleg1,x_axis,math.rad(-104),8)
		Turn(jhoneyleg1,y_axis,math.rad(162),12)
		Turn(jhoneyleg1,z_axis,math.rad(0),7)
		
		Turn(jhoneyleg3,x_axis,math.rad(65),5)
		Turn(jhoneyleg3,y_axis,math.rad(-30),4)
		Turn(jhoneyleg3,z_axis,math.rad(-90),8)
		
		Turn(jhoneyleg2,x_axis,math.rad(71),7)
		Turn(jhoneyleg2,y_axis,math.rad(-32),4)
		Turn(jhoneyleg2,z_axis,math.rad(73),7)
		
		Turn(jhoneyleg4,x_axis,math.rad(-30),4)
		Turn(jhoneyleg4,y_axis,math.rad(57),5)
		Turn(jhoneyleg4,z_axis,math.rad(79),7)
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
		
		if flopFlip== -1 then
			posItive=math.random(12,20)
			Turn(Turner,z_axis,math.rad(posItive),3)
		else
			negAtive=math.random(-20,-12)
			Turn(Turner,z_axis,math.rad(negAtive),3)		
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
	WaitForTurn(jhoneyleg4,z_axis)
	
	
	
	return 0
end