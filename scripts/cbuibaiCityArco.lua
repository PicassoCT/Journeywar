--include "AniMatrix3d.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

include "jVitalFunctions.lua"
include "createCorpse.lua"
--Alarm SystemPieces
TheNews = piece "spinTheNews"
AlarmOne = {}
AlarmTwo = {}
AlarmThree = {}
Alarm1 = piece "Alarm1"
AlarmOne[1] = Alarm1
Alarm2 = piece "Alarm2"
AlarmTwo[1] = Alarm2
arco2 = piece "arco2"
arco3 = piece "arco3"

for i = 1, 4, 1 do
    stringOfStrings = "Alarm2Fly" .. i
    AlarmTwo[i + 1] = piece(stringOfStrings)
end

AlarmThree[1] = piece "Alarm3"
AlarmThree[2] = piece "Alarm3Arm"
AlarmThree[3] = piece "Alarm3Arm2"
AlarmThree[4] = piece "Alarm3Flag2"
AlarmThree[5] = piece "Alarm3Flag1"
numberOfActors =15
for i = 0, 9, 1 do
    stringII = "Alarm3Fla" .. i
    AlarmThree[i + 6] = piece(stringII)
end

flagTable1 = {}
for i = 5, 9, 1 do
    stringII = "Alarm3Fla" .. i
    flagTable1[i - 4] = piece(stringII)
end
flagTable2 = {}
for i = 0, 4, 1 do
    stringII = "Alarm3Fla" .. i
    flagTable2[i] = piece(stringII)
end
--Globallos
--General Public License goes in all fields
testCenter = piece "testCenter"

-----------------------------------------------------------------------------------------------------------------------------------------------
function randomFlyBySound()
    while (true) do

        Spring.PlaySoundFile("sounds/cbuibaiarc/buibaiarc.wav")
        Sleep(5000)

        randSlept = math.random(0, 6000)
        Sleep(randSlept)
    end
end





--List of emitpieces
emitArray = {}

for i = 1, 63, 1 do
    subfolder = {}

    for b = 1, 4, 1 do
        --Spring.Echo(b)
        subfolder[b] = {}
        emitString = "flameEmit" .. i
        local emitpiece = emitString .. b
        subfolder[b] = piece(emitpiece)
    end
    table.insert(emitArray, i, subfolder)
end

buibaicity = piece "buibaicity"

flameEmit11 = piece "flameEmit11"
flameEmit12 = piece "flameEmit12"
flameEmit13 = piece "flameEmit13"
flameEmit14 = piece "flameEmit14"
--List of Fire Related Variables
local hp2reducePerSecond = 5
local boolBurning = false
local boolUnitRepaired = false
local nrOfFires = 0
maxNrOfFires = 63

SIG_BURN = 2


currentHitPoints = Spring.GetUnitHealth(unitID)
hitPointsASecondAgo = currentHitPoints
startHitpoints = Spring.GetUnitHealth(unitID)

--Economics
totalEnergyConsumed = 0
totalMetallConsumed = 0
insuranceRate = 1.5
-- oh, noes doing insurrance math for a game.
--so we have a total of startHitpoints and want to return the stored Values*insuranceRate
--so 
nrOfSteps = startHitpoints / hp2reducePerSecond
returnOfInvestmentE = 0
returnOfInvestmentM = 0
function getRetE()
    returnOfInvestmentE = (totalEnergyConsumed * insuranceRate) / nrOfSteps
    return returnOfInvestmentE
end

function getRetM()
    returnOfInvestmentM = (totalMetallConsumed * insuranceRate) / nrOfSteps
    return returnOfInvestmentM
end



energyConsumedPerSecond = 140


teamId = Spring.GetUnitTeam(unitID)
-- the 3d animatrix array
carArray = {}
--function checks whos team the last attacker was on
attackerOfOld = -1
boolLastDecision = false
function lastAttackerEnemyTeam()
    attacId = Spring.GetUnitLastAttacker(unitID)
    if attacId == nil then
        return false
    end

    attackerTeamId = Spring.GetUnitTeam(attacId)
    assert(attackerTeamId)
    if attackerTeamId == teamId then
        return false
    else
        return true
    end
end

--function:really.. you need a explanation.. fuckin read the title
function getHealth()
    return Spring.GetUnitHealth(unitID)
end

--turns all given firepoints to the winDirX
function turnAllthePoints(x, z)
    x = (x % 100) * 0.25
    z = (z % 100) * 0.25
    target = (table.getn(emitArray)) % 4
    for i = 1, target, 1 do
        dada = x + math.random(-4, 4)

        Turn((emitArray[i][1]), x_axis, math.rad(dada), 0.2)
        dodo = z + math.random(-3, 3)
        Turn((emitArray[i][1]), z_axis, math.rad(dodo), 0.2)
    end
end

--func: calcs how many fires show up
function howManyFires()
    -- testExample: 1400 /2500=0.4 *40 =10 Fire
    reSaltoMortale = math.floor(((startHitpoints - currentHitPoints) / startHitpoints) * maxNrOfFires)
    if reSaltoMortale >= 64 then
        reSaltoMortale = 63
    end
    return reSaltoMortale
end

--function: Increments the given Variable


--function: displays the damage to the Arcology based upon its health Stat
local durchLaufErhitzer = 0
function fireAndFlames()


    while (true) do
        if durchLaufErhitzer == 3 then
            currentHitPoints = getHealth()
            nrOfFires = howManyFires()
            durchLaufErhitzer = 0
        end
        durchLaufErhitzer = durchLaufErhitzer + 1

        --activates particlespawn over a 3D point table (every point has three subpoints-- knows three diffrent levels of fire.. smoldering.. outburst.. lichterloh
        if nrOfFires ~= 0 then
            dirX, dirY, dirZ, strength, normDirX, normDirY, normDirZ = Spring.GetWind()

            winDirX = dirX * strength
            winDirZ = dirZ * strength

            turnAllthePoints(winDirX, winDirZ)
            --Spring.Echo("NrOfFires:",nrOfFires)
            for i = 1, nrOfFires, 1 do
                EmitSfx(emitArray[i][1], 1025)
                EmitSfx(emitArray[i][2], 1026)
                EmitSfx(emitArray[i][3], 1027)
                EmitSfx(emitArray[i][4], 1028)
            end
        end


        Sleep(256)
    end
end


function reWardProcess()
    SetSignalMask(SIG_REWARD)
    returnOfInvestmentM = getRetM()
    returnOfInvestmentE = getRetE()
    while (true) do


        Spring.AddTeamResource(teamId, "metal", returnOfInvestmentM)
        Spring.AddTeamResource(teamId, "energy", returnOfInvestmentE)






        Sleep(1000)
    end
end

function burnDownAnimations()
    Spin(TheNews, y_axis, 0.42, 0.03)
    Spin(AlarmTwo[3], x_axis, 0.52, 0.03)
    Spin(AlarmTwo[5], x_axis, 0.32, 0.03)
    Spin(AlarmTwo[2], z_axis, 0.32, 0.03)
    Spin(AlarmTwo[4], z_axis, 0.32, 0.03)
    while (true) do
        x = math.random(-60, 14)
        Turn(AlarmThree[2], z_axis, math.rad(x * -1), 6)
        Turn(AlarmThree[3], z_axis, math.rad(x), 5)
        WaitForTurn(AlarmThree[2], z_axis)
        WaitForTurn(AlarmThree[1], z_axis)
        Turn(AlarmThree[4], y_axis, math.rad(0), 28)
        Turn(AlarmThree[5], y_axis, math.rad(0), 28)
        WaitForTurn(AlarmThree[4], y_axis)
        WaitForTurn(AlarmThree[5], y_axis)
        Turn(AlarmThree[4], x_axis, math.rad(-45), 3)
        Turn(AlarmThree[5], x_axis, math.rad(-45), 3)
        ripple(flagTable1, 17, "x_axis", 1, 3, true, 0)
        ripple(flagTable2, 14, "x_axis", 1, 3, true, 0)
        WaitForTurn(AlarmThree[4], x_axis)
        WaitForTurn(AlarmThree[5], x_axis)
        Turn(AlarmThree[4], x_axis, math.rad(45), 3)
        Turn(AlarmThree[5], x_axis, math.rad(45), 3)
        Turn(AlarmThree[4], y_axis, math.rad(180), 28)
        Turn(AlarmThree[5], y_axis, math.rad(180), 28)
        WaitForTurn(AlarmThree[4], y_axis)
        WaitForTurn(AlarmThree[5], y_axis)
        WaitForTurn(AlarmThree[4], x_axis)
        WaitForTurn(AlarmThree[5], x_axis)
        Turn(AlarmThree[2], z_axis, math.rad(0), 5.5)
        Turn(AlarmThree[3], z_axis, math.rad(0), 4.2)
        WaitForTurn(AlarmThree[2], z_axis)
        WaitForTurn(AlarmThree[1], z_axis)
    end
end

function burnDown()
    SetSignalMask(SIG_BURN)


    StartThread(reWardProcess)
    StartThread(fireAndFlames)
    StartThread(burnDownAnimations)
    modulu3 = 1
    while (boolBurning == true) do
        if modulu3 == 3 then
            modulu3 = 0

            --Hide all Stages
            for i = 1, table.getn(AlarmOne), 1 do
                Hide(AlarmOne[i])
            end
            for i = 1, table.getn(AlarmTwo), 1 do
                Hide(AlarmTwo[i])
            end
            for i = 1, table.getn(AlarmThree), 1 do
                Hide(AlarmThree[i])
            end
            x = math.random(0, 2)
            if x == 0 then
                for i = 1, table.getn(AlarmOne), 1 do
                    Show(AlarmOne[i])
                end
            elseif x == 1 then
                for i = 1, table.getn(AlarmTwo), 1 do
                    Show(AlarmTwo[i])
                end
            else
                for i = 1, table.getn(AlarmThree), 1 do
                    Show(AlarmThree[i])
                end
            end
        end
        modulu3 = modulu3 + 1
        health = currentHitPoints - hp2reducePerSecond * 2
        Spring.SetUnitHealth(unitID, health)

        Sleep(2000)
    end
end

function hideThemAll()
    for i = 1, table.getn(AlarmOne), 1 do
        Hide(AlarmOne[i])
    end
    for i = 1, table.getn(AlarmTwo), 1 do
        Hide(AlarmTwo[i])
    end
    for i = 1, table.getn(AlarmThree), 1 do
        Hide(AlarmThree[i])
    end
end


function healthCheck()
    while (true) do
        --update Health
        currentHitPoints = Spring.GetUnitHealth(unitID)

        --if unit doesent burn
        if boolBurning == false then
            --substract costs

            boolEnergyUsed = Spring.UseUnitResource(unitID, "e", energyConsumedPerSecond)

            if boolEnergyUsed == true then
                totalEnergyConsumed = totalEnergyConsumed + energyConsumedPerSecond
            else
                totalEnergyConsumed = totalEnergyConsumed - energyConsumedPerSecond
            end

        

            --if currentHitPoints has decreased --> Start a burning Thread
            if currentHitPoints < hitPointsASecondAgo and lastAttackerEnemyTeam() == true then
                boolBurning = true
                Signal(SIG_BURN)
                StartThread(burnDown)
            end




        else
            --if unit is burning

            if currentHitPoints > hitPointsASecondAgo then
                --case baitBuilding gets repaired -- burning stops
                Signal(SIG_BURN)
                boolBurning = false
                hideThemAll()
            end
        end
        hitPointsASecondAgo = currentHitPoints
        Sleep(1000)
    end
end

function SideEffects()
    if not GG.BuiLuxUpgrade then GG.BuiLuxUpgrade = {} end

    IdTable = { [UnitDefNames["cbuilux"].id] = true }
    while true do
        --get builux nearby
        x, y, z = Spring.GetUnitPosition(unitID)
        T = getAllInCircle(x, z, 512, unitID)
        T = getUnitsOfTypeInT(T, IdTable)
		process(T,
		function (id)
            GG.BuiLuxUpgrade[id] = true
		end
		)
		   

        Sleep(1000)
    end
end



function script.Create()
    StartThread(randomFlyBySound)
    --<buildanimationscript>
    x, y, z = Spring.GetUnitPosition(unitID)
    teamID = Spring.GetUnitTeam(unitID)
	
	buildIngs={arco2,arco3,buibaicity}
	hideT(buildIngs)
	index= math.random(1,#buildIngs)
	Show(buildIngs[index])


    if GG.UnitsToSpawn then
        GG.UnitsToSpawn:PushCreateUnit("cbuildanimation", x, y, z, 0, teamID)
        --if nil ~= Spring.CreateUnit("cbuildanimation",x,y,z,0,teamID)
        -- then Spring.Echo ("GeoHive::Success")
    end

    --</buildanimationscript>
	
    StartThread(healthCheck)
	dramatisPersona3d= initFlyingCars(15)
    StartThread(littleFlyingCars, 15,dramatisPersona3d)
    for i = 1, table.getn(AlarmOne), 1 do
        Hide(AlarmOne[i])
    end
    for i = 1, table.getn(AlarmTwo), 1 do
        Hide(AlarmTwo[i])
    end
    for i = 1, table.getn(AlarmThree), 1 do
        Hide(AlarmThree[i])
    end

    StartThread(SideEffects)
end


function script.Killed(recentDamage, maxHealth)
    for i = 1, 63, 1 do
        EmitSfx(emitArray[i][1], 1025)
    end
    Sleep(400)
    for i = 1, 63, 1 do
        EmitSfx(emitArray[i][1], 1025)
    end
    Sleep(400)

    for i = 1, 63, 1 do
        EmitSfx(emitArray[i][1], 1025)
        EmitSfx(emitArray[i][2], 1026)
    end

    Sleep(300)
    x = 63
    while x > 0 do
        for i = 1, 63, 1 do
            EmitSfx(emitArray[i][1], 1025)
            EmitSfx(emitArray[i][2], 1026)
            EmitSfx(emitArray[i][3], 1027)
            EmitSfx(emitArray[i][4], 1028)
        end
        Sleep(250)
        x = x - 1
    end
    for i = 1, numberOfActors, 1 do
        randYSpin = math.random(2, 7)/10
        randZSpin = math.random(2, 7)/10
        Spin(dramatisPersona3d[i][2], y_axis, math.rad(randYSpin), 0.1)
        Spin(dramatisPersona3d[i][2], z_axis, math.rad(randZSpin), 0.01)
        Move(dramatisPersona3d[i][2], y_axis, -140, 0.7)
    end

    quiteSomeTime = 17
    for x = 0, quiteSomeTime, 1 do
        for i = 1, numberOfActors, 1 do
            EmitSfx(dramatisPersona3d[15][2], 1025)
            EmitSfx(dramatisPersona3d[15][2], 1027)
        end
        Sleep(150)
    end
    for i = 1, numberOfActors, 1 do
        randy = math.random(100, 350)
        Explode(dramatisPersona3d[i][2], SFX.FIRE + SFX.SMOKE + SFX.FALL + SFX.EXPLODE_ON_HIT)
        Hide(dramatisPersona3d[i][2])
        Sleep(randy)
    end


    Sleep(100)
    EmitSfx(buibaicity, 1024)
    Move(buibaicity, y_axis, -50, 7)
    EmitSfx(buibaicity, 1024)
    Sleep(800)
    Hide(buibaicity)

    createCorpseCBuilding(unitID, recentDamage)
    return 0
end



--------BUILDING---------