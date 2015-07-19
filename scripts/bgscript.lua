 include "lib_OS.lua"
 include "lib_TableOp.lua"
 include "lib_Build.lua" 


--a walking animation using threads
--smoothly aiming the weapon, also using threads
local depshield= piece "depshield"
local bgbase= piece "bgbase"
local bgtorso= piece "bgtorso"
maxspeed=math.ceil(183492) --2.8*65533
local turn_rate = UnitDefNames["bg"].turnRate
				
riotshield= piece "riotshield"
local riotshield2= piece "riotshield2"
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
defID=Spring.GetUnitDefID(unitID)


bgdefID=UnitDefNames["bg"].id 
boolCityTrooper=(defID==UnitDefNames["bg"].id )

LArm	=piece"LArm"
RArm	=piece"RArm"
Head	=piece"Head"
Gun		=piece"Gun"
Neck= piece"Neck"


function bodyBuilder()
Hide(LArm)
Hide(RArm)
Hide(Gun)
if defID== bgID then


decIsion=math.random(1,3)
	if decIsion==1 then

	Hide(riotshield)
		elseif decIsion==2 then

		Hide(riotshield2)
			else
			Hide(riotshield)
			Hide(riotshield2)
			end
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
 Hide(depshield)
 Hide(flare01)
 Hide(flare02)
 Hide(deathpivot)
 bodyBuilder()
 StartThread(soundStart)
end

function idle()
Signal(SIG_IDLE)
sleeper=math.random(1024,8192)
signum=-1
SetSignalMask(SIG_IDLE)
	while(true)do
	Sleep(sleeper)
	signum=signum*-1
	if boolCityTrooper ==true then
	Turn(Head,y_axis,math.rad(math.random(35*signum,45*signum*signum)),2)
	end
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
	if boolCanMove ==true then
	Turn(Head,y_axis,math.rad(0),12)
	Move(bgbase,y_axis,0,12)
    Turn(bgtorso,y_axis,0,4)
	
	
	StartThread (walk)
	
	
	StartThread(counter)
	end
boolMoveOrderd=true
end

function script.StopMoving()

boolMoveOrderd=false
		
		Signal(SIG_COUNTER)
		
		Turn(bgtorso, x_axis, math.rad(0), 14)
--    --Spring.Echo ("stopped walking!")
		Signal(SIG_WALK)
		if boolCanMove==true then
		legs_down()
		end
		
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
boolHeadTurn=false
function Headturn(heading) 
	boolHeadTurn=true
	Turn(Head,y_axis,heading,12)
	WaitForTurn(Head,y_axis)
	Turn(Head,y_axis,0,3)
	WaitForTurn(Head,y_axis)
	Sleep(500)
	boolHeadTurn=false
 end

function script.AimWeapon1( heading, pitch )
Signal(SIG_AIMRESET)
StartThread(aimReseter)
boolNotAiming=false

	Signal(SIG_IDLE)
	--make sure the aiming animation is only run once
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
		if boolCityTrooper ==true and boolHeadTurn==false then StartThread(Headturn,heading) end
	
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

function headexplode(time,intervall)
for i=1,time,intervall do

spawnCegAtPiece(unitID,Neck,"bghdexplode",0)
Sleep(intervall)
end

end

function offOverHead()
Move(bgbase,y_axis,-4.6,10)
Turn(bglowlegr,x_axis,math.rad(107),45)
Turn(bglowleg ,x_axis,math.rad(95),45)
WaitForMove(bgbase,y_axis)
spawnCegAtPiece(unitID,Head,"bloodspray",0)

Explode(Head,SFX.FALL+SFX.NO_HEATCLOUD)
Hide(Head)
wavetime=math.ceil(math.random(2000,4000))
itterator=1
Show(LArm)
Show(RArm)
Hide(bgarm)
Turn(RArm,x_axis,math.rad(-108*itterator),5)
Turn(LArm,x_axis,math.rad(-108*itterator),5)
StartThread(headexplode,wavetime,18)
	while wavetime > 0 do
		for i=1,10 do 
		
	spawnCegAtPiece(unitID,bgbase,"bgbloodslay",false)
		Sleep(120)
		end
	itterator=itterator*0.9	
	Turn(RArm,x_axis,math.rad(-108*itterator),3)
	Turn(LArm,x_axis,math.rad(-108*itterator),8)
	Sleep(800)
	wavetime=wavetime-2000
	end
Turn(RArm,x_axis,math.rad(90),12)
Turn(RArm,y_axis,math.rad(math.random(-20,20)),12)

Turn(LArm,x_axis,math.rad(90),12)
Turn(RArm,y_axis,math.rad(math.random(-20,20)),12)

Turn(deathpivot,x_axis,math.rad(-90),5)
Move(bgbase,y_axis,0,35)
Turn(bglowlegr,x_axis,math.rad(0),12)
Turn(bglowleg ,x_axis,math.rad(0),12)
Sleep(2500)

return 1
end
----death animation: fall over & explode
TIGLILDAMAGE=325
bgID=UnitDefNames["bg"].id 
function script.Killed(recentDamage, maxHealth)
Signal(SIG_AIM)
Signal(SIG_IDLE)
Signal(SIG_COUNTER)
Signal(SIG_KNEE)
Signal(SIG_FIRE)
spawnCegAtPiece(unitID,bgtorso,"bghdexplode",0)
dice=math.random(1,3)
if dice==1 then
	if math.random(0,1)==1 then
	StartThread(PieceDropTillStop,unitID,Gun,9.81, 32, 3, true, 0.15)
	Show(Gun)
	else
	Explode(Gun,SFX.NO_HEATCLOUD+SFX.FALL)
	end
Move(Gun,x_axis,math.random(-15,15), 7) 
Move(Gun,z_axis,math.random(-15,15), 7) 

if recentDamage/maxHealth > 0.3 and math.random(0,1)==1 then return offOverHead() end

Hide(bgarm)
Show(LArm)
Show(RArm)
  Turn(LArm,x_axis,math.rad(-29),90)
  Turn(RArm,x_axis,math.rad(math.random(-29,12)),90)
	Turn(bglegr,x_axis,math.rad(-30), 45)
	Turn(bglowlegr,x_axis,math.rad(54),32)
	Turn(bgleg,x_axis,math.rad(-28),32)
	Turn(bgleg,y_axis,math.rad(-29),42)
	Turn(bglowleg,x_axis,math.rad(0),32)
	Turn(deathpivot,x_axis,math.rad(-38),45)
	EmitSfx(bgtorso, 1027)
	WaitForTurn(RArm,x_axis)
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
	Turn(LArm, x_axis, math.rad(-90),85)
	Turn(deathpivot,x_axis,math.rad(-90),75)
	WaitForTurn(deathpivot,x_axis)
	Sleep (150)
	Spring.PlaySoundFile("sounds/bgmtw/bgDeath.wav") 
elseif dice==2 then
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
	Spring.PlaySoundFile("sounds/bgmtw/bgDeath.wav") 

else
Turn(bglegr,x_axis,math.rad(25),22)
Turn(bgleg,x_axis,math.rad(-10),12)
Turn(bglowleg,x_axis,math.rad(0),12)
Turn(bglowlegr,x_axis,math.rad(-10),12)
spawnCegAtPiece(unitID,Head,"bghdexplode",0)
Sleep(250)
Turn(bgbase,x_axis,math.rad(-10),12)
Turn(bglegr,x_axis,math.rad(10),12)
Turn(bgleg,x_axis,math.rad(10),12)
Turn(bglowleg,x_axis,math.rad(0),12)
Turn(bglowlegr,x_axis,math.rad(0),12)
spawnCegAtPiece(unitID,Head,"bghdexplode",0)
syncTurn(LArm,0,80,74,122)
syncTurn(RArm,0,-80,-34,122)
Sleep(350)
spawnCegAtPiece(unitID,bgtorso,"bghdexplode",0)
Turn(bgbase,x_axis,math.rad(35),12)
Turn(bglegr,x_axis,math.rad(-43),12)
Turn(bgleg,x_axis,math.rad(-62),12)
Turn(bglowleg,x_axis,math.rad(39),12)
Turn(bglowlegr,x_axis,math.rad(78),12)
syncTurn(LArm,0,135,74,122)
syncTurn(RArm,0,-146,-34,122)
Sleep(350)
val=math.random(-15,15)
Turn(deathpivot,y_axis,math.rad(val),35)
Turn(deathpivot,x_axis,math.rad(69),35)
Turn(bgbase,x_axis,math.rad(35),12)
syncTurn(LArm,0,84,74,84)
syncTurn(RArm,-28,-119,-12,100)
Sleep(320)
Turn(bglegr,z_axis,math.rad(-15),12)
Turn(bglegr,x_axis,math.rad(-15),12)
Turn(bgleg,x_axis,math.rad(-12),12)
Turn(bglowleg,x_axis,math.rad(0),12)
Turn(bglowlegr,x_axis,math.rad(0),12)
Sleep(420)

end
		return 1 
end
--]]

function OnceInAWhileReseter()
SetSignalMask(SIG_FIRE)
Sleep(7000)
boolOnceInAWhile=true

end

function soundStart()
	while true do
	
	
	Sleep(500)
		if boolShieldDown==true then
		boolShieldDown=false
		StartThread(PlaySoundByUnitType,bgdefID,"sounds/bgmtw/shielddrop.ogg",1500,1,1)
		end
	end


end

function showShield()
 Show(depshield)
  if not GG.RiotShieldTable then GG.RiotShieldTable={} end
  GG.RiotShieldTable[unitID]=true
  
					Move(bgbase,y_axis,-4,12)
					Turn(bgleg,x_axis,math.rad(-90),18)
					Turn(bglowleg,x_axis,math.rad(90),28)
					Turn(bglowlegr,x_axis,math.rad(101),28)
					boolShieldDown=true
				
				
end

function hideShield()
 Hide(depshield)
 if not GG.RiotShieldTable then GG.RiotShieldTable={} end
  GG.RiotShieldTable[unitID]=nil
					Move(bgbase,y_axis,0,12)
					Turn(bgleg,x_axis,math.rad(0),18)
					Turn(bglowleg,x_axis,math.rad(0),28)
					Turn(bglowlegr,x_axis,math.rad(0),28)
					legs_down()
					Signal(SIG_WALK)
				
end

boolDefStance=false

	function script.Activate ( )
	boolDefStance=true
	--setMoveRateToZero
	SetUnitValue(COB.MAX_SPEED,1)--sets the speed to 5,2 *65533
	
	showShield()
	
		return 1
	  end

	function script.Deactivate ( )
	boolreVert=false

	SetUnitValue(COB.MAX_SPEED,maxspeed)--sets the speed to 5,2 *65533

	hideShield()	
	
		return 0
	  end


