--Eliah

--Define the wheel pieces

local boolSecondAiming=false

--define other pieces

local SIG_WALK = 1	--signal for the walk animation thread
local SIG_AIM = 2  --signal for the weapon aiming thread
local SIG_IDLE=4
local SIG_AIM2 = 8
local SIG_LRESET=16
local SIG_RRESET=32
local SIG_FIGHTCLUB=64
boolNonCombatant=true

--eggspawn --tigLil and SkinFantry
center=piece "center"
cMonoHead=piece "cMonoHead"
cMonoStope=piece "cMonoStope"
pieces={}
for i=1,27,1 do
pieces[i]={}
temp="cNanoWir"..i
pieces[i]=piece(temp)
end

function script.Create()

Show(cMonoStope)
Hide(cMonoHead)
for i=1,27,1 do
Hide(pieces[i])
end

end

oneStep=(4*3.14159)/27
TwoStep=(2*3.14159)/27
ThreeStep=(3.14159/27)

local function walk()
SetSignalMask(SIG_WALK)
Hide(cMonoStope)
Show(cMonoHead)
for i=1,27,1 do
Show(pieces[i])
end
Spin(cMonoHead,z_axis,math.rad(42),0.02)
	while (true) do
			xi=1
			acc=0
			
			temp=TwoStep
			if math.random(0,1)==1 then
			temp=ThreeStep 
			--Spring.Echo("Alternative")
			end
				for i=0,2*3.14159,temp do

					radiantsToTurn=(-acc)-math.cos(i)
						if xi~=1 then
						Turn(pieces[xi],x_axis,radiantsToTurn,1.4)
							else
							if temp==ThreeStep then
							Turn(pieces[1],x_axis,math.rad(67),1.4)
							else
							Turn(pieces[1],x_axis,math.rad(-50),1.4)
							end
							end
					xi=((xi)%27)+1
					acc=acc+radiantsToTurn
						if xi==0 then xi=1 end
				end	
							if temp==ThreeStep then
							Turn(pieces[22],x_axis,math.rad(67),1.4)
							end	
		Sleep(100)
		WaitForTurn(pieces[26],x_axis)
		WaitForTurn(pieces[16],x_axis)
		
			xi=1
			acc=0
		
				for i=0,4*3.14159,oneStep do
				radiantsToTurn=(-acc)+math.sin(i)
					if xi~=1 then
					Turn(pieces[xi],x_axis,radiantsToTurn,1.4)
						else
						Turn(pieces[1],x_axis,math.rad(-10),1.4)
						end
				xi=((xi)%27)+1
				acc=acc+radiantsToTurn
					if xi==0 then xi=1 end
				end	
			Sleep(100)
			
		WaitForTurn(pieces[26],x_axis)
		WaitForTurn(pieces[16],x_axis)
	
	end
end


function script.Killed(recentDamage, maxHealth)
--legs_down()


	return 0
end


function idle()
SetSignalMask(SIG_IDLE)
Spin(cMonoStope,y_axis,math.rad(82),0.1)
Show(cMonoStope)
Hide(cMonoHead)
for i=1,27,1 do
Hide(pieces[i])
end
StopSpin(cMonoHead,z_axis)
Turn(cMonoHead,z_axis,0,0)
Sleep(4000)
if math.random(0,1)==1 then addIdle() end
while(true) do
val=math.random(4,9)
Move(cMonoStope,y_axis,val,0.125)
WaitForMove(cMonoStope,y_axis)
Move(cMonoStope,y_axis,0,0.25)
WaitForMove(cMonoStope,y_axis)
end
end


function addIdle()

Hide(cMonoStope)
Show(cMonoHead)
	for i=1,27,1 do
	Show(pieces[i])
	end
sup=3
		while (sup >=2) do
		xi=1
		
			for i=0,2*3.14159,oneStep do
			
			Turn(pieces[xi],x_axis,math.cos(i),3)
			xi=(xi+1)%27
				if xi==0 then xi=1 end
			end	
		Sleep(600)
		xi=1
			for i=0,2*3.14159,oneStep do
			Turn(pieces[xi],x_axis,math.sin(i),3)
			xi=(xi+1)%27
				if xi==0 then xi=1 end
			end	
		
			Sleep(600)
		sup=sup-1
		end
	
	
	Show(cMonoStope)
	Hide(cMonoHead)
		for i=1,27,1 do
		Hide(pieces[i])
		end

	
end


function script.StartMoving()
--    ----Spring.Echo ("starting to walk!")
	Signal(SIG_IDLE)
	StartThread (walk)
end

function script.StopMoving()
		
--    ----Spring.Echo ("stopped walking!")
		Signal(SIG_IDLE)
		Signal(SIG_WALK)
		StartThread(idle)
		
		
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return cMonoHead
end

function script.QueryWeapon1() 
	return cMonoHead
end

function script.AimWeapon1( heading ,pitch)
return true
end


function script.FireWeapon1()	
Spring.DestroyUnit(unitID,false,true)
	return true
end
