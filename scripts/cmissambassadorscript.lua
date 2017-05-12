--a walking animation using threads
--smoothly aiming the weapon, also using threads
local bgbase = piece "body"



local bgarm = piece "ArmLow"


local bgleg = piece "LegUp2"
local bglegr = piece "LegUp1"
local deathpivot = piece "center"
local bglowlegr = piece "LegLow1"
local bglowleg = piece "LegLow2"

local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_IDLE = 4
local SIG_COUNTER = 8
local SIG_FIRE = 16
local SIG_ROB = 32
local SIG_AIMRESET = 64
local SIG_ATTACK = 128
local leg_movespeed = 3
local leg_movedistance = 10

function Emit()
    local emitor = piece "emitor"
    while true do
        EmitSfx(emitor, 1024)
        Sleep(10)
    end
end

local function legs_down()

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

    Turn(bgleg, x_axis, math.rad(0), 9)
    Turn(bgleg, y_axis, math.rad(0), 15)
    Turn(bgleg, z_axis, math.rad(0), 9)

    Turn(bglowleg, x_axis, math.rad(0), 14)
    Turn(bglowleg, y_axis, math.rad(0), 13)
    Turn(bglowleg, z_axis, math.rad(0), 9)
    Turn(deathpivot, y_axis, math.rad(0), 8)
    Turn(deathpivot, x_axis, math.rad(0), 9)

    Turn(bgarm, x_axis, math.rad(0), 8)





    return
end








function script.Create()
    StartThread(Emit)
end


function walk()

    SetSignalMask(SIG_WALK)




    while (true) do
        --left leg up, right leg down
        Turn(bglegr, x_axis, math.rad(-18), 9)
        Turn(bglowlegr, x_axis, math.rad(0), 18)
        Turn(bglowleg, x_axis, math.rad(35), 18)

        Turn(bgleg, x_axis, math.rad(12), leg_movespeed)

        WaitForTurn(bglegr, x_axis)
        WaitForTurn(bgleg, x_axis)
        WaitForTurn(bglowleg, x_axis)
        if boolNotAiming == true then
            rand = math.random(15, 30)
            Turn(bgarm, x_axis, math.rad(-1 * rand), 3)
        end
        Turn(bglegr, x_axis, math.rad(-18), 9)
        --	Turn(bgleg, x_axis, math.rad(10), leg_movespeed)
        Turn(bglowleg, x_axis, math.rad(14), leg_movespeed)


        WaitForTurn(bglegr, x_axis)
        WaitForTurn(bglowleg, x_axis)
        --	WaitForTurn (bgleg, x_axis)
        WaitForTurn(bglowlegr, x_axis)
        --------------------------------------------------------------------------
        Sleep(165)
        --left leg down, right leg up
        Turn(bgleg, x_axis, math.rad(-18), 9)
        Turn(bglowleg, x_axis, math.rad(0), 18)

        Turn(bglowlegr, x_axis, math.rad(35), 18)
        Turn(bglegr, x_axis, math.rad(12), leg_movespeed)

        WaitForTurn(bgleg, x_axis)
        WaitForTurn(bglegr, x_axis)
        WaitForTurn(bglowlegr, x_axis)
        if boolNotAiming == true then
            rand = math.random(22, 45)
            Turn(bgarm, x_axis, math.rad(-1 * rand), 3)
        end


        --------------------------------------------------------------------------
        Sleep(156)
    end
end


function script.StartMoving()







    Signal(SIG_WALK)
    StartThread(walk)
end

function script.StopMoving()





    --    --Spring.Echo ("stopped walking!")
    Signal(SIG_WALK)

    legs_down()
end


boolNotAiming = true

--- AIMING & SHOOTING---


--- -death animation: fall over & explode
function script.Killed(recentDamage, maxHealth)


    return 1
end



