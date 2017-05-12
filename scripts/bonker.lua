include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"

--Define the wheel pieces

--Define the pieces of the weapon

flare1 = piece "flare1"
gun1 = piece "gun1"
gun2 = piece "gun2"

flare2 = piece "flare2"
Barrels = {}

muzzles = {}

for i = 1, 4, 1 do
    name = "Barrel" .. i
    Barrels[i] = piece(name)
end
for i = 1, 4, 1 do
    name = "b" .. i


    muzzles[i] = piece(name)
end

TurnTurret = piece "TurnTurret"
ExtrudeTur = piece "ExtrudeTur"
YawTurret = piece "YawTurret"
Shield1 = piece "Shield1"
Shield2 = piece "Shield2"



SIG_FIRE = 2
SIG_FIRE2 = 4
--define other pieces


teamID = Spring.GetUnitTeam(unitID)

function script.Create()
    Hide(flare1)
    Hide(flare2)
    StartThread(fold)
    --StartThread(testTurn)
    hideT(muzzles)
end


function flareThread()
    nr = 1
    for j = 1, 4 do
        if nr == 1 then
            for i = 1, 4, 1 do
                EmitSfx(muzzles[1], 1024)
                Sleep(97)
            end
        elseif nr == 2 then
            for i = 1, 4, 1 do
                EmitSfx(muzzles[2], 1024)
                Sleep(97)
            end
        elseif nr == 3 then
            for i = 1, 4, 1 do
                EmitSfx(muzzles[3], 1024)
                Sleep(97)
            end
        elseif nr == 4 then
            for i = 1, 4, 1 do
                EmitSfx(muzzles[4], 1024)
                Sleep(97)
            end
        end
        nr = nr % 4 + 1
    end
end


--- -aimining & fire weapon
boolDoneAiming1 = false
function script.AimFromWeapon1()
    return flare1
end

function script.QueryWeapon1()
    return flare1
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_FIRE)
    if heading > 1.63 and heading < 4.8 then
        boolDoneAiming1 = false
        return false
    else
        --aiming animation: instantly turn the gun towards the enemy

        Turn(gun1, y_axis, heading, 4)
        Turn(gun1, x_axis, -pitch, 4)
        WaitForTurn(gun1, y_axis)
        boolDoneAiming1 = true
        return true
    end
end



function script.FireWeapon1()
    Spring.PlaySoundFile("sounds/bonkers/plasma.wav", 1.0)
    EmitSfx(flare1, 1025)
    return true
end

----------------------------------------------
function script.AimFromWeapon2()
    return flare2
end

function script.QueryWeapon2()
    return flare2
end

function script.AimWeapon2(heading, pitch)
    Signal(SIG_FIRE)
    if heading < 1.63 or heading > 4.8 then

        return false
    else
        --aiming animation: instantly turn the gun towards the enemy

        Turn(gun2, y_axis, heading, 4)
        Turn(gun2, x_axis, -pitch, 4)
        WaitForTurn(gun2, y_axis)

        return true
    end
end



function script.FireWeapon2()
    Spring.PlaySoundFile("sounds/bonkers/plasma.wav", 2.0)

    EmitSfx(flare2, 1025)

    return true
end

----------------------------------------------
function script.AimFromWeapon3()
    return Barrels[it]
end

it = 1
function script.QueryWeapon3()
    it = it % 4 + 1
    return Barrels[it]
end

SIG_FOLD = 16
minus90 = math.rad(90)
function script.AimWeapon3(heading, pitch)

    if boolUnfold == true then
        --aiming animation: instantly turn the gun towards the enemy

        Turn(ExtrudeTur, y_axis, heading, 4)
        Turn(YawTurret, x_axis, -pitch + minus90, 4)
        WaitForTurn(ExtrudeTur, y_axis)
        WaitForTurn(YawTurret, x_axis)
        return true
    else

        unfold()
        return false
    end
end

boolUnfold = false

function unfold()
    Signal(SIG_FOLD)
    Move(ExtrudeTur, y_axis, 61.15, 25)
    WaitForMove(ExtrudeTur, y_axis)
    Move(Shield1, y_axis, -37, 17)
    Sleep(1900)
    Move(Shield2, y_axis, -37, 17)
    WaitForMove(Shield2, y_axis)
    Hide(Shield1)
    Hide(Shield2)
    Turn(Barrels[1], y_axis, math.rad(130), 8)
    Turn(Barrels[2], y_axis, math.rad(-120), 8) -- -68
    Turn(Barrels[3], y_axis, math.rad(130), 8) --58
    Turn(Barrels[4], y_axis, math.rad(-126), 8)
    boolUnfold = true
end

function fold()
    SetSignalMask(SIG_FOLD)
    Sleep(9000)
    boolUnfold = false
    Turn(YawTurret, x_axis, math.rad(0), 3)
    Turn(ExtrudeTur, y_axis, math.rad(0), 3)


    Turn(Barrels[1], y_axis, math.rad(0), 8)
    Turn(Barrels[2], y_axis, math.rad(0), 8)
    Turn(Barrels[3], y_axis, math.rad(0), 8)
    Turn(Barrels[4], y_axis, math.rad(0), 8)
    WaitForTurn(Barrels[1], y_axis)
    Show(Shield1)
    Show(Shield2)
    Move(Shield1, y_axis, 0, 7)
    Move(Shield2, y_axis, 0, 7)
    WaitForMove(Shield2, y_axis)
    Move(ExtrudeTur, y_axis, 0, 3)
    WaitForMove(ExtrudeTur, y_axis)
end

function script.FireWeapon3()
    StartThread(flareThread)
    StartThread(fold)
    return true
end




function script.Killed(recentDamage, maxHealth)
    teamID = Spring.GetUnitTeam(unitID)
    dropPx, dropPy, dropZ = Spring.GetUnitPosition(unitID)
    for i = 1, 4, 1 do
        Spring.CreateUnit("bg", dropPx + 20, dropPy, dropZ + 90, 0, teamID)
    end
    createCorpseCBuilding(unitID, recentDamage)

    --whatever
    return 0
end

--Building


