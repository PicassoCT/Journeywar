include "createCorpse.lua"
--	include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"

include "lib_Build.lua"


SIG_AIM = 2
SIG_WALK = 4
SIG_TAKEAIM = 8
SIG_GUARD = 16

SIG_AIMWEAPON = 64
local pi = 3.14159

inHibitorRange = 700

local piecesTable = {}

center = piece "center"
piecesTable[1] = {}
piecesTable[1] = center
LightRefl10 = piece "LightRefl10"

piecesTable[#piecesTable + 1] = LightRefl10
LightRefl1 = piece "LightRefl1"

piecesTable[#piecesTable + 1] = LightRefl1
LightRefl2 = piece "LightRefl2"

piecesTable[#piecesTable + 1] = LightRefl2
LightRefl3 = piece "LightRefl3"

piecesTable[#piecesTable + 1] = LightRefl3
LightRefl4 = piece "LightRefl4"

piecesTable[#piecesTable + 1] = LightRefl4
LightRefl5 = piece "LightRefl5"

piecesTable[#piecesTable + 1] = LightRefl5
LightRefl6 = piece "LightRefl6"

piecesTable[#piecesTable + 1] = LightRefl6
LightRefl7 = piece "LightRefl7"

piecesTable[#piecesTable + 1] = LightRefl7
LightRefl8 = piece "LightRefl8"

piecesTable[#piecesTable + 1] = LightRefl8
LightRefl9 = piece "LightRefl9"

piecesTable[#piecesTable + 1] = LightRefl9
ballsbebou = piece "ballsbebou"

piecesTable[#piecesTable + 1] = ballsbebou
field1 = piece "field1"

piecesTable[#piecesTable + 1] = field1
field2 = piece "field2"

piecesTable[#piecesTable + 1] = field2
heavymetal = piece "heavymetal"

piecesTable[#piecesTable + 1] = heavymetal
animCenter = piece "animCenter"

piecesTable[#piecesTable + 1] = animCenter
tigLil = piece "tigLil"

piecesTable[#piecesTable + 1] = tigLil
tlarmr01 = piece "tlarmr01"

piecesTable[#piecesTable + 1] = tlarmr01
tllowll = piece "tllowll"

piecesTable[#piecesTable + 1] = tllowll
tllegUpR = piece "tllegUpR"

piecesTable[#piecesTable + 1] = tllegUpR
tllegLowR = piece "tllegLowR"

piecesTable[#piecesTable + 1] = tllegLowR
tllegUpR01 = piece "tllegUpR01"

piecesTable[#piecesTable + 1] = tllegUpR01
tllegLowR0 = piece "tllegLowR0"

piecesTable[#piecesTable + 1] = tllegLowR0
tlHead = piece "tlHead"

piecesTable[#piecesTable + 1] = tlHead
tlarmr = piece "tlarmr"

piecesTable[#piecesTable + 1] = tlarmr
tllowlr = piece "tllowlr"

piecesTable[#piecesTable + 1] = tllowlr
gun = piece "gun"

piecesTable[#piecesTable + 1] = gun
field3 = piece "field3"
armrotator = piece "armrotator"
field1x = 0
field1y = 0
field3x = 0
field3y = 0
function fieldLoop()
    Hide(field1)
    Show(field3)
    speed = 60
    startFrame = Spring.GetGameFrame()
    while (true) do
        if math.random(0, 1) == 1 then Show(field1); Hide(field3) else Show(field3); Hide(field1) end
        if math.random(0, 2) == 1 then Show(field1); Show(field3) end

			
        if math.random(0, 1) == 1 then 
				Turn(field2, x_axis, math.rad(0), 0)
				if math.random(0, 1) == 1 then  Turn(field2, y_axis, math.rad(180), 0) else Turn(field2, y_axis, math.rad(0), 0) end
			else
				Turn(field2, x_axis, math.rad(180), 0) 
				if math.random(0, 1) == 1 then Turn(field2, y_axis, math.rad(124), 0) else	Turn(field2, y_axis, math.rad(124 + 180), 0) 	end
			end

				

		
		
        if math.random(0, 1) == 0 then Turn(field3, y_axis, math.rad(180), 0) else Turn(field3, y_axis, math.rad(0), 0) end
        if math.random(0, 1) == 0 then Turn(field1, y_axis, math.rad(180), 0) else Turn(field1, y_axis, math.rad(0), 0) end
        if math.random(0, 1) == 0 then Turn(field3, z_axis, math.rad(180), 0) else Turn(field3, z_axis, math.rad(0), 0) end
        if math.random(0, 1) == 0 then Turn(field1, z_axis, math.rad(180), 0) else Turn(field1, z_axis, math.rad(0), 0) end
        if math.random(0, 1) == 0 then field1x = math.min(0.20, math.max(-0.20, field1x + math.random(-100, 100) / 1000)) else Move(field1, x_axis, field1x) end
        if math.random(0, 1) == 0 then field1y = math.min(0.0125, math.max(-0.05, field1y + math.random(-100, 100) / 1000)) else Move(field1, y_axis, field1y) end

        frame = Spring.GetGameFrame()
        Sleep(speed)
        speed = math.max(30, math.ceil(60) + math.cos(math.pi * (frame - startFrame) / 900) * 120)
    end
end

function upLoop()
    oldSpeed = math.random(3.141, 19)
    while (true) do

        Move(ballsbebou, y_axis, 8, oldSpeed)
        WaitForMove(ballsbebou, y_axis)

        newSpeed = math.random(3.141, 19)
        Move(ballsbebou, y_axis, -3, (newSpeed + oldSpeed * 2) / 3)
        oldSpeed = newSpeed
        Sleep(50)
        WaitForMove(ballsbebou, y_axis)
    end
end


function sideLoop()
    speed = 0.9

    while true do

        Move(ballsbebou, x_axis, 0.9, speed)
        WaitForMove(ballsbebou, x_axis)
        speed = speed + math.random(0.1, 0.3)
        Move(ballsbebou, x_axis, -0.9, speed)
        WaitForMove(ballsbebou, x_axis)
        speed = speed - math.random(0.1, 0.3)
        speed = math.abs(speed % 2) + 0.01
    end
end

function takeAim(pitch)

    pitch = math.rad(360) - pitch
    --- -Spring.Echo(pitch)

    Turn(tllegLowR0, x_axis, math.rad(11), 3.141)
    Turn(tllegUpR01, x_axis, math.rad(-17), 3.141)
    Turn(tllegUpR, x_axis, math.rad(10), 3.141)
    Turn(tllegUpR, y_axis, math.rad(8), 3.141)
    Turn(tllegUpR, z_axis, math.rad(-1.5), 3.141)
    Turn(tlHead, z_axis, math.rad(14), 4)
    Turn(tlHead, x_axis, pitch, 4)
    Turn(armrotator, x_axis, -pitch, 3.2)

    Turn(tlarmr01, x_axis, math.rad(0), 1)
    Turn(tlarmr01, y_axis, math.rad(93), 15)
    Turn(tlarmr01, z_axis, math.rad(0), 38)

    Turn(tllowll, x_axis, math.rad(0), 1)
    Turn(tllowll, y_axis, math.rad(5), 13)
    Turn(tllowll, z_axis, math.rad(-6), 3)

    Turn(tlarmr, x_axis, math.rad(6), 1)
    Turn(tlarmr, y_axis, math.rad(-97), 15)
    Turn(tlarmr, z_axis, math.rad(63), 5)

    Turn(tllowlr, x_axis, math.rad(0), 1)
    Turn(tllowlr, y_axis, math.rad(0), 1)
    Turn(tllowlr, z_axis, math.rad(-96), 8)


    Turn(gun, x_axis, math.rad(0), 1)
    Turn(gun, y_axis, math.rad(-8), 1)
    Turn(gun, z_axis, math.rad(31), 8)


    WaitForTurn(armrotator, x_axis)
end

AimPiece2 = piece "AimPiece2"
function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIMWEAPON)
    Signal(SIG_GUARD)
    Signal(SIG_WALK)

    Move(gun, x_axis, math.rad(0), 22)
    Move(gun, y_axis, math.rad(0), 22)
    Move(gun, z_axis, math.rad(0), 22)

    SetSignalMask(SIG_AIMWEAPON)
    if pitch > 48 then return false end
    boolGuardWalking = false
    --- -Spring.Echo("CombinedFeatureScript_AIMWEAPON1")



    boolAiming = true


    Turn(tigLil, y_axis, heading + math.rad(-141 + 180), 5)
    takeAim(pitch)
    WaitForTurn(tigLil, y_axis)
    --Spring.Echo("AimWeapon1:Completed")

    StartThread(AimReseter)
    return true
end

boolEmit=false
function constLazzorsEmit()
	Sleep(1500)
	local lEmitSfx = EmitSfx

	while(true) do
		
		if boolEmit == true then

			lEmitSfx(AimPiece2,1028)
		end
		--EmitSfx by force
		Sleep(65)
		
	end	
end


function AimReseter()

    Sleep(6000)
    boolAiming = false
end

function script.AimFromWeapon1()

    return tigLil
end

function script.QueryWeapon1()
    return gun
end

function PauseEmit()
boolEmit=true
Sleep(1000)
boolEmit=false
end
function script.FireWeapon1()
	StartThread(PauseEmit)

    return true
end


function T(piecename, degx, speedx, degz, speedz, degz, speedz)
    if degx ~= nil then Turn(piecename, x_axis, math.rad(degx), speedx) end
    if degz ~= nil then Turn(piecename, z_axis, math.rad(degz), speedz) end
    if degy ~= nil then Turn(piecename, y_axis, math.rad(degy), speedy) end
end



boolLoaded = true

function reLoader()
    Sleep(3000)
    boolLoaded = true
end

------------------------------------------------------------

boolAiming = false
boolGuardWalking = false
function setUp()
    Turn(animCenter, y_axis, math.rad(141), 0)
    --Spring.Echo("setUp")
end

function reSume()
    takeAim(-math.rad(15))
    Turn(tigLil, y_axis, math.rad(0), 3)
    --Spring.Echo("Resume")
end

function legsDown()
    T(gun, 0, 3, 0, 3, 0, 3)
    Move(gun, y_axis, 0, 10)
    Move(gun, x_axis, 0, 10)


    if math.random(0, 1) == 1 then
        Turn(tllegUpR, x_axis, math.rad(0), 1.2)
        Turn(tllegUpR, y_axis, math.rad(0), 1.2)
        Turn(tllegUpR, z_axis, math.rad(0), 1.2)

        Turn(tllegLowR, x_axis, math.rad(0), 1.3)
        Turn(tllegLowR, y_axis, math.rad(0), 1.3)
        Turn(tllegLowR, z_axis, math.rad(0), 1.2)

        Turn(tllegUpR01, x_axis, math.rad(0), 1.2)
        Turn(tllegUpR01, y_axis, math.rad(0), 1.2)
        Turn(tllegUpR01, z_axis, math.rad(0), 1.2)

        Turn(tllegLowR0, x_axis, math.rad(0), 1.2)
        Turn(tllegLowR0, y_axis, math.rad(0), 1.2)
        Turn(tllegLowR0, z_axis, math.rad(0), 1.2)
    elseif math.random(0, 1) == 0 then
        Turn(tllegUpR, x_axis, math.rad(5), 1.2)
        Turn(tllegUpR, y_axis, math.rad(0), 1.2)
        Turn(tllegUpR, z_axis, math.rad(-12), 1.2)

        Turn(tllegLowR, x_axis, math.rad(0), 1.3)
        Turn(tllegLowR, y_axis, math.rad(0), 1.3)
        Turn(tllegLowR, z_axis, math.rad(0), 1.2)

        Turn(tllegUpR01, x_axis, math.rad(-7), 1.2)
        Turn(tllegUpR01, y_axis, math.rad(0), 1.2)
        Turn(tllegUpR01, z_axis, math.rad(8), 1.2)

        Turn(tllegLowR0, x_axis, math.rad(0), 1.2)
        Turn(tllegLowR0, y_axis, math.rad(0), 1.2)
        Turn(tllegLowR0, z_axis, math.rad(0), 1.2)

    else
        Turn(tllegUpR, x_axis, math.rad(5), 1.2)
        Turn(tllegUpR, y_axis, math.rad(0), 1.2)
        Turn(tllegUpR, z_axis, math.rad(12), 1.2)

        Turn(tllegLowR, x_axis, math.rad(0), 1.3)
        Turn(tllegLowR, y_axis, math.rad(0), 1.3)
        Turn(tllegLowR, z_axis, math.rad(0), 1.2)

        Turn(tllegUpR01, x_axis, math.rad(-7), 1.2)
        Turn(tllegUpR01, y_axis, math.rad(0), 1.2)
        Turn(tllegUpR01, z_axis, math.rad(-8), 1.2)

        Turn(tllegLowR0, x_axis, math.rad(0), 1.2)
        Turn(tllegLowR0, y_axis, math.rad(0), 1.2)
        Turn(tllegLowR0, z_axis, math.rad(0), 1.2)
    end
end

function walkAnimation(orgDegY, factor)
    SetSignalMask(SIG_WALK)
    --Spring.Echo("Resume")

    while true do
        --- -Spring.Echo("combinedFeatureScript::1")
        -- HeadBody
        tSyncIn(tlHead, 0, (17), (-8), 500)		
        tSyncIn(tigLil, (1.4),(orgDegY - 5),0.5, 500)
       
        --Legs
        
        tSyncIn(tllegUpR, (20),0,11,500)
        tSyncIn(tllegLowR,  (-26),(-6), 0, 500)
        tSyncIn(tllegUpR01, (-26),0, -6, 500)
        tSyncIn(tllegLowR0,(-11),0,-14,500)

        WaitForTurns(tllegLowR0, tllegUpR01, tllegLowR, tllegUpR, tlHead)
        --- -Spring.Echo("combinedFeatureScript::2")
        -- HeadBody
        tSyncIn(tlHead, (-19), -3 , 1, 500)
		tSyncIn(tigLil, 1.4, orgDegY, 1.4, 500)

        tSyncIn(tllegUpR, (8),(0),(11), 500)
        tSyncIn(tllegLowR, (-32),(0), (3),500)
        tSyncIn(tllegUpR01, (17), (0), (-2), 500)
        tSyncIn(tllegLowR0, (-41), 0, 20, 500)
        WaitForTurns(tllegLowR0, tllegUpR01, tllegLowR, tllegUpR, tlHead, tigLil)
        --- -Spring.Echo("combinedFeatureScript::3")
        -- HeadBody
		 tSyncIn(tigLil,(0),(orgDegY + 5),  (-1.4), 500)
        --Legs
        tSyncIn(tlHead,  (-7), (-19), (12),500) 
        tSyncIn(tllegUpR, (-4), (0), (3), 500)

        tSyncIn(tllegLowR, (0), (0), (0),500)

        tSyncIn(tllegUpR01, (20),(0), (-11),500)

        tSyncIn(tllegLowR0, (-26),(-6), (0), 500)
        WaitForTurns(tllegLowR0, tllegUpR01, tllegLowR, tllegUpR, tlHead, tigLil)

        --HeadBody
        tSyncIn(tlHead, 0,0,0, 500)
        tSyncIn(tigLil, (-1.4),(orgDegY),0,500)
		
        tSyncIn(tllegUpR, (-26), (0),(6), 500)

        tSyncIn(tllegLowR,(-11), (0), (14),500)

        tSyncIn(tllegUpR01, (8), (0),(-11),500)

        tSyncIn(tllegLowR0, (-32), (0), (-3), 500)
        WaitForTurns(tllegLowR0, tllegUpR01, tllegLowR, tllegUpR, tlHead, tigLil)

        --- -Spring.Echo("combinedFeatureScript::4")
        -- HeadBody
		tSyncIn(tigLil, (-1), (orgDegY - 5),  (-2),500)

        tSyncIn(tlHead,0, (0),  (15),500)
        --Legs
        tSyncIn(tllegUpR, (17), (0),(2), 500)

        tSyncIn(tllegLowR,  (-41),  (0), (-20), 500)

        tSyncIn(tllegUpR01,  (-4),  (0), (-3), 500)

        tSyncIn(tllegLowR0, (0), (0), (0),500)

        WaitForTurns(tllegLowR0, tllegUpR01, tllegLowR, tllegUpR, tlHead, tigLil)

    end
end



function idle(StringThing)

    deci = math.random(1, 4)
    if StringThing == "start" then
        if deci == 1 then
            --gunRiding
        elseif deci == 2 then
            --waitingPose
            T(armrotator, -30, 3, 0, 3, 0, 3)
            T(tlarmr01, 0, 3, 75, 5, 0, 3)
            T(tllowll, 0, 3, 35, 3, 0, 3)
            T(tlarmr, 0, 3, -75, 3, 0, 3)
            T(tllowlr, 0, 3, -35, 3, 0, 3)
            T(gun, -2.7, 3, -5.3, 3, -116.8, 3)
            Move(gun, y_axis, -5, 3)
            Move(gun, x_axis, -2.4, 3)

            Sleep(70000)
        end
    else
        if deci == 3 then
            --salto
            T(tigLil, 0, 3, 0, 3, 0, 3)
            WaitForTurn(tigLil, y_axis)
            Move(tigLil, y_axis, -5, 10)
            T(tllegUpR, 83, 7, -12, 3, 0, 5)
            T(tllegLowR, -150, 25, 0, 3, 0, 3)
            T(tllegUpR01, 75, 5, 0, 3, 0, 3)
            T(tllegLowR0, -115, 11, 0, 3, 0, 3)
            T(tlHead, -29, 3, 0, 3, 0, 3)
            T(armrotator, -36, 6, 0, 3, 0, 3)
            T(tlarmr01, 0, 3, 76, 5, 0, 3)
            T(tllowll, 0, 3, 21, 4, 0, 3)
            T(tlarmr, 0, 3, -71, 9, -5, 3)
            WaitForMove(tigLil, y_axis)
            Move(tigLil, z_axis, -32, 6)
            Move(tigLil, y_axis, 22, 17)
            Sleep(450)
            legsDown()
            Spin(tigLil, x_axis, math.rad(-190), 6)
            Sleep(350)
            T(tllegUpR, 83, 7, -12, 3, 0, 5)
            T(tllegLowR, -150, 25, 0, 3, 0, 3)
            T(tllegUpR01, 75, 5, 0, 3, 0, 3)
            T(tllegLowR0, -115, 11, 0, 3, 0, 3)
            T(tlHead, -29, 3, 0, 3, 0, 3)
            T(armrotator, -36, 6, 0, 3, 0, 3)
            T(tlarmr01, 0, 3, 76, 5, 0, 3)
            T(tllowll, 0, 3, 21, 4, 0, 3)
            T(tlarmr, 0, 3, -71, 9, -5, 3)
            Sleep(800)
            StopSpin(tigLil, x_axis)
            Turn(tigLil, x_axis, math.rad(0), 17)
            WaitForMove(tigLil, y_axis)
            Move(tigLil, y_axis, 0, 9)
            Sleep(300)
            Move(tigLil, y_axis, 0, 32)

            return true
        elseif deci == 4 then
            --Leaving the Post
        end
    end
end

function walkingTheGuard()
    boolGuardWalking = true
    SetSignalMask(SIG_GUARD)
    setUp()

    reSume()
    while true do
        --Reseting it
        Move(tigLil, y_axis, 0, 21)
        StartThread(walkAnimation, 0, math.random(141, 241) / 100)
        for i = 1, 56, 1 do
            Move(tigLil, z_axis, -i, 3.2)
            WaitForMove(tigLil, z_axis)
        end

        rand = math.ceil(math.random(600, 19000))
        dx = -90
        if math.random(0, 1) == 1 then dx = math.abs(dx) end
        dx = dx + 180

        Signal(SIG_WALK)
        Turn(tigLil, y_axis, math.rad(dx), 19)
        legsDown()
        Sleep(rand)

        Turn(tigLil, y_axis, math.rad(180), 19)
        WaitForTurn(tigLil, y_axis)
        boolIDLE = idle("end")
        StartThread(walkAnimation, 180, math.random(141, 200) / 100)

        Move(tigLil, y_axis, 0, 21)

        if boolIDLE == nil or boolIDLE == false then
            for i = 56, 0, -1 do
                Move(tigLil, z_axis, -i, 3.2)
                WaitForMove(tigLil, z_axis)
            end
        else
            for i = 32, 0, -1 do
                Move(tigLil, z_axis, -i, 3.2)
                WaitForMove(tigLil, z_axis)
            end
        end

        Move(tigLil, z_axis, 0, 3.2)

        WaitForMove(tigLil, z_axis)
        Signal(SIG_WALK)
        rand = math.ceil(math.random(600, 19000))
        legsDown()
        idle("start")
        legsDown()
        Sleep(rand)
        takeAim(-math.rad(28))
        Turn(tigLil, y_axis, math.rad(0), 19)
        WaitForTurn(tigLil, y_axis)
    end
end

function guardOS()
    setUp()
    while true do
        if boolAiming == false and boolGuardWalking == false then
            Sleep(250)
            if boolAiming == false and boolGuardWalking == false then
                Signal(SIG_GUARD)
                StartThread(walkingTheGuard)
            end
        end

        if boolAiming == true then

            while boolAiming == true do
                boolGuardWalking = false
                Sleep(500)
            end
        end

        Sleep(250)
    end
end

function shieldShine()
    ------ Spring.Echo("shieldShine activated")
    while true do
        for i = 1, 10, 1 do
            Move(piecesTable[i + 1], x_axis, math.random(0.9, 1.5), 0.15)
            randDelay = math.ceil(math.random(80, 120))
            Sleep(randDelay)
        end
        WaitForMove(piecesTable[2], x_axis)

        for i = 1, 10, 1 do
            Move(piecesTable[i + 1], x_axis, 0, 0.2)
            randDelay = math.ceil(math.random(80, 120))
            Sleep(randDelay)
        end
        --	----Spring.Echo("shieldShine activated3")
        WaitForMove(piecesTable[2], x_axis)
    end
end

function killEgg(Did)
    rand = math.ceil(math.random(1000, 3500))
    Sleep(rand)
    if Spring.GetUnitIsDead(Did) == false then
        Spring.DestroyUnit(Did, false, false)
    end
end

function KillEggLoop()
    local inhibRange = inHibitorRange
    local spGetUnitDefID = Spring.GetUnitDefID
    while true do
        Sleep(2000)
        ClarkTable = {}
        ClarkTable = Spring.GetUnitsInCylinder(xPos, zPos, inhibRange)
        --Spring.Echo("combinedFeatureScript",table.getn(ClarkTable))
        if ClarkTable ~= nil then
            for i = 1, table.getn(ClarkTable), 1 do
                res = spGetUnitDefID(ClarkTable[i])
                if res == UnitDefNames["jtigeggnogg"].id or res == UnitDefNames["jskineggnogg"].id then StartThread(killEgg, ClarkTable[i]) end
            end
        end
    end
end

xPos = 0
zPos = 0
function script.Create()
    Hide(AimPiece2)

    --generatepiecesTableAndArrayCode(unitID)
    xPos, _, zPos = Spring.GetUnitPosition(unitID)
    StartThread(guardOS)
    StartThread(shieldShine)
    StartThread(sideLoop)
    StartThread(upLoop)
    StartThread(KillEggLoop)
    StartThread(fieldLoop)
    StartThread(constLazzorsEmit)
end


--function is a testloop

function script.Killed(recentDamage, _)


    createCorpseCUnitSmall(recentDamage)

    return 0
end


------------------------------------------------------------