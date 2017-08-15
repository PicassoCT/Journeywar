--Eliah

--Define the wheel pieces

local boolSecondAiming = false

--define other pieces

local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_IDLE = 4
local SIG_AIM2 = 8
local SIG_LRESET = 16
local SIG_RRESET = 32
local SIG_FIGHTCLUB = 64
local SIG_MOVE = SIG_FIGHTCLUB * 2
boolNonCombatant = true

--eggspawn --tigLil and SkinFantry


p = {}
body = piece "body"
center = piece "center"
deathpivot = piece "deathpivot"
Head = piece "Head"
leftside = piece "leftside"
LArm = piece "Larm"
LLeg = piece "LLeg"
rightside = piece "rightside"
RArm = piece "RArm"
RLLeg = piece "RLLeg"
p[#p + 1] = {}
p[#p] = body
p[#p + 1] = {}
p[#p] = center
p[#p + 1] = {}
p[#p] = deathpivot
p[#p + 1] = {}
p[#p] = Head
p[#p + 1] = {}
p[#p] = leftside
p[#p + 1] = {}
p[#p] = LArm
p[#p + 1] = {}
p[#p] = LLeg
p[#p + 1] = {}
p[#p] = rightside
p[#p + 1] = {}
p[#p] = RArm
p[#p + 1] = {}
p[#p] = RLLeg

weaponPoints = {}
for i = 1, 6, 1 do
    weaponPoints[i] = {}
    temp = "laserpointer" .. i
    weaponPoints[i] = piece(temp)
end

SHIELDRANGE = 240

function script.HitByWeapon(x, z, weaponDefID, damage)
    NearestAlly = Spring.GetUnitNearestAlly(unitID)
    if NearestAlly then
        x, y, z = Spring.GetUnitPosition(NearestAlly)
        if x then
            dist = math.sqrt(x * x + z * z)
            if dist < SHIELDRANGE then
                return 0
            end
        end
    end
    return damage
end

function script.Create()
    --Spring.Echo(math.tan(0.85))
    --Spring.Echo(math.tan(0.65))
    --Spring.Echo(math.deg(math.tan(0.85)))
    --Spring.Echo(math.deg(math.tan(0.128)))
end

local function idle()
    SetSignalMask(SIG_IDLE)
    if boolNonCombatant == true then
        dicebenice = math.random(1, 5)
        if dicebenice == 5 then
            sleeper = math.random(1024, 8192)
            Turn(body, x_axis, math.rad(-90), 12)
            goDown = math.random(0, 1)
            boolMrTurner = false
            if goDown == 1 then
                Move(body, y_axis, -24, 2.14)
            else
                boolMrTurner = true
            end


            while (true) do
                if boolMrTurner == true then
                    Move(body, y_axis, -5, 7)
                end
                Turn(leftside, y_axis, math.rad(-32), 3)
                Turn(rightside, y_axis, math.rad(30), 3)
                WaitForTurn(rightside, y_axis)
                Turn(leftside, y_axis, math.rad(25), 1)
                Turn(rightside, y_axis, math.rad(-25), 1)
                if boolMrTurner == true then
                    up = math.random(2, 6)
                    Move(body, y_axis, up, 7)
                    diceTurn = math.random(-360, 360)
                    Turn(deathpivot, y_axis, diceTurn, 0.5)
                end
                WaitForTurn(rightside, y_axis)
                rand = math.ceil(math.random(50, 250))
                Sleep(rand)
            end
        else
            while (true) do
                Turn(leftside, y_axis, math.rad(-7), 1.2)
                Turn(LArm, y_axis, math.rad(13), 2.1)
                Turn(rightside, y_axis, math.rad(7), 1.2)
                Turn(RArm, y_axis, math.rad(-13), 2.1)
                Turn(LLeg, x_axis, math.rad(12), 2.1)
                Turn(LLeg, x_axis, math.rad(12), 2.1)
                Turn(RLLeg, z_axis, math.rad(-14), 2.1)
                Move(body, z_axis, 1, 1.1)
                Turn(deathpivot, x_axis, math.rad(-1), 0.07)
                WaitForTurn(rightside, y_axis)

                Turn(leftside, y_axis, math.rad(3), 0.4)
                Turn(LArm, y_axis, math.rad(0), 1)
                Turn(rightside, y_axis, math.rad(-3), 0.4)
                Turn(RArm, y_axis, math.rad(0), 1)
                Turn(LLeg, x_axis, math.rad(0), 0.4)
                Turn(RLLeg, z_axis, math.rad(0), 0.4)
                Move(body, z_axis, 0, 1)
                Turn(deathpivot, x_axis, math.rad(2), 0.15)
                WaitForTurn(rightside, y_axis)
            end
        end
    end
end


--http://answers.springlobby.info/questions/427/howto-spinning-wheels-on-moving-units

-- p[#p]= body
-- p[#p]= center
-- p[#p]= deathpivot
-- 3
-- p[#p]=Head
-- p[#p]=leftside
-- p[#p]=LArm
--6
-- p[#p]=LLeg
-- p[#p]=rightside
-- p[#p]=RArm
--9
-- p[#p]=RLLeg
function takingSteps()
    rand = math.random(-8, -4)
    Turn(body, x_axis, math.rad(6), 0.75)
    Turn(body, y_axis, math.rad(rand), 1)
    Turn(leftside, y_axis, math.rad(-12), 2.1)
    Turn(LArm, y_axis, math.rad(34), 4)
    Turn(LArm, x_axis, math.rad(-7), 2)
    Turn(rightside, y_axis, math.rad(-19), 2)
    Turn(RArm, y_axis, math.rad(18), 4)
    Turn(RArm, x_axis, math.rad(11), 2)
    Turn(LLeg, x_axis, math.rad(-64), 5)
    Turn(RLLeg, x_axis, math.rad(25), 3)

    WaitForTurn(leftside, y_axis)
    WaitForTurn(rightside, y_axis)
    WaitForTurn(LLeg, x_axis)
    WaitForTurn(RLLeg, x_axis)
    Turn(body, x_axis, math.rad(-3), 1)
    Turn(body, y_axis, math.rad(-rand), 1)

    Turn(leftside, y_axis, math.rad(32), 2)

    Turn(LArm, y_axis, math.rad(18), 2)
    Turn(LArm, x_axis, math.rad(-7), 1.7)
    Turn(rightside, y_axis, math.rad(12), 2)
    Turn(RArm, y_axis, math.rad(-11), 4)
    Turn(RArm, x_axis, math.rad(-18), 3)
    Turn(LLeg, x_axis, math.rad(25), 5)
    Turn(RLLeg, x_axis, math.rad(-64), 3)


    WaitForTurn(leftside, y_axis)
    WaitForTurn(rightside, y_axis)
    WaitForTurn(LLeg, x_axis)
    WaitForTurn(RLLeg, x_axis)
end

local function walk()
    local lp = p
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)

    local ltakingSteps = takingSteps


    while (true) do

        Turn(lp[4], y_axis, math.rad(-5), 4)
        Move(body, y_axis, 10, 7.6)
        Move(body, z_axis, 12, 7.6)
        Turn(lp[3], x_axis, math.rad(-39), 3)


        Sleep(320)
        Turn(lp[5], y_axis, math.rad(63), 2)
        Turn(lp[6], y_axis, math.rad(72), 2)
        Turn(lp[8], y_axis, math.rad(-63), 2)
        Turn(lp[9], y_axis, math.rad(-72), 2)
        Turn(lp[10], x_axis, math.rad(22), 7)
        Turn(lp[7], x_axis, math.rad(22), 7)

        WaitForMove(body, y_axis)
        WaitForMove(body, z_axis)
        Turn(lp[3], x_axis, math.rad(9), 2)

        Move(body, y_axis, 0, 17.6)
        Move(body, z_axis, 0, 17.6)
        Turn(lp[10], x_axis, math.rad(0), 7)
        Turn(lp[7], x_axis, math.rad(0), 7)

        WaitForMove(body, y_axis)
        WaitForMove(body, z_axis)

        Turn(lp[4], y_axis, math.rad(-5), 4)
        Turn(lp[5], y_axis, math.rad(-12), 3)
        Turn(lp[6], y_axis, math.rad(-12), 2)
        Turn(lp[8], y_axis, math.rad(12), 3)
        Turn(lp[9], y_axis, math.rad(12), 2)
        WaitForTurn(lp[5], y_axis)
        WaitForTurn(lp[8], y_axis)
        --Steps
        why = math.random(0, 4)
        for i = 1, why, 1 do
            ltakingSteps()
        end
    end
end


function script.Killed(recentDamage, maxHealth)
    --legs_down()


    return 0
end

function readyAiming()
    Turn(body, x_axis, math.rad(0), 12)
    Turn(body, z_axis, math.rad(0), 12)
    Move(body, y_axis, 0, 57.6)
    Move(body, x_axis, 0, 57.6)
    Move(body, z_axis, 0, 57.6)
end




function legs_down()

    readyAiming()

    for i = 1, #p, 1 do
        Turn(p[i], y_axis, math.rad(0), 27)
        Turn(p[i], x_axis, math.rad(0), 27)
        Turn(p[i], z_axis, math.rad(0), 27)
    end
end

boolMove = false
function delayedMove(delay, targetValue)
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)
    Sleep(delay)
    boolMove = targetValue
end



function script.StartMoving()
    -- ----Spring.Echo ("starting to walk!")
    Signal(SIG_IDLE)
    legs_down()
    StartThread(walk)
    StartThread(delayedMove, 50, true)
end

function script.StopMoving()

    -- ----Spring.Echo ("stopped walking!")
    Signal(SIG_IDLE)
    Signal(SIG_WALK)
    legs_down()
    StartThread(idle)
    StartThread(delayedMove, 500, false)
end


function setterOfBools(boolLeft)
    if boolLeft == true then SetSignalMask(SIG_RRESET) else SetSignalMask(SIG_LRESET) end
    if boolLeft == true then boolLeftSideAimed = true end
    if boolLeft == false then boolRightSideAimed = true end
    Sleep(250)
    if boolLeft == true then boolLeftSideAimed = false end
    if boolLeft == false then boolRightSideAimed = false end
end

boolGLHeading = 0
boolGRHeading = 0
boolLeftSideAimed = false
boolRightSideAimed = false
--- -aimining & fire weapon
function script.AimFromWeapon1()
    return body
end

function script.QueryWeapon1()
    return body
end

function stillFighting()
    Signal(SIG_FIGHTCLUB)
    SetSignalMask(SIG_FIGHTCLUB)
    Sleep(500)
    boolNonCombatant = true
end

function script.AimWeapon1(heading, pitch)
    if boolMove == false then
        boolGLHeading = heading
        Signal(SIG_AIM)
        Signal(SIG_LRESET)
        SetSignalMask(SIG_AIM)

        Signal(SIG_IDLE)
        Signal(SIG_WALK)
        boolNonCombatant = false
        StartThread(stillFighting)
        readyAiming()

        --aiming animation: instantly turn the gun towards the enemy
        --Turn(center, y_axis, heading)
        Turn(RArm, x_axis, -pitch, 9)
        Turn(LArm, x_axis, -pitch, 9)
        --WaitForTurn(center,x_axis)
        return true
    else
        return false
    end
end


function script.FireWeapon1()
    Signal(SIG_LRESET)
    StartThread(setterOfBools, true)
    return true
end



--weapon 3
function script.AimFromWeapon2()
    return weaponPoints[3]
end

function script.QueryWeapon2()
    return weaponPoints[3]
end


function script.FireWeapon2()
    return false
end


function script.AimWeapon2(heading, pitch)
    return false
end