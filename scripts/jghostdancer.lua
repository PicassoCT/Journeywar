	--All Praise goes to Knorke. Just look under Awesome in the Wiki.
	
	
	--Those who enter: Beware, only mindfucks here, i swear!
	-- i worked really hard to de-robotimize these - and i think i succeded. 
	
	
	---Signals to be spread
	
	---------------------IdleStance10-Fucntions-------
	aimpivot=piece "aimpivot"
	shadowemit=piece"shadowemit"
	gdbhleg=piece"gdbhleg"
	gdbhlegj=piece"gdbhlegj"
	gdflegj=piece"gdflegj"
	gdfrontleg=piece"gdfrontleg"
	ghostdance=piece"ghostdance"
	deathpivot=piece"deathpivot"
	boolActivated=true
	unitTable={}
	unitTableNr=0
	recoverTime=90000
	SIG_WALK= 1
	SIG_IDLE= 2
	teamID=Spring.GetUnitTeam(unitID)
	boolOnlyOnce=false
	fullHealthOfAShadow=0
	
	
	local JSHADOWCOST=100
	function buildIt()
		for i=#unitTable,1,-1 do
			if Spring.GetUnitIsDead(unitTable[i])== false then
			else
			internalEnergy=internalEnergy+30
			table.remove(unitTable,i)
			end
		end
	
		if internalEnergy - JSHADOWCOST > 0 then
		internalEnergy=internalEnergy-JSHADOWCOST
			if #unitTable < 4 then
			x,y,z=Spring.GetUnitPosition(unitID)
			thisID=Spring.CreateUnit("jshadow",x,y,z,1,teamID)
			table.insert(unitTable,thisID)
			end
		return true
		end
	return false
	end
	
	function script.HitByWeapon ( x, z, weaponDefID, damage )
		if damage and  damage > 20 then
		ed=Spring.GetUnitNearestEnemy(unitID)
			if ed then
			ex,ey,ez=Spring.GetUnitPosition(ed)
				if ex then
				ux,uy,uz=Spring.GetUnitPosition(unitID)
				vx,vz=ex-ux,ez-uz
				
					if buildIt()==true then
					Spring.SetUnitPosition(unitID,ex+vx,ey,ez+vz)
					else
					Spring.SetUnitPosition(unitID,ux-vx/2,uy,uz-vz/2)
					end
				end
			end
		end
	return damage
	end
	
	local internalEnergy=0
	
	function spawnAndManageShadows()
	
	local MAX=240
	
		while(true) do
		exp=Spring.GetUnitExperience(unitID) 
		if not exp or exp < 1 then exp=1 end
	
		internalEnergyMax=MAX *exp
		internalEnergy=math.min(internalEnergyMax,internalEnergy+10 )
	
		Sleep(500)
		end
	end
	
	
	function script.Activate()
	boolActivated=true
		return 1
	end
	
	function script.Deactivate()
	boolActivated=false
	
		return 0
	end
	
	
	local function legs_down()
	Hide(gdbhlegj)
	Hide(gdflegj)
	Show(gdfrontleg)
	Show(gdbhleg)
	Move(ghostdance,y_axis,0,9.81)
		Turn(gdbhleg,x_axis,math.rad(0),12)   
		Turn(gdbhlegj,x_axis,math.rad(0),12)   
		Turn(gdflegj,x_axis,math.rad(0),12)   
		Turn(gdfrontleg,x_axis,math.rad(0),12)   
		Turn(ghostdance,x_axis,math.rad(0),12)   
	end
	
	function reset()
	
	
	end
	
	function idle()
	SetSignalMask(SIG_IDLE)
	
	
	
	
	end
	
	function script.Create()
	Hide(gdbhlegj)
	Hide(gdflegj)
	StartThread(spawnAndManageShadows)
	end
	
	function script.Killed(recentDamage,maxHealth)
	end
	function smokeEmit()
	local lEmitSFX=EmitSfx
	while(true) do
	erratic=math.random(0,25)
	if erratic==12 then
	Sleep(512)
	end
	lEmitSFX(shadowemit,1025)
	Sleep(110)
	end
	end
	
	function threadedLegs(prevtime,time)
	Sleep(prevtime)
	Show(gdbhlegj)
	Show(gdflegj)
	Hide(gdfrontleg)
	Hide(gdbhleg)
	Sleep(time)
	Hide(gdbhlegj)
	Hide(gdflegj)
	Show(gdfrontleg)
	Show(gdbhleg)
	end
	
	function walk()
	SetSignalMask(SIG_WALK)
	StartThread(smokeEmit)
	while (true) do
	
	--landing
	Move(ghostdance,y_axis,0,25)
	Turn(ghostdance,x_axis,math.rad(11),12)
	Turn(gdflegj,x_axis,math.rad(8),0)--8
	Turn(gdfrontleg,x_axis,math.rad(155),0)
	Turn(gdflegj,x_axis,math.rad(222),90)--138
	Turn(gdfrontleg,x_axis,math.rad(-29),90)
	
	Turn(gdbhlegj,x_axis,math.rad(8),0)
	Turn(gdbhleg,x_axis,math.rad(155),0)
	Turn(gdbhlegj,x_axis,math.rad(222),90)--138
	Turn(gdbhleg,x_axis,math.rad(-29),90)
	StartThread(threadedLegs,120,120)
	--placeleghidefunction here
	WaitForMove(ghostdance,y_axis)
	--TouchDown
	Turn(ghostdance,x_axis,math.rad(-2),12)
	Move(ghostdance,y_axis,-2,25)
	Sleep(320)
	
	--anlauf
	Turn(ghostdance,x_axis,math.rad(-8),12)
	Turn(gdflegj,x_axis,math.rad(0),55)
	Turn(gdfrontleg,x_axis,math.rad(108),55)
	Turn(gdbhlegj,x_axis,math.rad(6),55)
	Turn(gdbhleg,x_axis,math.rad(118),55)
	--sprung
	Move(ghostdance,y_axis,6,15)
	StartThread(threadedLegs,120,80)
	WaitForMove(ghostdance,y_axis)
	Sleep(220)
	--zenit
	Turn(ghostdance,x_axis,math.rad(-2),12)
	
	end
	
	end
	
	
	
	
	
	function script.StartMoving()
	Signal(SIG_IDLE)
	reset()
	Signal(SIG_WALK)
	StartThread(walk)
	end
	
	function script.StopMoving()
	Signal(SIG_WALK)
	legs_down()
	Signal(SIG_IDLE)
	StartThread(idle)
	
		end
	
	---AIMING & SHOOTING -
	function script.AimFromWeapon1() 
		
		return aimpivot 
	end
	
	function script.QueryWeapon1() 
		return aimpivot
	end
	
	--must return true to allow the weapon to shot. return false denies the weapon from shooting
	-- can be used delay the shooting until a "turn turret" animation is completed
	function script.AimWeapon1(heading,pitch)
	return true
	end
	
	-- called after the weapon has fired
	function script.FireWeapon1()
		
		--Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav")  
	
		
	end
	
	function script.AimFromWeapon2() 
		
		return aimpivot 
	end
	
	function script.QueryWeapon2() 
		return aimpivot
	end
	
	--must return true to allow the weapon to shot. return false denies the weapon from shooting
	-- can be used delay the shooting until a "turn turret" animation is completed
	function script.AimWeapon2(heading,pitch)
	return true
	end
	
	-- called after the weapon has fired
	function script.FireWeapon2()
		
		--Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav")  
	
		
	end


  
