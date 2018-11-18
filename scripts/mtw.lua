include "createCorpse.lua"
--Define the wheel pieces

--Define the pieces of the weapon
local spawn = piece "spawn"
local mtwteletur = piece "mtwteletur"
local turret = piece "mtwmgsmoke"
local flare01 = piece "flare01"
local flare02 = piece "flare02"
local flare03 = piece "flare03"
local flare = piece "flare"
--define other pieces
local body = piece "cspc"
local mtwchain = piece "mtwchain"
local mtwchain2 = piece "mtwchain2"
local mtwthemwhe = piece "mtwthemwhe"
local sfbucky = piece "sfbucky"
local mtwsfxball = piece "mtwsfxball"

local SIG_WIP = 2
local boolCanBuild = true
local treadEnder = false
portal = {}
for i = 1, 7, 1 do
    portal[i] = {}
    portalSX = "portal" .. i
    portal[i] = piece(portalSX)
end


teamID = Spring.GetUnitTeam(unitID)
poX, poY, poZ = Spring.GetUnitPosition(unitID)
function disDance()
    fx, fy, fz = Spring.GetUnitPosition(unitID)
    return math.sqrt((fx - poX) ^ 2 + (fy - poY) ^ 2 + (fz - poZ) ^ 2) > 1600
end

function script.Create()
    for i = 1, 7, 1 do
        Hide(portal[i])
    end


    Spring.UnitScript.Hide(flare)
    Spring.UnitScript.Hide(flare01)
    Spring.UnitScript.Hide(flare02)
    Spring.UnitScript.Hide(flare03)
    Spin(sfbucky, y_axis, 2.2, 0.1)
    Spin(sfbucky, z_axis, 1.9, 0.1)
    Spin(mtwsfxball, z_axis, 0.5, 0.1)
    Spin(mtwsfxball, x_axis, 0.5, 0.1)

    StartThread(unitGenAndStore)
end



local function workInProgress()





    SetSignalMask(SIG_WIP)
    while boolCanBuild == true do

        local actualHealth = Spring.GetUnitHealth(unitID)
        actualHealth = actualHealth - 4
        -------- Spring.Echo(actualHealth)
        Spring.SetUnitHealth(unitID, actualHealth)
        Sleep(250)
        if actualHealth < 200 then

            SetUnitValue(COB.INBUILDSTANCE, 0)

            boolCanBuild = false
            Signal(SIG_WIP)
        end
    end
end

--- -driving animation
-- http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units



--- -aimining & fire weapon
function script.AimFromWeapon1()
    return turret
end


function script.QueryWeapon1()
    return flare
end

Spring.SetUnitNanoPieces(unitID, { mtwteletur })
boolTurretAimed = true
function script.AimWeapon1(heading, pitch)

    --aiming animation: instantly turn the gun towards the enemy
    Turn(turret, y_axis, heading, 25)
    WaitForTurn(turret, y_axis)

    return true
end

function flareThread()
    Spring.PlaySoundFile("sounds/bgmtw/gattling.wav")
    for i = 1, 17, 1 do
        EmitSfx(flare, 1025)
        Sleep(97)
    end
end

function script.FireWeapon1()
    StartThread(flareThread)
    return true
end

function script.Killed(recentDamage, maxHealth)

    Explode(mtwchain, SFX.FIRE)
    Explode(mtwchain2, SFX.FIRE)
    Explode(mtwteletur, SFX.FIRE)
    Explode(mtwthemwhe, SFX.FIRE)
    Explode(body, SFX.SHATTER)

    createCorpseCUnitSmall(recentDamage)
    ------ Spring.Echo ("He is dead, Jim!")
end

--Building

boolShiver = false
function shiver()
    while (boolShiver == true) do
        lenkAus = math.random(-2, 2)
        deCidere = math.random(0, 2)
        for i = 1, 7, 1 do

            if deCidere == 0 then
                Turn(portal[i], x_axis, math.rad(lenkAus), 3)

            elseif deCidere == 1 then
                Turn(portal[i], y_axis, math.rad(lenkAus), 3)

            else
                Turn(portal[i], z_axis, math.rad(lenkAus), 3)
            end
        end



        Sleep(300)
    end
end

function showPortal()
    boolShiver = true
    StartThread(shiver)
    xOrY = math.random(0, 1)
    ausLenkung = math.random(-3, 3)
    for i = 1, 7, 1 do
        Show(portal[i])
        if xOrY == 0 then
            Move(portal[i], x_axis, ausLenkung, 2)
        else
            Move(portal[i], y_axis, ausLenkung, 3)
        end
        Sleep(110)
    end

    for i = 1, 6, 1 do
        Hide(portal[i])
        Sleep(10)
    end
    Sleep(300)
    Hide(portal[7])
    boolShiver = false
end

function script.StopBuilding()
    Turn(mtwteletur, y_axis, math.rad(0), 12)

    SetUnitValue(COB.INBUILDSTANCE, 0)
    Signal(SIG_WIP)
    WaitForTurn(mtwteletur, y_axis)
end

function script.StartBuilding(heading, pitch)



    if boolCanBuild == true then
        Signal(SIG_WIP)
        Turn(mtwteletur, y_axis, heading, 15)
        WaitForTurn(mtwteletur, y_axis)
        SetUnitValue(COB.INBUILDSTANCE, 1)
        StartThread(workInProgress)
    end


    if boolCanBuild == false then
        Health = Spring.GetUnitHealth(unitID)
        if Health > 300 then
            boolCanBuild = true
            Signal(SIG_WIP)
            Turn(mtwteletur, y_axis, heading, 15)
            WaitForTurn(mtwteletur, y_axis)
            SetUnitValue(COB.INBUILDSTANCE, 1)
            StartThread(workInProgress)
        end
        SetUnitValue(COB.INBUILDSTANCE, 0)

        -------- Spring.Echo("Not enough Hitpoints to deploy!")
    end
end

------------------------------------------------------------------------------------------------------------------------
local maxUnits = 6
local unitsStored = 0
local emptySlots = 6
passengerList = {}
deployedIDList = {}
deployedNr = 0


function script.StartMoving()
    Turn(mtwteletur, y_axis, math.rad(0), 4)
end

function script.StopMoving()
end



function script.AimFromWeapon2()
    return mtwteletur
end


function script.AimWeapon2(heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy
    Turn(mtwteletur, y_axis, heading, 5)
    WaitForTurn(turret, y_axis)
    Sleep(200)

    if unitsStored > 0 then
        --direction of the tele(harry)po(r)terturret
        headingPercentage = heading / 100
        heading = heading + headingPercentage * unitsStored
        if heading > 16000 then
            heading = heading * -1
        end

        Turn(mtwteletur, y_axis, heading, 7)
        if unitsStored > 3 then
            move = ((unitsStored - 3) * 15)
        else
            move = unitsStored * 15
        end

        Move(spawn, z_axis, move, 0)
        WaitForTurn(turret, y_axis)
        WaitForMove(spawn, z_axis)

        spawnAUnit()
        Sleep(100)
    else
        Move(spawn, z_axis, 0, 0)
        --do nothing
    end

    return false
end





local boolBuildBG = true
function script.Activate()
    boolBuildBG = true
    --- -Spring.Echo("MTW:activate")
    -- Sleep(50)
    return 1
end

function script.Deactivate()
    boolBuildBG = false
    --- -Spring.Echo("MTW:Deactivate")
    -- Sleep(50)
    return 0
end

function spawnAUnit()
    unitX, unitY, unitZ = Spring.GetUnitPosition(unitID)
    SemitX, SemitY, SemitZ = Spring.GetUnitPiecePosition(unitID, spawn)
    showPortal()

    if passengerList[1] == "BG" then
        numBer = math.random(1, 3)
        if numBer == 1 then
            Xstring = "sounds/bgmtw/teleport1.wav"
        elseif numBer == 2 then
            Xstring = "sounds/bgmtw/teleport2.wav"
        else
            Xstring = "sounds/bgmtw/teleport3.wav"
        end
        Spring.PlaySoundFile(Xstring)
        sx, sy, sz, _, _, _ = Spring.GetUnitPiecePosDir(unitID, spawn)
        Spring.SpawnCEG("portalstorm", sx, sy, sz, 0, 1, 0, 50, 0)
        --spawn a BG
        table.remove(passengerList, 1)
        if disDance() == true then
            deployedID = Spring.CreateUnit("cit", sx, sy, sz, 0, teamID)
        else
				if maRa()==true then
					deployedID = Spring.CreateUnit("cit2", sx, sy, sz, 0, teamID)
				else
				deployedID = Spring.CreateUnit("cit3", sx, sy, sz, 0, teamID)
				end
        end
        table.insert(deployedIDList, deployedID)
        unitsStored = unitsStored - 1
        deployedNr = deployedNr + 1

        Sleep(50)
        --add the Units Id to the deployedIDList

    elseif passengerList[1] == "CSS" then
        sx, sy, sz, _, _, _ = Spring.GetUnitPiecePosDir(unitID, spawn)
        Spring.SpawnCEG("portalstorm", sx, sy, sz, 0, 1, 0, 50, 0)
        deployedID = Spring.CreateUnit("css", sx, sy, sz, 0, teamID)
        table.insert(deployedIDList, deployedID)
        table.remove(passengerList, 1)
        unitsStored = unitsStored - 1
        deployedNr = deployedNr + 1
        Sleep(50)
    end

    if unitsStored == 0 then
        y = math.random(0, 2)
        if y == 0 then
            Spring.PlaySoundFile("sounds/bgmtw/bgmtw.wav")
        elseif y == 1 then
            Spring.PlaySoundFile("sounds/bgmtw/rand2.wav")
        elseif y == 2 then
            Spring.PlaySoundFile("sounds/bgmtw/rand3.wav")
        end
    end
end


function boolRessourcesBuildSoldier()

    currentLevel, storage, pull, income, expense, share, sent, received = Spring.GetTeamResources(teamID, "metal")
    ------ Spring.Echo(currentLevel)

    unitCost = UnitDefNames["cit"].metalCost


    if currentLevel > unitCost then
        return true
    else

        return false
    end
end

boolIntBuild = false

function boolRessourcesBuildCSS()
    currentLevel, storage, pull, income, expense, share, sent, received = Spring.GetTeamResources(teamID, "metal")

    unitCost = UnitDefNames["css"].metalCost

    if currentLevel > unitCost then
        --- -Spring.Echo("MTW:Returning true")
        return true
    else
        --- -Spring.Echo("MTW:Returning False")
        return false
    end
end

function updateProgressBar(status)
    orgString = "Contains: "
    passengerString = ""
	Description= "<Unit Producing Unit>"
    for i = 1, unitsStored, 1 do
        if passengerList[i] == "BG" then
            passengerString = passengerString .. " IT "
        else
            passengerString = passengerString .. "CSS "
        end
    end

    for i = 1, (maxUnits - unitsStored), 1 do
        passengerString = passengerString .. "- "
    end
    if boolIntBuild == true and status < 11 then
        passengerString = passengerString .. " Building: ["

        for i = 1, status, 1 do
            passengerString = passengerString .. "|"
        end
        passengerString = passengerString .. "]"

    elseif status == 11 then
        passengerString = passengerString .. " Build Completed"
    else
    end


    orgString = orgString .. passengerString..Description


    Spring.SetUnitTooltip(unitID, orgString)
end

function buildBG()
    boolIntBuild = true
    local currentLevel, storage, pull, income, expense, share, sent, received = Spring.GetTeamResources(teamID, "metal")
    ------ Spring.Echo(currentLevel)
    unitCost = UnitDefNames.bg.metalCost
    ------ Spring.Echo(unitCost)
    price = currentLevel - unitCost
    Spring.SetTeamResource(teamID, "m", price)
    for iB = 1, 10, 1 do
        updateProgressBar(iB)
        Sleep(1000)
    end
    unitsStored = unitsStored + 1
    emptySlots = emptySlots - 1
    passengerList[unitsStored] = "BG"
    updateProgressBar(11)
    boolIntBuild = false
    updateProgressBar(12)
end

function buildCSS()
    boolIntBuild = true
    local currentLevel, storage, pull, income, expense, share, sent, received = Spring.GetTeamResources(teamID, "metal")
    Sleep(10)
    ------ Spring.Echo("BuildingCss")
    unitCost = UnitDefNames["css"].metalCost
    price = currentLevel - unitCost
    Spring.SetTeamResource(teamID, "m", price)
    for iB = 1, 10, 1 do
        updateProgressBar(iB)
        Sleep(1000)
    end
    unitsStored = unitsStored + 1
    emptySlots = emptySlots - 1
    passengerList[unitsStored] = "CSS"
    updateProgressBar(11)
    boolIntBuild = false
    updateProgressBar(12)
end

function check4Lifesigns()
    for i = 1, deployedNr, 1 do
        if Spring.ValidUnitID(deployedIDList[i]) == true then

            --still alive
        else
            table.remove(deployedIDList, i)
            --Remove that unit from the deployed List and the Id-List
            deployedNr = deployedNr - 1
            --Decrease the deployedNr
            emptySlots = emptySlots + 1
            --Increase the emptySlots
        end
    end
end

function unitGenAndStore()
    while (true) do
        --what is the boolBuildB	--check if the boolIntBuild ==false if yes then
        if boolIntBuild == false and boolBuildBG == true then
            if emptySlots > 0 and boolRessourcesBuildSoldier() == true then
                --if there is a empty Slot and the Ressources are there

                StartThread(buildBG)

                --Start A Builder Thread
            end

        elseif boolIntBuild == false and boolBuildBG == false then
            --want to build CSS -if there is a empty Slot and the Ressources are there
            if emptySlots > 0 and boolRessourcesBuildCSS() == true then
                --check if the boolIntBuild ==false if yes then
                StartThread(buildCSS)
                --Start A Builder Thread
            end
        end




        check4Lifesigns()

        --Check the Lifesigns of the deployedIDList


        Sleep(350)
    end
end



function script.FireWeapon2()
    return true
end


function script.AimFromWeapon3()
    return turret
end


function script.AimWeapon3(heading, pitch)


    return boolTurretAimed
end


it = 1
function script.QueryWeapon3()
    return turret
end

function Weapon3Reload()
    Sleep(10000)
    boolTurretAimed = true
end

function script.FireWeapon3()
    boolTurretAimed = false
    StartThread(Weapon3Reload)
    return true
end