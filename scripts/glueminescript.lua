include "suddenDeath.lua"
include "toolKit.lua"

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end

center=piece"center"

pieces={}
for i=1,8 do
if i~= 4 and i~= 8 then
name="Kugel"..i
pieces[#pieces+1]=piece(name)
end
end

function script.Create()
spinT(pieces, y_axis,0.02,12,22)
spinT(pieces, x_axis,0.02,12,22)
spinT(pieces, z_axis,0.02,12,22)
end

function script.Killed(recentDamage,_)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return center 
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


function script.Activate()

return 1
end

function script.Deactivate()

return 0
end
