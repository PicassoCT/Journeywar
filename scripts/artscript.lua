include "createCorpse.lua"
include "lib_UnitScript.lua"

local art = piece "art"
local ArtLoadtur = piece "ArtLoadtur"
local artbarrel = piece "artbarrel"
local artbarrel2 = piece "artbarrel2"
local artbarrel3 = piece "artbarrel3"
local flare02 = piece "flare02"
local artclaws = piece "artclaws"
local flare01 = piece "flare01"
local barrelmovespeed = 5
local SIG_WALK = 1 --signal for the walk animation thread
local SIG_AIM = 2 --signal for the weapon aiming thread
local boolSecondaryWeapon = false
local boolHCReloadedAndReadyToFire = true
local boolPlasmaReloadedAndReadyToFire = true
local boolSoundPlaying = false

function script.Create()
    --Spring.Echo "This was a Triumph! Im making a note here huge Success!"
    Hide(flare01)
    Hide(flare02)
	StartThread(reloadHeadCrabs)
	StartThread(speedManager)
end

function script.Killed(recentDamage, _)
    Explode(art, SFX.SHATTER)
    Explode(ArtLoadtur, SFX.FIRE)
    Explode(artbarrel, SFX.FIRE)
    Explode(artbarrel2, SFX.FIRE)
    Explode(artbarrel3, SFX.FIRE)
    Explode(flare02, SFX.FIRE)
    Explode(artclaws, SFX.FIRE)
    Explode(flare01, SFX.FIRE)

    --Spring.SpawnCEG

    --( string "cegname",
    -- number posX = 0, number posY = 0, number posZ = 0,
    -- number dirX = 0, number dirY = 0, number dirZ = 0,
    -- number radius = 0, number damage = 0
    -- )

    createCorpseCUnitGeneric(recentDamage)
end

function script.Activate()
    --activates the secondary weapon
    boolSecondaryWeapon = false
    return 1
end

function script.Deactivate()
    --deactivates the secondary weapon
    boolSecondaryWeapon = true

    return 0
end

function script.AimFromWeapon2()



    return flare02
end

function script.QueryWeapon2()
    return flare02
end


unitdef = Spring.GetUnitDefID(unitID)
boolSoundOnlyOnce = false
boolPlasmaReady = false
function playChargeUpSound()
    StartThread(PlaySoundByUnitDefID, unitdef, "sounds/cart/lnduo.wav", 1, 5000, 1, 0)
    Sleep(5000)
    boolPlasmaReady = true
end

boolTimedOut=false
function timeOutThread()
boolTimedOut=false
Sleep(7000)
	if boolFiringRequested== false then boolTimedOut = true end

end

boolFiringRequested = false
boolInFiringPosition = false
function speedManager()
	setSpeedEnv(unitID,1.0)

	while true do
	Sleep(250)
		if boolFiringRequested == true and boolHCReloadedAndReadyToFire == false or boolPlasmaReloadedAndReadyToFire == false then
			Move(artclaws, y_axis, -7, 3)
			WaitForMove(artclaws, y_axis)
			setSpeedEnv(unitID,0.0)
			boolInFiringPosition= true
			StartThread(timeOutThread)
		end
		
		if boolFiringRequested == false and boolInFiringPosition== true and boolTimedOut == true then
			Move(artclaws, y_axis, 0, 3)
			WaitForMove(artclaws, y_axis)
			setSpeedEnv(unitID,1.0)
			boolInFiringPosition = false	
		end
	end
end

        if boolSoundOnlyOnce == false then
            boolSoundOnlyOnce = true
            
        end

		
function script.AimWeapon2(heading, pitch)
	boolFiringRequested = true
    if boolInFiringPosition == true and boolPlasmaReloadedAndReadyToFire == true and boolSecondaryWeapon == true then       
        return boolPlasmaReady
    end

    return false
end

boolStop = true
local function move()
    boolSoundPlaying = true
    while (boolStop == false) do
        Spring.PlaySoundFile("sounds/cart/artilleryMove2.wav", 0.1)
        Sleep(3500)
    end
    boolSoundPlaying = false
end




function script.StartMoving()
    boolStop = false
    if boolSoundPlaying == false then
        StartThread(move)
    end
end

function script.StopMoving()
    boolStop = true
end

function plasmaReload()
	
    boolPlasmaReady = false
    boolPlasmaReloadedAndReadyToFire = false
	boolFiringRequested= false

    Move(artbarrel3, y_axis, -17, 45)
    WaitForMove(artbarrel3, y_axis)
    Move(artbarrel2, y_axis, -16, 35)
    WaitForMove(artbarrel2, y_axis)
    Move(artbarrel, y_axis, -20, 20)
    WaitForMove(artbarrel, y_axis)

    --Sleep(400)
    --RestorePieces()
	StartThread(playChargeUpSound)
    Move(artbarrel, y_axis, 0, barrelmovespeed)
    WaitForMove(artbarrel, y_axis)
    Move(artbarrel2, y_axis, 0, barrelmovespeed)
    WaitForMove(artbarrel2, y_axis)
    Move(artbarrel3, y_axis, 0, barrelmovespeed)
    --WaitforMove(artbarrel3,y_axis)

	boolPlasmaReloadedAndReadyToFire = true

end



function script.FireWeapon2()
   StartThread(plasmaReload)
   Sleep(5000)
end

----------------------------------------------------------------------------------
function script.AimFromWeapon1()



    return flare02
end

function script.QueryWeapon1()
    return flare02
end



function script.AimWeapon1(heading, pitch)
	boolFiringRequested = true
    if boolInFiringPosition == true and  boolHCReloadedAndReadyToFire == true and boolSecondaryWeapon == false then
    
        return true
    end

    return false
end

function reloadHeadCrabs()
    boolHCReloadedAndReadyToFire = false
	 boolFiringRequested= false
    Show(flare01)
    Explode(flare01, SFX.FIRE)
    Hide(flare01)
    Move(artbarrel3, y_axis, -17, 45)
    WaitForMove(artbarrel3, y_axis)
    Move(artbarrel2, y_axis, -16, 35)
    WaitForMove(artbarrel2, y_axis)
    Move(artbarrel, y_axis, -20, 20)
    WaitForMove(artbarrel, y_axis)

    --Sleep(400)
    --RestorePieces()
    Move(artclaws, y_axis, 0, 6)
    WaitForMove(artclaws, y_axis)
    Move(artbarrel, y_axis, 0, barrelmovespeed)
    WaitForMove(artbarrel, y_axis)
    Move(artbarrel2, y_axis, 0, barrelmovespeed)
    WaitForMove(artbarrel2, y_axis)
    Move(artbarrel3, y_axis, 0, barrelmovespeed)
    --WaitforMove(artbarrel3,y_axis)
    Move(artclaws, y_axis, 0, 6)
    WaitForMove(artclaws, y_axis)
    boolHCReloadedAndReadyToFire = true

end


function script.FireWeapon1()
	StartThread(reloadHeadCrabs)
	Sleep(5000)
end