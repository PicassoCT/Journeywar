include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"


feet = {}
for i = 1, 6, 1 do
    x = i - 1
    feet[i] = {}
    feet[i][1] = {}
    feet[i][2] = {}
    tempR = "rightleg" .. x
    tempD = "rightlegl" .. x
    feet[i][1] = piece(tempR)
    feet[i][2] = piece(tempD)

    --add upperfeet at [1]

    --add lowerfeet at [2]

    feet[i + 6] = {}
    feet[i + 6][1] = {}
    feet[i + 6][2] = {}
    tempR = "leftleg" .. x
    tempD = "leftleglo" .. x
    feet[i + 6][1] = piece(tempR)
    feet[i + 6][2] = piece(tempD)
end
interVallHalf = 9
center = piece "center"
hdlmain = piece "hdlaumain"
walls = {}
for i = 1, 3, 1 do
    walls[i] = {}
    walls[i][1] = {}
    temp = "hWall" .. i
    walls[i][1] = piece(temp)
    Hide(walls[i][1])
    Move(walls[i][1], y_axis, -20, 0)

    walls[i][2] = {}
    walls[i][3] = {} --interVallStart
    walls[i][4] = {} --interVallEnd

    walls[i][3] = 0 --interVallStart
    walls[i][4] = 0 --interVallEnd
    walls[i][2] = false
end

eye = {}
for i = 1, 6, 1 do
    eye[i] = {}
    tempPiece = "Eye" .. i
    eye[i] = piece(tempPiece)
end
SIG_WALK = 2
SIG_DELAY = 4
SIG_DELAYL = 16
SIG_RETURN = 8

hlfus1 = piece "hlfus1"
hlfus2 = piece "hlfus2"
hlfusspore = piece "hlfusspore"
hlfusspor0 = piece "hlfusspor0"
hlamocircl = piece "hlamocircl"
hlamocirc2 = piece "hlamocirc2"
hlamo = piece "hlamo"
hlgun = piece "hlgun"



function legs_Down()
    for i = 1, 12 do
        Turn(feet[i][1], x_axis, math.rad(0), 12)
        Turn(feet[i][1], y_axis, math.rad(0), 12)
        Turn(feet[i][1], z_axis, math.rad(0), 12)


        Turn(feet[i][2], x_axis, math.rad(0), 12)
        Turn(feet[i][2], y_axis, math.rad(0), 12)
        Turn(feet[i][2], z_axis, math.rad(0), 12)
    end
end




function getFreeWall()

    for i = 1, 3, 1 do
        if walls[i][2] == false then return i end
    end
    return nil
end


function TurnShield(nr, degree)
    --	--Spring.Echo("Reached TurnShield")
    walls[nr][2] = true --in use
    Show(walls[nr][1])
    Move(walls[nr][1], y_axis, 0, 66)
    WaitForMove(walls[nr][1], y_axis)
    Turn(walls[nr][1], y_axis, math.rad(degree), 22)
    WaitForTurn(walls[nr][1], y_axis)
    walls[nr][3] = degree - interVallHalf
    walls[nr][4] = degree + interVallHalf
    countNumber = 2000

    while (boolMoving == false and countNumber > 0) do
        Sleep(350)
        countNumber = countNumber - 350
    end

    Move(walls[nr][1], y_axis, -20, 66)
    WaitForMove(walls[nr][1], y_axis)
    Hide(walls[nr][1])
    walls[nr][2] = false
end


function script.HitByWeapon(x, z, weaponDefID, damage)
	lastAttackerID = Spring.GetUnitLastAttacker(unitID)
	degree = math.huge
	if lastAttackerID and Spring.GetUnitIsDead(lastAttackerID)==false then
		x,_,z= Spring.GetUnitPosition(unitID)
		ox,_,oz=  Spring.GetUnitPosition(lastAttackerID)
		degree=	convPointsToDeg(x,z,ox,oz)
	end
	degree= math.rad(degree)

    --check Allready established Walls
    for i = 1, 3, 1 do
        if walls[i][2] == true and degree > walls[i][3] and degree < walls[i][4] then
            return 0
        end -- we have a Wall in Place, no damage taken
    end
	w = getFreeWall()
    if w and degree ~= math.huge then
        --getFreeWall
        StartThread(TurnShield, w, degree)
        return 0
        --if not nil showWall, then StartThread Turn
    else
        return damage
    end
end


function moveFootBackward(nr, speed, delay)


	sidesign=-1
    if nr < 7 then
		sidesign= 1
	end
	
	tP(feet[nr][1], 0, -35*sidesign, 0, speed)
	tP(feet[nr][2], 0,0, 0, speed)

	WaitForTurns(feet[nr][1],feet[nr][2])
	
	tP(feet[nr][1], 0, -35*sidesign, 55, speed)
	tP(feet[nr][2], 0,0, -55, speed)

	WaitForTurns(feet[nr][1],feet[nr][2])
	
	tP(feet[nr][1], 0, 35*sidesign, 55, speed)
	tP(feet[nr][2], 0,0, -55, speed)

	WaitForTurns(feet[nr][1],feet[nr][2])

	tP(feet[nr][1], 0, 35*sidesign, 0, speed)
	tP(feet[nr][2], 0,0, 0 , speed)

	WaitForTurns(feet[nr][1],feet[nr][2])

end


function moveFoot(nr, speed, delay)



    if nr < 7 then
        if nr == 1 or nr == 6 then
            Turn(feet[nr][1], y_axis, math.rad(0), speed * 2)

        else
            Turn(feet[nr][1], y_axis, math.rad(0), speed)
        end


        --move foot up and retract inwards

        Turn(feet[nr][1], z_axis, math.rad(-54), speed)
        WaitForTurn(feet[nr][1], y_axis)
        --WaitForTurn(feet[nr][1],z_axis)
        Turn(feet[nr][2], z_axis, math.rad(108), speed)
        WaitForTurn(feet[nr][2], z_axis)
        --turn forward, expand
        if nr == 1 or nr == 6 then
            Turn(feet[nr][1], y_axis, math.rad(60), speed * 2)

        else
            Turn(feet[nr][1], y_axis, math.rad(60), speed)
        end




        WaitForTurn(feet[nr][1], y_axis)
        if nr == 1 or nr == 6 then
            Turn(feet[nr][2], z_axis, math.rad(-20), speed * 4.5)
            WaitForTurn(feet[nr][2], z_axis)
        end
        Turn(feet[nr][1], z_axis, math.rad(0), speed)
        WaitForTurn(feet[nr][1], z_axis)
        Turn(feet[nr][2], z_axis, math.rad(0), speed)
        --turn down
        Turn(feet[nr][1], y_axis, math.rad(0), speed * 0.8)
        WaitForTurn(feet[nr][1], y_axis)
       
        --turn midway, retract halfup

        --turn back-- turn down

        Turn(feet[nr][1], y_axis, math.rad(-75), speed * 0.7)
        WaitForTurn(feet[nr][1], y_axis)
        Sleep(100)
        Turn(feet[nr][1], z_axis, math.rad(-35), speed)
        Turn(feet[nr][2], z_axis, math.rad(60), speed)

        WaitForTurn(feet[nr][1], z_axis)
        WaitForTurn(feet[nr][2], z_axis)
        --move foot up and retract inwards



    else --move foot up and retract inwards
        if nr == 7 or nr == 12 then
            Turn(feet[nr][1], y_axis, math.rad(0), speed * 2)

        else
            Turn(feet[nr][1], y_axis, math.rad(0), speed)
        end


        Turn(feet[nr][1], z_axis, math.rad(54), speed)
        WaitForTurn(feet[nr][1], y_axis)
        Turn(feet[nr][2], z_axis, math.rad(-108), speed)
        WaitForTurn(feet[nr][2], z_axis)
        --turn forward, expand
        if nr == 7 or nr == 12 then
            Turn(feet[nr][1], y_axis, math.rad(-60), speed * 2.5)
        else
            Turn(feet[nr][1], y_axis, math.rad(-60), speed)
        end



        WaitForTurn(feet[nr][1], y_axis)
        if nr == 7 or nr == 12 then
            Turn(feet[nr][2], z_axis, math.rad(20), speed * 4.5)
            WaitForTurn(feet[nr][2], z_axis)
        end

        Turn(feet[nr][1], z_axis, math.rad(0), speed)
        WaitForTurn(feet[nr][1], z_axis)
        Turn(feet[nr][2], z_axis, math.rad(0), speed)
        --turn down
        Turn(feet[nr][1], y_axis, math.rad(0), speed * 0.8)

        WaitForTurn(feet[nr][1], y_axis)
        --turn midway, retract halfup

        --turn back-- turn down

        Turn(feet[nr][1], y_axis, math.rad(75), speed * 0.7)
        WaitForTurn(feet[nr][1], y_axis)
        Sleep(100)
        Turn(feet[nr][1], z_axis, math.rad(35), speed)
        Turn(feet[nr][2], z_axis, math.rad(-60), speed)

        WaitForTurn(feet[nr][1], z_axis)
        WaitForTurn(feet[nr][2], z_axis)
        --move foot up and retract inwards
    end
end

function walkAnimation()
		for i = 1, 6, 1 do
            StartThread(moveFoot, i, 3, 0)
            StartThread(moveFoot, i + 6, 3, 0)
            Sleep(180)
        end
        Turn(hdlmain, x_axis, math.rad(-3), 0.025)
        Sleep(1800)
        Turn(hdlmain, x_axis, math.rad(3), 0.045)
end

function turnAnimation()
		if boolTurnLeft == false then
			for i = 1, 6, 1 do
				StartThread(moveFoot, i, 3, 0)
				StartThread(moveFootBackward, i + 6, 3, 0)
				Sleep(180)
			end
		else
			for i = 1, 6, 1 do
				StartThread(moveFootBackward, i, 3, 0)
				StartThread(moveFoot, i + 6, 3, 0)
				Sleep(180)
			end

		end
		
        Sleep(1800)
end

function walk()
	if boolDead== true then return end
    for i = 1, 3, 1 do
        Hide(walls[i][1])
    end
	mP(hdlmain,0,0,0,12)
    SetSignalMask(SIG_WALK)
    while true do
      if boolTurning == false then
		walkAnimation()
	  else
		turnAnimation()
	  end
    end
end

reloadProj = piece "hlamo"
TurnPoint = piece "turnPoint"
boolReadyToFire = true

function reloadAnimation()
	StopSpin(hlgun,z_axis,1)
	Turn(hlgun,z_axis,0,3)
    boolReadyToFire = false
    Turn(TurnPoint, x_axis, math.rad(0), 0)
    --StopSpin(reloadProj,z_axis,0)
    Turn(reloadProj, x_axis, math.rad(0), 0)
    Spin(reloadProj, y_axis, math.rad(42), 4)
    Show(reloadProj)
    Move(reloadProj, y_axis, 14, 3)
    WaitForMove(reloadProj, y_axis)
    --StopSpin(reloadProj,y_axis,0)

    --Turn(reloadProj,y_axis,math.rad(0),12)
    Turn(TurnPoint, x_axis, math.rad(90), 17)
    WaitForTurn(TurnPoint, x_axis)
    --Spin(reloadProj,z_axis,math.rad(42),4)
    boolReadyToFire = true
	Spin(hlgun,z_axis,math.rad(42),1)
end

function delayedMove()
    SetSignalMask(SIG_DELAY)
    Sleep(50)
    boolMoving = true
end

function delayedLegsDown()
    SetSignalMask(SIG_DELAYL)
    Sleep(650)
    legs_Down()
	boolIdle = true

end

boolMoving = false
function script.StartMoving()

    Signal(SIG_DELAY)
    StartThread(delayedMove)
	boolIdle = false
    StartThread(walk)
    Signal(SIG_DELAYL)
end

function script.StopMoving()

    Signal(SIG_WALK)
    boolMoving = false
    StartThread(delayedLegsDown)
end

boolIdle=true
function idleBreathLoop()
while true do
	mP(hdlmain,0,0,0, 12)
	Sleep(900)
		while boolIdle==true do
		variableTime= math.random(1200,1700)
			if boolIdle==true then
				for i=1,#feet do
						if i < 7 then
							equiTurnIn(feet[i][1], feet[i][2], z_axis, 0, variableTime)
						else
							equiTurnIn(feet[i][1], feet[i][2], z_axis, 0, variableTime)
						end
				end
				mSyncIn(hdlmain,0,0,0, variableTime)
				Sleep(variableTime)
			end

			if boolIdle==true then
				for i=1,#feet do
						if i < 7 then
							equiTurnIn(feet[i][1], feet[i][2], z_axis, -25, variableTime)
						else
							equiTurnIn(feet[i][1], feet[i][2], z_axis, 25, variableTime)
						end
				end
				mSyncIn(hdlmain,0,-5,0, variableTime)
				Sleep(variableTime)
			end
		end
	end

end
function eyeLoop()
	Sleep(100)
    --Spring.Echo("JW_HEADLAUNCH_EYELOOP")
	process(TableOfPieceGroups["Eye"],
			function(id)
			if id ~= eye[1] then
				xRand = math.random(-360, 360)
				yRand = math.random(-360, 360)
				zRand = math.random(-360, 360)
				Spin(id, x_axis, math.rad(xRand), speed)
				Spin(id, y_axis, math.rad(yRand), speed)
				Spin(id, z_axis, math.rad(zRand), speed)
			end
			
			end
			)

    while (true) do
        xRand = math.random(-40, 20)
        yRand = math.random(-66, 66)
        speed = math.random(4, 19)
        Turn(eye[1], x_axis, math.rad(xRand), speed)
        Turn(eye[1], y_axis, math.rad(yRand), speed)
        WaitForTurn(eye[1], x_axis)
        WaitForTurn(eye[1], y_axis)
        SleepRand = math.ceil(math.random(50, 800))
        Sleep(SleepRand)
    end
end



boolTurning= false
boolTurnLeft= false
function turnDetector()
    local spGetUnitHeading = Spring.GetUnitHeading
    oldHeading = spGetUnitHeading(unitID)
    Sleep(500)
    newHeading = oldHeading

    while true do
        newHeading = spGetUnitHeading(unitID)

        if math.abs(newHeading - oldHeading) > 1400 then
            boolTurning = true
            if newHeading - oldHeading < 0 then 
				boolTurnLeft = true 
			else 
				boolTurnLeft = false 
			end
        else
            boolTurning = false
        end
        Sleep(500)
        oldHeading = newHeading
    end
end

TableOfPieceGroups={}
function script.Create()

    --leave()
	TableOfPieceGroups=  getPieceTableByNameGroups(false, true)
    Hide(reloadProj)
    StartThread(eyeLoop)
    StartThread(turnDetector)
    Spin(hlfus1, y_axis, math.rad(192), 0.5)
    Spin(hlfus2, y_axis, math.rad(-192), 0.5)
    Spin(hlfusspore, y_axis, math.rad(222), 0.5)
    Spin(hlfusspor0, y_axis, math.rad(222), 0.5)

    Spin(hlamo, y_axis, math.rad(-145), 0.5)
    Spin(hlamocircl, y_axis, math.rad(200), 0.5)
    Spin(hlamocirc2, y_axis, math.rad(-200), 0.5)
    StartThread(idleBreathLoop)
    StartThread(reloadAnimation)
end

function reTurnGun()
    SetSignalMask(SIG_RETURN)
    Sleep(1000)
    Turn(hlgun, y_axis, math.rad(0), 5)
end


boolDead=false

function killedAnimation()
boolDead=true

setSpeedEnv(unitID,0.0)
	Signal(SIG_WALK)
    for i = 1, 3, 1 do
        Hide(walls[i][1])
    end
    Explode(hlgun, SFX.SHATTER + SFX.NO_HEATCLOUD)
    Hide(hlgun)

   
	tSyncIn(hdlmain,-12,0,0,1000)
	mSyncIn(hdlmain,0,-16,0,1000)
	process(TableOfPieceGroups["rightleg"],
			function(id)
					tSyncIn(id,0,0,-90,1000)		
			end
			)	
	process(TableOfPieceGroups["rightlegl"],
			function(id)
					tSyncIn(id,0,0,90,1000)		
			end
			)

	process(TableOfPieceGroups["leftleg"],
			function(id)
					tSyncIn(id,0,0,90,1000)		
			end
			)	
	process(TableOfPieceGroups["leftleglo"],
			function(id)
					tSyncIn(id,0,0,-90,1000)		
			end
			)		

    Sleep(1000)
	
	
    for i = 1, 6, 1 do
		
        Explode(feet[i][1], SFX.FALL + SFX.FIRE)
        Explode(feet[i + 6][1], SFX.FALL + SFX.FIRE)
        Explode(feet[i][2], SFX.FALL + SFX.FIRE)
        Explode(feet[i + 6][2], SFX.FALL + SFX.FIRE)

		Hide(feet[i][1])
        Hide(feet[i + 6][1])
        Hide(feet[i][2])
        Hide(feet[i + 6][2])

        Sleep(180)
    end
        Explode(hdlmain, SFX.SHATTER)
		Hide(hdlmain)


end

--- -death animation: fall over & explode
function script.Killed(recentDamage, maxHealth)
	killedAnimation()
createCorpseCUnitGeneric(recentDamage)
end

boolActive=false

--- AIMING & SHOOTING---
function script.QueryWeapon1()
    return hlgun
end

function script.AimFromWeapon1()
    return hlgun
end



--must return true to allow the weapon to shot. return false denies the weapon from shooting
--can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon1(heading, pitch)
	if Spring.GetGameFrame() %10 == 0 then 	
		lastheading=heading
		px,pz= Spring.GetVectorFromHeading(heading)
		if px and pz then 
			vec= {x=px,y=0,z=pz}
			spawnCegAtPiece(unitID,hlgun, "cheadlaunch", 0, vec )
		end
	end
    Turn(hlgun, y_axis, heading, 7)
    WaitForTurn(hlgun, y_axis)
    --make sure the aiming animation is only run once

    if boolReadyToFire == true and  boolActive==false then
        return true
    else
        return false
    end
end

lastheading=0
--called after the weapon has fired
function script.FireWeapon1()
    Signal(SIG_RETURN)
		px,pz= Spring.GetVectorFromHeading(lastheading)
		if px and pz then
			vec={x=px,y=0,z=pz}
			spawnCegAtPiece(unitID,hlgun, "cheadlaunch", 0, vec )
		end
    StartThread(reTurnGun)
    Hide(reloadProj)
    Move(reloadProj, y_axis, 0, 0)
    Turn(reloadProj, x_axis, math.rad(0), 0)
    Sleep(10)
    StartThread(reloadAnimation)
end



--- -aimining & fire weapon
function script.AimFromWeapon2()
    return hlgun
end



function script.QueryWeapon2()
    return hlgun
end

function script.AimWeapon2(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy

    return boolActive == true 
end


function script.FireWeapon2()
		px,pz= Spring.GetVectorFromHeading(lastheading)
		spawnCegAtPiece(unitID,hlgun, "cheadlaunch", 0, {x=px,y=0,z=pz} )
		return true
end




function script.Activate()
boolActive=true
    return 1
end

function script.Deactivate()
boolActive= false
    return 0
end

