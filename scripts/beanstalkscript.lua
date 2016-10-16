include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"

include "lib_Build.lua" 

center=piece"center"
beans= piece"beans"
beanstalk=piece"beanstalk"
introgroup =piece"introgroup"
bean1 =piece"bean1"
seed =piece"seed"
rootGroup=piece"rootGroup"
seedRotator=piece"seedRotator"
bshelix=piece"bshelix"
unRooted=piece"unRooted"
bsfetas=piece"bsfetas"
growGroup=piece"growGroup"
bsholo= piece"bsholo"
local SIG_ENTER=1
local SIG_PUMP=2
local SIG_DIRT=4
local SIG_PIPE=8
local SIG_LEAVE=16
local SIG_SHIELD=32
teamID=Spring.GetUnitTeam(unitID)
local currentpiece=piece"somemit1"
buildemitcenter= piece"buildemitcenter"
emitIt={}
for i=1,6,1 do
	emitIt[i]={}
	stone= "somemit"..i
	emitIt[i]=piece (stone)
end

spindl= piece"spindl"
spindl2=piece"spindl2"
spindl3=piece"spindl3"
pipePieces={}
for i=0,59,1 do
	pipePieces[i]={}
	stone= "bspip01p"..i
	pipePieces[i]=piece (stone)
end

pumps={}
for i=1,5,1 do
	pumps[i]={}
	stone= "pump"..i
	pumps[i]=piece (stone)
end

greenSleaves={}
for i=1,14,1 do
	greenSleaves[i]={}
	stone= "growLea"..i
	greenSleaves[i]=piece (stone)
end

bean1=piece"bean1"
bean2=piece"bean2"
bean3=piece"bean3"
rootgrow=piece"rootgrow"
rootRotate=piece"rootRotate"




wurzelballen={}

for i=1,10,1 do
	wurzelballen[i]={}
	stone= "Wurzelbal"..i
	wurzelballen[i]=piece (stone)
end




dirt={}
for i=1,6,1 do
	dirt[i]={}
	stone= "Dirt"..i
	dirt[i]=piece (stone)
end
fireFx1=piece"fireFx1"
fireFx2=piece"fireFx2"
fireFx3=piece"fireFx3"
spiralCenter= piece"spiralCenter"

function nanoEmitIdler()
	Spring.SetUnitNanoPieces(unitID,emitIt)
	
	local randNom=math.random
	while(true) do
		randDeg=randNom(0,360)
		Turn(buildemitcenter,y_axis,math.rad(randDeg),0,true)
		selected=math.ceil(randNom(1,6))
		Sleep(75)
	end
end

function cyclesOfFire()
	Hide(fireFx1)
	Hide(fireFx2)
	Hide(fireFx3)
	while(true) do
		Spin(spiralCenter,y_axis,math.rad(42),0.3)
		EmitSfx(fireFx1,1032)
		EmitSfx(fireFx2,1032)
		EmitSfx(fireFx3,1032)
		Sleep(60)
		
	end
end
blimelyLookAtTheTime=0

boolOnce=true
total=10
function spawny()
	blimelyLookAtTheTime=1500
	if total > 0 then
		slice=math.ceil(math.random(1,5))
		px, py, pz, dx, dy, dz =Spring.GetUnitPiecePosDir(unitID,pumps[slice])
		GG.UnitsToSpawn:PushCreateUnit("tiglil",px,py,pz, 0, teamID) 
		total=total-1
	elseif boolOnce==true then
		boolOnce=false
		Sleep(23000)
		total=10
		boolOnce=true
		blimelyLookAtTheTime=0
		
	end
	Sleep(1500)
	blimelyLookAtTheTime=0
	
end

function soundSleeper()
	restTime=math.ceil(math.random(900000,1900000))
	Sleep(restTime)
	d=math.random(0,2)
	if d==1 then
		Spring.PlaySoundFile("sounds/jBeanStalk/propAgenda.ogg",1.0)
	elseif d==0 then
		Spring.PlaySoundFile("sounds/jBeanStalk/propAgenda2.wav",1.0)
	elseif d==2 then
		Spring.PlaySoundFile("sounds/jBeanStalk/propAgenda3.wav",1.0)
	end
	
end

function darkEnergyReactor()
	time=0
	PIE=3.14159/60
	med=0
	while true do
		time=(time+PIE)%6.28318530
		val=math.ceil(((math.sin(time)*75)+med)/2)
		med=val
		if val > 0 then 
			Spring.AddUnitResource(unitID,"e",val)
		else
			val=math.abs(val)
			Spring.UseUnitResource(unitID,"e",val)
		end
		Sleep(1010)
		
	end
end


function HitByWeapon ( x, z, weaponDefID, damage )
	if blimelyLookAtTheTime == 0 and damage > 15 then
		StartThread(spawny)
		Signal(SIG_SHIELD)
		StartThread(shield)
	end
	return damage
end

function shield()
	SetSignalMask(SIG_SHIELD)
	Sleep(500)
	Spring.SetUnitShieldState(unitID,1,true)	
	Sleep(22000)
	Spring.SetUnitShieldState(unitID,1,false)	
end


function emitDirt()
	SetSignalMask(SIG_DIRT)
	StartThread(cyclesOfFire)
	while(true) do
		for i=1,6,1 do
			rondo=math.random(190,420)
			Explode(dirt[i],SFX.FALL+SFX.NO_HEATCLOUD)
			for i=1,6,1 do
				EmitSfx(dirt[i],1028)
				EmitSfx(dirt[i],1028)
			end
			
			Sleep(rondo)
		end
		Sleep(300)	
		
	end
end

function SpinArrest(piecename)
	StopSpin(piecename,x_axis)
	StopSpin(piecename,y_axis)
	StopSpin(piecename,z_axis)
	
end
--13
function unfoldLeaves()
	for i=1,table.getn(greenSleaves),1 do
		Hide(greenSleaves[i])
	end
	Sleep(3000)
	SetSignalMask(SIG_LEAVE)
	while(true) do
		for i=1,table.getn(greenSleaves),1 do
			
			ProRany=math.random(0,1)
			if ProRany == 1 then
				EmitSfx(greenSleaves[i],1031)
				Sleep(25)
				EmitSfx(greenSleaves[i],1031)		
			end
			
			
			Sleep(100)
		end
		Sleep(100)
	end
end

function dropLeave(nr)
	
	while true do
		Spin(greenSleaves[nr],y_axis,math.rad(math.random(-22,22)),0.01)
		
		Show(greenSleaves[nr])
		Move(greenSleaves[nr],y_axis,0,0,true)
		Move(greenSleaves[nr],y_axis,-800,math.random(5,10))
		xval=math.random(-60,60)
		zval=math.random(-60,60)
		while (true==Spring.UnitScript.IsInMove (greenSleaves[nr], y_axis)) do
	
		speed= (math.abs(xval)+math.abs(zval))*0.05 * 0.1
			if math.random(0,1)==1 then deci=-1 end
			
			Turn(greenSleaves[nr],x_axis,math.rad(xval),speed)
			Turn(greenSleaves[nr],z_axis,math.rad(zval), speed)
			if math.abs(xval) > math.abs(zval) then
				WaitForTurn(greenSleaves[nr],x_axis)
			else
				WaitForTurn(greenSleaves[nr],z_axis)
			end
			xval=xval*0.75
			zval=zval*0.75
			
			Sleep(100)
			Turn(greenSleaves[nr],x_axis,math.rad(xval*-1),speed)
			Turn(greenSleaves[nr],z_axis,math.rad(zval*-1),speed)
			if math.abs(xval) > math.abs(zval) then
				WaitForTurn(greenSleaves[nr],x_axis)
			else
				WaitForTurn(greenSleaves[nr],z_axis)
			end

			
			--refill
			if math.abs(xval) < 5 then xval=math.random(-60,60) end
			if math.abs(zval) < 5 then zval=math.random(-60,60) end
			Sleep(100)
		end
		
		
		WaitForMove(greenSleaves[nr],y_axis)	
		
		
		
		Sleep(2000)
		
	end
	
end

function emitSparks()
	while boolEntryOver== false do Sleep(10) end

	while(true) do
		for i=1,table.getn(dirt),1 do
			EmitSfx(dirt[i],1030)
			
		end
		Sleep(200)
	end
	
end

function moveUpAndDown()
	SetSignalMask(SIG_PUMP)
	Signal(SIG_PIPE)
	StartThread(pumpAnimation)
	while(true) do
		for i=1,table.getn(pumps),1 do
			Move(pumps[i],y_axis,13,0.8)
		end
		WaitForMove(pumps[5],y_axis)
		for i=1,5,1 do
			Move(pumps[i],y_axis,0,1.8)
		end
		WaitForMove(pumps[5],y_axis)
		Sleep(100)
	end
end
--emits the Seeds EntryHeat
function flameEmitEntry()
	SetSignalMask(SIG_ENTER)
	emOx,emOy,emOz=0
	while(true)do
		emitX,emitY,emitZ,_,_,_=Spring.GetUnitPiecePosDir(unitID,seed)
		
		Spring.SpawnCEG("blackerThenSmoke",emitX,emitY,emitZ,0,1,0,50,0)
		Spring.SpawnCEG("flames",emitX,emitY,emitZ,0,1,0,50,0)
		Spring.SpawnCEG("blackerThenSmoke",emOx,emOy,emOz,0,1,0,50,0)
		Spring.SpawnCEG("glowSmoke",emOx,emOy,emOz,0,1,0,50,0)
		emOx=emitX
		emOy=emitY
		emOz=emitZ
		Sleep(40)
	end
end	


function pumpAnimation()
	local lpipePieces={}
	lpipePieces=pipePieces
	for i=0,59,1 do
		Hide(lpipePieces[i])
		Move(lpipePieces[i],x_axis,0,0,true)
		Move(lpipePieces[i],y_axis,0,0,true)
		Move(lpipePieces[i],z_axis,0,0,true)
	end
	local spGetUnitPiecePosition=Spring.GetUnitPiecePosition
	
	SetSignalMask(SIG_PIPE)
	while(true) do
		--3
		for i=0,57,3 do
			
			
			ox,oy,oz=spGetUnitPiecePosition(unitID,lpipePieces[i])
			ux,uy,uz=spGetUnitPiecePosition(unitID,lpipePieces[i+2])
			Show(lpipePieces[i])
			if x and ox then
				ox=ux-ox				
				oz=uz-oz
				
				timepiece=10/(math.abs(ox)+math.abs(oz))
				
				Move(lpipePieces[i],x_axis,ox*-1,timepiece*ox)
				
				Move(lpipePieces[i],z_axis,oz,timepiece*oz)
			end
		end
		Sleep(850)
		for i=0,57,3 do Show(lpipePieces[i+2])end
		WaitForMove(lpipePieces[51],x_axis)
		WaitForMove(lpipePieces[51],y_axis)
		WaitForMove(lpipePieces[51],z_axis)
		
		for i=0,59,3 do
			Hide(lpipePieces[i])
			Move(lpipePieces[i],x_axis,0,0)
			Move(lpipePieces[i],y_axis,0,0)
			Move(lpipePieces[i],z_axis,0,0)	
		end
		
		for i=0,57,3 do Show(lpipePieces[i])end
		second=iRand(80,660)
		Sleep(second)
		for i=0,57,3 do Hide(lpipePieces[i+2])end
		
		
	end
	
	
	
end
function playHeartBeat()
	while(true) do
		Spring.PlaySoundFile("sounds/jBeanStalk/beanstalkhbeat.wav",0.5)
		Sleep(9000)
	end
end

function idle()
	while(true) do
		sleepTime=iRand(90,14000)
		Sleep(sleepTime)
		Signal(SIG_PUMP)
		sleepTime=iRand(90,14000)
		Sleep(sleepTime)
		StartThread(moveUpAndDown)
		
	end
end

function swayBeanstalk()
	while true do
		WTurn(beanstalk,z_axis,math.rad(0.12),0.00015)
		WTurn(beanstalk,z_axis,math.rad(-0.12),0.00015)
	end
end

function greatEntry()
	Show(bean1)
	Show(bean2)
	Show(bean3)
	for i=1,table.getn(greenSleaves),1 do
		Hide(greenSleaves[i])
	end
	StartThread(emitSparks)
	Hide(rootRotate)
	for i=1,6,1 do
		Hide(dirt[i])
	end
	Hide(bean1)
	--preparations
	Move(bean1,y_axis,-2700,0) 
	Move(bean2,y_axis,-2700,0) 
	Move(bean3,y_axis,-2700,0) 
	
	Spin(rootgrow,y_axis,math.rad(15),0.4)
	Spin(rootgrow,x_axis,math.rad(7),0.4)
	Spin(rootgrow,z_axis,math.rad(2),0.4)
	
	Move(beans,y_axis,-700,0)
	Move(rootRotate,y_axis,-128,0)
	
	Spin(rootRotate,y_axis,math.rad(-32),0.4)
	Spin(bean1,y_axis,math.rad(-52),0.4)
	Spin(bean2,y_axis,math.rad(-55),0.4)
	Spin(bean3,y_axis,math.rad(-67),0.4)
	Spin(spindl,y_axis,math.rad(57),0.4)
	Spin(spindl2,x_axis,math.rad(57),0.4)
	Spin(spindl3,x_axis,math.rad(-57),0.4)
	
	
	Spin(rootgrow,y_axis,math.rad(-9),0.4)
	
	
	for i=1, #wurzelballen do
		val=math.random(10,30) 
		tspeed=math.random(0.7,2)
		Spin(wurzelballen[i],y_axis,math.rad(val),tspeed)
	end
	
	
	Spin(bsfetas,y_axis,math.rad(3.2),0.2)
	Spin(bshelix,y_axis,math.rad(4.2),0.2)
	Turn(seed,x_axis,math.rad(64),0)
	dir=math.random(0,360)
	StartThread(flameEmitEntry)
	Turn(seedRotator,y_axis,math.rad(dir),0)--sets the impactor direction to a random value.. 
	
	--send in the seed 15 secs
	Spring.PlaySoundFile("sounds/jBeanStalk/beanstalkgrowth.wav")
	
	Turn(seed,x_axis,math.rad(0),0.074467381418424728615410806122181)--4.22222226
	WaitForTurn(seed,x_axis)
	Show(bean1)
	Signal(SIG_ENTER)
	Hide(seed)
	
	--Impact --35 secs
	StartThread(emitDirt)
	EmitSfx(center,1024)
	EmitSfx(center,1026)
	EmitSfx(center,1027)	
	EmitSfx(center,1025)
	EmitSfx(center,1026)
	EmitSfx(center,1027)
	Move(bean3,y_axis,0,92)	
	Show(spindl)
	Show(spindl2)
	Show(spindl3)
	Sleep(500)
	Move(bean1,y_axis,0,110)	
	Sleep(2000)
	Move(bean2,y_axis,0,95)	
	
	Move(rootRotate,y_axis,0,	7.4285714285714285714285714285714)
	Sleep(9000)
	StartThread(unfoldLeaves)
	Show(rootRotate)
	for i=1,table.getn(greenSleaves),1 do	
		if math.random(0,1) == 1 then			
			StartThread(dropLeave,i)
		end
	end
	
	WaitForMove(bean1,y_axis)
	--Spawning the beanstalks groundplate
	teamID=Spring.GetUnitTeam(unitID)
	x,y,z=Spring.GetUnitPosition(unitID)
	GG.UnitsToSpawn:PushCreateUnit("jbeanstalkplate",x,y,z,0,teamID)
	Move(bean3,y_axis,-2450,675)
	Move(beans,y_axis,0,0)
	Sleep(4000)
	Hide(bean1)
	SpinArrest(bean1)
	Hide(bean2)
	SpinArrest(bean2)
	Hide(bean3)
	SpinArrest(bean3)
	Hide(spindl)
	SpinArrest(spindl)
	Hide(spindl2)
	SpinArrest(spindl2)
	Hide(spindl3)
	SpinArrest(spindl3)
	Hide(rootRotate)
	SpinArrest(rootRotate)
	
	
	
	for i=1,table.getn(wurzelballen),1 do
		Move(wurzelballen[i],y_axis,-40,4)
		
		
	end
	
	for i=1,table.getn(wurzelballen),1 do
		
		Hide(wurzelballen[i])
		SpinArrest(wurzelballen[i])
	end
	
	
	Hide(rootgrow)
	SpinArrest(rootgrow)
	Hide(rootRotate)
	SpinArrest(rootRotate)
	
	
	Signal(SIG_DIRT)	
	boolEntryOver=true
end

nrOfReinforcements=3
function reInforCements()
	Sleep(65000)
	StartThread(swayBeanstalk)
	--Spring.PlaySoundFile("sounds/citadell/citadellJourney.wav") 
	Sleep(180000)
	dropPx,dropPy,dropZ=Spring.GetUnitPosition(unitID)
	for i=1,nrOfReinforcements,1 do
		
		for thee=1,600,1 do
			Sleep(100)
		end
		--Spring.PlaySoundFile("sounds/citadell/reinforcements.wav") 
		
		
		if i==1 then
			
			GG.UnitsToSpawn:PushCreateUnit("jconroach",getFrameDependentUniqueOffset(15)+dropPx,dropPy,dropZ+125, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+90, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("tiglil",getFrameDependentUniqueOffset(15)+dropPx-20,dropPy,dropZ+75, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+55, 0, teamID) 
			
			GG.UnitsToSpawn:PushCreateUnit("jconroach",getFrameDependentUniqueOffset(15)+dropPx,dropPy,dropZ+250, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+200, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx-20,dropPy,dropZ+180, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+160, 0, teamID)
			
			GG.UnitsToSpawn:PushCreateUnit("jconroach",getFrameDependentUniqueOffset(15)+dropPx,dropPy,dropZ+340, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+300, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx-20,dropPy,dropZ+280, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+260, 0, teamID)
			
			
		else
			
			GG.UnitsToSpawn:PushCreateUnit("jconroach",getFrameDependentUniqueOffset(15)+dropPx,dropPy,dropZ+340, 0, teamID) 
			
			
			GG.UnitsToSpawn:PushCreateUnit("jconroach",getFrameDependentUniqueOffset(15)+dropPx,dropPy,dropZ+250, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("tiglil",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+200, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("tiglil",getFrameDependentUniqueOffset(15)+dropPx-20,dropPy,dropZ+180, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("tiglil",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+160, 0, teamID)
			
			GG.UnitsToSpawn:PushCreateUnit("jconroach",getFrameDependentUniqueOffset(15)+dropPx,dropPy,dropZ+340, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+300, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx-20,dropPy,dropZ+280, 0, teamID) 
			GG.UnitsToSpawn:PushCreateUnit("skinfantry",getFrameDependentUniqueOffset(15)+dropPx+20,dropPy,dropZ+260, 0, teamID)
			
		end
		
	end
end
function reEntry()
	Spin(bsfetas,y_axis,math.rad(3.2),0.2)
	Spin(bshelix,y_axis,math.rad(4.2),0.2)
	tableOfPieces={}
	tableOfPieces=Spring.GetUnitPieceList(unitID)
	
	for i=1,table.getn(tableOfPieces),1 do
		name=tableOfPieces[i]
		x=piece(name)
		Show(x)
		
	end
	
	for i=1,6,1 do
		Hide(dirt[i])
	end
	
	Hide(unRooted)
	Hide(spindl)
	Hide(spindl2)
	Hide(spindl3)
	Hide(fireFx1)
	Hide(fireFx2)
	Hide(fireFx3)
	Hide(seed)
	Hide(bean1)
	Hide(rootgrow)
	
	Hide(bean2)
	
	Hide(bean3)
	
	Hide(spindl)
	
	Hide(spindl2)
	
	Hide(spindl3)
	
	Hide(rootRotate)
	for i=1,14,1 do
		Hide(greenSleaves[i])
		
	end
	
	hideT(wurzelballen)
	boolEntryOver=true
end

defID=Spring.GetUnitDefID(unitID)
function script.Create()
	StartThread(soundSleeper)
	StartThread(darkEnergyReactor)

	Turn(bsholo,y_axis,math.rad(-90),0)
	Hide(unRooted)
	Hide(spindl)
	Hide(spindl2)
	Hide(spindl3)
	Hide(fireFx1)
	Hide(fireFx2)
	Hide(fireFx3)
	if defID == UnitDefNames["beanstalk"].id then
		greatEntry()
	elseif defid == UnitDefNames["dbeanstalk"].id then
		reEntry()
		
	end
	
	StartThread(idle)
	StartThread(nanoEmitIdler)
	StartThread(playHeartBeat)
	Signal(SIG_LEAVE)
	StartThread(reInforCements)
	StartThread(waitingGame)
end

function script.Killed(recentDamage, maxHealth)
	
	
	suddenDeathjBuildCorpse(unitID,recentDamage)
	return 0
	
end

 boolreVert=false
boolEntryOver=false
function waitingGame()
	while boolEntryOver== false do Sleep(500) end
	while(true) do
		if boolreVert==true and (Spring.ValidUnitID (unitID)) then
			Sleep(500)
			if boolreVert==true and (Spring.ValidUnitID (unitID)) then
				local x,y,z=Spring.GetUnitPosition (unitID)
				local teamID = Spring.GetUnitTeam (unitID)
				mexID= Spring.CreateUnit("mbeanstalk", x, y, z, 0, teamID) 
				
				
				health=Spring.GetUnitHealth(unitID)
				Spring.SetUnitHealth(mexID,health)	
				Spring.DestroyUnit (unitID,false,true)
			end
		end
		
		
		
		
		Sleep(1000)
	end
end

function script.Activate ( )
	boolreVert=false
	
	--boolUnDeployed=false
	--boolSafetyFirst=true
	return 1
end

function script.Deactivate ( )
	boolreVert=true
	--if boolSafetyFirst==true then
	--boolUnDeployed=true
	--end
	--Place Unmorpher here
	return 0
end



--------BUILDING---------
function script.StopBuilding()
	Signal(SIG_PUMP)
	SetUnitValue(COB.INBUILDSTANCE, 0)
end

function script.StartBuilding(heading, pitch)	
	StartThread(moveUpAndDown)
	SetUnitValue(COB.INBUILDSTANCE, 1)
end

Spring.SetUnitNanoPieces(unitID,{ currentpiece})




aimpoint= piece "aimpoint"
----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpoint 
end

function script.QueryWeapon1() 
	return aimpoint 
end

function script.AimWeapon1( heading ,pitch)	
	
	
	return true
end

function script.FireWeapon1()	
	
	
	
	return true
end