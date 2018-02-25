include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"

boolFullGrown=true
growUpTime= 3*60*1000
jumpReloadTimeInSec=35

local center = piece "center"
local aimspot = piece "aimspot"
local swiftspear = piece "swiftspear"
local swsplefta = piece "swsplefta"
local swsprighta = piece "swsprighta"
local swpenis = piece "swpenis"
local friendwithbenefits = piece "friendwithbenefits"
local penistip = piece "penistip"


local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_SHIVER = 4
local SIG_ROCK = 8
local SIG_JERK = 16
local SIG_SEX = 32
local checkRange = 140
local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit
local boolInTheMiddleOfSomething = true
teamID = Spring.GetUnitTeam(unitID)
local loaded = false
faceDamagePerSecond= 55
local llegs = {}
local llow = {}
local rlegs = {}
local rlow = {}
for i = 1, 5, 1 do
    llegs[i] = {}
    llow[i] = {}
    rlegs[i] = {}
    rlow[i] = {}
    llegtemp = "swl" .. i
    llowtemp = "ll" .. i
    rlegtemp = "swr" .. i
    rlowtemp = "lr" .. i
    llegs[i] = piece(llegtemp)
    llow[i] = piece(llowtemp)
    rlegs[i] = piece(rlegtemp)
    rlow[i] = piece(rlowtemp)
end

--- - i know the api.. its all in my head... brb, have to see doctor freeman
-- throws the unit grabbed by the elephant appendix
function timeBudget(timeBudgetinMs, Soundfilename1, Soundfilename2, lenght1, lenght2, loudness)

    while (timeBudgetinMs > 0) do
        --Spring.PlaySoundFile(as al ,loudness)
        var = math.random(-10, 10) / 100
        Spring.PlaySoundFile(Soundfilename1, loudness + var)
        Sleep(lenght1)
        timeBudgetinMs = timeBudgetinMs - lenght1
        var = math.random(-0.1, 0.1)
        if loudness == 1 then var = 0 end
        Spring.PlaySoundFile(Soundfilename2, loudness + var)
        Sleep(lenght2)
        timeBudgetinMs = timeBudgetinMs - lenght2
    end
end

function limit(amount, limit)
    if amount > limit then return limit else return amount end
end

function sexbackgroundloop()
    SetSignalMask(SIG_SEX)
    sound = 0.5
    while true do
        Spring.PlaySoundFile("sounds/swiftspear/spsexbackground.wav", sound)
        Sleep(8000)
        sound = limit(sound + 0.1, 1)
    end
end

function ohYeah(timeInMS)
    --a -- ai --i -- iu -- u -- uo -- o -- org
    org = 9000
    timeInMS = timeInMS - org
    divProd = math.ceil((timeInMS / 7))
    temp = divProd
    loudness = 0.5
    StartThread(sexbackgroundloop)
    timeBudget(divProd, "sounds/swiftspear/spalong.wav", "sounds/swiftspear/spashort.wav", 5000, 600, loudness) --a
    loudness = 0.6
    timeBudget(divProd, "sounds/swiftspear/spishort05s.wav", "sounds/swiftspear/spashort.wav", 500, 600, loudness) --ai
    loudness = 0.8
    timeBudget(divProd, "sounds/swiftspear/spishort06s.wav", "sounds/swiftspear/spishort05s.wav", 600, 500, loudness) --i

    timeBudget(divProd, "sounds/swiftspear/spishort06s.wav", "sounds/swiftspear/spulong.wav", 600, 2000, loudness) --iu
    loudness = 0.9
    timeBudget(divProd, "sounds/swiftspear/spulong.wav", "sounds/swiftspear/spushort07s.wav", 2000, 700, loudness) --u

    timeBudget(divProd, "sounds/swiftspear/spulong.wav", "sounds/swiftspear/sposhort1s.wav", 2000, 1000, loudness) --uo
    loudness = 1.0
    timeBudget(divProd, "sounds/swiftspear/spolong2s.wav", "sounds/swiftspear/sposhort1s.wav", 2000, 1000, loudness) --uo
    dice = math.random(0, 1)
    if dice == 1 then Spring.PlaySoundFile("sounds/swiftspear/sporg1.wav", 1) else Spring.PlaySoundFile("sounds/swiftspear/sporg2.wav", 1) end
    Sleep(9000)
    Signal(SIG_SEX)
end


function setzero(piece)
    Turn(piece, x_axis, math.rad(0), 22)
    Turn(piece, y_axis, math.rad(0), 22)
    Turn(piece, z_axis, math.rad(0), 22)
end

function legsDown()
    for i = 1, 5, 1 do
        setzero(llegs[i])
        setzero(llow[i])
        setzero(rlegs[i])
        setzero(rlow[i])
    end
    Move(swiftspear, y_axis, 0, 12)
    Move(swiftspear, z_axis, 0, 12)
    Move(swiftspear, x_axis, 0, 12)
    Turn(center, x_axis, math.rad(0), 12)
    Turn(center, z_axis, math.rad(0), 12)
    Turn(center, y_axis, math.rad(0), 12)

	StartThread(showStatus)
end

function walkStageOneL(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(34), speed)
    Turn(llegs[Nr], y_axis, math.rad(59), speed)
    Turn(llegs[Nr], z_axis, math.rad(0), speed)

    Turn(llow[Nr], x_axis, math.rad(38), speed)
    Turn(llow[Nr], y_axis, math.rad(-47), speed)
    Turn(llow[Nr], z_axis, math.rad(0), speed)
end

function walkStageTwoL(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(12), speed)
    Turn(llegs[Nr], y_axis, math.rad(38), speed)
    Turn(llegs[Nr], z_axis, math.rad(-16), speed)

    Turn(llow[Nr], x_axis, math.rad(-37), speed)
    Turn(llow[Nr], y_axis, math.rad(-11), speed)
    Turn(llow[Nr], z_axis, math.rad(26), speed)
end

function walkStageThreeL(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(4), speed)
    Turn(llegs[Nr], y_axis, math.rad(31), speed)
    Turn(llegs[Nr], z_axis, math.rad(5), speed)

    Turn(llow[Nr], x_axis, math.rad(0), speed)
    Turn(llow[Nr], y_axis, math.rad(0), speed)
    Turn(llow[Nr], z_axis, math.rad(-39), speed)
end

function walkStageFourL(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(0), speed)
    Turn(llegs[Nr], y_axis, math.rad(-7), speed)
    Turn(llegs[Nr], z_axis, math.rad(0), speed)

    Turn(llow[Nr], x_axis, math.rad(0), speed)
    Turn(llow[Nr], y_axis, math.rad(0), speed)
    Turn(llow[Nr], z_axis, math.rad(-20), speed)
end

function walkStageFiveL(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(-2), speed)
    Turn(llegs[Nr], y_axis, math.rad(-37), speed)
    Turn(llegs[Nr], z_axis, math.rad(3), speed)

    Turn(llow[Nr], x_axis, math.rad(6), speed)
    Turn(llow[Nr], y_axis, math.rad(0), speed)
    Turn(llow[Nr], z_axis, math.rad(-32), speed)
end


function walkStageOneR(Nr, speed)
    Turn(rlegs[Nr], x_axis, math.rad(34), speed)
    Turn(rlegs[Nr], y_axis, math.rad(-59), speed)
    Turn(rlegs[Nr], z_axis, math.rad(0), speed)

    Turn(rlow[Nr], x_axis, math.rad(38), speed)
    Turn(rlow[Nr], y_axis, math.rad(47), speed)
    Turn(rlow[Nr], z_axis, math.rad(0), speed)
end

function walkStageTwoR(Nr, speed)
    Turn(rlegs[Nr], x_axis, math.rad(12), speed)
    Turn(rlegs[Nr], y_axis, math.rad(-38), speed)
    Turn(rlegs[Nr], z_axis, math.rad(16), speed)

    Turn(rlow[Nr], x_axis, math.rad(-37), speed)
    Turn(rlow[Nr], y_axis, math.rad(11), speed)
    Turn(rlow[Nr], z_axis, math.rad(-26), speed)
end

function walkStageThreeR(Nr, speed)
    Turn(rlegs[Nr], x_axis, math.rad(4), speed)
    Turn(rlegs[Nr], y_axis, math.rad(-31), speed)
    Turn(rlegs[Nr], z_axis, math.rad(-5), speed)

    Turn(rlow[Nr], x_axis, math.rad(0), speed)
    Turn(rlow[Nr], y_axis, math.rad(0), speed)
    Turn(rlow[Nr], z_axis, math.rad(39), speed)
end

function walkStageFourR(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(0), speed)
    Turn(llegs[Nr], y_axis, math.rad(7), speed)
    Turn(llegs[Nr], z_axis, math.rad(0), speed)

    Turn(llow[Nr], x_axis, math.rad(0), speed)
    Turn(llow[Nr], y_axis, math.rad(0), speed)
    Turn(llow[Nr], z_axis, math.rad(20), speed)
end

function walkStageFiveR(Nr, speed)
    Turn(llegs[Nr], x_axis, math.rad(-2), speed)
    Turn(llegs[Nr], y_axis, math.rad(37), speed)
    Turn(llegs[Nr], z_axis, math.rad(-3), speed)

    Turn(llow[Nr], x_axis, math.rad(6), speed)
    Turn(llow[Nr], y_axis, math.rad(0), speed)
    Turn(llow[Nr], z_axis, math.rad(32), speed)
end




function walk()
    Turn(center, y_axis, math.rad(0), 13.141)
    Move(swiftspear, y_axis, 0, 12)
    Move(swiftspear, z_axis, 0, 12)
    Move(swiftspear, x_axis, 0, 12)
    SetSignalMask(SIG_WALK)
    while true do

        t = math.random(32, 55)
        randSpeed = math.random(12, 19)
        Turn(swsplefta, x_axis, math.rad(t), randSpeed)
        t = math.random(32, 55)
        randSpeed = math.random(12, 19)
        Turn(swsprighta, x_axis, math.rad(t), randSpeed)
        speed = math.random(5, 7)
        for i = 1, 10, 1 do
            Sleep(140)
            randrot = math.random(-50, -35)
            Turn(swpenis, x_axis, math.rad(randrot), 6)
            walkStageOneL((((i % 5) + 1) % 5) + 1, speed)
            walkStageTwoL((((i % 5) + 2) % 5) + 1, speed)
            walkStageThreeL((((i % 5) + 3) % 5) + 1, speed)
            walkStageFourL((((i % 5) + 4) % 5) + 1, speed)
            walkStageFiveL((((i % 5) + 5) % 5) + 1, speed)

            walkStageOneR((((i % 5) + 5) % 5) + 1, speed)
            walkStageTwoR((((i % 5) + 4) % 5) + 1, speed)
            walkStageThreeR((((i % 5) + 3) % 5) + 1, speed)
            walkStageFourR((((i % 5) + 2) % 5) + 1, speed)
            walkStageFiveR((((i % 5) + 1) % 5) + 1, speed)

            Sleep(140)
            Turn(swpenis, x_axis, math.rad(0), 6)
        end
        randSpeed = math.random(12, 19)
        Turn(swsprighta, x_axis, math.rad(0), randSpeed)
        randSpeed = math.random(12, 19)
        Turn(swsplefta, x_axis, math.rad(0), randSpeed)
    end
end
boolMoving=false
function script.StartMoving()
boolMoving=true
    Signal(SIG_WALK)
    StartThread(walk)
end

function script.StopMoving()
boolMoving=false
    Signal(SIG_WALK)
    StartThread(legsDown)
end

--------------------------------------------------------------------------
function jerkingOffForTests()
    SetSignalMask(SIG_JERK)

    while true do
        EmitSfx(penistip, 1026)
        Sleep(10)
    end
end

function script.Killed()
	transporteeID= Spring.GetUnitTransporting
	if transporteeID then DropUnit(transporteeID) end
	Signal(SIG_AIM)
	Signal(SIG_JERK)
	Signal(SIG_ROCK)
	Signal(SIG_SEX)
	Signal(SIG_SHIVER)

 


--Turn 
for k=1,math.random(180,270),35 do
	tSyncIn(swpenis,math.random(-10,10),0,0,500)
	tSyncIn(center,0,-1*(k-5),0 , 1000)
	tSyncIn(swiftspear,0,0, -70 + math.random(-10,10), 1000)
	tSyncIn(swsplefta, 0,0,0, 1000)
	tSyncIn(swsprighta,0,0,0, 1000)
	
	for i = 1, 5, 1 do
		tSyncIn(rlegs[i],0,0,-90,1000)
		tSyncIn(rlow[i],math.random(-10,10),0,math.random(-10,10),1000)
		
		tSyncIn(llegs[i],0,0,-1* math.random(20,40),1000)
		tSyncIn(llow[i],math.random(-10,10),0,math.random(-10,10),1000)	
    end
	Sleep(900)
	tSyncIn(swpenis,-150,0,0,1000)
	tSyncIn(center,0,-k,0 , 1000)
	tSyncIn(swiftspear,0,0, -70 + math.random(-10,10), 1000)
	tSyncIn(swsplefta, 80,0,0, 1000)
	tSyncIn(swsprighta,80,0,0, 1000)
	
	for i = 1, 5, 1 do
		tSyncIn(rlegs[i],math.random(10,35),0,-90,1000)
		tSyncIn(rlow[i],math.random(-10,10),0,math.random(-10,10),1000)
		
		tSyncIn(llegs[i],math.random(10,35),0,-1*math.random(20,40),1000)
		tSyncIn(llow[i],math.random(-10,10),0,math.random(-10,10),1000)	
    end
	Sleep(900)
end

tSyncIn(swsplefta, -90,0,0, 1000)
tSyncIn(swsprighta,-90,0,0, 1000)
tSyncIn(swpenis,-150,0,0,500)
	for i = 1, 5, 1 do
		tSyncIn(rlegs[i],math.random(10,35),0,-160,1000)
		tSyncIn(rlow[i],math.random(-10,10),0,math.random(-10,10),1000)		
		tSyncIn(llegs[i],math.random(10,35),0,60,1000)
		tSyncIn(llow[i],math.random(-10,10),0,math.random(-10,10),1000)	
    end
Sleep(3000)


end



function rockBackAndForth()
    SetSignalMask(SIG_ROCK)
    sexSpeed = 1
    while true do
        forth = math.random(-6, -4)
        for i = 1, 5, 1 do
            Turn(llegs[i], x_axis, math.rad(-forth), sexSpeed)
            Turn(llow[i], x_axis, math.rad(0), sexSpeed)
            Turn(rlegs[i], x_axis, math.rad(-forth), sexSpeed)
            Turn(rlow[i], x_axis, math.rad(0), sexSpeed)
        end
        Turn(center, x_axis, math.rad(forth), sexSpeed)
        WaitForTurn(center, x_axis)
        back = math.random(3, 6)
        for i = 1, 5, 1 do
            Turn(llegs[i], x_axis, math.rad(-back), sexSpeed)
            Turn(llow[i], x_axis, math.rad(0), sexSpeed)
            Turn(rlegs[i], x_axis, math.rad(-back), sexSpeed)
            Turn(rlow[i], x_axis, math.rad(0), sexSpeed)
        end
        sexSpeed = (sexSpeed + 0.0001) % 2
        Turn(center, x_axis, math.rad(back), sexSpeed)
        WaitForTurn(center, x_axis)
    end
end



function randomShivers(Time)
    SetSignalMask(SIG_SHIVER)
    while Time > 0 do
        xRand = math.random(-5, 5)
        zRand = math.random(-5, 5)
        yRand = math.random(-5, 5)
        Turn(center, x_axis, math.rad(xRand), 4)
        Turn(center, z_axis, math.rad(zRand), 4)
        Turn(center, y_axis, math.rad(yRand), 4)
        Sleep(600)
        Time = Time - 600
    end
end



boolLookAtTheTime = false

function rape( 	)
    Signal(SIG_ROCK)
    StartThread(rockBackAndForth)
    --probing
    Turn(swsplefta, x_axis, math.rad(156), 7)
    Turn(swsprighta, x_axis, math.rad(156), 8)
    Turn(swpenis, x_axis, math.rad(-104), 12)
    for i = 1, 7, 1 do
        rand = math.random(-110, -90)
        Turn(swpenis, x_axis, math.rad(rand), 1.5)
        WaitForTurn(swpenis, x_axis)
    end
    Turn(swpenis, x_axis, math.rad(-80), 19)
    WaitForTurn(swpenis, x_axis)
    Sleep(1500)
    --penetration
    Turn(swpenis, x_axis, math.rad(-152), 59)
    Sleep(300)
    Move(friendwithbenefits, z_axis, 5, 18)
    WaitForTurn(swpenis, x_axis)

    fuckOnSpeed = 6
    timeLimited = 45000
    boolLookAtTheTime = true
    StartThread(ohYeah, timeLimited)
    while (timeLimited > 0) do
        Turn(swpenis, x_axis, math.rad(-90), fuckOnSpeed)
        Move(friendwithbenefits, z_axis, 0, 18)
        naptime = limit(math.abs(800 - (fuckOnSpeed * 4)), 400)
        Sleep(naptime)
        deapThroat = math.random(-155, -145)
        Turn(swpenis, x_axis, math.rad(deapThroat), fuckOnSpeed)
        Sleep(100)
        Move(friendwithbenefits, z_axis, 5, 18)
        soDeep = limit(math.abs(600 - math.ceil(fuckOnSpeed * 1.5)), 250)
        Sleep(soDeep)
        fuckOnSpeed = limit(fuckOnSpeed + 6, 110)
        timeLimited = timeLimited - naptime - 100 - soDeep
    end
    boolLookAtTheTime = false
    StartThread(randomShivers, 12300)
    Turn(swpenis, x_axis, math.rad(-152), 180)
    Sleep(300)
    Move(friendwithbenefits, z_axis, 5, 18)
    WaitForTurn(swpenis, x_axis)
    StartThread(jerkingOffForTests)
    Sleep(9000)
    --climaxing
    Turn(swpenis, x_axis, math.rad(3), 9)
    --drippinSperm

    --dazzed (sperm drip)
    Sleep(3000)
    Move(friendwithbenefits, z_axis, 0, 28)
    Signal(SIG_SHIVER)
    Signal(SIG_ROCK)
    Signal(SIG_JERK)
end

function idle()

    Signal(SIG_ROCK)
    StartThread(rockBackAndForth)
    naptime = math.random(2000, 30000)
    Sleep(naptime)
    Signal(SIG_ROCK)
end

notMyTypeTable= getUnAttractiveTypesTable()

function script.TransportPickup(passengerID)
    --Spring.Echo("UnitIsFired 5", table.getn(unitsStompedLately))
	
	if not 	GG.Fucked then 	GG.Fucked = {} end
	if not GG.Prego then GG.Prego = {} end
	
   marker(unitID.."swiftspear")
	--can not be raped
	typus= Spring.GetUnitDefID(passengerID)
    if boolFullGrown == false or notMyTypeTable[typus] then 
		StartThread(retreatToPreviousLocation,storedPosition,4000)
        return
    end
	
   marker(unitID.."swiftspear")
	--save Position
    abductedPosition.x, abductedPosition.y, abductedPosition.z = Spring.GetUnitPosition(passengerID)
    if GG.Fucked[passengerID] then
        DropUnit(passengerID)
		victim= nil
		StartThread(retreatToPreviousLocation,storedPosition,4000)
        return
    end
	
   marker(unitID.."swiftspear")
   
	--is allready transported
	transporterID= Spring.GetUnitTransporter(passengerID)
	if transporterID then
		StartThread(retreatToPreviousLocation,storedPosition,4000)
        return
    end
	
   marker(unitID.."swiftspear")
   
	--on the wrong team --no team-mate incests
    passengerTeam = Spring.GetUnitTeam(passengerID)
    ourTeam = Spring.GetUnitTeam(unitID)
    if not passengerTeam or not ourTeam or Spring.AreTeamsAllied(passengerTeam, ourTeam) == true then
		StartThread(retreatToPreviousLocation,storedPosition,4000)
        return
    end

   marker(unitID.."swiftspear")
	--to big difference, yes, to big distance
	local px1, py1, pz1 = Spring.GetUnitBasePosition(unitID)
    local px2, py2, pz2 = Spring.GetUnitBasePosition(passengerID)
    local dx, dy, dz = px2 - px1, py2 - py1, pz2 - pz1
    local dist = (dx ^ 2 + dz ^ 2) ^ 0.5

    if dist > 80 then
		StartThread(retreatToPreviousLocation,storedPosition,4000)
        return
	end
	
	--Unit is allready deeply in love- as deep as it can stick its genitals in

	
	--Semaphore
    SetUnitValue(COB.BUSY, 1)
  
    AttachUnit(friendwithbenefits, passengerID)
   GG.Fucked[passengerID] = true
   marker(unitID.."swiftspear")
	StartThread(retreatToPreviousLocation,storedPosition,4000)
	   marker(unitID.."swiftspear")
    setSpeedEnv(unitID, 0.001, UnitDefs)
	   marker(unitID.."swiftspear")
    rape()
	   marker(unitID.."swiftspear")
    setSpeedEnv(unitID, 1.0, UnitDefs)

 
		
		
        GG.Prego[table.getn(GG.Prego) + 1] = {}
        GG.Prego[table.getn(GG.Prego)][1] = passengerID
        GG.Prego[table.getn(GG.Prego)][2] = teamID   

    marker(unitID.."swiftspear")--5
	StartThread(dropLoad,passengerID)
end

function dropLoad(passengerID)
    SetUnitValue(COB.BUSY, 0)

    x, y, z = Spring.GetUnitPosition(unitID)
    script.TransportDrop(passengerID, x, y, z)
	
    Spring.SetUnitPosition(passengerID, abductedPosition.x, abductedPosition.y, abductedPosition.z)
    Spring.SetUnitMoveGoal(passengerID, abductedPosition.x + math.random(-100, 100), abductedPosition.y, abductedPosition.z + math.random(-100, 100))
    StartThread(potencyReloader)

end

function script.TransportDrop(passengerID, x, y, z)

    --post coital function is ankward


    if Spring.GetUnitIsDead(passengerID) == true then return end

    SetUnitValue(COB.BUSY, 1)

    DropUnit(passengerID)
	victim= nil

    health = Spring.GetUnitHealth(passengerID)
    health = health * 10
    Spring.AddUnitDamage(passengerID, 0, health)

    --not even cigaretts

    SetUnitValue(COB.BUSY, 0)
end

storedPosition = {x=ux,y=uy,z=uz}
abductedPosition =  {x=ux,y=uy,z=uz}
function getReadyJump()
    storedPosition.x, storedPosition.y, storedPosition.z = Spring.GetUnitPosition(unitID)


    Turn(swpenis, x_axis, math.rad(-179), 90)
    WaitForTurn(swpenis, x_axis)
    Move(swiftspear, y_axis, -17, 22.5)
    Turn(swpenis, x_axis, math.rad(-222), 60)
    Turn(swsplefta, x_axis, math.rad(62), 22)
    Turn(swsprighta, x_axis, math.rad(62), 22)

    for i = 1, 5, 1 do
        upTurn = 28 - (((i - 1) * 14) % 10)
        if i == 4 then upTurn = 12 end
        Turn(llegs[i], z_axis, math.rad(-1 * upTurn), 9)
        downTurn = 80 - (((i - 1) * 20) % 20)
        Turn(llow[i], z_axis, math.rad(downTurn), 11)
        Turn(rlegs[i], z_axis, math.rad(upTurn), 9)
        Turn(rlow[i], z_axis, math.rad(-1 * downTurn), 11)
    end

    WaitForMove(swiftspear, y_axis)
    whip = math.random(2, 6)
    for i = 1, whip do
        Turn(center, x_axis, math.rad(3), 1.8)
        WaitForTurn(center, x_axis)
        Turn(center, x_axis, math.rad(-6), 1.8)
        WaitForTurn(center, x_axis)
    end
    WaitForTurn(center, y_axis)
    --jump
    Move(swiftspear, y_axis, 17, 110)
    Turn(swpenis, x_axis, math.rad(-75), 80)
    for i = 1, 5, 1 do
        Turn(llegs[i], z_axis, math.rad(60), 9)
        downTurn = 80 - (((i - 1) * 20) % 20)
        Turn(llow[i], z_axis, math.rad(-62), 11)
        Turn(rlegs[i], z_axis, math.rad(-62), 9)
        Turn(rlow[i], z_axis, math.rad(62), 11)
    end
    WaitForMove(swiftspear, y_axis)
    Sleep(150)
end

function soundFromTimeToTime()
    howOften = math.random(10, 23)
    local spPlaySoud = Spring.PlaySoundFile
    for i = 1, howOften do
        dice = math.random(0, 6)
        randloud = ((i) % 10) / 10
        if dice == 1 then spPlaySoud("sounds/swiftspear/splonging.wav", randloud)
            Sleep(7000)
        elseif dice == 2 then spPlaySoud("sounds/swiftspear/spmoan.wav", randloud)
            Sleep(7000)
        elseif dice == 3 or dice == 5 then
            spPlaySoud("sounds/swiftspear/spbreath2.wav", randloud)
            Sleep(1100)
        else spPlaySoud("sounds/swiftspear/spbreath1.wav", randloud)
            Sleep(2000)
        end
    end
end


function idleSound()

    while true do
        randSleep = math.random(3000, 12000)
        if boolInTheMiddleOfSomething == false then soundFromTimeToTime() end
        Sleep(randSleep)
    end
end

----------------------------------------- WEAPON ONE ----------------------------
function script.AimFromWeapon1()
    return aimspot
end

function script.QueryWeapon1()
    return aimspot
end

function script.AimWeapon1(heading, pitch)
    SetSignalMask(SIG_AIM)
	if boolInside== true or boolFullGrown == false  then return false end

    --Spring.PlaySoundFile("sounds/headcrab/hc.wav")
		if boolJumpLoaded == true 
		and boolInTheMiddleOfSomething == false 
		and boolPotencyRestored == true
		then
        Turn(center, y_axis, heading, 3.141)
        getReadyJump()
        return true
    else
        return false
    end
end

boolJumpLoaded = false
function script.FireWeapon1()

    StartThread(jumpReloader)
    StartThread(HideMeWhileNotThere)
    EmitSfx(center, 1024)
	dx,dy,dz = Spring.GetUnitDirection(unitID)
	spawnCEGatUnit(unitID, "jswspout", 0 ,10 ,0, -dx,-dy,-dz)
	
	return true
end

function landing()
    Move(swiftspear, y_axis, -14.5, 22)

    for i = 1, 5, 1 do
        Turn(llegs[i], z_axis, math.rad(-42), 9)
        Turn(llow[i], z_axis, math.rad(42), 11)

        Turn(rlegs[i], z_axis, math.rad(42), 9)
        Turn(rlow[i], z_axis, math.rad(-42), 11)
    end
    Sleep(200)
    legsDown()
end


ux, uy, uz = Spring.GetUnitPosition(unitID)
function HideMeWhileNotThere()
    ux, uy, uz = Spring.GetUnitPosition(unitID)
    xt, yt, zt = Spring.GetUnitPosition(unitID)
    Spring.SetUnitNoDraw(unitID, true)

    Spring.SetUnitNoSelect(unitID, true)
    Spring.SetUnitBlocking(unitID, false, false, false)

    while (absDistance(ux,xt) < 3 and absDistance(uy,yt) < 3 and absDistance(uz,zt)	< 3) do
        Sleep(100)
        xt, yt, zt = Spring.GetUnitPosition(unitID)
    end

    Spring.SetUnitNoDraw(unitID, false)
    Spring.SetUnitNoSelect(unitID, false)
    Spring.SetUnitBlocking(unitID, true, true, true)
    for i = 1, 5, 1 do
        EmitSfx(center, 1024)
        Sleep(15)
    end
    Sleep(500)
    landing()
end

potencyReloadTimeInSec = 30
dega=80/potencyReloadTimeInSec
pl=1
boolPotencyRestored= false
function potencyReloader()
boolPotencyRestored= false	
	for pl=1,potencyReloadTimeInSec do
		if boolMoving == false then
			tSyncIn(swsplefta, 80- dega*pl,0,0, 1000)
			tSyncIn(swsprighta,80- dega*pl,0,0, 1000)
		end
	Sleep(1000)
	end

boolPotencyRestored= true
end

jl=1
function jumpReloader()
    boolJumpLoaded = false
	for jl=1,jumpReloadTimeInSec do
		if boolMoving == false then
			tSyncIn(swpenis,-2*jl,0,0, 1000)
		end
	Sleep(1000)
	end

    boolJumpLoaded = true
end

function showStatus()
	tSyncIn(swpenis,-2*jl,0,0, 1000)
	tSyncIn(swsplefta, 80- dega*pl,0,0, 1000)
	tSyncIn(swsprighta,80- dega*pl,0,0, 1000)

end


----------------------------------------- WEAPON TWO ----------------------------
function findInTable(namet, searchKey)
    for i = 1, table.getn(namet), 1 do
        if namet[i] == searchKey then
            return i
        end
    end

    return nil
end

boolWaitForVictim = true
local victim 
function IfSomedayItMightHappenThatAVictimMustBeFound(victimID)

	if not victime then 
		boolWaitForVictim= false
		victim = victimID
	end
end

function polygAmour()
	while (boolFullGrown == false) do	
		Sleep(50)
	end

	while true do
	
		repeat 
			Sleep(50)
		until  boolWaitForVictim == false 	
	
		if boolInTheMiddleOfSomething == false then
			if victim and  not GG.Fucked[victim] then --cleanup
				echo("Resume")
				 boolInTheMiddleOfSomething = true
				script.TransportPickup(victim)
				 boolInTheMiddleOfSomething=false
			end
						
			boolWaitForVictim= true
		
			
		Sleep(100)			
		end
		
    end
end

maxSpeedPerSecond = 70

function retreatToPreviousLocation(previousLocation,times)
	tSyncIn(swpenis,25,0,0,350)
	Sleep(250)
		px,py,pz =Spring.GetUnitPosition(unitID)
		local pVec= {	x=previousLocation.x-px,
						y=previousLocation.y-py,
						z=previousLocation.z-pz}
		pVec= normalizeVec(pVec)
		
		spawnCEGatUnit(unitID, "jswspin", 0 ,10 ,0, pVec.x, pVec.y, pVec.z)
	
	--going back
	Spring.MoveCtrl.Enable(unitID)
	factor = 0
	orgVec = {x=px,y=py,z=pz}

	totalDistance = distance(previousLocation.x,previousLocation.y,previousLocation.z,
							orgVec.x,orgVec.y,orgVec.z)
	elmoPerMs= totalDistance/times
	increaseFactor = math.min(1.0, math.max(0.001,math.ceil(100*elmoPerMs)/totalDistance))
	
	while factor < 1 do
		tVec = mix( orgVec, previousLocation, factor)		
		Spring.MoveCtrl.SetPosition(unitID, tVec.x, tVec.y + math.sin(factor*math.pi)*55, tVec.z)
		Sleep(100)
		factor = math.max(0.0,math.min(1.0,factor + increaseFactor))
	end
	
	Spring.MoveCtrl.Disable(unitID)			
end
---------------------------------------------------------------------------------

function script.AimFromWeapon2()
    return aimspot
end

function script.QueryWeapon2()
    return aimspot
end

function script.AimWeapon2(heading, pitch)

 
        return 
		boolFullGrown == true 
		and boolInside == false 
		and  boolPotencyRestored == true 
  
end

function script.FireWeapon2()
	return true
end

---------------------------------------------------------------------------------
function resetSwiftspear()
	transporteeID= Spring.GetUnitTransporting
	if transporteeID then DropUnit(transporteeID) end
	
	if not 	GG.Fucked then 	GG.Fucked = {} end
	if not GG.Prego then GG.Prego = {} end
	Spring.MoveCtrl.Disable(unitID)
    setSpeedEnv(unitID, 1.0, UnitDefs)


end
function statSpam()
while true do
	Sleep(3000)
	stats("boolFullGrown", boolFullGrown,
		   "boolInside", boolInside,
		   "boolJumpLoaded", boolJumpLoaded,
		   "boolPotencyRestored", boolPotencyRestored		   
		)


end

end
function script.Create()
	resetSwiftspear()
 
    StartThread(growUP)
    StartThread(idleSound)
    StartThread(jumpReloader)
    StartThread(potencyReloader)
	StartThread(polygAmour)
    StartThread(hugToDeath)
end

function script.AimFromWeapon3()
    return aimspot
end

function script.QueryWeapon3()
    return aimspot
end


function growUP()
	Sleep(growUpTime)
	boolFullGrown=true
end

function script.AimWeapon3(heading, pitch)

	return boolFullGrown == false and boolInside== false
end

boolInside= false
faceFuckVictim= nil
function faceFuck(faceFoock)
	if boolInside== false then
	faceFuckVictim= faceFoock
	boolInside= true	
	end
end

function hugToDeath()
	local spGetUnitIsDead = Spring.GetUnitIsDead
	
	while boolFullGrown==false do
		if boolInside==true then
			
			removeFromWorld(unitID,0,-90,0)
				
			while not spGetUnitIsDead(faceFuckVictim) do		
				hp=Spring.GetUnitHealth(faceFuckVictim)
				if not hp or  hp -faceDamagePerSecond <=0 then 
					break 
				else
					Spring.SetUnitHealth(faceFuckVictim,hp  - faceDamagePerSecond)
					myHP= Spring.GetUnitHealth(unitID)
					Spring.SetUnitHealth(unitID,myHP  + math.ceil(faceDamagePerSecond/2))
				end
				Spring.AddUnitImpulse(faceFuckVictim,math.random(-1,1),math.random(0,1), math.random(-1,1))
				Sleep(1000)				
			end
			
			rx,ry,rz= Spring.GetUnitPosition(faceFuckVictim)
			Spring.DestroyUnit(faceFuckVictim,false,true)
			returnToWorld(unitID,rx,ry,rz)
			boolInside=false
		end
		
	Sleep(50)
	end
end

