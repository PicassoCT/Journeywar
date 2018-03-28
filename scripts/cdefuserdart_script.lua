include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua"
include "lib_Animation.lua"
include "lib_jw.lua"
include "lib_Build.lua"

--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center = piece "center"
dart = piece "dart"

function script.Create()
	
    StartThread(uHave20Seconds)
    StartThread(maxTime)
end

function uHave20Seconds()
    Sleep(20000)
    dropDead()
end

function maxTime()
    Sleep(80000)
    dropDead()
end


function script.Killed(recentDamage, _)
    return 1
end


--- -aimining & fire weapon
function script.AimFromWeapon1()
    return dart
end



function script.QueryWeapon1()
    return dart
end

function script.AimWeapon1(Heading, pitch)
    --aiming animation: instantly turn the gun towards the enemy
    return true
end

typesAsStrings={
"jsuneggnogg",
"jracedart"
}

dartableTypeTable = getTypeTable(UnitDefNames, typesAsStrings)

function script.FireWeapon1()
	x,y,z=Spring.GetUnitPosition(unitID)
	process(getAllInSphere(x,y,z,35),
			function(id)
				if dartableTypeTable[Spring.GetUnitDefID(id)]
					Spring.DestroyUnit(id,true,false)
					for i=1,4 do
						Explode(dart,SFX.SHATTER + SFX.FIRE)			
					end
					Spring.DestroyUnit(unitID,true,false)
				end
			)
    return true
end

function dropDead()
    Move(center, y_axis, -22, 12)
    Sleep(2000)
    Spring.DestroyUnit(unitID, false,true)
end


function script.StartMoving()
    Signal(SIG_DROP)
end

local SIG_DROP = 2

function TimeDelayedDrop()
    SetSignalMask(SIG_DROP)
    Sleep(2000)
    dropDead()
end

function script.StopMoving()
    Signal(SIG_DROP)
    StartThread(TimeDelayedDrop)
end