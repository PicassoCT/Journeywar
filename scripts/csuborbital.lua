
include "createCorpse.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"



climb = {}
for i = 1, 40, 1 do
    climb[i] = {}
    climbtemp = "climb" .. i
    climb[i] = piece(climbtemp)
end

impact = {}
for i = 1, 18, 1 do
    impact[i] = {}
    climbtemp = "impact" .. i
    impact[i] = piece(climbtemp)
end


boolLaunched = false
boolReady = false
impactorcounter = 8




--unitPieces
SIG_EXAUST = 1
SIG_COUNT = 2
local upgoer5 = piece "upgoer5"
local subOrbital = piece "SubOrbital"
local Drive1 = piece "Drive1"
local Drive2 = piece "Drive2"
local driveemit1 = piece "drivemit1"
local driveemit2 = piece "drivemit2"
local driveemit3 = piece "drivemit3"
boolOnlyOnce = true


function counter()
    for i = 21, 40, 1 do
        Show(climb[i])
    end
    for i = 10, 18, 1 do
        Show(impact[i])
    end
    for o = 1, 20, 1 do
        Sleep(9000)
        Show(climb[o])
        Hide(climb[(o + 20)])
    end
    Sleep(9000)

    for i = 1, 9, 1 do
        randSleep = math.random(300, 600)
        Sleep(randSleep)
        Show(impact[i])
        Hide(impact[i + 9])
    end
    Sleep(400)
    Spring.PlaySoundFile("sounds/csubOrbital/subready.wav")
    boolReady = true
end

function launched()
    Turn(subOrbital, x_axis, math.rad(-84), 21)
    Turn(Drive1, x_axis, math.rad(-84), 21)
    Turn(Drive2, x_axis, math.rad(84), 21)
    Move(subOrbital, y_axis, 900, 4)
    Spring.PlaySoundFile("sounds/csubOrbital/subOrbLaunch.wav")
    Sleep(1000)
    Move(subOrbital, y_axis, 900, 8)
    Sleep(1000)
    Move(subOrbital, y_axis, 1900, 12)
    Sleep(1000)
    Move(subOrbital, y_axis, 1900, 24)
    Sleep(1000)
    Spin(subOrbital, y_axis, math.rad(2), 0.5)
    Explode(Drive1, SFX.FIRE + SFX.FALL)
    Move(subOrbital, y_axis, 1900, 28)
    Hide(Drive1)
    Sleep(1400)
    Signal(SIG_EXAUST)
    Explode(Drive2, SFX.FIRE + SFX.FALL)
    Move(subOrbital, y_axis, 1900, 32)
    Hide(Drive2)
    Sleep(1000)
    Move(subOrbital, y_axis, 2200, 64)
    StartThread(counter)
    while (true == Spring.UnitScript.IsInMove(subOrbital, y_axis)) do
        EmitSfx(driveemit3, 1024)
        EmitSfx(driveemit3, 1024)
        Sleep(50)
    end
    Hide(subOrbital)
    --4000 -5000 Explode OutsideDrives
end

boolSwitchedState = 0

boolMoving = false
boolCountDownRunning = false
function readyNessIndicator()
    while true do
        Sleep(500)
		 if boolCountDownRunning == true and boolMoving == false and boolReady == false then
		      Show(upgoer5)
            Move(upgoer5, y_axis, 35, 40)
            WaitForMove(upgoer5, y_axis)
            Move(upgoer5, y_axis, 55, 60)
            WaitForMove(upgoer5, y_axis)
            Move(upgoer5, y_axis, 85, 80)
            WaitForMove(upgoer5, y_axis)
            Hide(upgoer5)
            Move(upgoer5, y_axis, 0, 0)
            Sleep(200)
		 end
		 
        if boolCountDownRunning == true and boolMoving == false and boolLaunched == false then
			Spring.MoveCtrl.Enable(unitID, true)
			x,y,z=Spring.GetUnitPosition(unitID)
			Spring.MoveCtrl.SetPosition(unitID, x, y +50, z)
			StartThread(launched)
			boolLaunched= true
        end
    end
end

function script.Activate()
    --activates the secondary weapon

	boolCountDownRunning = true
 
    return 1
end

function script.Deactivate()
    --deactivates the secondary weapon
   boolCountDownRunning = false
    return 0
end






function exaust()
    SetSignalMask(SIG_EXAUST)
    while (true) do
        EmitSfx(driveemit1, 1024)
        EmitSfx(driveemit2, 1024)
        EmitSfx(driveemit3, 1024)
        Sleep(50)
    end
end


function script.StartMoving()
    Signal(SIG_COUNT)

    boolMoving = true
end


function countdown()
    SetSignalMask(SIG_COUNT)
    --Spring.Echo("T-60 secs to launch")
    Sleep(15000)
    SetUnitValue(COB.MAX_SPEED, 1)

    if boolOnlyOnce == true then
        boolOnlyOnce = false
        StartThread(launched)
        boolLaunched = true
        SetUnitValue(COB.MAX_SPEED, 1)
    end
end



function script.StopMoving()
    boolMoving = false
end





function script.Create()

    for i = 1, 40, 1 do
        Hide(climb[i])
    end


    for i = 1, 18, 1 do
        Hide(impact[i])
    end

    StartThread(readyNessIndicator)
    StartThread(exaust)
    Hide(upgoer5)
end

function script.Killed()

    return 1
end




function script.AimFromWeapon1()

    return subOrbital
end

function script.QueryWeapon1()
    return subOrbital
end



function script.AimWeapon1(heading, pitch)
    if boolReady == true and impactorcounter > 0 then
        return true
    elseif impactorcounter == 0 then
        Spring.DestroyUnit(unitID, false, true)
        return false
    else
        return false
    end
end



function script.FireWeapon1()
    impactorcounter = impactorcounter - 3
	 hideT(impact, impactorcounter+1, impactorcounter + 3)
end