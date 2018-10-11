include "createCorpse.lua"
--Define the wheel pieces

--Define the pieces of the weapon

local start = piece "start"

--define other pieces



function fromTimeToTime()
    local spPlaySoundFile = Spring.PlaySoundFile
    while (true) do
        Sleep(1000)
        dice = math.random(0, 10)
        if dice == 3 then
            anyThingButPlayItLoud = math.random(0.75, 1)
            spPlaySoundFile("sounds/jbeehive/beehiveactive.wav", anyThingButPlayItLoud)
        end
    end
end

function script.Create()
	teamID=Spring.GetUnitTeam(unitID)
	x,y,z=Spring.GetUnitPosition(unitID)
	GG.UnitsToSpawn:PushCreateUnit("gbeehiveplate",x,y,z,0,teamID)
    StartThread(fromTimeToTime)
end





--- -aimining & fire weapon
function script.AimFromWeapon1()
    return start
end

function script.QueryWeapon1()
    return start
end

salvoValid = 1

function script.AimWeapon1(heading, pitch)


    Turn(start, y_axis, heading, 4)
    Turn(start, x_axis, -pitch, 4)
    WaitForTurn(start, y_axis)

    return salvoValid < 6
end

boolPlaySound = false
function playActivateSound()
    boolPlaySound = true
    Spring.PlaySoundFile("sounds/jbeehive/beeAktiv.wav")
    Sleep(4500)
    boolPlaySound = false
end

function salvoReload()
    Sleep(4000)
    salvoValid = 1
    boolOnce = false
end

boolOnce = false
function script.FireWeapon1()
    salvoValid = salvoValid + 1
    if salvoValid >= 6 and boolOnce == false then
        boolOnce = true
        StartThread(salvoReload)
    end
    if boolPlaySound == false then StartThread(playActivateSound) end
    return true
end


function script.Killed(recentDamage, maxHealth)
    createCorpseJBuilding(unitID, recentDamage)
    return 1
end

--Building


