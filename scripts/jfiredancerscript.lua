--Define the wheel pieces
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
local flare02= piece "pad1"
local center= piece "center"
local LegR = piece"LegR"
local LLegR = piece"LLegR"
local LegL = piece"LegL"
local LLegL= piece"LLegL"


--define other pieces
local body = piece "body"
local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
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
				mexID= Spring.CreateUnit("jfiredancebomb", x, y, z, 0, teamID) 
				--Transfer Unit Attack Command
	
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(mexID,health)	
				dirx,diry,dirz=Spring.GetUnitDirection(unitID)
				Spring.SetUnitDirection(mexID,dirx,diry,dirz)				
				Spring.DestroyUnit (unitID,false,true)
	
	
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
String="sounds/jfiredance/jfiredance"
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

	rand=math.random(0,3)
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
----driving animation
--local LegR = piece" LegR "
--local LLegR = piece" LLegR "
--local LegL = piece" LegL "
--local LLegL= piece" LLegL"

--http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units

local function walk()
	
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	--Turn(center, y_axis, math.rad(0), 34)
	Turn(body, x_axis, math.rad(0), 34)
	WaitForTurn(body,x_axis)
	leg_movespeed=1

	
	while (true) do
	leg_movespeed=math.min(7, leg_movespeed+3)
	
		--left leg up, right leg down
		Turn(Head,y_axis,math.rad(2),0.5)
		Turn(LegR, x_axis,math.rad(-13) ,3 )
	
		
		Turn(LegL, x_axis, math.rad(6), leg_movespeed)
		Turn(ArmL,x_axis,math.rad(7),4)
	
		WaitForTurn (LegR, x_axis)
		WaitForTurn (LegL, x_axis)	
		WaitForTurn (LLegL,x_axis)
		Turn(body, x_axis,math.rad(12),9)
		Turn(Head,x_axis,math.rad(2),0.5)
		Turn(ArmR,x_axis,math.rad(-29),2)
		Turn(LegR, x_axis,math.rad(-32) ,3 )
		Turn(LegL, x_axis, math.rad(22), leg_movespeed)
		Turn(LLegL, x_axis, math.rad(24), leg_movespeed)
		Turn(LLegR,x_axis,math.rad(50), 6)

		WaitForTurn (LegR, x_axis)
		WaitForTurn (LLegL,x_axis)
		WaitForTurn (LegL, x_axis)		
		WaitForTurn (LLegR, x_axis)
		randSleep=math.random(140,200)
		Sleep (randSleep)
		--left leg down, right leg up
		Turn(Head,y_axis,math.rad(-2),0.5)
		Turn(LegL, x_axis,math.rad(-26) ,3 )
		Turn(LLegL,x_axis,math.rad(45), 6)
		
		Turn(LegR, x_axis, math.rad(12), leg_movespeed)
		Turn(ArmL,x_axis,math.rad(-29),2)
		WaitForTurn (LegL, x_axis)
		WaitForTurn (LegR, x_axis)	
		WaitForTurn (LLegR,x_axis)
		WaitForTurn (LLegL, x_axis)
		
		Turn(body, x_axis,math.rad(6),9)
		Turn(ArmR,x_axis,math.rad(7),4)
		Turn(LegL, x_axis,math.rad(-34) ,5)
		Turn(LLegR, x_axis, math.rad(18), leg_movespeed)
		Turn(LLegL,x_axis,math.rad(60), 5)
		Turn(Head,x_axis,math.rad(-0.5),0.5)
		WaitForTurn (LegR, x_axis)
		WaitForTurn (LegL, x_axis)
		WaitForTurn (LLegR,x_axis)
		WaitForTurn (LLegL, x_axis)
		Sleep (80)
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


				x,y,z=Spring.GetUnitPosition (unitID)
			   Spring.CreateUnit("jfiredancedecal", x, y, z, math.ceil(math.random(0,3)), teamID) 


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
--    ----Spring.Echo ("starting to walk!")
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
		
		
end

--FireWeapon2

 
 function stanceReSet()
	Sleep(500) 
	Turn(center,y_axis,math.rad(0),12) 
 end
 

