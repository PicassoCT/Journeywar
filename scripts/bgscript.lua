--a walking animation using threads
--smoothly aiming the weapon, also using threads
local bgbase= piece "bgbase"
local bgtorso= piece "bgtorso"
local bgtorso2= piece "bgtorso2"
local riotshield= piece "riotshield"
local bgarm= piece "bgarm"
local flare01= piece "flare01"
local flare02= piece "flare02"
local bgleg= piece "bgleg"
local bglegr= piece "bglegr"
local deathpivot=piece"deathpivot"
local bglowlegr= piece"bglowlegr"
local bglowleg= piece "bglowleg"
local sleeper=1
local boolUnderFire=false

local boolOnceInAWhile=true
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_IDLE=4
local SIG_COUNTER=8
local SIG_FIRE=16
local SIG_ROB=32
local SIG_AIMRESET=64
local SIG_ATTACK=128
local leg_movespeed = 12+math.random(-1,1)
local leg_movedistance = 10

function bodyBuilder()
decIsion=math.random(1,3)
	if decIsion==1 then
	Show(bgtorso)
	Hide(bgtorso2)
	Hide(riotshield)
		elseif decIsion==2 then
		Hide(bgtorso)
		Show(bgtorso2)
		Hide(riotshield)
			else
			Hide(bgtorso)
			Show(bgtorso2)
			Show(riotshield)

			end

end

local function legs_down()

	Turn (bgleg, x_axis, 0, leg_movespeed)
	Turn (bglegr, x_axis, 0, leg_movespeed)
	Turn(bglowlegr,x_axis,math.rad(0), leg_movespeed)
	Turn(bglowleg,x_axis,math.rad(0), leg_movespeed)
	Turn(bglegr,x_axis,math.rad(0),9)
	Turn(bglegr,y_axis,math.rad(0),13)
	Turn(bglegr,z_axis,math.rad(0),9)

	Turn(bglowlegr,x_axis,math.rad(0),9)
	Turn(bglowlegr,y_axis,math.rad(0),13)
	Turn(bglowlegr,z_axis,math.rad(0),9)

	Turn(bgleg,x_axis,math.rad(0),9)
	Turn(bgleg,y_axis,math.rad(0),15)
	Turn(bgleg,z_axis,math.rad(0),9)

	Turn(bglowleg,x_axis,math.rad(0),14)
	Turn(bglowleg,y_axis,math.rad(0),13)
	Turn(bglowleg,z_axis,math.rad(0),9)
	Turn(deathpivot,y_axis,math.rad(0), 8)
	Turn(deathpivot,x_axis,math.rad(0),9)
	val=math.random(-10,45)
	Turn(bgarm,x_axis,math.rad(val),8)	
	
	StartThread(idle)
	return
end





boolCanMove=true
function kneeDown(time)
					boolCanMove=false
					SetUnitValue(COB.MAX_SPEED,math.floor(15))
					Move(bgbase,y_axis,-4,12)
					Turn(bgleg,x_axis,math.rad(-90),18)
					Turn(bglowleg,x_axis,math.rad(90),28)
					Turn(bglowlegr,x_axis,math.rad(101),28)
					time=math.floor(math.random(100,time))
						while (time > 0 and boolFiredRecently==true) do
						o=math.max(math.floor(time-120),120)
						
						Sleep(o)
						time=time-o
						end
					Move(bgbase,y_axis,0,12)
					Turn(bgleg,x_axis,math.rad(0),18)
					Turn(bglowleg,x_axis,math.rad(0),28)
					Turn(bglowlegr,x_axis,math.rad(0),28)
				
					SetUnitValue(COB.MAX_SPEED,math.floor(65533*8))
			
					boolCanMove=true
					if boolMoveOrderd==true then
						Signal(SIG_WALK)
						StartThread(walk)
					end
end



function script.Create()

 Hide(flare01)
 Hide(flare02)
 Hide(deathpivot)
 bodyBuilder()
end

function idle()
Signal(SIG_IDLE)
sleeper=math.random(1024,8192)

SetSignalMask(SIG_IDLE)
	while(true)do
	Sleep(sleeper)

		aynRandValue=math.random(0,12)
			if aynRandValue== 8 then
			Move(bgbase,y_axis,-4,10)
			Turn(bglegr,x_axis,math.rad(-90),18)
			Turn(bglowlegr,x_axis,math.rad(90),28)
			Turn(bglowleg,x_axis,math.rad(101),28)

			end
					if aynRandValue== 3 then
					Move(bgbase,y_axis,-4,12)
					Turn(bgleg,x_axis,math.rad(-90),18)
					Turn(bglowleg,x_axis,math.rad(90),28)
					Turn(bglowlegr,x_axis,math.rad(101),28)
					end


	Turn(bgtorso,y_axis,math.rad(35),1)

	Turn(bgarm,x_axis,math.rad(-24),3)

	Turn(bgarm,y_axis,math.rad(-10),3)
	WaitForTurn(bgarm,x_axis)
	WaitForTurn(bgtorso,y_axis)
	WaitForTurn(bgarm,y_axis)
	Turn(bgtorso,y_axis,math.rad(-27),3)

	Turn(bgarm,y_axis,math.rad(10),3)

	Turn(bgarm,x_axis,math.rad(10),3)
	WaitForTurn(bgarm,x_axis)
	WaitForTurn(bgtorso,y_axis)
	WaitForTurn(bgarm,y_axis)
	Sleep(512)
	Turn(bgtorso,y_axis,math.rad(0),3)
	Turn(bgarm,x_axis,math.rad(0),3)
	Turn(bgarm,y_axis,math.rad(0),3)
	Turn(bgtorso,y_axis,math.rad(0),3)
	Turn(bgarm,y_axis,math.rad(0),3)
	Turn(bgarm,x_axis,math.rad(0),3)
	WaitForTurn(bgarm,x_axis)
	WaitForTurn(bgtorso,y_axis)
	WaitForTurn(bgarm,y_axis)

	Move(bgbase,y_axis,0,12)
	Turn(bglegr,x_axis,math.rad(0),18)
	Turn(bgleg,x_axis,math.rad(0),18)
	Turn(bglowlegr,x_axis,math.rad(0),28)
	Turn(bglowleg,x_axis,math.rad(0),28)
	Sleep(250)
	end


end

timeSinceLastChatter=0

function reduceTimeSinceLastChatter()
Sleep(timeSinceLastChatter)
timeSinceLastChatter=0
end


---WALKING---
function walk()
	if boolCanMove== true then
		Signal(SIG_WALK)
		boolFiredRecently=false
		SetSignalMask(SIG_WALK)
		Turn(bgtorso, x_axis, math.rad(22), 14)
		WaitForTurn(bgtorso,x_axis)
	

				if timeSinceLastChatter== 0 and math.random(0,800) ==100  then
			
						if math.random(0,1)== 0 then
						Spring.PlaySoundFile("sounds/bgmtw/bgAff.wav")
						timeSinceLastChatter=19000
						StartThread(reduceTimeSinceLastChatter)
						else
						Spring.PlaySoundFile("sounds/bgmtw/bgAff2.wav")
						timeSinceLastChatter=19000
						StartThread(reduceTimeSinceLastChatter)
						end
				end
				
	local altspeed=9+math.random(-1,1)
	local doublealtspeed=(9*2)+math.random(-1,1)
		while (true) do
			--left leg up, right leg down
			Turn(bglegr, x_axis,math.rad(-16) ,altspeed )
			Turn(bglowlegr,x_axis,math.rad(50), doublealtspeed )
			Turn(bgleg, x_axis, math.rad(9), leg_movespeed)
			
			WaitForTurn (bglegr, x_axis)
			WaitForTurn (bgleg, x_axis)	
			WaitForTurn (bglowleg,x_axis)
			if boolNotAiming == true then
			rand=math.random(15,30)
			Turn(bgarm,x_axis,math.rad(rand),3)
			end
			Turn(bglegr, x_axis,math.rad(-33) ,altspeed)
		--	Turn(bgleg, x_axis, math.rad(10), leg_movespeed)
			Turn(bglowleg, x_axis, math.rad(24), leg_movespeed)
			Turn(bglowlegr,x_axis,math.rad(50), doublealtspeed)
			
			WaitForTurn (bglegr, x_axis)
			WaitForTurn (bglowleg,x_axis)
		--	WaitForTurn (bgleg, x_axis)		
			WaitForTurn (bglowlegr, x_axis)
			
			Sleep (65)
			--left leg down, right leg up
			Turn(bgleg, x_axis,math.rad(-16),altspeed)
			Turn(bglowleg,x_axis,math.rad(50), doublealtspeed)
			Turn(bglegr, x_axis, math.rad(12), leg_movespeed)
			
			WaitForTurn (bgleg, x_axis)
			WaitForTurn (bglegr, x_axis)	
			WaitForTurn (bglowlegr,x_axis)
			if boolNotAiming == true then
			rand=math.random(22,45)
			Turn(bgarm,x_axis,math.rad(rand),3)
			end
			Turn(bgleg, x_axis,math.rad(-33) ,altspeed)
			Turn(bglowlegr, x_axis, math.rad(25), leg_movespeed)
			Turn(bglowleg,x_axis,math.rad(52),doublealtspeed)
			
			WaitForTurn ( bglegr , x_axis)
			WaitForTurn (bglowlegr,x_axis)
			WaitForTurn (bglowleg, x_axis)
			Sleep (56)
		end
	end	
end

function counter()
SetSignalMask(SIG_COUNTER)
napTime=math.ceil(math.random(900,2800))
Sleep(napTime)
oneInThreeHundred=math.random(0,35)
if oneInThreeHundred == 5 then
Spring.PlaySoundFile("sounds/bgmtw/bgAff.wav")
end
if oneInThreeHundred == 7 then
Spring.PlaySoundFile("sounds/bgmtw/bgAff2.wav")
end


end

boolMoveOrderd=false

function script.StartMoving()



	Signal(SIG_IDLE)
	Move(bgbase,y_axis,0,12)
    Turn(bgtorso,y_axis,0,4)
	
	
	StartThread (walk)
	
	
	StartThread(counter)
	
boolMoveOrderd=true
end

function script.StopMoving()

boolMoveOrderd=false
		
		Signal(SIG_COUNTER)
		Turn(bgtorso, x_axis, math.rad(0), 14)
--    --Spring.Echo ("stopped walking!")
		Signal(SIG_WALK)

		legs_down()
		
		
end

function aimReseter()
SetSignalMask(SIG_AIMRESET)
Sleep(6000)
boolNotAiming=true
end

boolNotAiming=true

---AIMING & SHOOTING---
function script.AimFromWeapon1() 
	return bgarm 
end

function script.QueryWeapon1() 
	return flare01
end

boolOnlyOnce=true
--must return true to allow the weapon to shot. return false denies the weapon from shooting
--can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon1( heading, pitch )
Signal(SIG_AIMRESET)
StartThread(aimReseter)
boolNotAiming=false

	Signal(SIG_IDLE)
	--make sure the aiming animation is only run once
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
		
	
		Turn(deathpivot,y_axis,math.rad(0),12)
		Turn(bgtorso, y_axis, heading, 3)
		Turn(bgarm, x_axis, -pitch, 3)
		--Math.Rad(70) ?
		--wait until the weapon is pointed in the right direction
		WaitForTurn (bgtorso, y_axis)
		WaitForTurn (bgarm, x_axis)
		
							
		
	
	
	
	Signal(SIG_FIRE)
	StartThread(OnceInAWhileReseter)
	return true
end


function shootFiredReseter()
SetSignalMask(SIG_ATTACK)
Sleep(900)
boolFiredRecently=false
end

boolFiredRecently=false
--called after the weapon has fired
function script.FireWeapon1()
	if boolOnceInAWhile== true then
	boolOnceInAWhile=false
	--StartThread(kneeDown,2000)
	end

 boolFiredRecently=true
 Signal(SIG_ATTACK)
StartThread(shootFiredReseter)
	for i=1,7,1 do
	EmitSfx(flare01, 1025)
	Sleep(142)
	end
end

----death animation: fall over & explode
function script.Killed(recentDamage, maxHealth)

    Turn(bgarm,x_axis,math.rad(-29),90)
	Turn(bglegr,x_axis,math.rad(-30), 45)
	Turn(bglowlegr,x_axis,math.rad(54),32)
	Turn(bgleg,x_axis,math.rad(-28),32)
	Turn(bgleg,y_axis,math.rad(-29),42)
	Turn(bglowleg,x_axis,math.rad(0),32)
	Turn(deathpivot,x_axis,math.rad(-38),45)
	EmitSfx(bgtorso, 1027)
	WaitForTurn(bgarm,x_axis)
		WaitForTurn(bglegr,x_axis)
			WaitForTurn(bglowlegr,x_axis)
				WaitForTurn(bgleg,x_axis)
					WaitForTurn(bgleg,y_axis)
						WaitForTurn(bglowleg,x_axis)
						Sleep(120)
						Turn(bgtorso,x_axis,math.rad(-14),84)
						WaitForTurn(bgtorso,x_axis)
	Turn(bgleg,x_axis,math.rad(0),15)
	Turn(bglegr,x_axis,math.rad(0),15)
	WaitForTurn(bgleg,x_axis)
	WaitForTurn(bglegr,x_axis)
	Turn(bgarm, x_axis, math.rad(-90),85)
	Turn(deathpivot,x_axis,math.rad(-90),75)
	WaitForTurn(deathpivot,x_axis)
	Sleep (150)
	Explode(bgarm, SFX.FALL+SFX.NO_HEATCLOUD)
	Spring.PlaySoundFile("sounds/bgmtw/bgDeath.wav") 

		return 1 
end

function OnceInAWhileReseter()
SetSignalMask(SIG_FIRE)
Sleep(7000)
boolOnceInAWhile=true

end


