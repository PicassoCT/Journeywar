
include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_Build.lua"
--Define the pieces of the weapon

--define other pieces
local vort = piece "vort"
local vortarml = piece "vortarml"
local vDisChar1 = piece "vDisChar1"
local vortarmr = piece "vortarmr"

local vorthead = piece "vorthead02"
local vortlegupl = piece "vortlegupl"
local vortlfootl = piece "vortlfootl"
local vortlegupr = piece "vortlegupr"
local vortlfootr = piece "vortlfootr"
local boolFlipFlop = 1
SIG_WALK = 1 --signal for the walk animation thread
SIG_AIM = 2 --signal for the weapon aiming thread
SIG_IDLE = 4
SIG_WAVE = 8

local boolHasFired = false
function script.Create()
    Hide(vDisChar1)
    StartThread(TelePortationLoop)
end

function randomArmGesture()
	xRand = math.random(-67, 6)
        zRand = math.random(7, 43)
        zRandR = math.random(-43, 7)
        yRand = math.random(0, 12)
        randSpeed = math.random(2, 5)
        Turn(vortarmr, x_axis, math.rad(xRand), randSpeed)
        Turn(vortarmr, z_axis, math.rad(zRandR), randSpeed)
        Turn(vortarmr, y_axis, math.rad(yRand), randSpeed)
        xRand = math.random(-67, 6)
        zRand = math.random(7, 43)
        yRand = math.random(5, 22)
        randSpeed = math.random(2, 5)
        Turn(vortarml, x_axis, math.rad(xRand), randSpeed)
        Turn(vortarml, z_axis, math.rad(zRand), randSpeed)
        Turn(vortarml, y_axis, math.rad(yRand), randSpeed)
end

function breathIn()
tSyncIn(vort,9,0,0,600)
tSyncIn(vortlegupl,-9,0,0,600)
tSyncIn(vortlegupr,-9,0,0,600)

end
function breathOut()
tSyncIn(vort,0,0,0,600)
tSyncIn(vortlegupl,0,0,0,600)
tSyncIn(vortlegupr,0,0,0,600)


end

function idle()
    SetSignalMask(SIG_IDLE)
    Sleep(500)
    boolMove = false
    moduLater = 1
    while (true) do
		
        moduLater = moduLater + 1
        if moduLater % 4 == 0 then
            sleepRAnd = math.random(5000, 22000)
            Sleep(sleepRAnd)
            moduLater = math.random(-1, 3)
        else
            Sleep(500)
        end
		breathIn()
			randomArmGesture()
        Sleep(450)
		
        headTurnX = math.random(-5, 34)
        Turn(vorthead, x_axis, math.rad(headTurnX), 1.5)
        headTurnZ = math.random(-5, 5)
        Turn(vorthead, z_axis, math.rad(headTurnZ), 1.5)
        headTurnY = math.random(-12, 12)
        Turn(vorthead, y_axis, math.rad(headTurnY), 1.5)
        Sleep(150)
        y = math.random(0, 18)
        if y == 9 then
            Spring.PlaySoundFile("sounds/vort/vortIdle2.wav")
        end

        if y == 15 then
            Spring.PlaySoundFile("sounds/vort/vortIdle.wav")
        end
        throwDice = math.random(0, 150)
        if throwDice == 45 then
            local x, y, z = Spring.GetUnitPosition(unitID)
            local teamID = Spring.GetUnitTeam(unitID)
            Spring.CreateUnit("jFirePlace", x + 15, y, z + 15, 0, teamID)
        end
			randomArmGesture()
			breathOut()
        Sleep(600)
    end
end

local function walk()
    Signal(SIG_IDLE)


    SetSignalMask(SIG_WALK)
	leftStepTime =math.random(400,600)
	rightstepTime = math.random(400,600)
    leg_movespeed = 6
    while (true) do

        tSyncIn(vort, 10,7,0, leftStepTime)
        tSyncIn(vorthead, 16,0,0, leftStepTime)
        tSyncIn(vortarmr, -19,0,0, leftStepTime)
        tSyncIn(vortarml, 32,0,0, leftStepTime)
        tSyncIn(vortlegupl, -60,0,0, leftStepTime)
        tSyncIn(vortlfootl, 50,0,0, leftStepTime)

        --rechts hinten
		tSyncIn(vortlegupr, 24,0,0, leftStepTime)
		tSyncIn(vortlfootr, -34,0,0, leftStepTime)
       	WaitForTurns(vort,vorthead,vortarmr,vortarml,vortlegupl,vortlfootl,vortlfootr,vortlegupr)

        tSyncIn(vort, 5,-7,0, rightstepTime)
        tSyncIn(vorthead, -8,0,0, rightstepTime)
        tSyncIn(vortarmr, 32,0,0, rightstepTime)
        tSyncIn(vortarml, -19,0,0, rightstepTime)
        tSyncIn(vortlegupl, 24,0,0, rightstepTime)
        tSyncIn(vortlfootl, -34,0,0, rightstepTime)

        --rechts vorne
		tSyncIn(vortlegupr, -60,0,0, rightstepTime)
		tSyncIn(vortlfootr, 50,0,0, rightstepTime)
       	WaitForTurns(vort,vorthead,vortarmr,vortarml,vortlegupl,vortlfootl,vortlfootr,vortlegupr)

    end
end

--- -aimining & fire weapon
function script.AimFromWeapon1()
    return vDisChar1
end

function script.QueryWeapon1()


    return vDisChar1
end


function script.AimWeapon1(heading, pitch)
    if boolReloaded == false  then 
		return false 
	end
    Turn(vorthead, x_axis, pitch, 5)
    Turn(vort, y_axis, heading, 12)
    WaitForTurn(vort, y_axis)
	 Signal(SIG_WAVE)
    ax, ay, az = Spring.GetUnitPosition(unitID)
    Spring.SpawnCEG("vortcharge", ax, ay + 15, az, math.random(-100, 100)/100, math.random(80,100)/100, math.random(-100, 100)/100)
    for i = 1, 2, 1 do
        random = math.random(1, 5)
        if random == 1 then
            Spring.PlaySoundFile("sounds/vort/zap1.wav")
        elseif random == 2 then
            Spring.PlaySoundFile("sounds/vort/zap2.wav")
        elseif random == 3 then
            Spring.PlaySoundFile("sounds/vort/zap3.wav")
        elseif random == 4 then
            Spring.PlaySoundFile("sounds/vort/zap4.wav")
        elseif random == 5 then
            Spring.PlaySoundFile("sounds/vort/zap5.wav")
        elseif random == 6 then
            Spring.PlaySoundFile("sounds/vort/zap6.wav")
        else
            Spring.PlaySoundFile("sounds/vort/zap7.wav")
        end
        Sleep(550)
    end
    Sleep(550)
    Turn(vortarmr, x_axis, math.rad(-12), 3)
    Turn(vortarmr, y_axis, math.rad(-101), 23)
    Turn(vortarmr, z_axis, math.rad(75), 19)

    Turn(vortarml, x_axis, math.rad(-38), 3)
    Turn(vortarml, y_axis, math.rad(63), 21)
    Turn(vortarml, z_axis, math.rad(-53), 14)
    WaitForTurn(vortarmr, x_axis)
    WaitForTurn(vortarmr, y_axis)
    WaitForTurn(vortarmr, z_axis)
    WaitForTurn(vortarml, x_axis)
    WaitForTurn(vortarml, y_axis)
    WaitForTurn(vortarml, z_axis)
    Sleep(230)

    return true
end

boolReloaded = true
function reloader()
    boolReloaded = false
    Sleep(20000)
    boolReloaded = true
end


function script.FireWeapon1()
    StartThread(reloader)
    boolHasFired = true
    return true
end

function script.Killed(recentDamage, maxHealth)
    --legs_down()
end


local function legs_down()
    Signal(SIG_WALK)
    Turn(vortarmr, x_axis, math.rad(0), 3)
    Turn(vortarmr, y_axis, math.rad(0), 23)
    Turn(vortarmr, z_axis, math.rad(0), 19)

    Turn(vortarml, x_axis, math.rad(0), 3)
    Turn(vortarml, y_axis, math.rad(0), 21)
    Turn(vortarml, z_axis, math.rad(0), 14)

    Turn(vortlegupl, x_axis, math.rad(0), 3)
    Turn(vortlegupl, y_axis, math.rad(0), 23)
    Turn(vortlegupl, z_axis, math.rad(0), 19)

    Turn(vortlfootl, z_axis, math.rad(0), 19)
    Turn(vortlfootl, x_axis, math.rad(0), 3)
    Turn(vortlfootl, y_axis, math.rad(0), 23)

    Turn(vortlegupr, x_axis, math.rad(0), 3)
    Turn(vortlegupr, y_axis, math.rad(0), 21)
    Turn(vortlegupr, z_axis, math.rad(0), 14)

    Turn(vortlfootr, z_axis, math.rad(0), 19)
    Turn(vortlfootr, x_axis, math.rad(0), 3)
    Turn(vortlfootr, y_axis, math.rad(0), 23)
    randSpeed = math.random(2, 5)
    Turn(vortarmr, x_axis, math.rad(0), randSpeed)
    Turn(vortarmr, z_axis, math.rad(0), randSpeed)
    Turn(vortarmr, y_axis, math.rad(0), randSpeed)

    Turn(vortarml, x_axis, math.rad(0), randSpeed)
    Turn(vortarml, z_axis, math.rad(0), randSpeed)
    Turn(vortarml, y_axis, math.rad(0), randSpeed)
    Turn(vorthead, x_axis, math.rad(0), 1.5)

    Turn(vorthead, z_axis, math.rad(0), 1.5)

    Turn(vorthead, y_axis, math.rad(0), 1.5)
end

function script.StartMoving()
    boolMove = true
    if boolHasFired == true then
        Turn(vort, y_axis, math.rad(0), 34)
        Turn(vorthead, x_axis, math.rad(0), 5)

        Turn(vortarmr, x_axis, math.rad(0), 3)
        Turn(vortarmr, y_axis, math.rad(0), 23)
        Turn(vortarmr, z_axis, math.rad(0), 19)

        Turn(vortarml, x_axis, math.rad(0), 3)
        Turn(vortarml, y_axis, math.rad(0), 21)
        Turn(vortarml, z_axis, math.rad(0), 14)
        boolHasFired = false
    end


    Signal(SIG_IDLE)
    Signal(SIG_WALK)
    StartThread(walk)
end


function script.StopMoving()


    Signal(SIG_IDLE)
    Signal(SIG_WALK)
    legs_down()
    StartThread(idle)
end

TELEPORTRANGE = 8500

function TelePortation()
    x, y, z = Spring.GetUnitPosition(unitID)
    cmds = Spring.GetCommandQueue(unitID, 4)
    for i = #cmds, 1, -1 do
        if cmds[i].id and cmds[i].id == CMD.MOVE and cmds[i].params then
            tx, ty, tz = cmds[i].params[1], cmds[i].params[2], cmds[i].params[3]
            px, py, pz = tx - x, ty - y, tz - z
            dist = math.sqrt(px * px + py * py + pz * pz)
            if dist < TELEPORTRANGE then
                EmitSfx(vort, 1024)
                for h = 1, 3 do
                    Spring.SpawnCEG("vortport", tx, ty + 15, tz, math.random(-1, 1), 1, math.random(-1, 1))
                end
                Spring.SpawnCEG("vortport", x, y + 15, z, 0, 1, 0)
                Spring.SetUnitPosition(unitID, tx, ty, tz)

                boolCharged = false
                return
            end
        end
    end

    boolCharged = true
    return
end

Charged = 0

TIMETOCHARGE = 15000

function reactor()
	while true do

		if Charged <=  Spring.GetUnitExperience(unitID) + 1 then
		Sleep(TIMETOCHARGE)
		Charged= inc(Charged)
		end
	Sleep(50)
	end
end

function TelePortationLoop()
StartThread(reactor)
    while true do


        if Charged > 0 and boolMove == true then
			Charged= dec(Charged)
            StartThread(TelePortation)
			Sleep(1000)
        end
        Sleep(300)
    end
end


--- -aimining & fire weapon
function script.AimFromWeapon2()
    return vDisChar1
end



function script.QueryWeapon2()
    return vDisChar1
end

function script.AimWeapon2(Heading, pitch)
    return true
end

function coolDown()
Sleep(15000)
Signal(SIG_WAVE)
end
function waving()
Signal(SIG_WAVE)
SetSignalMask(SIG_WAVE)
		StartThread(coolDown)
while true do
		
	  tSyncIn(vortarmr, 0,0,0,1500)
	  tSyncIn(vortarml, 0,0,0,1500)
	  WaitForTurns(vortarml,vortarmr)
	  ax, ay, az = Spring.GetUnitPosition(unitID)
     Spring.SpawnCEG("vortcharge", ax, ay + 15, az, math.random(-100, 100)/100, math.random(80,100)/100, math.random(-100, 100)/100)
	  tSyncIn(vortarmr, -110,0,0, 1500)
	  tSyncIn(vortarml, -110,0,0, 1500)
	  	 WaitForTurns(vortarml,vortarmr)
		Sleep(100)
end
end

function script.FireWeapon2()
		StartThread(waving)

    return true
end
