include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"



--All Praise goes to Knorke. Just look under Awesome in the Wiki.


--Those who enter: Beware, only mindfucks here, i swear!
-- i worked really hard to de-robotimize these - and i think i succeded. 


--- Signals to be spread

--------------------- IdleStance10-Fucntions-------
aimpivot = piece"aimpivot"
shadowemit = piece"shadowemit"
gdbhleg = piece"gdbhleg"
gdbhlegj = piece"gdbhlegj"
gdflegj = piece"gdflegj"
gdfrontleg = piece"gdfrontleg"
ghostdance = piece"ghostdance"
deathpivot = piece"deathpivot"
boolActivated = true

unitTableNr = 0
recoverTime = 90000
SIG_WALK = 1
SIG_IDLE = 2
SIG_CONTDAMAGE = 4
SIG_JUMP= 8
teamID = Spring.GetUnitTeam(unitID)
boolOnlyOnce = false
fullHealthOfAShadow = 0


unitTable = {}
local JSHADOWCOST = 120
DECOY_COST= 140

function buildIt()
    for i = table.getn(unitTable), 1, -1 do
        if Spring.GetUnitIsDead(unitTable[i]) == true then
            table.remove(unitTable, i)
        end
    end

    if internalEnergy - JSHADOWCOST > 0 and table.getn(unitTable) < 4 then
        internalEnergy = internalEnergy - JSHADOWCOST
        x, y, z = Spring.GetUnitPosition(unitID)
        thisID = Spring.CreateUnit("jshadow", x, y, z, 1, teamID)
        table.insert(unitTable, thisID)
    end
end

trackMax = 25

oldPos = {}
function storeOldPositions()
    ox, oy, oz = Spring.GetUnitPosition(unitID)
    for i = 1, trackMax do
        oldPos[i] = { x = ox, y = oy, z = oz }
    end

    while true do
        if boolContinousDamage == false then
            vo = {}
            vo.x, vo.y, vo.z = Spring.GetUnitPosition(unitID)

            if distance(vo, oldPos[#oldPos]) > 30 then
                for i = 1, trackMax - 1 do
                    oldPos[i].x = oldPos[i + 1].x
                    oldPos[i].y = oldPos[i + 1].y
                    oldPos[i].z = oldPos[i + 1].z
                end
                oldPos[trackMax].x = vo.x
                oldPos[trackMax].y = vo.y
                oldPos[trackMax].z = vo.z
            end
        end
        Sleep(400)
    end
end

function showPath(index)
    for i = index, math.min(#oldPos, backTrackindex), 1 do
        oVoc = oldPos[i + 1] or oldPos[i - 1]
        voc = oldPos[i]
        vfx = {}
        vfx.x, vfx.y, vfx.z = Spring.GetUnitDirection(unitID)
        vfx.x, vfx.y, vfx.z = oVoc.x - voc.x, oVoc.y - voc.y, oVoc.z - voc.z
        vfx = normVector(vfx)
        Spring.SpawnCEG("jghostdancerswitch", voc.x, voc.y + 15, voc.z, vfx.x, vfx.y, vfx.z, 0, 0)
    end
end


backTrackindex = trackMax
function backTrack()

    ox, oy, oz = Spring.GetUnitPosition(unitID)
    for i = 1, trackMax do
        oldPos[i] = { x = ox, y = oy, z = oz }
    end

    while true do
        if boolContinousDamage == true then
            buildIt()
            backTrackindex = trackMax
			index = math.random(1,2) or 1
			StartThread(PlaySoundByUnitDefID, Spring.GetUnitDefID(unitID), "sounds/jghostdancer/Backtrack"..index..".ogg", 1, 4000, 1, 0)

            while boolContinousDamage == true and backTrackindex ~= 1 do

                vec = oldPos[backTrackindex]
                if vec then
                    showPath(backTrackindex)
                    Spring.SetUnitPosition(unitID, vec.x, vec.y, vec.z)
                end

                backTrackindex = math.max(1, backTrackindex - 1)
                Sleep(50)
            end
            boolContinousDamage = false
            Signal(SIG_CONTDAMAGE)
        end
        Sleep(400)
    end
end

sleepCycles = 300 * (trackMax - 1)
function continousDamageReset()
    boolContinousDamage = true
    Signal(SIG_CONTDAMAGE)
    SetSignalMask(SIG_CONTDAMAGE)
    Sleep(sleepCycles)
    boolContinousDamage = false
end

myTeamID = Spring.GetUnitTeam(unitID)
function lastAttackerWasMyTeam()
    lastDamagingID = Spring.GetUnitLastAttacker(unitID)
    if lastDamagingID == unitID then
        return true
    end
    if lastDamagingID then
        lastTeamID = Spring.GetUnitTeam(lastDamagingID)
        if lastTeamID == myTeamID then
            return true
        end
    end
    return false
end

gdjumpDefID = WeaponDefNames["jgdjump"].id
boolContinousDamage = false
function script.HitByWeapon(x, z, weaponDefID, damage)
    if lastAttackerWasMyTeam() == false and weaponDefID ~= gdjumpDefID then

        StartThread(continousDamageReset)
    end
    return damage
end

internalEnergy = 0

function internalEnergyReactor()
    local MAX = 240

    while (true) do
        eXp = Spring.GetUnitExperience(unitID)
        if not eXp or eXp < 1 then eXp = 1 end

        internalEnergyMax = MAX * eXp
        internalEnergy = math.min(internalEnergyMax, internalEnergy + 10)
        Sleep(500)
    end
end

decoyTypes= {
	[1]="tiglildecoy",
	[2]="skinfantrydecoy"
	}
function createDecoysLoop()
	delayTillComplete(unitID)
	
while true do
	if boolMoving== true and boolActivated == true and internalEnergy - DECOY_COST > 0 then
		internalEnergy = internalEnergy - DECOY_COST
		x, y, z = Spring.GetUnitPiecePosDir(unitID,TableOfPieceGroups["Tail"][#TableOfPieceGroups["Tail"]])
		id= Spring.CreateUnit(decoyTypes[math.random(1,#decoyTypes)], x, y, z, 1, teamID)
		tx,ty,tz= x,y,z 
		spawnCegatUnit(id,"jghostdancerswitch")
		ed=Spring.GetUnitNearestEnemy(unitID)
		if ed then 
			tx,ty,tz=Spring.GetUnitPosition(ed)
		end
		  Spring.GiveOrderToUnit(id, CMD.GUARD, { unitID }, { "shift" })

	end
	Sleep(500)
end
end

function script.Activate()
    boolActivated = true
    return 1
end

function script.Deactivate()
    boolActivated = false

    return 0
end

local function legs_down()
	Turn(rotcenter, x_axis, math.rad(0), 30)
    Hide(gdbhlegj)
    Hide(gdflegj)
    Show(gdfrontleg)
    Show(gdbhleg)
    Move(ghostdance, y_axis, 0, 9.81)
    Turn(gdbhleg, x_axis, math.rad(0), 12)
    Turn(gdbhlegj, x_axis, math.rad(0), 12)
    Turn(gdflegj, x_axis, math.rad(0), 12)
    Turn(gdfrontleg, x_axis, math.rad(0), 12)
    Turn(ghostdance, x_axis, math.rad(0), 12)
    StartThread(idle)
end

HeadRump = piece "HeadRump"
Head = piece "Head"
Ass = piece "Ass"
boolIdle = true
tails = {}
for i = 0, 5, 1 do
    name = "Tail0" .. i
    tails[#tails + 1] = piece(name)
end

function wiggle()
    ydeg, xdeg = math.random(-25, 25), math.random(-3, 30)
    turnT(tails, x_axis, xdeg, math.abs(xdeg) / 5)
    turnT(tails, y_axis, ydeg, math.abs(ydeg) / 5)
    WaitForTurns(tails)
    ydeg, xdeg = ydeg * -1, math.random(-3, 30)
    turnT(tails, x_axis, xdeg, math.abs(xdeg) / 5)
    turnT(tails, y_axis, ydeg, math.abs(ydeg) / 5)
    WaitForTurns(tails)
    Sleep(200)
end

waveTables = {
    [1] = -1,
    [2] = 1,
    [3] = 0,
    [4] = 1,
    [5] = -1,
    [6] = 0
}
ears = piece "ears"
Ear1 = piece "Ear1"
Ear2 = piece "Ear2"
Rump = piece "Rump"
rotcenter = piece "rotcenter"

function swooshTail()
    degToGoX = math.random(-35, 35)
    waveFoo = math.sin
    if maRa() == true then waveFoo = math.cos end
    degAloof = math.random(-10, 10)

    randfac = math.random(3, 12)
    for i = 2, #tails, 1 do
        offSetYet = degAloof * waveFoo(math.pi / randfac * i)
        Turn(tails[i], y_axis, math.rad(degToGoX + offSetYet), math.abs((degToGoX + offSetYet) / 2))
    end
    glowTail()
end


function standingGuard()
    resetT(tails)
    reset(ghostdance, 30)
    Turn(gdbhleg, z_axis, math.rad(0), 63 / 1.5)
    Turn(gdbhleg, x_axis, math.rad(0), 63 / 1.5)
    Turn(gdflegj, x_axis, math.rad(0), 63 / 1.5)
    Turn(gdflegj, z_axis, math.rad(0), 63 / 1.5)
    Turn(tails[1], x_axis, math.rad(75), 70 / 1.5)
    Turn(rotcenter, x_axis, math.rad(-70), 70 / 1.5)
    Turn(gdbhleg, x_axis, math.rad(63), 63 / 1.5)
    Turn(Head, x_axis, math.rad(42), 42 / 1.5)
    Turn(Rump, x_axis, math.rad(7), 7 / 1.5)
    Turn(Ass, x_axis, math.rad(-8), 8 / 1.5)
    Show(gdflegj)
    Hide(gdfrontleg)
    while boolIdle == true do
        --swooshing tail
        swooshTail()

        if maRa() == true then
            val1, val2 = math.random(-10, 10), math.random(-10, 10)
            Turn(Ear1, x_axis, math.rad(val1), 25)
            Turn(Ear2, x_axis, math.rad(val2), 25)
            if math.random(1, 15) == 3 then
                for k = 1, 5 do
                    WTurn(Head, x_axis, math.rad(32 - k * 2 * (-1 ^ k)), 42 / 1.5)
                    Sleep(300)
                end
                WTurn(Head, x_axis, math.rad(42), 42 / 1.5)
            end
        end
        WaitForTurns(tails)
        Sleep(200)
  
    end
	Turn(rotcenter, x_axis, math.rad(0), 70 / 1.5)

end


function standingWave()
    resetT(tails, 2.5)
    xdeg = math.random(-3, 30)
    ripple = math.random(-10, 10)
    tailstart = 1
    Turn(ears, x_axis, math.rad(0), 7)
    while tailstart < #tails do
        for i = 1, tailstart, 1 do
            randOffset = math.random(-5, 5)
            reset(tails[i], 3)
            Turn(tails[i], x_axis, math.rad(randOffset), 2)
        end
        turnT(tails, x_axis, xdeg, math.abs(xdeg) / 5)
        for i = tailstart, #tails, 1 do
            randOffset = math.random(-5, 5)
            Turn(tails[i], y_axis, math.rad(ripple * waveTables[i + 1 - tailstart] + randOffset), 2)
        end
        WaitForTurns(tails)
        Sleep(300)
        tailstart = tailstart + 1
    end

    while boolIdle == true and math.random(1, 128) == 64 do
        Sleep(500)
    end
end

function pranceStance()
    resetT(TableOfPieceGroups, 42)
    Move(ghostdance, y_axis, -2.5, 2.55)
    Turn(HeadRump, x_axis, math.rad(RumpOffset), math.abs(-18 - RumpOffset) / 10)
    Turn(Head, x_axis, math.rad(-17), 1.7)
    Turn(gdfrontleg, x_axis, math.rad(-18 - RumpOffset), math.abs(-18 - RumpOffset) / 10)
    Turn(Ass, y_axis, math.rad(13), 1.3)
    WTurn(gdbhleg, x_axis, math.rad(-24), 1.8)
    WaitForMove(ghostdance, y_axis)
    while boolIdle == true do
        Time = math.ceil(math.random(500, 1200))
        Sleep(Time)
        swooshTail()
    end
end


function idle()
	SetSignalMask(SIG_IDLE)
    boolIdle = true
    RumpOffset = 12
    resetT(tails)
    resetT(TableOfPieceGroups, 22)
	Turn(rotcenter, x_axis, math.rad(0), 1.7)
    while (boolIdle == true ) do
        if maRa() == true then wiggle() end
        if maRa() == true then standingWave() end
        if maRa() == true then standingGuard() end
        if maRa() == true then pranceStance() end
        resetT(TableOfPieceGroups, 12)
        Sleep(3000)
        showWalkLegs()
    end
    Turn(HeadRump, y_axis, math.rad(0), math.abs(-18 - RumpOffset) / 10)
    Turn(Head, y_axis, math.rad(0), 1.7)
    Move(ghostdance, y_axis, 0, 0.5)
    WTurn(gdfrontleg, y_axis, math.rad(0), 1.8)
    WTurn(gdbhleg, y_axis, math.rad(-18), 1.8)
    resetT(TableOfPieceGroups, 42)
	Turn(rotcenter, x_axis, math.rad(0), 1.7)
end



TableOfPieceGroups = {}
function script.Create()

	TableOfPieceGroups = getPieceTableByNameGroups(false, true)
	hideT(TableOfPieceGroups["esc"])
	hideT(TableOfPieceGroups["esct"])
    Hide(gdbhlegj)
    Hide(gdflegj)
    Show(gdfrontleg)
    resetT(TableOfPieceGroups)
   StartThread(storeOldPositions)
   StartThread(internalEnergyReactor)
   StartThread(backTrack)
   StartThread(createDecoysLoop)
end

function attackAnimation(heading)

		Turn(deathpivot,y_axis,heading,70)
		turnT(TableOfPieceGroups["Tail"],x_axis, math.random(10,20),40)
		showJumpLegs()
		Move(warpRotor,z_axis,60,180)
		for i=360,0,-10 do
			Turn(warpRotor,x_axis,math.rad(i), (i/360)* 90)
			WaitForTurn(warpRotor,x_axis)
			if i == 90 then
				Move(warpRotor,z_axis,0,120)
				 EmitSfx(Rump, 1024)
				showWalkLegs()
			end
		end

		Turn(warpRotor,x_axis,math.rad(0), 0)
		showWalkLegs()
		Turn(deathpivot,y_axis,0,5)
		turnT(TableOfPieceGroups["Tail"],x_axis, math.random(-5,-2),40)
	
end

warpRotor=piece"warpRotor"
deathtime=0
myDefID = Spring.GetUnitDefID(unitID)

function deathAnimation()
Spring.SetUnitNeutral(unitID,true)
Spring.SetUnitNoSelect(unitID,true)
Spring.SetUnitBlocking(unitID,false)
resetT(TableOfPieceGroups)
Sleep(1)
	setSpeedEnv(unitID,0)
	signalAll(16)
	hideAll(unitID)
	Show(Rump)
	Show(HeadRump)
	Show(Ass)
	Show(gdflegj)
	Show(gdbhlegj)
	Show(Head)
	showT(TableOfPieceGroups["Ear"])
	showT(TableOfPieceGroups["Tail"])
	Move(warpRotor,y_axis,14,3)
	Turn(Rump,z_axis,math.rad(180), 15)
	StartThread(PlaySoundByUnitDefID, Spring.GetUnitDefID(unitID), "sounds/jghostdancer/death.ogg", 1, 8000, 1, 0)
	for k=0, 11/3 do
	signUm=randSign()
	Spin(deathpivot,y_axis,math.rad(42)*signUm,0.1)
	Signal(SIG_JUMP)
	StartThread(sleeperJump)
	spawnCegAtPiece(unitID,warpRotor,"portalenter",0)
		for i=1,360, 5 do
		
			deathtime=i/360
			turnT(tails, x_axis,-15, (k+1)*160  )
			turnT(tails, y_axis,math.cos((i/360)*math.pi*2)*10, (k+1)*160  )
			Turn(warpRotor,x_axis,math.rad(i*-1),(k+1)*160)
			WaitForTurns(warpRotor)
		end
	Move(ghostdance,y_axis,k*3,6)
	end
		StartThread(PlaySoundByUnitDefID, myDefID, "sounds/jghostdancer/death.ogg",0.5, 8000, 1, 0)

signalAll(16)
spinRand(warpRotor,22,88,5)
Show(Head)
resetT(TableOfPieceGroups["esct"])
resetT(TableOfPieceGroups["esc"])
for i=1,3,1 do
	totaltime=i*1000
	spawnCegAtPiece(unitID,warpRotor,"portalenter",0)
	deathtime=0.4
	StartThread(sleeperJump)
	Sleep(1000)
	
	deathtime=1
	Sleep(1000)
	hideT(TableOfPieceGroups["esct"])
	hideT(TableOfPieceGroups["esc"])
	spawnCegAtPiece(unitID,warpRotor,"portalenter",0)
	Sleep(totaltime)
end
delayedHideBody()
spawnCegAtPiece(unitID,warpRotor,"portalenter",0)


end
function delayedHideBody()
	for i=#TableOfPieceGroups["Tail"],1,-1 do
		Hide(TableOfPieceGroups["Tail"][i])
		EmitSfx(TableOfPieceGroups["Tail"][i], 1025)   
		Sleep(150)
	end
Hide(Ass)
spawnCegAtPiece(unitID,Ass,"portalenter",0)
Hide(gdbhleg)
Hide(gdbhlegj)
Sleep(300)
Hide(Rump)
spawnCegAtPiece(unitID,Rump,"portalenter",0)
Sleep(300)
Hide(Head)
Hide(HeadRump)
spawnCegAtPiece(unitID,Head,"portalenter",0)
Hide(gdflegj)
Hide(gdfrontleg)
hideT(TableOfPieceGroups["ear"])
Sleep(300)

end

escapee=piece"escapee"
function sleeperJump()
Sleep(1)
SetSignalMask(SIG_JUMP)
hideT(TableOfPieceGroups["esct"])
hideT(TableOfPieceGroups["esc"])
resetT(TableOfPieceGroups["esct"])
resetT(TableOfPieceGroups["esc"])

Move(escapee,y_axis,20,0)
Jumper= TableOfPieceGroups["esc"][6]

rY,rX=math.random(0,360),math.random(-10,0)
Move(Jumper,y_axis,20,0)
tP(escapee,rX,rY,0,15)
showT(TableOfPieceGroups["esct"])
showT(TableOfPieceGroups["esc"])
speed=math.random(250,450)
gotoVal=10

while deathtime < 0.5 do
	speed=speed^0.92
	gotoVal=gotoVal+gotoVal
	Move(Jumper,z_axis,gotoVal,speed)
	WaitForMove(Jumper,z_axis)

end
Turn(Jumper,x_axis,math.rad(-90),0)
turnT(TableOfPieceGroups["esct"],x_axis,-20,5)
speed=70



spawnCegAtPiece(unitID,Jumper,"portalenter",0)
hideT(TableOfPieceGroups["esct"])
hideT(TableOfPieceGroups["esc"])
Move(escapee,y_axis,50,50)
while deathtime > 0.5  do	
	Move(Jumper,y_axis,0,speed)

	speed=speed^(1+deathtime)

	 	EmitSfx(TableOfPieceGroups["esct"][6], 1025)   
	 Sleep(100)
end

Move(escapee,x_axis,0,15)
Move(escapee,z_axis,0,15)
reset(Jumper,15)
end
function script.Killed(recentDamage, maxHealth)
	deathAnimation()
	
	
    Spring.Echo("Jghostdancer:Killed")
    return 0
end

function smokeEmit()

    EmitSfx(shadowemit, 1024)
end

function glowTail()
    if maRa() == true then
        EmitSfx(shadowemit, 1025)
    end
end

function showWalkLegs()
	Hide(gdbhlegj)
    Hide(gdflegj)
    Show(gdfrontleg)
    Show(gdbhleg)

end

function showJumpLegs()
	Show(gdbhlegj)
    Show(gdflegj)
    Hide(gdfrontleg)
    Hide(gdbhleg)
end


function threadedLegs(prevtime, Time)
    Sleep(prevtime)
	showJumpLegs()
    Sleep(Time)
	showWalkLegs()
end

function walk()
    SetSignalMask(SIG_WALK)
    boolIdle = false

    Turn(ears, x_axis, math.rad(-70), 35)
    resetT(TableOfPieceGroups, 22)
	reset(warpRotor, 30)
	Turn(rotcenter, x_axis, math.rad(0), 30)
    while (true) do

        --landing
        turnT(tails, y_axis, math.random(-5, 5), 5)
        turnT(tails, x_axis, math.random(5), 5)
        Move(ghostdance, y_axis, 0, 25)
        Turn(ghostdance, x_axis, math.rad(11), 12)
        Turn(gdflegj, x_axis, math.rad(8), 0) --8
        Turn(gdfrontleg, x_axis, math.rad(155), 0)
        Turn(gdflegj, x_axis, math.rad(222), 90) --138
        Turn(gdfrontleg, x_axis, math.rad(-29), 90)

        Turn(gdbhlegj, x_axis, math.rad(8), 0)
        Turn(gdbhleg, x_axis, math.rad(155), 0)
        Turn(gdbhlegj, x_axis, math.rad(222), 90) --138
        Turn(gdbhleg, x_axis, math.rad(-29), 90)
        StartThread(threadedLegs, 120, 120)
        --placeleghidefunction here
        WaitForMove(ghostdance, y_axis)
        --TouchDown
        Turn(ghostdance, x_axis, math.rad(-2), 12)
        Move(ghostdance, y_axis, -2, 25)
        Sleep(320)

        --anlauf
        Turn(ghostdance, x_axis, math.rad(-8), 12)
        Turn(gdflegj, x_axis, math.rad(0), 55)
        Turn(gdfrontleg, x_axis, math.rad(108), 55)
        Turn(gdbhlegj, x_axis, math.rad(6), 55)
        Turn(gdbhleg, x_axis, math.rad(118), 55)
        turnT(tails, y_axis, math.random(-5, 5), 5)
        turnT(tails, x_axis, math.random(-5, 5), 5)
        --sprung
        glowTail()
        Move(ghostdance, y_axis, 6, 15)
        StartThread(threadedLegs, 120, 80)
        turnT(tails, y_axis, math.random(-5, 5), 5)
        turnT(tails, x_axis, math.random(-5, -2), 5)
        WaitForMove(ghostdance, y_axis)
        glowTail()
        Sleep(220)
        glowTail()
        --zenit
        turnT(tails, y_axis, math.random(-5, 5), 5)
        turnT(tails, x_axis, math.random(-5, 5), 5)
        Turn(ghostdance, x_axis, math.rad(-2), 12)
        glowTail()
        if maRa() == true then
            smokeEmit()
        end
    end
end




boolMoving=false
function script.StartMoving()
    Signal(SIG_IDLE)
	boolMoving=true
    Signal(SIG_WALK)
    StartThread(walk)
end

function script.StopMoving()
	boolMoving=false
    Signal(SIG_WALK)
    boolIdle = false
    Turn(ears, x_axis, math.rad(0), 35)
    legs_down()
end

--- AIMING & SHOOTING -
function script.AimFromWeapon1()
    return aimpivot
end

function script.QueryWeapon1()
    return aimpivot
end

--must return true to allow the weapon to shot. return false denies the weapon from shooting
-- can be used delay the shooting until a "turn turret" animation is completed
storedHeading=0
function script.AimWeapon1(heading, pitch)
	Signal(SIG_IDLE)
	Turn(rotcenter, x_axis, math.rad(0), 1.7)
    boolIdle = false
	storedHeading=heading
    return true
end

-- called after the weapon has fired
function script.FireWeapon1()
	StartThread(attackAnimation,storedHeading)
	StartThread(PlaySoundByUnitDefID, myDefID, "sounds/jghostdancer/roar.ogg", 1, math.random(2000,9000), 1, 0)
    --Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav")
    return true
end

function script.AimFromWeapon2()
    return aimpivot
end

function script.QueryWeapon2()
    return aimpivot
end

--must return true to allow the weapon to shot. return false denies the weapon from shooting
-- can be used delay the shooting until a "turn turret" animation is completed
function script.AimWeapon2(heading, pitch)
	Signal(SIG_IDLE)
	Turn(rotcenter, x_axis, math.rad(0), 1.7)
    boolIdle = false
    return true
end

-- called after the weapon has fired
function script.FireWeapon2()
	Signal(SIG_IDLE)
	StartThread(PlaySoundByUnitDefID, myDefID, "sounds/jghostdancer/jghostdancermove.ogg", 1, math.random(8000,9000), 1, 0)
    --Spring.PlaySoundFile("sounds/tiglil/tgswoard1.wav")
    return true
end