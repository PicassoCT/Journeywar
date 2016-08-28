include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

blackListCAllyGator= getTypeTable(UnitDefNames,{"ccomender", "beanstalk", "jhoneypot"})

TablesOfPiecesGroups={}
ucruiseAlt = 85 -- UnitDefNames["callygator"].cruiseAlt 

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	
	return damage
end
center=piece"center"
aimpiece=piece"Portal"

piecesTable={}
center = piece("center")
piecesTable[#piecesTable+1]= center
pivotPoint = piece("pivotPoint")
piecesTable[#piecesTable+1]= pivotPoint
ScoopPoint = piece("ScoopPoint")
piecesTable[#piecesTable+1]= ScoopPoint
Gate1 = piece("Gate1")
piecesTable[#piecesTable+1]= Gate1
turbine1 = piece("turbine1")
piecesTable[#piecesTable+1]= turbine1
emit1 = piece("emit1")
piecesTable[#piecesTable+1]= emit1
Rotator = piece("Rotator")
piecesTable[#piecesTable+1]= Rotator
Barring = piece("Barring")
piecesTable[#piecesTable+1]= Barring
turbine3 = piece("turbine3")
piecesTable[#piecesTable+1]= turbine3
shield1 = piece("shield1")
piecesTable[#piecesTable+1]= shield1
shield2 = piece("shield2")
piecesTable[#piecesTable+1]= shield2
emit3 = piece("emit3")
piecesTable[#piecesTable+1]= emit3
turbine2 = piece("turbine2")
piecesTable[#piecesTable+1]= turbine2
emit2 = piece("emit2")
piecesTable[#piecesTable+1]= emit2
MainBody = piece("MainBody")
piecesTable[#piecesTable+1]= MainBody
Gate2 = piece("Gate2")
piecesTable[#piecesTable+1]= Gate2
Portal = piece("Portal")
piecesTable[#piecesTable+1]= Portal
Front = piece("Front")
piecesTable[#piecesTable+1]= Front

x,y,z=Spring.GetUnitPosition(unitID)
currPos={x=x,y=y,z=z}
oldPos = {}
oldPos.x=currPos.x
oldPos.y=currPos.y
oldPos.z=currPos.z

function movementDetector()
	while true do
		currPos.x,currPos.y,currPos.z=Spring.GetUnitPosition(unitID)
		distanceValue =math.sqrt((currPos.x-oldPos.x)^2 + ( currPos.y-oldPos.y)^2 + (currPos.z-oldPos.z)^2) 
		boolMoving= distanceValue > 5
		Sleep(500)
		oldPos.x=currPos.x
		oldPos.y=currPos.y
		oldPos.z=currPos.z
	end
end

function motionStateDetector()
	StartThread(movementDetector)
	while true do
		--Sensory Evaluation
		boolImTurning = TurnDetector()
		flightDetector()
		
		
		--evaluate states
		if boolMoving == false then
			tP(turbine1,0,-11,0, 1.41)
			tP(turbine2,0,11,0, 1.41)
			tP(turbine3,0,0,0, 2.41)
			tP(Rotator,91,0,0, 2.41)
			tP(Barring,0,-180,0, 4)
			WaitForTurns(turbine1,turbine2,Rotator,Barring)
			
		else
			if boolImLandingLifting == true then
				tP(turbine1,29,-11,0, 1.41)
				tP(turbine2,29,11,0, 1.41)
				tP(turbine3,0,0,0, 1.41)
				tP(Rotator,60,0,0, 1.41)
				tP(Barring,0,-180,0, 4)
				WaitForTurns(turbine1,turbine2,Rotator,Barring)
			else
				if boolImTurning == true then
					if boolTurnLeft == true then
						tP(turbine1,-10,-11,0, 1.41)
						tP(turbine2,29,11,0, 1.41)
						tP(turbine3,0,0,0, 1.41)
						tP(Rotator,0,0,0, 1.41)
						tP(Barring,0,90,0, 4)
						WaitForTurns(turbine1,turbine2,Rotator,Barring)
					else
						tP(turbine1,29,-11,0, 1.41)
						tP(turbine2,-10,11,0, 1.41)
						tP(turbine3,0,0,0, 1.41)
						tP(Rotator,0,0,0, 1.41)
						tP(Barring,0,-90,0, 4)
						WaitForTurns(turbine1,turbine2,Rotator,Barring)
						
					end
				else
					frame= Spring.GetGameFrame() or 0
					frame= ((frame %60)/30)*math.pi
					
					value= 40 + (math.abs(math.sin(frame))* 30)
					tP(turbine1,value,-11,0, 1.41)
					tP(turbine2,value,11,0, 1.41)
					
					tP(turbine3,0,0,0, 1.41)
					tP(Rotator,-35*(math.abs(math.sin(frame))),0,0, 1.41)
					tP(Barring,0,0,0, 4)
					WaitForTurns(turbine1,turbine2,Rotator,Barring)
				end
			end
			
		end
		
		Sleep(150)
	end
end

function script.Create()
	--Hide(Portal)
	Spin(Portal,z_axis,math.rad(180),0.01)
	
	StartThread(devourerLoop)
	StartThread(motionStateDetector)
	Turn(turbine1,y_axis,math.rad(-11),0)
	Turn(turbine2,y_axis,math.rad(11),0)
end

function hidePortals()
	Hide(Portal)
	Hide(Front)
end

function showPortals()
	Show(Portal)
	Show(Front)
end

function swallow()
	Hide(Front)
	Sleep(1000)
	Show(Front)
end

--V Below this
function rexGate(degree, speed,offset)
	tP(Gate1,degree + offset,0,0, speed)
	tP(Gate2,-1*degree +offset,0,0, speed)
	Turn(Portal,x_axis,math.rad(offset), speed)
	WaitForTurns(Gate1,Gate2)
end

boolImFlying= false
boolImLandingLifting=false
boolMoving=true
boolImTurning=false
boolTurnLeft=false


function flightDetector()
	
	local spGetUnitPosition= Spring.GetUnitPosition
	local spGetGroundHeight =Spring.GetGroundHeight
	x,y,z = spGetUnitPosition(unitID)
	if x then
		gh = spGetGroundHeight(x,z)
		if gh then
			
			if y > gh +25 then
				boolImFlying= true				
				if math.abs(y- (gh + ucruiseAlt )) < 20 then
					boolImLandingLifting = true
					return 
				else
					boolImLandingLifting = false
					return
				end
			end
		end
	end
	boolImLandingLifting= false
	boolImFlying = false
end

newHeading =0
oldHeading=newHeading


--Function needs a delay when used, else there be no turning ever
function TurnDetector()
	_,newHeading,_ =Spring.GetUnitRotation (unitID)
	
	if math.abs(math.abs(newHeading)- math.abs(oldHeading)) > 0.04 then
		
		if newHeading+ math.pi > oldHeading +math.pi then
			boolTurnLeft =true 
		else
			boolTurnLeft = false
		end
		oldHeading=newHeading	
		return true
	else
		oldHeading=newHeading
		return false
	end
end


--Nietzsche would be so proud
function getTargetAngle(targetID)
	--TODO make the abyss look at you
	
end

unitdefID=Spring.GetUnitDefID(unitID)
boolAteItAlive=false
function nomNomNom(targetID)
	
	boolAteItAlive=false
	offset = math.random(0,25)
	StartThread(PlaySoundByUnitType, unitdefID, "sounds/callygator/openMouth.ogg",1,4000,1,0)
	rexGate(0, 1.5, offset)
	showPortals()
	
	while boolAteItAlive== false do
		randoVal=math.random(-5, 15)
		rexGate(randoVal,0.7,offset)
		if math.random(0,3) == 2 then Sleep(600) end
		StartThread(PlaySoundByUnitType, unitdefID, "sounds/callygator/portal.ogg",1,3000,1,0)	
	end 
	
	StartThread(PlaySoundByUnitType, unitdefID, "sounds/callygator/eating.ogg",1,3000,1,0)	
	swallow()
	for i=1, 2 do
		StartThread(PlaySoundByUnitType, unitdefID, "sounds/callygator/portal.ogg",1,3000,1,0)	
		Sleep(3000)
	end
	hidePortals()
	StartThread(PlaySoundByUnitType, unitdefID, "sounds/callygator/closeMouth.ogg",1,3000,1,0)	
	rexGate(90, 1.52, offset)
end


function script.Killed(recentDamage,_)
	
	suddenDeathV(recentDamage)
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
	
	return boolNewVictim == false
	
end


function script.FireWeapon1()	
	
	return true
end

localVictimID= nil
boolNewVictim= false

function tagYourIt(victimID)
	localVictimID =victimID
	boolNewVictim= true
end

function devourerLoop()
	while true do
		if boolNewVictim == true and Spring.ValidUnitID(localVictimID) == true then
			swallowAnimation(localVictimID)
			boolNewVictim=false	
		end
		Sleep(500)
	end
end

-- teamKiller=Spring.GetUnitTeam(unitID)
-- function testSwallowAnimation()
	
	-- while true do
		-- px,py,pz=Spring.GetUnitPosition(unitID)
		-- vicID= Spring.CreateUnit("css",px+math.random(-400,400),py,pz+math.random(-400,400),1,teamKiller)
		
		-- if vicID then
			-- Spring.Echo("Spawned a critter")
			-- swallowAnimation(vicID)
		-- end
		
		-- Sleep(15000)
	-- end
	
-- end

-- This is the actuall Animation
function swallowAnimation(victimID )
	boolAbortEating=false
	StartThread(nomNomNom,victimID)
	victimType = Spring.GetUnitDefID(victimID)
	--unit is blacklisted?
	
	
	if victimType and not blackListCAllyGator[victimType] then
			
			-- Unit check by size
			vx,vy,vz= Spring.GetUnitCollisionVolumeData(victimID)
			if vx then
				if vx < 50 or vz < 50 and vy < 50 then
					
					
					-- congrats if you pass this you are going to be eaten
					--paralyze victimID
					pVx,pVy,pVz =Spring.GetUnitPosition(victimID)
						if not pVx then return end
					pUx,pUy,pUz =Spring.GetUnitPosition(unitID)
					Radius= math.max( math.abs(pVy-pUy),250)
					AnimationRunning_ms= 0
					
					boolIsDeadYet = false
					Spring.MoveCtrl.Enable(unitID,true)
					totalAnimationTime= 8000
					constOffsetGround= 15
					boolAbortEating= true
					
					while (AnimationRunning_ms < totalAnimationTime)  do
							
						if Spring.GetUnitIsDead(victimID) == false then
							pVx,pVy,pVz =Spring.GetUnitPosition(victimID)							
							orgAllgygatorRotationRad = convPointsToDeg(pVx,pVz, pUx, pUz)
						end				
						--orgRotationDeg =50 
						--calculate position on the arc
						pStart={x=Radius, y=Radius+35, z= 0}		
						animationFactor=(AnimationRunning_ms/totalAnimationTime)
						animationOffset= (math.pi/-4)
						pStart.x, pStart.y = RotationMatrice(pStart.x, pStart.y, animationOffset + -math.pi * animationFactor )
						--rotation Matrice at UnitDeg
						pStart.x, pStart.z= RotationMatrice(pStart.x, pStart.z, orgAllgygatorRotationRad)
						--Position Check & Clamp
						pTargetX,pTargetY,pTargetZ = pVx+ pStart.x, pVy + pStart.y + Radius , pVz + pStart.z
						GroundY= Spring.GetGroundHeight(pTargetX,pTargetZ)
						
						if pTargetY < GroundY +constOffsetGround then
							pTargetY = GroundY +constOffsetGround
						end
											
						
						-- move Unit to the circle position
						Spring.MoveCtrl.SetPosition(unitID, pTargetX,pTargetY,pTargetZ)	
						Spring.SetUnitRotation(unitID,0,orgAllgygatorRotationRad + math.pi/2,0)
						--
						
						-- use rotation matrice to turn the arc to units position
						if boolIsDeadYet == false and (AnimationRunning_ms/totalAnimationTime) > 0.5 then
							boolIsDeadYet = true
							Spring.DestroyUnit(victimID,true,true)
							boolAteItAlive= true
							boolAbortEating= false
						end
						
						
						AnimationRunning_ms= AnimationRunning_ms + 30
						Sleep(30)
					end
					
					Spring.MoveCtrl.Disable(unitID,true)	
					
					
					
					--flying Animatin towards the Unit
					boolAteItAlive=true
					
			else boolAbortEating=true;	 end
		else boolAbortEating=true;	end
	else boolAbortEating=true;	end
	
	if boolAbortEating == true then
		cleanUpAfterYou(victimID)
	end
end

function cleanUpAfterYou(victimID)
	
end

function script.StartMoving()
	
end

function script.StopMoving()
	
	
end

function script.Activate()
	
	return 1
end

function script.Deactivate()
	
	return 0
end