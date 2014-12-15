include "toolKit.lua"
--Define the wheel pieces
local tent=piece"tent"
--Define the pieces of the weapon
local turret = piece "skarmR"
local turret2 = piece "skarmleft"
local flare01 = piece "flare01"
local flare02= piece "flare02"
local center= piece "center"
local skinleg = piece"skinleg"
local lowlegsk = piece"lowlegsk"
local skinleg2 = piece"skinleg2"
local lowlegsk02 = piece"lowlegsk02"
local boolSecondAiming=false

--define other pieces
local body = piece "skInfantry"
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_IDLE=4
local SIG_AIM2 = 8
local SIG_AMBUSH=16
local SIG_PEACE=32
--eggspawn --tigLil and SkinFantry
local AMBUSHLOADTIME=30000
local AMBUSHTIME=9000

experienceSoFar=0
teamID=Spring.GetUnitTeam(unitID)
function spawnAEgg(x,z)
randSleep=math.ceil(math.random(370,1200))
Sleep(randSleep)
	Spring.CreateUnit("jskineggnogg",x,-10,z, 0, teamID)  

end

function EGG_LOOP()
x,y,z=Spring.GetUnitPosition(unitID)
local spGetGroundHeight=Spring.GetGroundHeight
	while(true) do
	x,_,z=Spring.GetUnitPosition(unitID)
	--check if standing in Water
	y=spGetGroundHeight(x,z)
		if y <= 0 then	
		-- if in Water check experience
		temp=Spring.GetUnitExperience(unitID)
			if temp > experienceSoFar then
			experienceSoFar=experienceSoFar+1
			--spawn numberofEggsToSpawn
				for i=1,math.ceil(experienceSoFar),1 do
				StartThread(spawnAEgg,x,z)
				end
			--update experienceSoFar
			end
		end
Sleep(2500)

	end
end


function script.Create()
StartThread(EGG_LOOP)
Spring.UnitScript.Hide ( flare01 ) 
Spring.UnitScript.Hide ( flare02 ) 
Hide(tent)
StartThread(cloakCheckAndAmbushLoad)
  StartThread(coolDownTimer)
end

function idle()

sleeper=math.random(1024,8192)

SetSignalMask(SIG_IDLE)
while(boolCloaked==false)do
Move (center,x_axis,0,12)
	Move (center,y_axis,0,12)
	Move (center,z_axis,0,12)
	Move (body,x_axis,0,12)
	Move (body,y_axis,0,12)
	Move (body,z_axis,0,12)
	Turn (center, x_axis,math.rad(0), 15)	
	Turn (center, y_axis,math.rad(0), 15)	
	Turn (center, z_axis,math.rad(0), 15)
	Turn (body, x_axis,math.rad(0), 15)	
	Turn (body, y_axis,math.rad(0), 15)	
	Turn (body, z_axis,math.rad(0), 15)
	Turn (skinleg2, x_axis,math.rad(0), 15)
	Turn (skinleg, x_axis,math.rad(0), 15)
	Turn(lowlegsk,x_axis,math.rad(0), 32)
	Turn(lowlegsk02,x_axis,math.rad(0), 32)
Sleep(sleeper)

rand=math.random(0,3)
if rand==3 then
Turn(center,x_axis,math.rad(85),6)
Turn(turret2,x_axis,math.rad(-170),7)
Turn(turret,x_axis,math.rad(-170),7)
tentShow=math.random(0,1)
if tentShow==1 then
Move(tent,y_axis,-10,0)
Show(tent)
Move(tent,y_axis,0,0.4)
WaitForMove(tent,y_axis)
end
sleepSnowWhite=math.random(4098,16344)
Sleep(sleepSnowWhite)
Move(tent,y_axis,-10,1.8)
Hide(tent)
Turn(turret,x_axis,math.rad(-175),7)
end
		if rand==1 then
			Turn(center,x_axis,math.rad(69),4)
			Turn(turret2,x_axis,math.rad(-90),7)
			ringAlingADingDong=math.random(2,26)
			WaitForTurn(center,x_axis)
				for i=0, ringAlingADingDong, 1 do
				Turn(center,x_axis,math.rad(81),2)
				WaitForTurn(center,x_axis)
				tRand=math.random(20,100)
				Sleep(tRand)
				Turn(center,x_axis,math.rad(69),1)
				WaitForTurn(center,x_axis)
				Sleep(120)
				end
		end
			
if rand==0 then
Turn(turret,x_axis,math.rad(-90),7)
Turn(turret2,x_axis,math.rad(-90),7)
WaitForTurn(turret,x_axis)
WaitForTurn(turret2,x_axis)

sportIsMord=math.random(0,128)
		for it=0, sportIsMord,1 do
		Move(body,y_axis,-4,12)
		Turn(skinleg,x_axis,math.rad(-42),3)
		Turn(skinleg2,x_axis,math.rad(-42),3)
		Turn(lowlegsk,x_axis,math.rad(121),10)
		Turn(lowlegsk02,x_axis,math.rad(121),10)
		Turn(turret,x_axis,math.rad(-80),2)
		Turn(turret2,x_axis,math.rad(-82),2)

		WaitForTurn(turret,x_axis)         
		WaitForTurn(turret2,x_axis)         
		WaitForTurn(skinleg,x_axis)         
		WaitForTurn(skinleg2,x_axis)         
		WaitForTurn(lowlegsk,x_axis)         
		WaitForTurn(lowlegsk02,x_axis)        

		WaitForMove(body,y_axis)

		fixFertig=math.random(20,120)
		Sleep(fixFertig)
		Turn(turret,x_axis,math.rad(-90),3)
		Turn(turret2,x_axis,math.rad(-90),3)
		Turn(skinleg,x_axis,math.rad(0),3)
		Turn(skinleg2,x_axis,math.rad(0),3)
		Turn(lowlegsk,x_axis,math.rad(0),5)
		Turn(lowlegsk02,x_axis,math.rad(0),5)
		Move(body,y_axis,0,16)
		WaitForTurn(turret,x_axis)         
		WaitForTurn(turret2,x_axis)         
		WaitForTurn(skinleg,x_axis)         
		WaitForTurn(skinleg2,x_axis)         
		WaitForTurn(lowlegsk,x_axis)         
		WaitForTurn(lowlegsk02,x_axis)        


		WaitForMove(body,y_axis)
		fixFertig=math.random(80,620)
		Sleep(fixFertig)
		end
end
if rand==2 then

sitUps=math.random(4,28)
		for i=0, sitUps, 1 do
		Move(center,y_axis,-9,9)
		Turn(body,x_axis,math.rad(0),4)
		Turn(turret2,x_axis,math.rad(-90),5)
		Turn(turret,x_axis,math.rad(-90),5)
		Turn(skinleg,x_axis,math.rad(-92),5)
		Turn(skinleg2,x_axis,math.rad(-92),5)
		WaitForTurn(body,x_axis)
		WaitForTurn(turret2,x_axis)
		WaitForTurn(turret,x_axis)
		WaitForTurn(skinleg,x_axis)
		WaitForTurn(skinleg2,x_axis)
		Sleep(420)
		Turn(body,x_axis,math.rad(88),3)
		Turn(skinleg,x_axis,math.rad(-166),4)
		Turn(skinleg2,x_axis,math.rad(-166),4)
		Move(center,y_axis,-10,8)
		Turn(turret2,x_axis,math.rad(-150),3)
		Turn(turret,x_axis,math.rad(-156),3)
		WaitForTurn(turret2,x_axis)
		WaitForTurn(turret,x_axis)
		WaitForTurn(skinleg,x_axis)
		WaitForTurn(skinleg2,x_axis)
		Sleep(150)
		end
end
end


end
----driving animation
--local skinleg = piece" skinleg "
--local lowlegsk = piece" lowlegsk "
--local skinleg2 = piece" skinleg2 "
--local lowlegsk02 = piece" lowlegsk02 "
local skinDef=Spring.GetUnitDefID(unitID)
--http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units
function skinSound()
					oneOrTwo=math.random(1,8)			
					toConcat=oneOrTwo..".wav"
					toConcat="sounds/skinfantry/skInfantry"..toConcat
	
PlaySoundByUnitType(skinDef, toConcat,1, 2000, 1)
end

function walk()
	Hide(tent)
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	Turn(body, x_axis, math.rad(22), 14)
	WaitForTurn(body,x_axis)
	boolMoving=true
	leg_movespeed=6
		
			StartThread(skinSound)				
			
	
	
	while (true) do
	if leg_movespeed <14 then
	leg_movespeed=leg_movespeed+4
	
	end
		--left leg up, right leg down
		Turn(skinleg, x_axis,math.rad(-26) ,12 )
		Turn(lowlegsk,x_axis,math.rad(50), 24)
		
		Turn(skinleg2, x_axis, math.rad(12), leg_movespeed)
		Turn(turret2,x_axis,math.rad(14),8)
		WaitForTurn (skinleg, x_axis)
		WaitForTurn (skinleg2, x_axis)	
		WaitForTurn (lowlegsk02,x_axis)
		
		Turn(turret,x_axis,math.rad(-58),8)
		Turn(skinleg, x_axis,math.rad(-33) ,12 )
		Turn(skinleg2, x_axis, math.rad(22), leg_movespeed)
		Turn(lowlegsk02, x_axis, math.rad(24), leg_movespeed)
		Turn(lowlegsk,x_axis,math.rad(50), 24)
		
		WaitForTurn (skinleg, x_axis)
		WaitForTurn (lowlegsk02,x_axis)
		WaitForTurn (skinleg2, x_axis)		
		WaitForTurn (lowlegsk, x_axis)
		randSleep=math.ceil(math.random(40,100))
		Sleep (randSleep)
		--left leg down, right leg up
		
		Turn(skinleg2, x_axis,math.rad(-26) ,12 )
		Turn(lowlegsk02,x_axis,math.rad(50), 24)
		
		Turn(skinleg, x_axis, math.rad(12), leg_movespeed)
		Turn(turret2,x_axis,math.rad(-58),8)
		WaitForTurn (skinleg2, x_axis)
		WaitForTurn (skinleg, x_axis)	
		WaitForTurn (lowlegsk,x_axis)
		WaitForTurn (lowlegsk02, x_axis)
		
		Turn(turret,x_axis,math.rad(14),8)
		Turn(skinleg2, x_axis,math.rad(-33) ,19 )
		Turn(lowlegsk, x_axis, math.rad(15), leg_movespeed)
		Turn(lowlegsk02,x_axis,math.rad(78), 20)
		
		WaitForTurn ( skinleg2, x_axis)
		WaitForTurn (lowlegsk,x_axis)
		WaitForTurn (lowlegsk02, x_axis)
		Sleep (80)
	end
end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return turret 
end

function script.QueryWeapon1() 
	return flare01 
end

function script.AimWeapon1( heading ,pitch)	
Signal(SIG_IDLE)
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)
	if boolSecondAiming==true then
	return false
	end
	if boolSecondAiming==false then
	Signal(SIG_AIM2)
	SetSignalMask(SIG_AIM2)
	
	
	Turn(turret, x_axis,math.rad(-80),3)
	WaitForTurn(turret,x_axis)
	Turn(body,y_axis,heading,3)
	WaitForTurn(body,y_axis)
	boolFiringWeapon=true
	return true
end
end

function script.FireWeapon1()	
StartThread(boolFireWeaponReset)
	return true
end

function script.Killed(recentDamage, maxHealth)
Move(center,x_axis,0,0)
leg_movespeed=12
stepsBack=math.ceil(math.random(3,6))
	for i=1, stepsBack,1 do
	--Armrand
	xrand=math.random(80,90)
	yrand=math.random(-10,70)
	Turn(turret,y_axis,math.rad(-1*yrand),130)
	Turn(turret,x_axis,math.rad(-1*xrand),130)
	xrand=math.random(80,90)
	yrand=math.random(-10,70)
	Turn(turret2,y_axis,math.rad(yrand),130)
	Turn(turret2,x_axis,math.rad(-1*xrand),130)
	deg=math.random(-35,-10)
	Turn(center,x_axis,math.rad(deg),29)
	WaitForTurn(center,x_axis)
	Move(center,z_axis,-4*i,0)
	Turn(center,x_axis,math.rad(0),92)



			-- Turn(skinleg, x_axis,math.rad(-33) ,12 )
			-- Turn(skinleg2, x_axis, math.rad(22), leg_movespeed)
			-- Turn(lowlegsk02, x_axis, math.rad(24), leg_movespeed)
			-- Turn(lowlegsk,x_axis,math.rad(50), 24)
			
			-- WaitForTurn (skinleg, x_axis)
			-- WaitForTurn (lowlegsk02,x_axis)
			-- WaitForTurn (skinleg2, x_axis)		
			-- WaitForTurn (lowlegsk, x_axis)
			-- randSleep=math.ceil(math.random(40,100))
			-- Turn(skinleg, x_axis,math.rad(-26) ,12 )
			-- Turn(lowlegsk,x_axis,math.rad(50), 24)
			
			-- Turn(skinleg2, x_axis, math.rad(12), leg_movespeed)
			-- WaitForTurn (skinleg, x_axis)
			-- WaitForTurn (skinleg2, x_axis)	
			-- WaitForTurn (lowlegsk02,x_axis)
			
			
		
			-- Sleep (randSleep)
			-- WaitForTurn(center,x_axis)
			
			-- Turn(turret,x_axis,math.rad(14),8)
			-- Turn(skinleg2, x_axis,math.rad(-33) ,19 )
			-- Turn(lowlegsk, x_axis, math.rad(15), leg_movespeed)
			-- Turn(lowlegsk02,x_axis,math.rad(78), 20)
			
			-- WaitForTurn ( skinleg2, x_axis)
			-- WaitForTurn (lowlegsk,x_axis)
			-- WaitForTurn (lowlegsk02, x_axis)
			--	left leg down, right leg up
			
			-- Turn(skinleg2, x_axis,math.rad(-26) ,12 )
			-- Turn(lowlegsk02,x_axis,math.rad(50), 24)
			
			-- Turn(skinleg, x_axis, math.rad(12), leg_movespeed)
			-- WaitForTurn (skinleg2, x_axis)
			-- WaitForTurn (skinleg, x_axis)	
			-- WaitForTurn (lowlegsk,x_axis)
			-- WaitForTurn (lowlegsk02, x_axis)
			
			Sleep (80)
	Sleep(300)
	end
Turn(center,x_axis,math.rad(-90),29)
	Sleep(1200)

	return 0
end



function script.AimFromWeapon2() 
	return turret2 
end

function script.QueryWeapon2() 
	return flare02 
end

function script.AimWeapon2( heading ,pitch)	
Signal(SIG_IDLE)
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
		
	boolSecondAiming=true
	Turn(turret2, x_axis, math.rad(-80),3)
	WaitForTurn(turret2,x_axis)
	----Spring.Echo(heading)
	heading=heading*0.1
	Turn(turret2,y_axis,heading,2)
	heading=heading*10-heading*0.1
	Turn(body,y_axis,heading*0.9,3)
	WaitForTurn(turret2,y_axis)
	WaitForTurn(body,y_axis)
	boolFiringWeapon=true
	return Weapon2AmbushMode()
end


boolCoolDownStart=false
boolCoolDown=true

function coolDownTimer()
	while true do
		if boolCoolDownStart==true then
		boolCoolDownStart=false
		boolCoolDown=false
		Sleep(1200)
	

		boolCoolDown=true
		end
	Sleep(150)
	end
end
function Weapon2AmbushMode()
if boolAmbushInProgress==true then return true end
	if boolCoolDown==true  then
	boolCoolDownStart=true
	
	return true 
		else
		return false 
		end
end


function boolFireWeaponReset()
Sleep(500)
boolFiringWeapon=false
end

function script.FireWeapon2()
	StartThread(boolFireWeaponReset)	
	boolSecondAiming=false
	return true
end

local function legs_down()
	Move (center,x_axis,0,12)
	Move (center,y_axis,0,12)
	Move (center,z_axis,0,12)
	Move (body,x_axis,0,12)
	Move (body,y_axis,0,12)
	Move (body,z_axis,0,12)
	Turn (center, x_axis,math.rad(0), 15)	
	Turn (center, y_axis,math.rad(0), 15)	
	Turn (center, z_axis,math.rad(0), 15)
	Turn (body, x_axis,math.rad(0), 15)	
	Turn (body, y_axis,math.rad(0), 15)	
	Turn (body, z_axis,math.rad(0), 15)
	Turn (skinleg2, x_axis,math.rad(0), 15)
	Turn (skinleg, x_axis,math.rad(0), 15)
	Turn(lowlegsk,x_axis,math.rad(0), 32)
	Turn(lowlegsk02,x_axis,math.rad(0), 32)
	
	
end
local boolMoving=false
function script.StartMoving()

	Signal(SIG_IDLE)
	legs_down()
	StartThread (walk)
	
end

function script.StopMoving()
		
--    ----Spring.Echo ("stopped walking!")
		Signal(SIG_IDLE)
		Signal(SIG_WALK)
		legs_down()
		StartThread(idle)
		boolMoving=false
		
end


boolAmbushCharged=false
boolAmbushInProgress=false
boolFiringWeapon=false

function AmbushinProgressThread()
Spring.Echo("SkinFantry:AmbushActivated")
resetwaitPosition()
boolAmbushInProgress=true
Sleep(AMBUSHTIME)
boolAmbushInProgress=false
Spring.Echo("SkinFantry:AmbushEnded")
end

function waitPosition()
Turn(center,x_axis,math.rad(85),6)
Turn(turret2,x_axis,math.rad(-170),7)
Turn(turret,x_axis,math.rad(-170),7)
end

function resetwaitPosition()
Turn(center,x_axis,math.rad(0),26)
Turn(turret2,x_axis,math.rad(0),27)
Turn(turret,x_axis,math.rad(0),27)
end

function AmbushCounterThread()
Spring.Echo("AmbushPreparing")
SetSignalMask(SIG_AMBUSH)
Sleep(AMBUSHLOADTIME)
boolAmbushCharged=true
Spring.Echo("AmbushReady")
end
boolCloaked=false
function cloakCheckAndAmbushLoad()
local boolPrevCloaked=false


	while true do
	--check wether the Unit is cloaked 
	boolCloaked=GetUnitValue(COB.CLOAKED)
	--if first time true, set unit FireStats to ReturnFire, set to Hold Position, start AmbushCounter --setFirstTime False
		if boolPrevCloaked==false and boolCloaked==true then
		Spring.Echo("Cloaking")
		Signal(SIG_AMBUSH)
			if boolPeacefull==true then
			StartThread(AmbushCounterThread)
			GiveOrderToUnit(unitID, CMD.FIRE_STATE, {0}, {})
			GiveOrderToUnit(unitID, CMD.MOVE_STATE, {0}, {})  
			boolPrevCloaked=true           
			WaitPosition()
			SetUnitValue(COB.CLOAKED, 1)
			SetUnitValue(COB.WANT_CLOAK, 0)
			end
		end


		--if cloaked and boolMove is true, uncloak, reset Fire Status --resetFirstTime
		if boolCloaked==true and (boolFiringWeapon==true or boolMoving==true) then

		SetUnitValue(COB.WANT_CLOAK, 0)
		SetUnitValue(COB.CLOAKED, 0)
		boolPrevCloaked=false
		GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, {})     
		GiveOrderToUnit(unitID, CMD.MOVE_STATE, {1}, {})
		Signal(SIG_AMBUSH)
			if boolAmbushCharged==true then
			StartThread(AmbushinProgressThread)
			boolAmbushCharged=false
			end
			--fire Ambushmodethread
		end
		
	Sleep(250)
	end
end

function script.Activate()
if boolPeacefull==true then
SetUnitValue(COB.WANT_CLOAK,1)
end
return 1
end

function script.Deactivate()
SetUnitValue(COB.WANT_CLOAK,0)
return 0
end

boolPeacefull=true
function restorePeace()
SetSignalMask(SIG_PEACE)
Sleep(5000)
boolPeacefull=true
end

function script.HitByWeapon ( x, z, weaponDefID, damage )
boolPeacefull=false
Signal(SIG_PEACE)
StartThread(restorePeace)
end