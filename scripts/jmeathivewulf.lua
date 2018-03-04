include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_OS.lua"

local boolCloseCombat = false
local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local SIG_RESET = 4 --signal for the weapon aiming thread
local SIG_TAIL = 8 
pieces = {}
rotor = piece "rotor"
pieces[#pieces + 1] = {}
pieces[#pieces] = rotor

rotor2 = piece "rotor2"
pieces[#pieces + 1] = {}
pieces[#pieces] = rotor

littleWulf = piece "littleWulf"
pieces[#pieces + 1] = {}
pieces[#pieces] = rotor


body = piece "body"
pieces[#pieces + 1] = {}
pieces[#pieces] = body

Tail = piece "Tail"
pieces[#pieces + 1] = {}
pieces[#pieces] = Tail

bUpL = piece "bUpL"
pieces[#pieces + 1] = {}
pieces[#pieces] = bUpL

bfootL = piece "bfootL"
pieces[#pieces + 1] = {}
pieces[#pieces] = bfootL

bUpR = piece "bUpR"
pieces[#pieces + 1] = {}
pieces[#pieces] = bUpR

bfootR = piece "bfootR"
pieces[#pieces + 1] = {}
pieces[#pieces] = bfootR

--
fUpL = piece "fUpL"
pieces[#pieces + 1] = {}
pieces[#pieces] = fUpL

ffootL = piece "ffootL"
pieces[#pieces + 1] = {}
pieces[#pieces] = ffootL

fUpR = piece "fUpR"
pieces[#pieces + 1] = {}
pieces[#pieces] = fUpR

ffootR = piece "ffootR"
pieces[#pieces + 1] = {}
pieces[#pieces] = ffootR

Head = piece "Head"
pieces[#pieces + 1] = {}
pieces[#pieces] = Head

jaw = piece "jaw"
pieces[#pieces + 1] = {}
pieces[#pieces] = jaw

aimspot = piece "aimspot"
pieces[#pieces + 1] = {}
pieces[#pieces] = aimspot

flesh = piece"flesh"
--- - i know the api.. its all in my Head... brb, have to see doctor freeman
-- throws the unit grabbed by the elephant appendix
function legsDown()
    for i = 1, table.getn(pieces), 1 do
        Turn(pieces[i], x_axis, math.rad(0), 17)
        Turn(pieces[i], y_axis, math.rad(0), 17)
        Turn(pieces[i], z_axis, math.rad(0), 17)
    end
end

function setMeatHiveHoundParent(unitID, jhiveHoundMeatID)
myTeam=Spring.GetUnitTeam(unitID)
	for mom, data in pairs( GG.HiveHoundTable[myTeam]) do
		for i=1,#data do
			if type(data)=="table" and data[i][1] == unitID then
			GG.HiveHoundTable[myTeam][mom][i][1] = jhiveHoundMeatID
			end
		end

	end
end

function script.HitByWeapon(x, z, weaponDefID, damage)
	hp,mp=Spring.GetUnitHealth(unitID)
	if hp < mp*0.5 then
		Explode(flesh, SFX.FALL +SFX.NO_HEATCLOUD)
		jhiveHoundID=  transformUnitInto(unitID, "jHiveWulf")
		setMeatHiveHoundParent(unitID, jhiveHoundID, nil, false)
	end
return damage
end



function waveTail()
Signal(SIG_TAIL)
SetSignalMask(SIG_TAIL)
	while true do
	val=math.random(35,67)
	tSyncIn(Tail, math.random(-10,10),val,0, 420)
	Sleep(420)
	tSyncIn(Tail, math.random(-10,10),val*-1,0, 420)
	Sleep(420)

	end
end



function walk()
    Turn(Tail, x_axis, math.rad(-15), 1)
    Move(body, y_axis, 0, 12)
    Move(body, z_axis, 0, 12)
    Move(body, x_axis, 0, 12)
    SetSignalMask(SIG_WALK)
    while true do
        Turn(body, y_axis, math.rad(-3), 0.25)
        rand = math.random(-22, -16)
        Turn(fUpR, x_axis, math.rad(-rand), 3.5)
        Turn(ffootR, x_axis, math.rad(rand), 3.5)
        Turn(bUpL, x_axis, math.rad(-rand), 3.5)
        Turn(bfootL, x_axis, math.rad(rand), 3.5)
        rand = math.random(8, 22)
        Turn(fUpL, x_axis, math.rad(-rand), 3.5)
        Turn(ffootL, x_axis, math.rad(-rand), 3.5)
        Turn(bUpR, x_axis, math.rad(-rand), 3.5)
        Turn(bfootR, x_axis, math.rad(-rand), 3.5)
        WaitForTurn(bfootR, x_axis)
        Sleep(350)
        Turn(body, y_axis, math.rad(0), 0.25)
        rand = math.random(-22, -16)
        Turn(fUpL, x_axis, math.rad(-rand), 3.5)
        Turn(ffootL, x_axis, math.rad(rand), 3.5)
        Turn(bUpR, x_axis, math.rad(-rand), 3.5)
        Turn(bfootR, x_axis, math.rad(rand), 3.5)
        rand = math.random(8, 22)
        Turn(fUpR, x_axis, math.rad(-rand), 3.5)
        Turn(ffootR, x_axis, math.rad(-rand), 3.5)
        Turn(bUpL, x_axis, math.rad(-rand), 3.5)
        Turn(bfootL, x_axis, math.rad(-rand), 3.5)
        WaitForTurn(bfootR, x_axis)
        Sleep(350)
    end
end




function script.StartMoving()

    Signal(SIG_WALK)
    StartThread(walk)
end



function script.StopMoving()
    Signal(SIG_WALK)
    StartThread(legsDown)
    StartThread(waveTail)
end

--------------------------------------------------------------------------
function script.Killed()
	Explode(flesh, SFX.FALL + SFX.NO_HEATCLOUD)		
    Move(rotor, y_axis, math.rad(-25), 39)
    Spin(rotor, y_axis, math.rad(42), 17)
    for i = 1, 5 do
        EmitSfx(body, 1025)
        Sleep(250)
    end
    return 0
end




function getReadyJump()
    oneInTwen = math.random(0, 20)
    if oneInTwen == 10 then
        oneOrTwo = math.random(0, 1)
        if oneOrTwo == 0 then
            Spring.PlaySoundFile("sounds/jhivehound/juniorwulf.wav")
        end
    end

    Move(body, y_axis, -3, 17)
    Turn(bUpL, x_axis, math.rad(39), 17)
    Turn(bUpR, x_axis, math.rad(39), 17)
    Turn(bfootL, x_axis, math.rad(-39), 17)
    Turn(bfootR, x_axis, math.rad(-39), 17)
    Turn(fUpL, x_axis, math.rad(19), 17)
    Turn(fUpR, x_axis, math.rad(19), 17)
    Sleep(900)
end


----------------------------------------- WEAPON ONE ----------------------------
function script.AimFromWeapon1()
    return aimspot
end

function script.QueryWeapon1()
    return aimspot
end

function landing()
    Sleep(200)
    legsDown()
end

function inLimit(value, altVal, limit)
    if value < altVal - limit or value > altVal + limit then return false
    else return true
    end
end


function emitBlood()
    for i = 1, 12, 1 do
        rand = math.random(-25, -15)
        Turn(Head, y_axis, math.rad(rand), 22)
        EmitSfx(jaw, 1024)
        Sleep(256)
        rand = math.random(15, 25)
        Turn(Head, y_axis, math.rad(rand), 22)
        EmitSfx(jaw, 1024)
        Sleep(256)
    end
end

function dieAfterTime()
Sleep(42000)
Spring.DestroyUnit(unitID, false, true)

end

function script.Create()
    StartThread(dieAfterTime)
    StartThread(emitBlood)
end