include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"
include "lib_jw.lua"

ResetTime = 8000
function delayedReset()
    boolFlowDirectionTowardsTeam = false
    Signal(SIG_RESET)
    SetSignalMask(SIG_RESET)
    Sleep(ResetTime)
    boolFlowDirectionTowardsTeam = true
end

totalDamage = 0

function script.HitByWeapon(x, z, weaponDefID, damage)
    totalDamage = damage + totalDamage
    if totalDamage > 320 then
        totalDamage = 0
        StartThread(delayedReset)
        StartThread(portalStormWave, unitID)
    end
end

rootspin1 = piece("rootspin1")
rootspin2 = piece("rootspin2")

SpinT = {}
for i = 1, 23 do
    name = "Spin" .. i
    SpinT[#SpinT + 1] = piece(name)
end


GMAN = piece("GMAN")
standing = piece("standing")
face = piece("face")
Root = {}
for i = 1, 3 do
    name = "Root" .. i
    Root[#Root + 1] = piece(name)
end
hideT(SpinT)
hideT(Root)
Hide(GMAN)
Hide(standing)
Hide(face)

SIG_RESET = 16

local INFLUENCERADIUS = 120
local NUMBEROFPIECES = 56
piecesTable = {}
center = piece("center")
piecesTable[#piecesTable + 1] = center
emitcenter = piece("emitcenter")

piecesTable[#piecesTable + 1] = emitcenter
emitor = piece("emitor")

piecesTable[#piecesTable + 1] = emitor

dice = piece("dice")

piecesTable[#piecesTable + 1] = dice

function restartRoots()
    resetT(Root)
    for i = 1, #Root do

        Spin(Root[i], y_axis, math.rad(math.random(10, 64)), 0.5)
        Show(Root[i])
    end

    for i = 1, #SpinT do
        Turn(SpinT[i], z_axis, math.rad(-90), 0, true)
        Turn(SpinT[i], z_axis, math.rad(0), 0.3)
        Show(SpinT[i])
		val=(2^math.random(2,9)) * -12
		speed= math.random(5,10)/10
        Spin(SpinT[i], y_axis, math.rad(val),speed)
    end
end

function dissapearRoots()
    for i = 1, #Root do
        Move(Root[i], y_axis, -30, 0)
    end
    WaitForMove(Root[#Root], y_axis)
    hideT(Root)
    for i = 1, #SpinT do
        Turn(SpinT[i], z_axis, math.rad(-90), 3)
        Turn(SpinT[i], z_axis, math.rad(0), 3)
        StopSpin(SpinT[i], y_axis, 0.5)
    end
    WaitForTurn(SpinT[#SpinT], z_axis)
    hideT(SpinT)
end

x, y, z = 0, 0, 0
UnitPieceTable = {}
function updateUnitsPosition()
    for pieceN, id in pairs(UnitPieceTable) do
        x, y, z = Spring.GetUnitPiecePosDir(unitID, pieceN)
        if Spring.ValidUnitID(id) and Spring.GetUnitIsDead(id) == false then
            Spring.MoveCtrl.SetPosition(id, x, y, z)
        end
    end
end

--CONST
count = 0
it = 2
LowerLimit = 1
up = 1
immunity = 0


function resConst()
    count = 0
    it = 2
    LowerLimit = 1
    up = 1
    immunity = 0
end



function collectExpFromTeamsToUnit(unitID, Range, amount, filterTeams, boolNegateFilter)
    x, y, z = Spring.GetUnitPosition(unitID)

    exP = Spring.GetUnitExperience(unitID)
    Range = math.max(minRange, maxRange * (exP / maxStore))
    teamid = Spring.GetUnitTeam(unitID)
    Tuid = getAllInCircle(x, z, Range)


    if Tuid then
        Tuid = process(Tuid,
            function(id)
                tid = Spring.GetUnitTeam(id)
                if boolNegateFilter == true then
                    if tid and not filterTeams[tid] then
                        return id
                    end
                else
                    if tid and filterTeams[tid] then
                        return id
                    end
                end
            end,
            function(id)
                xP = Spring.GetUnitExperience(id)
                if xP then
                    if xP > amount then
                        Spring.SetUnitExperience(id, xP - amount)
                        currXP = Spring.GetUnitExperience(id)
                        Spring.SetUnitExperience(unitID, currXP + amount)
                        return id
                    end
                end
            end)
    end
end

exP = Spring.GetUnitExperience(unitID)
function giveExpFromUnitToTeam(unitID, Range, filterTeams)
    teamid = Spring.GetUnitTeam(unitID)
    x, y, z = Spring.GetUnitPosition(unitID)

    exP = Spring.GetUnitExperience(unitID)
    if not exP then return end
   
    if exP > 0 then -- reDistribute


        TeamToGive = getAllInCircle(x, z, Range)
        TeamToGive = process(TeamToGive,
            function(id)
                tid = Spring.GetUnitTeam(id)
                if tid and not filterTeams[tid] then
                    return id
                end
            end)

        --Distribute along own Team
        if TeamToGive then
            amount = exP / #Tuid
            for i = 1, #Tuid do
                currXP = Spring.GetUnitExperience(Tuid[i])
                Spring.SetUnitExperience(Tuid[i], currXP + amount)
                currXP = Spring.GetUnitExperience(unitID)
                Spring.SetUnitExperience(unitID, currXP - amount)
            end
        end
    end
end

--Range depends upon Exp
minRange = 128
maxRange = 1024
minLeachQuote = 0.06125
maxLeachQuote = 0.25
maxStore = 4
boolFlowDirectionTowardsTeam = true

function leachExpLoop()
  local tid = 0
	repeat
		tid = Spring.GetUnitTeam(unitID)
	  Sleep(100)
	until  tid ~= nil
	  
	


    while true do

        Range = math.max(minRange, maxRange * (Spring.GetUnitExperience(unitID) / maxStore))
        amount = maxLeachQuote
			teamIDTable= 	{ }
			teamIDTable[tid] = true
			
        if boolFlowDirectionTowardsTeam == true then	
			
            collectExpFromTeamsToUnit(
					unitID, 
					Range, 
					amount,
					teamIDTable
					)
            giveExpFromUnitToTeam( Range, amount, teamIDTable)

        else
            collectExpFromTeamsToUnit(unitID, Range, amount, teamIDTable)
            giveExpFromUnitToTeam( Range, amount, teamIDTable)
        end

        Sleep(1000)
    end
end

--On beeing Hit, loose Exp proportional to hp

--Weapon 	

function script.Create()
    Hide(fireFx)

    StartThread(leachExpLoop)
    StartThread(animationLoop)
    --StartThread(upYourGame)
end





function script.Killed(recentDamage, _)

   createCorpseJUnitGeneric(recentDamage)
    return 1
end




boolMoving = false
function script.StartMoving()
    boolMoving = true
end

function script.StopMoving()
    boolMoving = false
end

Emitor = piece("emitor")
emitcenter = piece("emitcenter")

boolActive = true






boolActive = false
function script.Activate()
    boolActive = true
    return 1
end

function script.Deactivate()
    boolActive = false
    return 0
end


SFXLENGHT = 50




posToCont = {}

SIG_TREE = 4

function animationLoop()

    --Localisations
    --test
    restartRoots()

    while true do

        --Move State
        if boolMoving == true then
            Hide(standing)
            Hide(face)

            if math.random(0, 1) == 1 then
                StartThread(dissapearRoots)
                diceAnimation()
            else
                while boolMoving == true do
                    Show(GMAN)
                    Spin(GMAN, y_axis, math.rad(math.random(-42, 42)), 0)
                    Sleep(50)
                end
            end
        end

        dissapearRoots()
        Hide(dice)
        Hide(GMAN)
        sudoRootOnGroot()

        while (boolMoving == false) do
            Show(standing)
            Show(face)
            Spin(face, y_axis, math.rad(42), 3)
            Spin(standing, y_axis, math.rad(-42), 3)
            hideT(Root)
            Hide(GMAN)
            Sleep(100)
        end
    end
end

function diceAnimation()
    StartVal = 128
    HalfWay = 32

    local CopyVal = StartVal
    local speed = 256
    Show(dice)
    while boolMoving == true do

        Sleep(100)
        Turn(dice, x_axis, math.rad(math.ceil(math.random(-3, 3)) * 90), 9)
        Turn(dice, y_axis, math.rad(math.ceil(math.random(-3, 3)) * 90), 9)
        Turn(dice, z_axis, math.rad(math.ceil(math.random(-3, 3)) * 90), 9)
        Move(dice, y_axis, CopyVal * 0.75, speed)
        WaitForMove(dice, y_axis)
        Move(dice, y_axis, CopyVal * 0.85, speed * 0.75)
        WaitForMove(dice, y_axis)
        Move(dice, y_axis, CopyVal, speed * 0.5)
        WaitForMove(dice, y_axis)
        WaitForTurns(dice)

        tP(dice, 0, 0, 0, 9)
        Move(dice, y_axis, CopyVal * 0.85, speed * 0.5)
        WaitForMove(dice, y_axis)
        Move(dice, y_axis, CopyVal * 0.75, speed * 0.75)
        WaitForMove(dice, y_axis)
        Move(dice, y_axis, 0, speed)
        WaitForMove(dice, y_axis)
        CopyVal = math.random(CopyVal / 1.25, CopyVal)
        if CopyVal <= HalfWay then CopyVal = StartVal end
    end
end

function sudoRootOnGroot()
    showT(Root)
    showT(SpinT)
    Move(Root[1], x_axis, math.rad(math.random(-26, 26), 0.3))
    Move(Root[2], x_axis, math.rad(math.random(-26, 26), 0.3))
    Spin(rootspin1, y_axis, math.rad(math.random(-42, 42)), 0.3)
    Spin(rootspin2, y_axis, math.rad(math.random(-42, 42)), 0.3)

    for i = 1, #SpinT do
		val= (2^math.random(6, 9))*-1
		Spin(SpinT[i],y_axis,math.rad(val),0)
        if maRa() == true then
            Move(SpinT[i], y_axis, math.rad(math.random(0, 55) * 2), 4.5)
        end
    end
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return ArmR
end

function script.QueryWeapon1()
    return Head
end



function script.AimWeapon1(Heading, pitch)

		return true

end


function script.FireWeapon1()

    return true
end
-- a bubble where you can rewind time by sacrificing a unit