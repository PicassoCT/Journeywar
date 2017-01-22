include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

cssArmL =piece "cssArmL"
cssArmR =piece "cssArmR"
center = piece"center"
jet2 =piece "jet2"
jet1 =piece "jet1"
flare02 =piece "flare02"
flare01 =piece "flare01"
cssBody=piece"cssBody"
cssLegL=piece"cssLegL"
cssLegLlow=piece"cssLegLlow"
cssLegR=piece"cssLegR"
cssLegRlow=piece"cssLegRlow"
itterator= 1
SIG_IDLE=2
SIG_AIM=4
SIG_WALK=8
SIG_LEG=16

myDefID=Spring.GetUnitDefID(unitID)
function letsWalkAndTalk()
	
	
	while(true) do
			randSleep=math.ceil(math.random(25000,500000))
			Sleep(randSleep)
		while boolMoving == false do
			randSleep=math.ceil(math.random(10000,25000))
			Sleep(randSleep)
		burst=math.ceil(math.random(1,3))
		for i=1,burst,1 do
			StringOfStrings="sounds/csupsold/talk"
			appendMe=math.floor(math.random(1,9))
			EndOfStrings=".wav"
			result=StringOfStrings..appendMe
			result=result..EndOfStrings
			PlaySoundByUnitDefID(myDefID,result,0.5, 2000, 1,0)

			Sleep(4200)
		end
		
		end
	end
end

boolWalking= false
function walk()
	Signal(SIG_IDLE)
	SetSignalMask(SIG_WALK)
	Turn(cssBody,y_axis,math.rad(0),20)
	Turn(cssBody,x_axis,math.rad(20),0)
	boolWalking=true
	while(true) do
		Turn(center,y_axis,math.rad(3),0.25)
		Turn(cssArmL,x_axis,math.rad(34),5)
		Turn(cssArmR,x_axis,math.rad(-12),5)
		--
		Turn(cssLegL,x_axis,math.rad(-63),7)
		Turn(cssLegLlow,x_axis,math.rad(25),7)
		Turn(cssLegR,x_axis,math.rad(-29),7)
		Turn(cssLegRlow,x_axis,math.rad(32),7)
		
		--	WaitForTurn(cssLegR,x_axis)
		WaitForTurn(cssLegL,x_axis)
		--
		Turn(cssLegL,x_axis,math.rad(-49),7)
		Turn(cssLegLlow,x_axis,math.rad(44),7)
		Turn(cssLegR,x_axis,math.rad(0),7)
		Turn(cssLegRlow,x_axis,math.rad(14),7)
		--
		WaitForTurn(cssLegL,x_axis)
		Turn(center,y_axis,math.rad(-3),0.25)
		Turn(cssArmL,x_axis,math.rad(-12),5)
		Turn(cssArmR,x_axis,math.rad(34),5)
		--
		Turn(cssLegL,x_axis,math.rad(10),7)
		Turn(cssLegLlow,x_axis,math.rad(61),7)
		Turn(cssLegR,x_axis,math.rad(-62),7)
		Turn(cssLegRlow,x_axis,math.rad(66),7)
		--
		WaitForTurn(cssLegR,x_axis)
		WaitForTurn(cssLegL,x_axis)
		--
		Turn(cssLegL,x_axis,math.rad(-16),7)
		Turn(cssLegLlow,x_axis,math.rad(96),7)
		Turn(cssLegR,x_axis,math.rad(-44),7)
		Turn(cssLegRlow,x_axis,math.rad(46),7)
		--
		WaitForTurn(cssLegL,x_axis)
	end
end

function lua_FlameShot(weapon)
	
	return 0;
end

function script.StartMoving()
	
	Turn(center, y_axis, math.rad(0), 14)
	
	Signal(SIG_IDLE)
	Signal(SIG_LEG)
	Signal(SIG_moveStatemachine)
	StartThread(walk)
	
end

function legs_down()
	SetSignalMask(SIG_LEG)
	Sleep(100)
	Turn(center,y_axis,math.rad(0),0)
	Turn(cssArmL,z_axis,math.rad(0),7)
	Turn(cssArmR,z_axis,math.rad(0),7)
	
	Turn(cssArmL,y_axis,math.rad(0),7)
	Turn(cssArmR,y_axis,math.rad(0),7)
	Turn(cssArmL,x_axis,math.rad(0),7)
	Turn(cssArmR,x_axis,math.rad(0),7)
	Turn(cssBody,x_axis,math.rad(0),17)
	Turn(cssLegL,x_axis,math.rad(0),7)
	Turn(cssLegLlow,x_axis,math.rad(0),7)
	Turn(cssLegR,x_axis,math.rad(0),7)
	Turn(cssLegRlow,x_axis,math.rad(0),7)
	
end

function script.StopMoving()
	
	boolWalking = false
	Signal(SIG_COUNTER)
	
	-- --Spring.Echo ("stopped walking!")
	Signal(SIG_WALK)
	
	StartThread(legs_down)
	
	
end



function script.Create()
	Hide(jet1)
	Hide(jet2)
	Hide(flare01)
	Hide(flare02)
	StartThread(letsWalkAndTalk)
	Signal(SIG_IDLE)
	Signal(SIG_LEG)
	Signal(SIG_moveStatemachine)
	
	----Spring.Echo "This was a Triumph! Im making a note here huge Success!"
	--Spring.UnitScript.Play("centerdeploy")
	
end

function script.Killed()
	setSpeed(unitID,0,UnitDefs)
	Turn(center,x_axis, math.rad(82),math.rad(55))
	EmitSfx(center,1025)	
	EmitSfx(center,1026)	
	for i=1,30 do
		
		EmitSfx(center,1024)	
		Sleep(50)
	end
	EmitSfx(center,1024)	
	WaitForTurn(center, z_axis)
	EmitSfx(center,1025)	
	EmitSfx(center,1024)
	if math.random(0,1)==1 then
		x,y,z=Spring.GetUnitPosition(unitID)
		if not GG.AddFire then 
			GG.AddFire={} 
		end
		
		GG.AddFire[#GG.AddFire+1]={x=x,y=y,z=z}
	end
	
	for i=1,24 do
		EmitSfx(center,1026)
		Sleep(100)
	end
	Explode (center, SFX.FIRE)
	Explode (cssArmL, SFX.FIRE)
end

unitDefID=Spring.GetUnitDefID(unitID)

--function script.Shot(num)
--
--GG.LUPS.FlameShot(unitID, unitDefID, _, num)
--
--end



function script.QueryWeapon1() return 
flare02 end

function script.AimFromWeapon1() 
	--soundstart="centeralert"
return cssArmL end

function script.AimWeapon1( heading, pitch )
	SetSignalMask(SIG_AIM)
	if boolWalking == false then
		Turn(cssArmL, x_axis, math.rad(-62),12)
		WaitForTurn(cssArmL, x_axis)
		Sleep(10)
		Turn(center,y_axis,heading,7)
		WaitForTurn(center, y_axis)		
		--Turn(lgun, x_axis, -pitch, math.rad(100))
		
		--WaitForTurn(lgun, x_axis)
		--StartThread(RestoreAfterDelay)
		return true
	end
	return false
end


function script.FireWeapon1()
	EmitSfx(flare01,1026)
	EmitSfx(jet1,1027)
	
	
	--lua_FlameShot(1)
end

function script.QueryWeapon2() 
	return flare01 
end

function script.AimFromWeapon2() 
	--soundstart="centeralert"
return cssArmR end

function script.AimWeapon2( heading, pitch )
	SetSignalMask(SIG_AIM)
	if boolWalking == false then
		Sleep(50)
		Turn(cssArmR, x_axis, math.rad(-62),12)
		WaitForTurn(cssArmR, x_axis)
		
		--Turn(lgun, x_axis, -pitch, math.rad(100))
		
		--WaitForTurn(lgun, x_axis)
		--StartThread(RestoreAfterDelay)
		return true
	end
	return false
end

function playSound2()
	Spring.PlaySoundFile("sounds/csupsold/flames.wav") 
	Sleep(1800)
	boolSoundPlays2=false
end

boolSoundPlays2=false
function script.FireWeapon2()
	if boolSoundPlays2==false then 
		boolSoundPlays2=true
		Spring.PlaySoundFile("sounds/csupsold/flamethrower.wav") 
		Sleep(800)
		StartThread(playSound2)
	end
	--emits the fire of the flamethrower
	
	EmitSfx(flare02,1026)
	EmitSfx(jet2,1027)
	--lua_FlameShot(2)
end

