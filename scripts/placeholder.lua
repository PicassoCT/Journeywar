include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"

function script.Create()
generatepiecesTableAndArrayCode(unitID)
StartThread(testEmit)
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
end

function testEmit()
Sleep(500)
Kugel=piece"Kugel02"
Move(Kugel,y_axis, -40,0)
Move(Kugel,x_axis,100,0)
Hide(Kugel)
	if Kugel then
		while true do
	
		EmitSfx( Kugel,1025)
		Sleep(1300)
		EmitSfx(Kugel,1024 )
		Sleep(10000)
		end
	end
end


function script.QueryWeapon1() 
	return center
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
end



function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end

function script.QueryBuildInfo() 
  return center 
end

function script.QueryNanoPiece()
     return center
end

