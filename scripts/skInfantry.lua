include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

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
local torso = piece"Torso"
local lowlegsk02 = piece"lowlegsk02"
local boolSecondAiming=false

--define other pieces
local body = piece "skInfantry"
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_IDLE=4
local SIG_AIM2 = 8
local SIG_AMBUSH=16
local SIG_PEACE=32
--eggspawn --tigLil and SkinFantry
local AMBUSHLOADTIME=30000
local AMBUSHTIME=9000
piecePeriod=12500
costPerEgg=0.5
experienceSoFar=Spring.GetUnitExperience(unitID)
eggEnemySpawnDistance = 700
teamID=Spring.GetUnitTeam(unitID)
defID = Spring.GetUnitDefID(unitID)

function spawnAEgg(x,z)
	randSleep=math.ceil(math.random(370,1200))
	Sleep(randSleep)
	id= Spring.CreateUnit("jskineggnogg",x,-10,z, 0, teamID) 
	transferOrders(unitID,id)
	
end
boolPeacefull = true
function EGG_LOOP()
	x,y,z=Spring.GetUnitPosition(unitID)
	local spGetGroundHeight=Spring.GetGroundHeight
	while(true) do
		x,_,z=Spring.GetUnitPosition(unitID)
		--check if standing in Water
		y=spGetGroundHeight(x,z)
		
		if boolPeacefull== true then	
			ed= Spring.GetUnitNearestEnemy(unitID)
			if ed then
				distanced = distanceUnitToUnit(unitID,ed) 
				if distanced > eggEnemySpawnDistance then
					
					-- if in Water check experience
					temp=Spring.GetUnitExperience(unitID)
					if temp > experienceSoFar+costPerEgg then
						--spawn numberofEggsToSpawn
						for i=experienceSoFar, temp,costPerEgg do
							StartThread(spawnAEgg,x+math.random(-5,5),z+math.random(-5,5))
							experienceSoFar=experienceSoFar+ costPerEgg
						end
						--update experienceSoFar
						if temp > 10 then
							for i=1,temp/5, 1 do
								StartThread(spawnAEgg,x+math.random(-5,5),z+math.random(-5,5))
							end
						end
					end
				end
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

function resetPosture()
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
	Hide(tent)
	
end
function skyFist()
	arm1= turret2
			arm2 = turret
			total= math.random(18,29)
			if not GG.SyncAnimT then GG.SyncAnimT = {} end
			if not GG.SyncAnimT[defID] then GG.SyncAnimT[defID] = {} end
			if GG.SyncAnimT[defID]  < 2 then 
				GG.SyncAnimT[defID] = 256
			end
			Sleep(GG.SyncAnimT[defID]/2)
			GG.SyncAnimT[defID]= GG.SyncAnimT[defID]/2
			
			for i=1,total do
				Turn(arm1,x_axis,math.rad(-90),5)
				Turn(arm2,x_axis,math.rad(90),5)
				Move(arm1,y_axis, -1.4,5)
				Move(arm1,x_axis, -0.5,10)
				WaitForMoves(arm1)
				Sleep(150)
				Move(arm1,y_axis, 0,5)
				Move(arm1,x_axis, 0,5)
				WaitForMoves(arm1)
				Sleep(300-i*3)
			end

end
function ringALingADingDong()
	Turn(center,x_axis,math.rad(69),4)
	Turn(turret2,x_axis,math.rad(armoffset-90),7)
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
	Turn(center,x_axis,math.rad(0),4)
end
function aimReset()
	Turn (center, x_axis,math.rad(0), 15)	
	Turn (center, y_axis,math.rad(0), 15)	
	Turn (center, z_axis,math.rad(0), 15)
	Hide(tent)
end
function sport()
	Turn(center,x_axis,math.rad(0),15)
			Turn(turret,x_axis,math.rad(armoffset-90),7)
			Turn(turret2,x_axis,math.rad(armoffset-90),7)
			WaitForTurn(turret,x_axis)
			WaitForTurn(turret2,x_axis)
			
			sportIsMord=math.random(0,128)
			for it=0, sportIsMord,1 do
				Move(body,y_axis,-4,12)
				Turn(skinleg,x_axis,math.rad(-42),3)
				Turn(skinleg2,x_axis,math.rad(-42),3)
				Turn(lowlegsk,x_axis,math.rad(121),10)
				Turn(lowlegsk02,x_axis,math.rad(121),10)
				Turn(turret,x_axis,math.rad(armoffset-80),2)
				Turn(turret2,x_axis,math.rad(armoffset-82),2)
				
				WaitForTurn(turret,x_axis) 
				WaitForTurn(turret2,x_axis) 
				WaitForTurn(skinleg,x_axis) 
				WaitForTurn(skinleg2,x_axis) 
				WaitForTurn(lowlegsk,x_axis) 
				WaitForTurn(lowlegsk02,x_axis) 
				
				WaitForMove(body,y_axis)
				
				fixFertig=math.random(20,120)
				Sleep(fixFertig)
				Turn(turret,x_axis,math.rad(armoffset -90),3)
				Turn(turret2,x_axis,math.rad(armoffset -90),3)
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
			Turn(center,x_axis,math.rad(0),4)

end
function sitUps()
	Turn(center,x_axis,math.rad(0),15)
			sitUpss=math.random(4,28)
			for i=0, sitUpss, 1 do
				Move(center,y_axis,-9,9)
				Turn(body,x_axis,math.rad(0),4)
				Turn(turret2,x_axis,math.rad(armoffset -90),5)
				Turn(turret,x_axis,math.rad(armoffset -90),5)
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
				Turn(turret2,x_axis,math.rad(armoffset -150),3)
				Turn(turret,x_axis,math.rad(armoffset -156),3)
				WaitForTurn(turret2,x_axis)
				WaitForTurn(turret,x_axis)
				WaitForTurn(skinleg,x_axis)
				WaitForTurn(skinleg2,x_axis)
				Sleep(150)
			end

end

function rest()
	Turn(center,x_axis,math.rad(-80),6)
			Turn(turret2,x_axis,math.rad(-120),7)
			Turn(turret,x_axis,math.rad(-120),7)
			Turn(turret,y_axis,math.rad(-75),7)
			Turn(turret2,y_axis,math.rad(75),7)
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
			Turn(turret,x_axis,math.rad(armoffset-175),7)
			Turn(center,x_axis,math.rad(0),6)

end
function idle()
	
	sleeper=math.random(1024,8192)
	Signal(SIG_IDLE)
	SetSignalMask(SIG_IDLE)
	
	while (boolCloaked==false)do
		
		Sleep(sleeper)
		
		rand=math.random(0,4)
		
		if rand==4 then	
			skyFist()
		end
		
		if rand==1 then
			ringALingADingDong()
		end
		
		if rand==0 then
			sport()
		end
		
		if rand==2 then
			sitUps()
		end	
		
		if rand==3 then
			rest()
		end
		Sleep(50)
	
			Turn(body,x_axis,math.rad(0),4)
			resetT({[4]=center,[1]=body,[2]=skinleg,[3]=skinleg2},3)
	end
end
	
	


local skinDef=Spring.GetUnitDefID(unitID)

function skinSound()
	oneOrTwo=math.random(1,8)			
	toConcat=oneOrTwo..".wav"
	toConcat="sounds/skinfantry/skInfantry"..toConcat
	
	PlaySoundByUnitDefID(skinDef, toConcat,1, 2000, 1)
end

function walk()
	Hide(tent)
	Signal(SIG_WALK)
	Signal(SIG_IDLE)
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
		walkStep(leg_movespeed,0, true)
	end
end


function walkStep(leg_movespeed, footOffset, bDisregardArms)
	Turn(skinleg, x_axis,math.rad(footOffset -26) ,12 )
	Turn(lowlegsk,x_axis,math.rad(50), 24)
	
	Turn(skinleg2, x_axis, math.rad(12), leg_movespeed)
	if bDisregardArms == true then Turn(turret2,x_axis,math.rad(armoffset + 14),8) end
	WaitForTurn (skinleg, x_axis)
	WaitForTurn (skinleg2, x_axis)	
	WaitForTurn (lowlegsk02,x_axis)
	
	if bDisregardArms == true then Turn(turret,x_axis,math.rad(armoffset -58),8) end
	Turn(skinleg, x_axis,math.rad(footOffset -33) ,12 )
	Turn(skinleg2, x_axis, math.rad(footOffset + 22), leg_movespeed)
	Turn(lowlegsk02, x_axis, math.rad(24), leg_movespeed)
	Turn(lowlegsk,x_axis,math.rad(50), 24)
	
	WaitForTurn (skinleg, x_axis)
	WaitForTurn (lowlegsk02,x_axis)
	WaitForTurn (skinleg2, x_axis)		
	WaitForTurn (lowlegsk, x_axis)
	randSleep=math.ceil(math.random(40,100))
	Sleep (randSleep)
	--left leg down, right leg up
	
	Turn(skinleg2, x_axis,math.rad(footOffset -26) ,12 )
	Turn(lowlegsk02,x_axis,math.rad(50), 24)
	
	Turn(skinleg, x_axis, math.rad(footOffset + 12), leg_movespeed)
	if bDisregardArms == true then Turn(turret2,x_axis,math.rad(armoffset -58),8) end
	WaitForTurn (skinleg2, x_axis)
	WaitForTurn (skinleg, x_axis)	
	WaitForTurn (lowlegsk,x_axis)
	WaitForTurn (lowlegsk02, x_axis)
	
	if bDisregardArms == true then Turn(turret,x_axis,math.rad(armoffset + 14),8) end
	Turn(skinleg2, x_axis,math.rad(footOffset -33) ,19 )
	Turn(lowlegsk, x_axis, math.rad(15), leg_movespeed)
	Turn(lowlegsk02,x_axis,math.rad(78), 20)
	
	WaitForTurn ( skinleg2, x_axis)
	WaitForTurn (lowlegsk,x_axis)
	WaitForTurn (lowlegsk02, x_axis)
	Sleep (80)
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
		aimReset()
		Turn(turret, x_axis,math.rad( -10),3)
		WaitForTurn(turret,x_axis)		
		boolFiringWeapon=true
		return true
	end
end

function script.FireWeapon1()	
	StartThread(boolFireWeaponReset)
	StartThread(restorePeace)
	return true
end

function script.Killed(recentDamage, maxHealth)
	killedAnimation()
	return 0
end

function killedAnimation()
	Move(center,x_axis,0,0)
	leg_movespeed=12
	stepsBack=math.ceil(math.random(2,4))
	boodyShake=19
	for i=1, stepsBack,1 do
		--Armrand
		xrand=math.random(80,90)
		yrand=math.random(-10,70)
		Turn(turret,y_axis,math.rad( -1*yrand * (-1)^i),130)
		Turn(turret,x_axis,math.rad(armoffset+ -1*xrand),130)
		xrand=math.random(80,90)
		yrand=math.random(-10,70)
		Turn(turret2,y_axis,math.rad( yrand * (-1)^(i+1)),130)
		Turn(turret2,x_axis,math.rad(armoffset + -1*xrand),130)
		ddeg=math.random(-35,-10)
		Turn(center,x_axis,math.rad(boodyShake*(-1^i)),29)
		WaitForTurn(center,x_axis)
		Move(center,z_axis,-4*i,20)
		Turn(center,x_axis,math.rad(0),92)	
		
		walkStep(6, 2* boodyShake*(-1^i), footfalse)
		Sleep(50)
	end
	
	Turn(turret2,y_axis,math.rad( 90*randSign()),130)
	Turn(turret,x_axis,math.rad( 90*randSign()),130)
	WTurn(center,x_axis,math.rad(-90),5)
	
end

function script.AimFromWeapon2() 
	return turret2 
end

function script.QueryWeapon2() 
	return flare02 
end

function script.AimWeapon2( heading ,pitch)	
	
	--aiming animation: instantly turn the gun towards the enemy
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)	
	boolSecondAiming=true
	Turn(turret2, x_axis, math.rad(0),3)
	Turn(torso, y_axis,heading,3)
	Signal(SIG_IDLE)
	WaitForTurn(turret2,x_axis)
	WaitForTurn(torso,y_axis)
	aimReset()
	----Spring.Echo(heading)
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
	if boolCoolDown==true then
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
	StartThread(restorePeace)
	return true
end

local function legs_down()
	Move (center,x_axis,0,12)
	Move (center,y_axis,0,12)
	Move (center,z_axis,0,12)
	Move (body,x_axis,0,12)
	Move (body,y_axis,0,12)
	Move (body,z_axis,0,12)

	tP (turret2,0,0,0,12)
	mP (turret2,0,0,0,12)
	tP (turret,0,0,0,12)
	Move (center,y_axis,0,12)
	Move (center,z_axis,0,12)
	Turn (torso, y_axis,math.rad(0), 15)	
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
	
	
	legs_down()
	StartThread (walk)
	
end

function script.StopMoving()
	
	-- ----Spring.Echo ("stopped walking!")
	
	Signal(SIG_WALK)
	legs_down()
	StartThread(idle)
	boolMoving=false
	
end





armoffset=90
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
	Turn(turret2,x_axis,math.rad(armoffset -170),7)
	Turn(turret,x_axis,math.rad(armoffset -170),7)
end

function resetwaitPosition()
	Turn(center,x_axis,math.rad(0),26)
	Turn(turret2,x_axis,math.rad(armoffset),27)
	Turn(turret,x_axis,math.rad(armoffset),27)
end

function AmbushCounterThread()
	Spring.Echo("AmbushPreparing")
	SetSignalMask(SIG_AMBUSH)
	Sleep(AMBUSHLOADTIME)
	boolAmbushCharged=true
	
end
boolCloaked=false
		oldStates = Spring.GetUnitStates(unitID)
 
 function cloakCheckAndAmbushLoad()
	boolPrevCloaked=false
	
	
	while true do
		--check wether the Unit is cloaked 
		boolCloaked=(GetUnitValue(COB.CLOAKED) == 1)
		--if first Time true, set unit FireStats to ReturnFire, set to Hold Position, start AmbushCounter --setFirstTime False
		if boolPrevCloaked==false and boolCloaked==true then
			Signal(SIG_AMBUSH) 
			if boolPeacefull==true then
				StartThread(AmbushCounterThread)
				oldStates = Spring.GetUnitStates(unitID)
				
				Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {0}, {})
				Spring.GiveOrderToUnit(unitID, CMD.MOVE_STATE, {0}, {}) 
				boolPrevCloaked=true 
				waitPosition()
				SetUnitValue(COB.CLOAKED, 1)
				SetUnitValue(COB.WANT_CLOAK, 0)
			end
		end
		
		
		--if cloaked and boolMove is true, uncloak, reset Fire Status --resetFirstTime
		if boolCloaked==true and (boolFiringWeapon==true or boolMoving==true) then
			
			SetUnitValue(COB.WANT_CLOAK, 0)
			SetUnitValue(COB.CLOAKED, 0)
			boolPrevCloaked=false
			Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {oldStates.firestate}, {}) 
			Spring.GiveOrderToUnit(unitID, CMD.MOVE_STATE, {oldStates.movestate}, {})
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
		Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {0}, {}) 
	end
	return 1
end

function script.Deactivate()
	SetUnitValue(COB.WANT_CLOAK,0)
	Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, {}) 
	return 0
end


function restorePeace()
	Signal(SIG_PEACE)
	boolPeacefull=false
	SetSignalMask(SIG_PEACE)
	Sleep(piecePeriod)
	boolPeacefull=true
end

function script.HitByWeapon ( x, z, weaponDefID, damage )
	
	StartThread(restorePeace)
	return damage
end