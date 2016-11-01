include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 


function TestSetLock(Lock,number)
	if TestLocks(Lock,number)==true then 
		Lock[number]=true
		return true
	end 
	return false
end

function TestLocks(Lock, number)
	for i=1,table.getn(Lock) do
		if number ~=i and Lock[i]==true then return false end
	end
	return true
end


function ReleaseLock(Lock,number)
	Lock[number]=false
end


--Define the pieces of the weapon
local Head = piece "Head"
local ArmR = piece "ArmR"
local ArmL = piece "ArmL"
local staff = piece "staff"
local flare02= piece "staff"
local center= piece "center"
local LegR = piece"LegR"
local LLegR = piece"LLegR"
local LegL = piece"LegL"
local LLegL= piece"LLegL"


--define other pieces
local body = piece "body"
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_IDLE=4
local SIG_AIM2 = 8

HaveLock={	[1]=false,
	[2]=false
} 



--eggspawn --tigLil and SkinFantry
boolIcanFly=false
function wizzardOfOS()
	while true do
		if boolIcanFly==true then
			--turn this whole thing into a groundtorpedo
			
			local x,y,z=Spring.GetUnitPosition (unitID)
			local teamID = Spring.GetUnitTeam (unitID)	
			Spring.CreateUnit("jfiredancedecal", x, y, z, math.ceil(math.random(0,3)), teamID) 
			transformUnitInto(unitID,"jfiredancebomb")
			
		end
		Sleep(100)
		
	end
	
end

function sound()
	if GG.FireDance== nil then 
		GG.FireDance={} 
		GG.FireDance[1]=math.floor(math.random(1,6))
		GG.FireDance[2]=math.floor(math.random(100000,400000))
		GG.FireDance[3]=unitID
	end
	String="sounds/jfiredancer/jfiredance"
	String2=".ogg"
	
	while true do
		if GG.FireDance and GG.FireDance[2]==0 and GG.FireDance[3]==unitID then
			GG.FireDance[1]=math.floor(math.random(1,6))
			GG.FireDance[2]=math.floor(math.random(100000,400000))
			GG.FireDance[3]=unitID
		end
		Sleep(500)
		randoVal=math.ceil(math.random(-50,50))
		res=GG.FireDance[2]+randoVal
		Sleep(res)
		Res=String..GG.FireDance[1]..String2
		Spring.PlaySoundFile(Res,1.0)
		Sleep(250)
		
		
	end
	
end

function script.Activate()
	boolIcanFly=true
	--	StartThread(alarmCheck)
	return 1
end

function script.Deactivate()
	
	--StartThread(alarmCheck)
	
	return 0
end


function script.Create()
	StartThread(wizzardOfOS)
	StartThread(sound)
	StartThread (downHillGlideDetector)
	
end

local function idle()
	
	sleeper=math.random(1024,8192)
	
	SetSignalMask(SIG_IDLE)
	while(true)do
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
		Turn (LegL, x_axis,math.rad(0), 15)
		Turn (LegR, x_axis,math.rad(0), 15)
		Turn(LLegR,x_axis,math.rad(0), 32)
		Turn(LLegL,x_axis,math.rad(0), 32)
		Sleep(sleeper)
		
		rand=math.random(0,4)
		if rand == 4 then
				Move(center,y_axis,-7,2)
				tP(Head,-24,0,0,1)
				tP(ArmR,-91,-44,0,1)
				tP(ArmL,-91,38,0,1)
				tP(LegR,-43,32,0,4)
				tP(LLegR,135,0,0,4)
				tP(LegL,-43,-32,0,4)
				tP(LLegL,135,0,0,4)
			if math.random(0,1)==1 then	
				for i=1, 12 do
					rand=math.random(-35,35)
					tP(ArmR,-91+rand,-44,0,1)
					tP(ArmL,-91+rand,38,0,1)
					tP(staff,-1*rand,0,0,1)
					WaitForTurns(ArmR,ArmL,staff)
					Sleep(2000)
				end			
			else
				Sleep(12000)
			end
		end
		
		if rand==3 then
			Turn(center,x_axis,math.rad(85),6)
			Turn(ArmL,x_axis,math.rad(-170),7)
			Turn(ArmR,x_axis,math.rad(-170),7)
			
			
			Turn(ArmR,x_axis,math.rad(-175),7)
		end
		if rand==1 then
			Turn(center,x_axis,math.rad(69),4)
			Turn(ArmL,x_axis,math.rad(-90),7)
			Turn(ArmR,x_axis,math.rad(-90),7)
			ringAlingADingDong=math.random(2,26)
			WaitForTurn(center,x_axis)
			for i=0, ringAlingADingDong, 1 do
				Turn(center,x_axis,math.rad(81),2)
				Turn(ArmL,x_axis,math.rad(-157),12)
				Turn(ArmR,x_axis,math.rad(-157),12)
				Turn(staff,x_axis,math.rad(75),12)
				WaitForTurn(center,x_axis)
				tRand=math.random(20,100)
				Sleep(tRand)
				Turn(center,x_axis,math.rad(62),1)
				Turn(ArmL,x_axis,math.rad(-84),11)
				Turn(ArmR,x_axis,math.rad(-84),11)
				Turn(staff,x_axis,math.rad(21),11)
				WaitForTurn(center,x_axis)
				Sleep(120)
			end
		end

		if rand==2 then
			tP(ArmL,12,0,-31,5)
			tP(ArmR,-172,0,30,5)
			tP(LLegR,152,0,0,5)
			tP(LegR,-77,0,0,5)
			tP(LegL,0,0,13,5)
			tP(LLegL,0,0,-13,5)
			tP(Head,-20,0,0,5)
		Spin(staff,y_axis,math.rad(400),0)
		WaitForTurns(ArmL,ArmR,LLegR, LegR,LLegL,LegL,Head)	
			tP(ArmL,-90,0,-31,5,true)
			tP(ArmL,-184,0,42,5,true)
			tP(ArmR,-172,0,-30,5)
		
		WaitForTurns(ArmL,ArmR,LLegR, LegR,LLegL,LegL,Head)	
		for i=1, 9 do 
			Spin(staff,y_axis,math.rad(400*-1^i),0)
			if i %2 == 0 then stompLeg(LegL,LLegL) else stompLeg(LegR,LLegR) end			
			randVal= math.random(-32,32)
			Turn(staff,x_axis,math.rad(randVal),11)
			Sleep(1000)
		end		
		StopSpin(staff,y_axis,1)
		reset(staff,1)
		end
		
		
		if rand==0 then
			Turn(ArmR,x_axis,math.rad(-90),7)
			Turn(ArmL,x_axis,math.rad(-90),7)
			WaitForTurn(ArmR,x_axis)
			WaitForTurn(ArmL,x_axis)
			
			sportIsMord=math.random(0,128)
			for it=0, sportIsMord,1 do
				Move(body,y_axis,-4,12)
				Turn(LegR,x_axis,math.rad(-42),3)
				Turn(LegL,x_axis,math.rad(-42),3)
				Turn(LLegR,x_axis,math.rad(121),10)
				Turn(LLegL,x_axis,math.rad(121),10)
				Turn(ArmR,x_axis,math.rad(-80),2)
				Turn(ArmL,x_axis,math.rad(-82),2)
				
				WaitForTurn(ArmR,x_axis) 
				WaitForTurn(ArmL,x_axis) 
				WaitForTurn(LegR,x_axis) 
				WaitForTurn(LegL,x_axis) 
				WaitForTurn(LLegR,x_axis) 
				WaitForTurn(LLegL,x_axis) 
				
				WaitForMove(body,y_axis)
				
				fixFertig=math.random(20,120)
				Sleep(fixFertig)
				Turn(ArmR,x_axis,math.rad(-90),3)
				Turn(ArmL,x_axis,math.rad(-90),3)
				Turn(LegR,x_axis,math.rad(0),3)
				Turn(LegL,x_axis,math.rad(0),3)
				Turn(LLegR,x_axis,math.rad(0),5)
				Turn(LLegL,x_axis,math.rad(0),5)
				Move(body,y_axis,0,16)
				WaitForTurn(ArmR,x_axis) 
				WaitForTurn(ArmL,x_axis) 
				WaitForTurn(LegR,x_axis) 
				WaitForTurn(LegL,x_axis) 
				WaitForTurn(LLegR,x_axis) 
				WaitForTurn(LLegL,x_axis) 
				
				
				WaitForMove(body,y_axis)
				fixFertig=math.random(80,620)
				Sleep(fixFertig)
				
				
			end
			Turn(LegR,x_axis,math.rad(70),5)
			Turn(LLegR,x_axis,math.rad(118),5)
			Turn(ArmR,x_axis,math.rad(-3),3)
			Turn(ArmR,y_axis,math.rad(-88),3)
			Turn(ArmR,z_axis,math.rad(77),3)
			Turn(ArmL,z_axis,math.rad(-77),3)
			Sleep(14000)
		end
		
	end
	
	
end
		function stompLeg(upLeg,dLeg)
			tP(dLeg,152,0,0,5)
			tP(upLeg,-77,0,0,5)
			WaitForTurns(upLeg,dLeg)
			tP(dLeg,0,0,0,5)
			tP(upLeg,0,0,0,5)
			WaitForTurns(upLeg,dLeg)		
		end

function walk()
	
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	--Turn(center, y_axis, math.rad(0), 34)
	Turn(body, x_axis, math.rad(0), 34)
	WaitForTurn(body,x_axis)
	leg_movespeed=1.5
	times=0
	step=math.pi/4
	while (true) do
		leg_movespeed=math.min(3, leg_movespeed+0.1)
		
		sway=math.sin(times)
		tP(Head,-15,0,0,leg_movespeed)
		tP(center,15,math.pi*sway,0,leg_movespeed)
		tP(LegR,-42,0,0,leg_movespeed)
		tP(LLegR,20,0,0,leg_movespeed)
		tP(LegL,11,0,0,leg_movespeed)
		tP(LLegL,15,0,0,leg_movespeed)
		
		tP(ArmL,-26,0,0,leg_movespeed)
		tP(ArmR,37,0,0,leg_movespeed)
		tP(staff,-37,0,0,leg_movespeed)
		
		WaitForTurns(LLegR,LegR,LLegL,LegL, Head, center, ArmL, ArmR)
		times=times+step
		tP(LegL,-42,0,0,leg_movespeed)
		tP(LLegL,20,0,0,leg_movespeed)
		tP(LegR,11,0,0,leg_movespeed)
		tP(LLegR,15,0,0,leg_movespeed)
		
		tP(ArmL,37,0,0,leg_movespeed)
		tP(ArmR,-16,0,0,leg_movespeed)
		tP(staff,16,0,0,leg_movespeed)
		--left leg up, right leg down
		tP(Head,-21,0,0,leg_movespeed)
		tP(center,10,-math.pi*sway ,0,leg_movespeed)
		WaitForTurns(LLegR,LegR,LLegL,LegL, Head, center, ArmL, ArmR)
		times=times+step
	end
end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return ArmR 
end

function script.QueryWeapon1() 
	return staff 
end

local lReleaseLock= ReleaseLock
local lTestSetLock= TestSetLock

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	Signal(SIG_IDLE)
	if lTestSetLock(HaveLock,1)==true then
		Signal(SIG_AIM2)
		SetSignalMask(SIG_AIM2)
		
		
		Turn(ArmR, x_axis, math.rad(-187),12)
		Turn(ArmR, y_axis, math.rad(0),12)
		Turn(ArmR, z_axis, math.rad(-3),12)
		Turn(ArmL, x_axis, math.rad(-178),12)
		Turn(ArmL, y_axis, math.rad(0),12)
		Turn(ArmL, z_axis, math.rad(5),12)
		Turn(staff,x_axis,math.rad(6),3)
		Turn(staff,y_axis,math.rad(79),13)
		Turn(staff,z_axis,math.rad(-10),3)
		
		Turn(LegL,z_axis,math.rad(-13),3)
		Turn(LegR,z_axis,math.rad(20),3)
		Turn(LLegL,z_axis,math.rad(5),3)
		Turn(LLegR,z_axis,math.rad(-11),3)
		
		WaitForTurn(ArmR,x_axis)
		Turn(center,y_axis,Heading,15)
		
		WaitForTurn(center,y_axis)
		return true
	else
		
		return false
	end
end

teamID = Spring.GetUnitTeam (unitID)
function script.FireWeapon1()	
	lReleaseLock(HaveLock,1)
	for i=1, 24, 1 do
		Sleep(i*3)
		EmitSfx(body,1024)
	end
	
	
	return true
end

function script.Killed(recentDamage, maxHealth)
	
	Signal(SIG_WALK)
	Signal(SIG_IDLE)
	
	mutliplier=1
	
	if bitRand==1 then
		Move(center,y_axis,2,0.6)
		
		Turn(center,x_axis,math.rad(25),3)
		WaitForTurn(center,x_axis)
		
		Turn(center,x_axis,math.rad(45),9)
		WaitForTurn(center,x_axis)	
		
		Turn(center,x_axis,math.rad(90),3)
		WaitForTurn(center,x_axis)
		Sleep(4096)
		----Spring.Echo ("He is dead, Jim!")
		return 0
		
	else
		Move(center,y_axis,2,0.6)
		
		Turn(center,x_axis,math.rad(-25),3)
		WaitForTurn(center,x_axis)
		
		Turn(center,x_axis,math.rad(-45),9)
		WaitForTurn(center,x_axis)	
		
		Turn(center,x_axis,math.rad(-90),3)
		WaitForTurn(center,x_axis)
		Sleep(4096)
		----Spring.Echo ("He is dead, Jim!")
		return 0
	end
	
	
	return 0
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
	Turn (LegL, x_axis,math.rad(0), 15)
	Turn (LegR, x_axis,math.rad(0), 15)
	Turn(LLegR,x_axis,math.rad(0), 32)
	Turn(LLegL,x_axis,math.rad(0), 32)
	
	Turn (ArmL, x_axis,math.rad(0), 15)	
	Turn (ArmL, y_axis,math.rad(0), 15)	
	Turn (ArmL, z_axis,math.rad(0), 15)
	
	Turn (ArmR, x_axis,math.rad(0), 15)	
	Turn (ArmR, y_axis,math.rad(0), 15)	
	Turn (ArmR, z_axis,math.rad(0), 15)
	
	Turn (staff, x_axis,math.rad(0), 15)	
	Turn (staff, y_axis,math.rad(0), 15)	
	Turn (staff, z_axis,math.rad(0), 15)
	
	Turn(ArmR, x_axis, math.rad(0),12)
	Turn(ArmR, y_axis, math.rad(0),12)
	Turn(ArmR, z_axis, math.rad(0),12)
	Turn(ArmL, x_axis, math.rad(0),12)
	Turn(ArmL, y_axis, math.rad(0),12)
	Turn(ArmL, z_axis, math.rad(0),12)
	Turn(staff,x_axis,math.rad(0),3)
	Turn(staff,y_axis,math.rad(0),13)
	Turn(staff,z_axis,math.rad(0),3)
	Turn(LegL,z_axis,math.rad(0),3)
	Turn(LegR,z_axis,math.rad(0),3)
	Turn(LLegL,z_axis,math.rad(0),3)
	Turn(LLegR,z_axis,math.rad(0),3)
	
	
	Turn(center,y_axis,math.rad(0),5)
	Turn(Head,y_axis,math.rad(0),3)
	
	
end

function script.StartMoving()
	-- ----Spring.Echo ("starting to walk!")
	Signal(SIG_IDLE)
	legs_down()
	StartThread (walk)

end

function downHillGlideDetector()

	while true do
		x,y,z=Spring.GetUnitPosition(unitID)
		gx,gy,gz= getUnitMoveGoal(unitID)
		if gx then
			gh  =  Spring.GetGroundHeight(x,z)
			ggh = 	Spring.GetGroundHeight(gx,gz)
			
			if ggh + 10 < gh and ggh > 0 then
			legs_down()
			Turn(staff,y_axis,math.rad(90),8)
			Turn(ArmL,x_axis,math.rad(-179),4)
			Turn(ArmR,x_axis,math.rad(-179),4)
			WaitForTurns(ArmL,ArmR,staff)
			--transform always into a glider downhill
			transformUnitInto(unitID,"jfiredanceglider")	

			end
		end
	Sleep(250)
	end
end

function script.StopMoving()
	
	-- ----Spring.Echo ("stopped walking!")
	Signal(SIG_IDLE)
	Signal(SIG_WALK)
	legs_down()
	StartThread(idle)
	
	
end

--FireWeapon2


function stanceReSet()
	Sleep(500) 
	Turn(center,y_axis,math.rad(0),12) 
end