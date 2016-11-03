include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 
include "jsunShipComonScript.lua"

--Declared pieces
center=piece"center"
Main= piece"Main"
circDanceCenter= piece"circDanceCenter"
crysCenter= piece"crysCenter"
centerCore = piece"centerCore"
Sun1 = piece"Sun1"
inRotX = piece"inRotX"
inRotY = piece"inRotY"
center = piece"center"
waterPivot= piece"waterPivot"
diamond1= piece"diamond1"
diamond2= piece"diamond2"

 SIG_FORCELOOP= 2
local TablesOfPiecesGroups={}
MAXFORCELOOP=7
boolSunshipActivateable=false
boolAllreadyBuilding= false

-- Unit has been hit by a weapon
function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end

--Create Function 
function script.Create()
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	init()	
	StartThread(releaseTimer)
	hideAllNonVitalPieces(TablesOfPiecesGroups)	
	StartThread(CrystallAnimations)	
	StartThread(spinCore)
	StartThread(playSoundTillYouDie)
	
end
--resets the Units pieces and shown pieces 
function init()
	recReseT(TablesOfPiecesGroups)
	recReseT(TablesOfPiecesGroups)
	Show(diamond1)
	Show(diamond2)
	showT(TablesOfPiecesGroups["circDa"])
	Move(center,y_axis,0,0)

end

function playSoundTillYouDie()
myDefID=Spring.GetUnitDefID(unitID)
timeLoudness=0
	while boolChargeUp == false do 
		StartThread(PlaySoundByUnitDefID,myDefID,"sounds/jsunship/sunShipGlass.ogg",(math.sin(timeLoudness)+2)/2, 5000, 1,0)
		timeLoudness=timeLoudness+ math.pi/4
		Sleep(5000)
	end
	Spring.PlaySoundFile("sounds/jsunship/startSun.ogg", 1.0)
	while boolChargeUp == true do 
		StartThread(PlaySoundByUnitDefID,myDefID,"sounds/jsunship/waterSuck.ogg",(math.sin(timeLoudness)+2)/2, 5000, 1,0)
		timeLoudness=timeLoudness+ math.pi/4
		Sleep(5000)
	end
		Spring.PlaySoundFile("sounds/jsunship/ignite.ogg", 1.0)


end



--animatin to spin the core
function spinCore()
	Spin(inRotX,x_axis,math.rad(42),0)
	Spin(inRotY,y_axis,math.rad(42),0)
	for i=1, 11 do
		randoVal=math.random(0.5, math.pi)
		randoVal=(randoVal*randSign()) or 1
		
		if TablesOfPiecesGroups["circ"][i] then
			if i % 2 == 0 then		
				Spin(TablesOfPiecesGroups["circ"][i],z_axis, randoVal,0)
			else
				Spin(TablesOfPiecesGroups["circ"][i],x_axis, randoVal,0)
			end
		end
	end
end

-- animation for rotating crystalls
function CrystallAnimations()
	Spin(Main,y_axis,math.rad(math.random(-math.pi,math.pi)))
	value=math.random(1,math.pi)
	value=value*randSign()
	
	if math.abs(value) < 0.5 then value= 0.5 end
	StartThread(circleDance,value,3,20,12, math.pi*4,35)
	Spin(crysCenter,y_axis,math.rad(value*-1))
	Spin(centerCore,y_axis,math.rad(value))
	while true do
		WMove (crysCenter,y_axis, math.random(-10,10),0.5)
		Sleep(100)	
	end
end

--Sinus animation for the rotating crystalls
function circleDance(value, multiplicator, heightoffset,speed, fullCircle, offset)
	Spin(circDanceCenter,y_axis,math.rad(value*multiplicator))
	rotation=0
	constNumberOfElementsInArray= table.getn(TablesOfPiecesGroups["circDa"])
	
	while true do
		-- fullCircle Rotation keeps track of the whole system turning
		rotation= (rotation + math.rad(value*multiplicator))
		-- how much each component is offset from the fullCircle
		constRotationOffset= (rotation/(fullCircle)	) 
		for i=1, constNumberOfElementsInArray do		
			relativeComponent = (i /constNumberOfElementsInArray)*fullCircle
			totalRotation= constRotationOffset + relativeComponent
			upValue= math.sin(totalRotation) * heightoffset
			Move(TablesOfPiecesGroups["circDa"][i],y_axis,upValue+offset,speed)
		end
		Sleep(10)
	end
end

--Timer that prevents early in build execution of unit
function releaseTimer()
	_,_,_,_,BuildProgress = Spring.GetUnitHealth(unitID)
	while BuildProgress < 1 do
		_,_,_,_,BuildProgress = Spring.GetUnitHealth(unitID)
		Sleep(1000)
	end	
	boolSunshipActivateable=true
end

--Killed function
function script.Killed(recentDamage,_)
	
	createCorpseCUnitGeneric(recentDamage)
	return 1
end

----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end

function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy	
	return true	
end

function script.FireWeapon1()	
	return true
end

function script.StartMoving()	
end

function script.StopMoving()
	
end

-- Show the forefielded Waterbubble
function showWater()
	
	spinT(TablesOfPiecesGroups["water"],y_axis, 12, math.random(90,350)*randSign())
	while true do
		hideT(TablesOfPiecesGroups["water"])
		index=math.ceil(math.random(1,3))
		if TablesOfPiecesGroups["water"][index] then
			Show(TablesOfPiecesGroups["water"][index])
		end
		Sleep(100)
	end
end

-- Deploy Sunship into a sun
boolChargeUp=false
function InitializeSunShip()
	Spin(diamond1,y_axis,math.rad(42))
	Spin(diamond2,y_axis,math.rad(-42))
	chargeUp= 0
	StartForceRotators(1)
	StartThread(showWater)
	x,y,z=Spring.GetUnitPosition(unitID)
	WMove(waterPivot,y_axis, (-250),0)
	
	while chargeUp < 100 do
	boolChargeUp=true
		Move(center,y_axis, (chargeUp*2.5), 2.5)
		Move(waterPivot,y_axis, ((-250)+(chargeUp*2.5)), 5.5)
		x,y,z=Spring.GetUnitPiecePosDir(unitID,waterPivot)
		chargeUp=chargeUp+1	
		
		if chargeUp == 50 then
		Signal(SIG_FORCELOOP)
		StartForceRotators(-1)
		end
		
		Sleep(1000)
	end
	Signal(SIG_FORCELOOP)
	StopSpin(waterPivot,y_axis,0.22)
	WaitForMoves(waterPivot,center)
	hideT(TablesOfPiecesGroups["forceLoop"])
	hideT(TablesOfPiecesGroups["gate"])
	hideT(TablesOfPiecesGroups["outRot"])
	hideT(TablesOfPiecesGroups["circDa"])
	Hide(diamond2)
	Hide(diamond1)
	
	
	createSun()
	
end

--Create the successor unit
function createSun()
	
	x,y,z=Spring.GetUnitPosition(unitID)
	teamID= Spring.GetUnitTeam(unitID)
	if x and teamID then
		Spring.Echo("Give birth")
		id=Spring.CreateUnit("jsunshipfire", x, y, z, 1, teamID)
		if id then
			Spring.Echo("Die off")
		Spring.DestroyUnit(unitID,true,true) end
	end
end

function script.Activate()
	if boolSunshipActivateable == true and boolAllreadyBuilding == false then
		boolAllreadyBuilding= true
		StartThread(InitializeSunShip)
	end
	return 1
end

function script.Deactivate()	
	return 0
end

function script.QueryBuildInfo() 
	return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})
-- Animate the force Rotator Loops
function StartForceRotators(handedDirection)
	direction= handedDirection or 1
	Signal(SIG_FORCELOOP)
	SetSignalMask(SIG_FORCELOOP)
	for i=1, MAXFORCELOOP,1 do
		Turn(TablesOfPiecesGroups["lopRot"][i],y_axis,math.random(-math.pi,math.pi),0,true)
		Spin(TablesOfPiecesGroups["lopRot"][i],y_axis, math.rad(math.random(-55,55)))
		Spin(TablesOfPiecesGroups["forceLoop"][i],z_axis, math.rad(math.random(-55,-35)*direction))
		Spin(TablesOfPiecesGroups["outRot"][i],y_axis, math.rad(math.random(75,155)*randSign()))
		if math.random(0,1)==1 then Spin(TablesOfPiecesGroups["gate"][i],y_axis, math.rad(math.random(75,155)*randSign())) end
	end
	StartThread(hideAndSeek)
end

--Hide Force Loops which are too deep into terrain
function hideAndSeek()
	
	while true do
		for i=1, MAXFORCELOOP,1 do
			x,y,z=Spring.GetUnitPiecePosDir(unitID,TablesOfPiecesGroups["outRot"][i])
			gh= Spring.GetGroundHeight(x,z)
			
			if gh > y then
				Hide(TablesOfPiecesGroups["outRot"][i])
				Hide(TablesOfPiecesGroups["forceLoop"][i])
				Hide(TablesOfPiecesGroups["gate"][i])
				
			else
				Show(TablesOfPiecesGroups["outRot"][i])
				Show(TablesOfPiecesGroups["forceLoop"][i])
				Show(TablesOfPiecesGroups["gate"][i])
			end
		end
		Sleep(100)
	end
end

