include "lib_jw.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


--a walking animation using threads
--smoothly aiming the weapon, also using threads
local center = piece "center"
local depshield = piece "depshield"
local bgbase = piece "bgbase"
local bgtorso = piece "bgtorso"
maxspeed = math.ceil(183492) --2.8*65533
local turn_rate = UnitDefNames["bg"].turnRate

riotshield = piece "riotshield"
local riotshield2 = piece "riotshield2"
local bgarm = piece "bgarm"
local flare01 = piece "flare01"
local flare02 = piece "flare02"
local bgleg = piece "bgleg"
local bglegr = piece "bglegr"
local deathpivot = piece "deathpivot"
local bglowlegr = piece "bglowlegr"
local bglowleg = piece "bglowleg"
local sleeper = 1
local boolUnderFire = false

local boolOnceInAWhile = true
local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
SIG_IDLE = 4
local SIG_COUNTER = 8
local SIG_FIRE = 16
local SIG_ROB = 32
local SIG_AIMRESET = 64
local SIG_ATTACK = 128
local SIG_UNDERFIRE= 256
local leg_movespeed = 12 + math.random(-1, 1)
local leg_movedistance = 10
defID = Spring.GetUnitDefID(unitID)
PiecesTable = getPieceTable(unitID)

bgdefID = UnitDefNames["bg"].id
boolCityTrooper = (defID == UnitDefNames["bg"].id)

LArm = piece "LArm"
RArm = piece "RArm"
Head = piece "Head"
Gun = piece "Gun"
DecoGun = piece "DecoGun"
Neck = piece "Neck"
attackedSounds = {}
for i = 1, 14, 1 do
    if i < 10 then
        attackedSounds[i] = "sounds/bgmtw/attacked/attacked00" .. i .. ".ogg"
    else
        attackedSounds[i] = "sounds/bgmtw/attacked/attacked0" .. i .. ".ogg"
    end
end
killedSounds = {}
for i = 1, 4, 1 do
    killedSounds[i] = "sounds/bgmtw/killed/killed00" .. i .. ".ogg"
end
shieldSounds = {}
for i = 1, 6, 1 do
    shieldSounds[i] = "sounds/bgmtw/moving/moving00" .. i .. ".ogg"
end
movingSounds = {}
for i = 1, 8, 1 do
    movingSounds[i] = "sounds/bgmtw/moving/moving00" .. i .. ".ogg"
end

function bodyBuilder()
	hideDecoArms()
    Hide(Gun)
    if defID == bgID then


        decIsion = math.random(1, 3)
        if decIsion == 1 then

            Hide(riotshield)
        elseif decIsion == 2 then

            Hide(riotshield2)
        else
            Hide(riotshield)
            Hide(riotshield2)
        end
    end
	
	if defID ==bg3defid then
		StartThread(HideStandingStill)
	end
end

function hideDecoArms()
			Hide(LArm)
			Hide(RArm)
			Hide(DecoGun)
end
function showDecoArms()
			Show(LArm)
			Show(RArm)
			Show(DecoGun)
end

function randomShowHide(piecename)
if maRa()== true then Show(piecename) else Hide(piecename) end
end

function slowlyFlickeringInvisible(TableOfPieces)
if maRa()== true then Hide(TableOfPieces[math.random(1,#TableOfPieces)])end

if math.random(1,22)== 12 then Show(TableOfPieces[math.random(1,#TableOfPieces)])end
end
function showActiveBody()
			Show(bglegr)
			Show(bgleg)
			Show(bgtorso)
			Show(bgbase)
			Show(bglowleg)
			Show(bglowlegr)
end

function HideStandingStill()
TablesOfPiecesGroups = getPieceTableByNameGroups(false, true)
Antenna = piece"Antenna"
while true do

	if boolMoveOrderd == true then
			showT(TablesOfPiecesGroups)
			hideDecoArms()
			showBattleArms()
			showActiveBody()
		
	else
		showDecoArms()
		hideBattleArms()
		slowlyFlickeringInvisible({bgtorso, bgbase, bglegr,bgleg, LArm, RArm, bglowleg,bglowlegr,depshield})
		slowlyFlickeringInvisible({ LArm, RArm})
	end
	interval=math.random(300,1500)
	Sleep(interval)

end

end


local function legs_down()

		resetLegs()
    val = math.random(-10, 45)
	Turn(center,y_axis, math.rad(0),5)
    Turn(bgarm, x_axis, math.rad(val), 8)
	--assert(type(idle)=="function")
    StartThread(idle)
    return
end

boolCanMove = true
function kneeDown()
	Time= math.random(12000,22000)

    Move(bgbase, y_axis, -8, 12)
    Turn(bgleg, x_axis, math.rad(-135), 18)
    Turn(bglegr, x_axis, math.rad(-135), 18)
    Turn(bglowleg, x_axis, math.rad(70), 28)
    Turn(bglowlegr, x_axis, math.rad(70), 28)
   
	if math.random(0,1000) == 450 then
        local x, y, z = Spring.GetUnitPosition(unitID)
        local teamID = Spring.GetUnitTeam(unitID)
        Spring.CreateUnit("cFirePlace", x + 15, y, z + 15, 0, teamID)
    end

        Sleep(Time)

    Move(bgbase, y_axis, 0, 12)
    Turn(bgleg, x_axis, math.rad(0), 18)
    Turn(bglegr, x_axis, math.rad(0), 18)
    Turn(bglowleg, x_axis, math.rad(0), 28)
    Turn(bglowlegr, x_axis, math.rad(0), 28)



   
end

function script.Create()
	Hide(DecoGun)
    Hide(depshield)
    Hide(flare01)
    Hide(flare02)
    Hide(deathpivot)
    bodyBuilder()
	--assert(type(soundStart)=="function")

    StartThread(soundStart)
end
idleFunc= {}

idleFunc[#idleFunc+1] = function (boolLeftRight)
--echo("idle look around")
--lookAround
        Turn(bgtorso, y_axis, math.rad(35), 1)

        Turn(bgarm, x_axis, math.rad(-24), 3)

        Turn(bgarm, y_axis, math.rad(-10), 3)
        WaitForTurn(bgarm, x_axis)
        WaitForTurn(bgtorso, y_axis)
        WaitForTurn(bgarm, y_axis)
        Turn(bgtorso, y_axis, math.rad(-27), 3)

        Turn(bgarm, y_axis, math.rad(10), 3)

        Turn(bgarm, x_axis, math.rad(10), 3)
        WaitForTurn(bgarm, x_axis)
        WaitForTurn(bgtorso, y_axis)
        WaitForTurn(bgarm, y_axis)
        Sleep(512)
        Turn(bgtorso, y_axis, math.rad(0), 3)
        Turn(bgarm, x_axis, math.rad(0), 3)
        Turn(bgarm, y_axis, math.rad(0), 3)
        Turn(bgtorso, y_axis, math.rad(0), 3)
        Turn(bgarm, y_axis, math.rad(0), 3)
        Turn(bgarm, x_axis, math.rad(0), 3)
        WaitForTurn(bgarm, x_axis)
        WaitForTurn(bgtorso, y_axis)
        WaitForTurn(bgarm, y_axis)

        Move(bgbase, y_axis, 0, 12)
        Turn(bglegr, x_axis, math.rad(0), 18)
        Turn(bgleg, x_axis, math.rad(0), 18)
        Turn(bglowlegr, x_axis, math.rad(0), 28)
        Turn(bglowleg, x_axis, math.rad(0), 28)
        Sleep(250)

end

idleFunc[#idleFunc+1] =  function (boolLeftRight) --kneeLeftRight
--echo("idle kneeLeftRight")
	if boolLeftRight == true then
				Move(bgbase, y_axis, -4, 10)
				Turn(bglegr, x_axis, math.rad(-90), 18)
				Turn(bglowlegr, x_axis, math.rad(90), 28)
				Turn(bglowleg, x_axis, math.rad(101), 28)
	else
				Move(bgbase, y_axis, -4, 12)
				Turn(bgleg, x_axis, math.rad(-90), 18)
				Turn(bglowleg, x_axis, math.rad(90), 28)
				Turn(bglowlegr, x_axis, math.rad(101), 28)
	end
end

idleFunc[#idleFunc+1] =  kneeDown

idleFunc[#idleFunc+1] =  function (boolLeftRight) --rest
--echo("idle rest")
	Sleep(5000)
	speed= 10
	angle= math.random(-45,15)
	 Move(bgbase,y_axis, -5, speed)
	 Turn(bgbase,y_axis, math.rad(angle), speed)

	 Turn(bglegr,x_axis,math.rad(-angle-58),speed)
	 Turn(bgleg,x_axis,math.rad(-angle-58),speed)
	 Turn(bglowlegr,x_axis,math.rad(130),speed)
	 Turn(bglowleg,x_axis,math.rad(130),speed)
	 Turn(bgarm,x_axis,math.rad(15),speed)
	 Sleep(15000)

	 Move(bgbase,y_axis,0, speed)
	 Turn(bgbase,y_axis, math.rad(0), speed)
	 Turn(bglegr,x_axis,math.rad(0),speed)
	 Turn(bgleg,x_axis,math.rad(0),speed)
	 Turn(bglowlegr,x_axis,math.rad(0),speed)
	 Turn(bglowleg,x_axis,math.rad(0),speed)
	 Turn(bgarm,x_axis,math.rad(0),speed)

end


function hideBattleArms()
	Hide(bgarm)
end
function showBattleArms()
	Show(bgarm)
end

thoughts="Thinking: "
homePlanet= PlanetNameGenerator()
homeTown =  CityNameGenerator()
name = "John Doe"

NormalThink = getBlackGuardThougth()
UnderFireThink = getBlackGuardUnderFireThought()

coherentThought ={}
coherentThoughtIndex=1
boolCoherentThought= false

function thoughBuilder()
	if boolUnderFire == false then
	
		if boolCoherentThought == true then
			coherentThoughtIndex = coherentThoughtIndex + 1
			if coherentThought[coherentThoughtIndex] then
				return thoughts..coherentThought[coherentThoughtIndex]
			end
			boolCoherentThought = false
		end
		
		ThinkSentences = NormalThink[math.random(1,#NormalThink)]()
		
		if type(ThinkSentences) == "string" then
			return thoughts..ThinkSentences
		else
			coherentThought= ThinkSentences
			coherentThoughtIndex=1
			boolCoherentThought= true
			return  thoughts..coherentThought[1]		
		end
	else
		return thoughts..UnderFireThink[math.random(1,#UnderFireThink)]()
	end
end 

function mindReader()

	while true do
	Spring.SetUnitTooltip(unitID, thoughBuilder())
	restPeriod= math.ceil(math.random(1000,12000))
	Sleep(restPeriod)
	end
end


idleFunc[#idleFunc+1] =  function (boolLeftRight)--weaponCheck
	if boolCityTrooper == false then
		hideBattleArms()
		showDecoArms()
		--TODO Weaponscheck
		Sleep(10000)	
		showBattleArms()		 
	end
end

function resetLegs()
     Turn(bgleg, x_axis, 0, leg_movespeed)
    Turn(bglegr, x_axis, 0, leg_movespeed)
    Turn(bglowlegr, x_axis, math.rad(0), leg_movespeed)
    Turn(bglowleg, x_axis, math.rad(0), leg_movespeed)
    Turn(bglegr, x_axis, math.rad(0), 9)
    Turn(bglegr, y_axis, math.rad(0), 13)
    Turn(bglegr, z_axis, math.rad(0), 9)

    Turn(bglowlegr, x_axis, math.rad(0), 9)
    Turn(bglowlegr, y_axis, math.rad(0), 13)
    Turn(bglowlegr, z_axis, math.rad(0), 9)
    Turn(deathpivot, x_axis, math.rad(0), 9)
    Turn(deathpivot, y_axis, math.rad(0), 13)
    Turn(deathpivot, z_axis, math.rad(0), 9)

    Turn(bgleg, x_axis, math.rad(0), 9)
    Turn(bgleg, y_axis, math.rad(0), 15)
    Turn(bgleg, z_axis, math.rad(0), 9)

    Turn(bglowleg, x_axis, math.rad(0), 14)
    Turn(bglowleg, y_axis, math.rad(0), 13)
    Turn(bglowleg, z_axis, math.rad(0), 9)
    Turn(deathpivot, y_axis, math.rad(0), 8)
    Turn(deathpivot, x_axis, math.rad(0), 9)
	
    val = math.random(-10, 45)
    Turn(bgarm, x_axis, math.rad(val), 8)
	
end

idleFunc[#idleFunc+1] =  function (boolLeftRight)--weaponCheck
	resetLegs()
	signum= randSign() or 1
	TurnTotal=math.random(1,12)
	for i=1, TurnTotal do
		valueToTurn= i*40*signum
		Turn(center,y_axis, math.rad(valueToTurn),5)
		StartThread(walk)
		WaitForTurn(center,y_axis)
		Signal(SIG_WALK)
		resetLegs()
		times=math.random(200,3000)
		Sleep(times)
	end
		Turn(center,y_axis, math.rad(0),5)
		StartThread(walk)
		WaitForTurn(center,y_axis)
		Signal(SIG_WALK)
end
bg3defid = UnitDefNames["bg3"].id

function idle()
    Signal(SIG_IDLE)
    SetSignalMask(SIG_IDLE)
    while (true) do
	    sleeper = math.random(1024, 8192)
        Sleep(sleeper)
		if boolUnderFire == false   then
       idleFunc[math.random(1,#idleFunc)](math.random(0,1)==1)
		end
    end
end

timeSinceLastChatter = 0

function reduceTimeSinceLastChatter()
    Sleep(timeSinceLastChatter)
    timeSinceLastChatter = 0
end

--- WALKING---
function walk()
    if boolCanMove == true then
        Signal(SIG_WALK)
        boolFiredRecently = false
        SetSignalMask(SIG_WALK)
        Turn(bgtorso, x_axis, math.rad(22), 14)
        WaitForTurn(bgtorso, x_axis)


        if timeSinceLastChatter == 0 and math.random(0, 800) == 100 then
            dec = math.random(0, 2) == 1
            if dec == 1 then
                StartThread(PlaySoundByUnitDefID, bgdefID, "sounds/bgmtw/bgAff.wav", 0.5, 2000, 1, 0)
                timeSinceLastChatter = 19000
                StartThread(reduceTimeSinceLastChatter)
            elseif dec == 2 then
                StartThread(PlaySoundByUnitDefID, bgdefID, "sounds/bgmtw/bgAff2.wav", 0.5, 2000, 1, 0)
                timeSinceLastChatter = 19000
                StartThread(reduceTimeSinceLastChatter)
            else
                StartThread(PlaySoundByUnitDefID, bgdefID, movingSounds[math.floor(math.random(1, #movingSounds))], 0.5, 2000, 1, 0)
                timeSinceLastChatter = 19000
                StartThread(reduceTimeSinceLastChatter)
            end
        end

        local altspeed = 9 + math.random(-1, 1)
        local doublealtspeed = (9 * 2) + math.random(-1, 1)
        while (true) do
            --left leg up, right leg down
            Turn(bglegr, x_axis, math.rad(-16), altspeed)
            Turn(bglowlegr, x_axis, math.rad(50), doublealtspeed)
            Turn(bgleg, x_axis, math.rad(9), leg_movespeed)

            WaitForTurn(bglegr, x_axis)
            WaitForTurn(bgleg, x_axis)
            WaitForTurn(bglowleg, x_axis)
            if boolNotAiming == true then
                rand = math.random(15, 30)
                Turn(bgarm, x_axis, math.rad(rand), 3)
            end
            Turn(bglegr, x_axis, math.rad(-33), altspeed)
            --	Turn(bgleg, x_axis, math.rad(10), leg_movespeed)
            Turn(bglowleg, x_axis, math.rad(24), leg_movespeed)
            Turn(bglowlegr, x_axis, math.rad(50), doublealtspeed)

            WaitForTurn(bglegr, x_axis)
            WaitForTurn(bglowleg, x_axis)
            --	WaitForTurn (bgleg, x_axis)
            WaitForTurn(bglowlegr, x_axis)

            Sleep(65)
            --left leg down, right leg up
            Turn(bgleg, x_axis, math.rad(-16), altspeed)
            Turn(bglowleg, x_axis, math.rad(50), doublealtspeed)
            Turn(bglegr, x_axis, math.rad(12), leg_movespeed)

            WaitForTurn(bgleg, x_axis)
            WaitForTurn(bglegr, x_axis)
            WaitForTurn(bglowlegr, x_axis)
            if boolNotAiming == true then
                rand = math.random(22, 45)
                Turn(bgarm, x_axis, math.rad(rand), 3)
            end
            Turn(bgleg, x_axis, math.rad(-33), altspeed)
            Turn(bglowlegr, x_axis, math.rad(25), leg_movespeed)
            Turn(bglowleg, x_axis, math.rad(52), doublealtspeed)

            WaitForTurn(bglegr, x_axis)
            WaitForTurn(bglowlegr, x_axis)
            WaitForTurn(bglowleg, x_axis)
            Sleep(56)
        end
    end
end

function counterTerrorIsm()
    SetSignalMask(SIG_COUNTER)
    napTime = math.ceil(math.random(900, 12800))
    Sleep(napTime)
    oneInThreeHundred = math.random(0, 35)
    if oneInThreeHundred == 5 then
        StartThread(PlaySoundByUnitDefID, bgdefID, "sounds/bgmtw/bgAff.wav", 0.5, 2000, 1, 0)
    end
    if oneInThreeHundred == 7 then
        StartThread(PlaySoundByUnitDefID, bgdefID, "sounds/bgmtw/bgAff2.wav", 0.5, 2000, 1, 0)
    end
end

boolMoveOrderd = false

function script.StartMoving()



    Signal(SIG_IDLE)
    if boolCanMove == true then
        Turn(Head, y_axis, math.rad(0), 12)
        Move(bgbase, y_axis, 0, 12)
        Turn(bgtorso, y_axis, 0, 4)


        StartThread(walk)


        StartThread(counterTerrorIsm)
    end
    boolMoveOrderd = true
end

function script.StopMoving()

    boolMoveOrderd = false

    Signal(SIG_COUNTER)

    Turn(bgtorso, x_axis, math.rad(0), 14)
    -- --Spring.--echo ("stopped walking!")
    Signal(SIG_WALK)
    if boolCanMove == true then
        legs_down()
    end
end

function aimReseter()
    SetSignalMask(SIG_AIMRESET)
    Sleep(6000)
    boolNotAiming = true
end

boolNotAiming = true

--- AIMING & SHOOTING---
function script.AimFromWeapon1()

    return bgarm
end
function script.AimFromWeapon2()
    return bgbase
end
function script.QueryWeapon2()
	  return bgbase
end

function script.QueryWeapon1()
    return flare01
end

boolOnlyOnce = true
--must return true to allow the weapon to shot. return false denies the weapon from shooting
--can be used delay the shooting until a "turn turret" animation is completed
boolHeadTurn = false
function Headturn(heading)
    boolHeadTurn = true
    Turn(Head, y_axis, heading, 12)
    WaitForTurn(Head, y_axis)
    Turn(Head, y_axis, 0, 3)
    WaitForTurn(Head, y_axis)
    Sleep(500)
    boolHeadTurn = false
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIMRESET)
    StartThread(aimReseter)
    boolNotAiming = false

    Signal(SIG_IDLE)
    --make sure the aiming animation is only run once
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)
    if boolCityTrooper == true and boolHeadTurn == false then StartThread(Headturn, heading) end
    Turn(bgarm, y_axis, math.rad(0), 12)
    Turn(deathpivot, y_axis, math.rad(0), 12)
    Turn(bgtorso, y_axis, heading, 3)
    Turn(bgarm, x_axis, -pitch, 3)
    --Math.Rad(70) ?
    --wait until the weapon is pointed in the right direction
    WaitForTurn(bgtorso, y_axis)
    WaitForTurn(bgarm, x_axis)

    Signal(SIG_FIRE)
    StartThread(OnceInAWhileReseter)
    return true
end

lastActiveFrame = Spring.GetGameFrame() or 1
GRENADE_RELOAD= 25 * 30
modulator= 0
UPDATE_REDUCER = 25
randoInterVal=  math.random(15,75)
currentFrame = lastActiveFrame

function script.AimWeapon2(heading, pitch)
	
	modulator = modulator + 1
	if modulator > UPDATE_REDUCER then
		modulator= 0
		currentFrame = Spring.GetGameFrame()
	end
	
	if  boolDefStance == true and 
	lastActiveFrame + GRENADE_RELOAD - randoInterVal < currentFrame  then

		return true
	end
	return false 
end


function shootFiredReseter()
    SetSignalMask(SIG_ATTACK)
    Sleep(900)
    boolFiredRecently = false
end

boolFiredRecently = false
--called after the weapon has fired
function script.FireWeapon1()
	showActiveBody()
    if boolOnceInAWhile == true then
        boolOnceInAWhile = false
    end

    boolFiredRecently = true
    Signal(SIG_ATTACK)
    StartThread(shootFiredReseter)
    for i = 1, 7, 1 do
        Turn(bgarm, y_axis, math.rad((5 / 7) * i), 77)
        EmitSfx(flare01, 1025)
        Sleep(142)
        Turn(bgarm, y_axis, math.rad((5 / 7) * i - 1), 33)
    end
end

function script.FireWeapon2()
		showActiveBody()
		lastActiveFrame = currentFrame 
	return true
end

function headexplode(Time, intervall)
    for i = 1, Time, intervall do

        spawnCegAtPiece(unitID, Neck, "bghdexplode", 0)
        Sleep(intervall)
    end
end

bloodtable = { [1] = bgbase, [2] = Head, [3] = bgtorso }
function offOverHead()
    Move(bgbase, y_axis, -4.6, 10)
    Turn(bglowlegr, x_axis, math.rad(107), 45)
    Turn(bglowleg, x_axis, math.rad(95), 45)
    WaitForMove(bgbase, y_axis)
    spawnCegAtPiece(unitID, Head, "bloodspray", 0)

    Explode(Head, SFX.FALL + SFX.NO_HEATCLOUD)
    Hide(Head)
    wavetime = math.ceil(math.random(500, 1000))
    itterator = 1
    Show(LArm)
    Show(RArm)
    Hide(bgarm)
    Turn(RArm, x_axis, math.rad(-108 * itterator), 5)
    Turn(LArm, x_axis, math.rad(-108 * itterator), 5)
    StartThread(headexplode, wavetime, 35)
    while wavetime > 0 do
        for i = 1, 5 do

            spawnCegAtPiece(unitID, bloodtable[math.random(1, #bloodtable)], "bgbloodslay", false)
            Sleep(240)
        end
        itterator = itterator * 0.9
        Turn(RArm, x_axis, math.rad(-108 * itterator), 3)
        Turn(LArm, x_axis, math.rad(-108 * itterator), 8)
        Sleep(800)
        wavetime = wavetime - 2000
    end
    Turn(RArm, x_axis, math.rad(90), 12)
    Turn(RArm, y_axis, math.rad(math.random(-20, 20)), 12)

    Turn(LArm, x_axis, math.rad(90), 12)
    Turn(RArm, y_axis, math.rad(math.random(-20, 20)), 12)

    Turn(deathpivot, x_axis, math.rad(-90), 5)
    Move(bgbase, y_axis, 0, 35)
    Turn(bglowlegr, x_axis, math.rad(0), 12)
    Turn(bglowleg, x_axis, math.rad(0), 12)
    Sleep(2500)

    return 1
end


function killinTime(recentDamage, maxHealth)
    Turn(deathpivot, y_axis, math.rad(0), 1.40)
    spawnCegAtPiece(unitID, bgtorso, "bghdexplode", 0)
    dice = math.random(1, 3)
    if dice == 1 then
        if math.random(0, 1) == 1 then
            StartThread(dropPieceTillStop, unitID, Gun, 9.81, 32, 5, true)
            Show(Gun)
        else
            Explode(Gun, SFX.NO_HEATCLOUD + SFX.FALL)
        end


        if recentDamage / maxHealth > 0.3 and recentDamage > TIGLILDAMAGE then return offOverHead() end

        Hide(bgarm)
        Show(LArm)
        Show(RArm)
        Turn(LArm, x_axis, math.rad(-29), 2 * 0.90)
        Turn(RArm, x_axis, math.rad(math.random(-29, 12)), 2 * 0.90)
        Turn(bglegr, x_axis, math.rad(-30), 3 * 0.45)
        Turn(bglowlegr, x_axis, math.rad(54), 3 * 0.32)
        Turn(bgleg, x_axis, math.rad(-28), 3 * 0.32)
        Turn(bgleg, y_axis, math.rad(-29), 3 * 0.42)
        Turn(bglowleg, x_axis, math.rad(0), 3 * 0.32)
        diff = math.random(-15, 15)
        Turn(deathpivot, y_axis, math.rad(diff), 0.40)
        Turn(deathpivot, x_axis, math.rad(-38), 0.40)
        EmitSfx(bgtorso, 1027)


        Turn(bgtorso, x_axis, math.rad(-14), 3 * 0.84)
        Sleep(320)
        WaitForTurn(bgtorso, x_axis)
        Turn(bgleg, x_axis, math.rad(0), 2 * 0.15)
        Turn(bglegr, x_axis, math.rad(0), 2 * 0.15)

        Turn(LArm, x_axis, math.rad(-90), 2 * 0.85)

        Turn(bgtorso, x_axis, math.rad(0), 3 * 0.84)
        Turn(deathpivot, x_axis, math.rad(-89), 2 * 0.75)


        synVal = math.random(40, 84)
        synValz = math.random(75, 95)
        syncTurn(unitID, LArm, 0, synVal, synValz, 284)
        syncTurn(unitID, RArm, 0, -90, synValz, 300)
        Sleep(550)
        Spring.PlaySoundFile("sounds/bgmtw/bgDeath.wav")
    elseif dice == 2 then
        Turn(bgarm, x_axis, math.rad(-29), 2 * 0.90)
        Turn(bglegr, x_axis, math.rad(-30), 2 * 0.45)
        Turn(bglowlegr, x_axis, math.rad(54), 2 * 0.32)
        Turn(bgleg, x_axis, math.rad(-28), 2 * 0.32)
        Turn(bgleg, y_axis, math.rad(-29), 2 * 0.42)
        Turn(bglowleg, x_axis, math.rad(0), 2 * 0.32)
        Turn(deathpivot, x_axis, math.rad(-38), 2 * 0.45)
        EmitSfx(bgtorso, 1027)


        Turn(bgtorso, x_axis, math.rad(-14), 2 * 0.84)
        Sleep(320)
        WaitForTurn(bgtorso, x_axis)
        Turn(bgleg, x_axis, math.rad(0), 2 * 0.15)
        Turn(bglegr, x_axis, math.rad(0), 2 * 0.15)
        WaitForTurn(bgleg, x_axis)
        WaitForTurn(bglegr, x_axis)
        Turn(bgarm, x_axis, math.rad(-90), 2 * 0.85)
        Turn(bgtorso, x_axis, math.rad(0), 3 * 0.84)
        Turn(deathpivot, x_axis, math.rad(-89), 2 * 0.75)

        WaitForTurn(deathpivot, x_axis)
        Sleep(150)
        Spring.PlaySoundFile("sounds/bgmtw/bgDeath.wav")

    else
        Turn(deathpivot, y_axis, math.rad(0), 2 * 0.12)
        Turn(bglegr, x_axis, math.rad(25), 0.42)
        Turn(bgleg, x_axis, math.rad(-10), 0.42)
        Turn(bglowleg, x_axis, math.rad(0), 0.32)
        Turn(bglowlegr, x_axis, math.rad(-10), 0.32)
        spawnCegAtPiece(unitID, Head, "bghdexplode", 0)

        Sleep(650)
        Turn(bgbase, x_axis, math.rad(-20), 2 * 0.12)
        Turn(deathpivot, x_axis, math.rad(-10), 2 * 0.12)
        Turn(bglegr, x_axis, math.rad(10), 2 * 0.12)
        Turn(bgleg, x_axis, math.rad(10), 2 * 0.12)
        Turn(bglowleg, x_axis, math.rad(0), 2 * 0.12)
        Turn(bglowlegr, x_axis, math.rad(0), 2 * 0.12)
        spawnCegAtPiece(unitID, Head, "bghdexplode", 0)
        Hide(bgarm)

        syncTurn(unitID, LArm, 0, 80, 74, 200)
        syncTurn(unitID, RArm, 0, -90, 74, 200)
        Sleep(450)

        spawnCegAtPiece(unitID, bgtorso, "bghdexplode", 0)
        Turn(bgbase, x_axis, math.rad(35), 5 * 0.12)
        Turn(bglegr, x_axis, math.rad(-43), 2 * 0.12)
        Turn(bgleg, x_axis, math.rad(-62), 2 * 0.12)
        Turn(bglowleg, x_axis, math.rad(39), 2 * 0.12)
        Turn(bglowlegr, x_axis, math.rad(78), 2 * 0.12)
        syncTurn(unitID, LArm, 0, 135, 74, 222)
        syncTurn(unitID, RArm, 0, -146, 74, 222)
        Sleep(550)


        val = math.random(-15, 15)

        Turn(deathpivot, x_axis, math.rad(69), 8.65 * 0.10)
        Turn(bgbase, x_axis, math.rad(35), 2 * 0.12)
        synVal = math.random(40, 84)
        synValz = math.random(75, 95)
        syncTurn(unitID, LArm, 0, synVal, synValz, 284)
        syncTurn(unitID, RArm, 0, -90, synValz, 300)
        Sleep(420)
        Signal(SIG_IDLE)
        valr = math.random(0, 45)
        vall = math.random(-45, 0)

        Turn(bglegr, z_axis, math.rad(val), 3 * 0.12)
        Turn(bglegr, x_axis, math.rad(-15), 2 * 0.12)
        Turn(bgleg, z_axis, math.rad(vall), 4 * 0.12)
        Turn(bgleg, x_axis, math.rad(-12), 2 * 0.12)
        Turn(bglowleg, x_axis, math.rad(0), 2 * 0.12)

        if maRa() == true then
            KneeRand = math.random(0, 65)
            Turn(bglowlegr, x_axis, math.rad(KneeRand), 5 * 0.12)
            Turn(bglegr, y_axis, math.rad(90), 8 * 0.12)
        else
            Turn(bglowlegr, x_axis, math.rad(0), 2 * 0.12)
        end

        Sleep(420)
        Signal(SIG_IDLE)
    end
end

--- -death animation: fall over & explode
TIGLILDAMAGE = 325
bgID = UnitDefNames["bg"].id
function script.Killed(recentDamage, maxHealth)
     setSpeedEnv(unitID, 0, UnitDefs)

     killinTime(recentDamage, maxHealth)

     if math.random(0, 12) == 7 then
         PlaySoundByUnitDefID(bgdefID, killedSounds[math.floor(math.random(1, #killedSounds))], 0.5, 2000, 1, 0)
     end

	return 1
end

--]]

function OnceInAWhileReseter()
    SetSignalMask(SIG_FIRE)
    Sleep(7000)
    boolOnceInAWhile = true
end

function soundStart()
    while true do


        Sleep(500)
        if boolShieldDown == true then
            boolShieldDown = false
            StartThread(PlaySoundByUnitDefID, bgdefID, "sounds/bgmtw/shielddrop.ogg", 1500, 1, 1)
            Sleep(1600)
            if timeSinceLastChatter == 0 and math.random(0, 4) == 1 then
                StartThread(PlaySoundByUnitDefID, bgdefID, shieldSounds[math.floor(math.random(1, #shieldSounds))], 0.5, 2000, 1, 0)
                timeSinceLastChatter = 19000
                StartThread(reduceTimeSinceLastChatter)
            end
        end
    end
end

function underFireReset()
	Signal(SIG_UNDERFIRE)
	SetSignalMask(SIG_UNDERFIRE)
	Sleep(3000)
	boolUnderFire = false
end

function script.HitByWeapon(x, z, weaponDefID, damage)
	boolUnderFire= true


	StartThread(underFireReset)
    if damage > 15 and math.random(0, 42) == 22 then
        StartThread(PlaySoundByUnitDefID, bgdefID, attackedSounds[math.floor(math.random(1, #attackedSounds))], 0.5, 2000, 1, 0)
    end
	
	if not GG.RiotShieldTable then GG.RiotShieldTable = {} end
	if GG.RiotShieldTable[unitID]== true then
		return math.ceil(damage * 0.3)
	else
		return damage
	end
end

function showShield()
    Show(depshield)
    if not GG.RiotShieldTable then GG.RiotShieldTable = {} end
    GG.RiotShieldTable[unitID] = true

    Move(bgbase, y_axis, -4, 12)
    Turn(bgleg, x_axis, math.rad(-90), 18)
    Turn(bglowleg, x_axis, math.rad(90), 28)
    Turn(bglowlegr, x_axis, math.rad(101), 28)
    boolShieldDown = true
end

function hideShield()
    Hide(depshield)
    if not GG.RiotShieldTable then GG.RiotShieldTable = {} end
    GG.RiotShieldTable[unitID] = nil
    Move(bgbase, y_axis, 0, 12)
    Turn(bgleg, x_axis, math.rad(0), 18)
    Turn(bglowleg, x_axis, math.rad(0), 28)
    Turn(bglowlegr, x_axis, math.rad(0), 28)
    legs_down()
    Signal(SIG_WALK)
end

boolDefStance = false

function script.Activate()
    boolDefStance = true
    --setMoveRateToZero
    SetUnitValue(COB.MAX_SPEED, 1) --sets the speed to 5,2 *65533

    showShield()

    return 1
end

function script.Deactivate()

	boolDefStance = false
    SetUnitValue(COB.MAX_SPEED, maxspeed) --sets the speed to 5,2 *65533

    hideShield()

    return 0
end