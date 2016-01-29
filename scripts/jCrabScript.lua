deathpivot = piece "deathpivot"
Crabbase = piece "Crabbase"
crabattack1=piece"crabattack1"
crabattack2=piece"crabattack2"
crabTakingCrapPoint=piece"crabTakingCrapPoint"
aimpoint=piece"aimpoint"
local SIG_AIM2=1
local SIG_WALK=2
local SIG_LEG=4
local SIG_DEFAULT=32



crableg={}
legBoolean={}
for i=1, 4,1 do
legBoolean[i]={}
legBoolean[i]=false
crableg[i]={}
temp="crableg"..i
crableg[i]=piece (temp)
end
function script.Create()
	StartThread(defaultEnemy)
end

function frontLeg(nr,inverter)
legBoolean[nr]=true
if inverter== -1 then
Turn(crableg[nr],y_axis,math.rad(-20*inverter),6)--back	
	WaitForTurn(crableg[nr],y_axis)		
Turn(crableg[nr],x_axis,math.rad(-41),6)  --backup
Turn(crableg[nr],z_axis,math.rad(5),6) 		
	WaitForTurn(crableg[nr],x_axis)	

Turn(crableg[nr],y_axis,math.rad(79*inverter),6)  --front	
WaitForTurn(crableg[nr],y_axis)
Turn(crableg[nr],x_axis,math.rad(0),6)  --frontdown
Turn(crableg[nr],z_axis,math.rad(0),6) 
WaitForTurn(crableg[nr],x_axis)
WaitForTurn(crableg[nr],z_axis)
legSound(0.1)
				  
else

Turn(crableg[nr],y_axis,math.rad(-20*inverter),6)--back		
WaitForTurn(crableg[nr],y_axis)
Turn(crableg[nr],x_axis,math.rad(0),6)  --frontdown
Turn(crableg[nr],z_axis,math.rad(0),6) 
WaitForTurn(crableg[nr],x_axis)
WaitForTurn(crableg[nr],z_axis)
legSound(0.1)
Turn(crableg[nr],y_axis,math.rad(79*inverter),6)  --front
	WaitForTurn(crableg[nr],y_axis)		
Turn(crableg[nr],x_axis,math.rad(-41),6)  --backup
Turn(crableg[nr],z_axis,math.rad(5),6) 		
	WaitForTurn(crableg[nr],x_axis)			

end		
				
legBoolean[nr]=false
end

function legSound(loudness)
diceBeNice=math.random(1,7)
	if diceBeNice%3== 0 then
		d=math.random(1,4)
		if math.random(0,2)==1 then
			if d==1 then
				Spring.PlaySoundFile("sounds/jcrabcreep/crabwalk4.wav",loudness)

			elseif d==2 then
				Spring.PlaySoundFile("sounds/jcrabcreep/crabwalk3.wav",loudness)
			elseif d==3 then
				Spring.PlaySoundFile("sounds/jcrabcreep/crabwalk2.wav",loudness)
			else
				Spring.PlaySoundFile("sounds/jcrabcreep/crabwalk1.wav",loudness)
			end
		end
	end
end

function behindLeg(nr,inverter) 
legBoolean[nr]=true
--1 invert
if inverter== -1 then

     Turn(crableg[nr],y_axis,math.rad(-45*inverter),4)--back
	 WaitForTurn(crableg[nr],y_axis)
   	 Turn(crableg[nr],y_axis,math.rad(27*inverter),5)
   
     Turn(crableg[nr],x_axis,math.rad(-25),7)
     Turn(crableg[nr],z_axis,math.rad(46),6) --upback
	 WaitForTurn(crableg[nr],y_axis)
	 WaitForTurn(crableg[nr],x_axis)
	 WaitForTurn(crableg[nr],z_axis)
	 --upfront
	Turn(crableg[nr],y_axis,math.rad(-71*inverter),5)

	 WaitForTurn(crableg[nr],y_axis)
	 --down
	  Turn(crableg[nr],x_axis,math.rad(0),7) 
	  Turn(crableg[nr],z_axis,math.rad(0),7) 
	  WaitForTurn(crableg[nr],x_axis)
	  legSound(0.1)
	 
			else
			
				--upfront
				 Turn(crableg[nr],y_axis,math.rad(27),7)
				 WaitForTurn(crableg[nr],y_axis)
				 --down
				 Turn(crableg[nr],x_axis,math.rad(0),7) 
				 Turn(crableg[nr],z_axis,math.rad(0),7) 
				 WaitForTurn(crableg[nr],x_axis)
				 legSound(0.1)
				 Turn(crableg[nr],y_axis,math.rad(-45),4)--back
				 WaitForTurn(crableg[nr],y_axis)
				 Turn(crableg[nr],y_axis,math.rad(-71),7)
				 Turn(crableg[nr],x_axis,math.rad(-25),7)
				 Turn(crableg[nr],z_axis,math.rad(-46),7) --upback
				 WaitForTurn(crableg[nr],y_axis)
				 WaitForTurn(crableg[nr],z_axis)
				
		

			end
legBoolean[nr]=false			
end

function legs_down()
SetSignalMask(SIG_LEG)
Sleep(550)
	Signal(SIG_WALK)
	Turn(deathpivot,y_axis,math.rad(0),7)
for i=1, 4,1 do
Turn(crableg[i],x_axis,math.rad(0),12)
Turn(crableg[i],y_axis,math.rad(0),12)
Turn(crableg[i],z_axis,math.rad(0),12)
end
for i=1, 4,1 do
legBoolean[i]=false
end
Turn(Crabbase,x_axis,math.rad(0),12)
Turn(Crabbase,y_axis,math.rad(0),12)
Turn(Crabbase,z_axis,math.rad(0),12)

Turn(crabattack1,x_axis,math.rad(0),12)
Turn(crabattack1,y_axis,math.rad(0),12)
Turn(crabattack1,z_axis,math.rad(0),12)


Turn(crabattack2,x_axis,math.rad(0),12)
Turn(crabattack2,y_axis,math.rad(0),12)
Turn(crabattack2,z_axis,math.rad(0),12)

end

function legz()
	for i=1,4, 1 do
		if legBoolean[i]==false then 
		--switches dont know about:
			if i == 1 then StartThread(behindLeg,1,-1) end
			if i== 2 then StartThread(frontLeg,2,1) end
			if i== 3 then StartThread(frontLeg,3,-1) end
			if i == 4 then StartThread(behindLeg,4,1) end
		end
	end

end

function walk()
	Sleep(5)
    Signal(SIG_LEG)
	SetSignalMask(SIG_WALK)
	Turn(deathpivot,y_axis,math.rad(45),7)
	
	while (true) do
				 legz()
				 Sleep(450)
				 Turn(Crabbase,x_axis,math.rad(3),0.5)
				 tol=math.random(2,7)
				 Turn(Crabbase,z_axis,math.rad(tol),0.5)
				 val=math.random(10,20)
				 Turn(crabattack1,y_axis,math.rad(val),4)
				 Turn(crabattack1,z_axis,math.rad(-2),6)
				 Turn(crabattack2,z_axis,math.rad(-8),6)
				 val=math.random(5,14)
				 Turn(crabattack2,y_axis,math.rad(val),4)
				 Turn(crabattack2,x_axis,math.rad(1),6)
				 legz()
				 Sleep(450)
				 Turn(Crabbase,x_axis,math.rad(-3),0.5)
				 tol=math.random(-7,-2)
				 Turn(Crabbase,z_axis,math.rad(tol),0.5)
				 legz()
				 if math.random(0,1) ==1 then
					 Turn(crabattack1,x_axis,math.rad(-3),6)
					 val=math.random(-12,-4)
					 Turn(crabattack1,y_axis,math.rad(val),4)
					 Turn(crabattack1,z_axis,math.rad(14),6)
				 Turn(crabattack2,z_axis,math.rad(3),6)
				 val=math.random(-36,-30)
				 Turn(crabattack2,y_axis,math.rad(val),6)
				 val=math.random(7,12)
				 Turn(crabattack2,x_axis,math.rad(val),4)
				else
				 Turn(crabattack1,y_axis,math.rad(0),4)
				 Turn(crabattack1,x_axis,math.rad(0),6)
				 Turn(crabattack1,z_axis,math.rad(0),6)
				
				 Turn(crabattack2,y_axis,math.rad(0),4)
				 Turn(crabattack2,x_axis,math.rad(0),6)
				 Turn(crabattack2,z_axis,math.rad(0),6)
				 Sleep(250)
				 legz()
				deci= math.random(5,55)
						 Turn(crabattack1,y_axis,math.rad(deci),4)
						 Turn(crabattack2,y_axis,math.rad(-deci),4)
						 Sleep(380)
				legz()
				end
					--left forwards back left down
				
		end
	end

	function script.StartMoving()
	Signal(SIG_DEFAULT)
	StartThread(walk)
	end

	function script.StopMoving()
		Signal(SIG_WALK)
		StartThread(defaultEnemy)
		StartThread(legs_down)
		Turn(deathpivot,y_axis,math.rad(0),7)
		

	end
		
	function defaultEnemy()
	SetSignalMask(SIG_DEFAULT)
	Sleep(15000)
	
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
	
	
	
	
	
function script.HitByWeapon(x,z,weaponDefID,damage)
h=Spring.GetHeadingFromVector(x,z)
h=h-32768
Turn(crabTakingCrapPoint,y_axis,h,0)
	for i=1, 4,1 do 
	EmitSfx(crabTakingCrapPoint,1024)
	end


end
	
	
	
	
	
----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpoint 
end

function script.QueryWeapon1() 
	return aimpoint 
end

function script.AimWeapon1( heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy
	--Turn(turret, y_axis, heading)
	
	Signal(SIG_AIM2)
	Signal(SIG_LEG)
	

	SetSignalMask(SIG_AIM2)
			Turn(deathpivot,y_axis,heading,7)	
	 	    Turn(crabattack1,y_axis,math.rad(-61),4)
			Turn(crabattack2,y_axis,math.rad(62),4)			
			WaitForTurn(deathpivot,y_axis)
			WaitForTurn(crabattack1,y_axis)
			WaitForTurn(crabattack2,y_axis)
	
	return true
end

function Clawanimation()
 	        Turn(crabattack1,y_axis,math.rad(0),64)
		 	Turn(crabattack2,y_axis,math.rad(0),64)			
			WaitForTurn(crabattack1,y_axis)
			WaitForTurn(crabattack2,y_axis)
end

function script.FireWeapon1()	

	Spring.PlaySoundFile("sounds/jcrabcreep/crabattack.wav",1)
Clawanimation()
	return true
end



function script.Killed(recentDamage,_)
Turn(Crabbase,x_axis,math.rad(180),90)
WaitForTurn(Crabbase,x_axis)
for i=1,15,1 do 
EmitSfx(Crabbase,1024)
Sleep(26)
end

return 0
end