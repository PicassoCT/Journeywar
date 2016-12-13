include "createCorpse.lua"
include "lib_OS.lua"
 include "lib_UnitScript.lua" 
include "lib_Animation.lua"

 include "lib_Build.lua" 


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

function lifetimeDependingOnWater()
lifetimepercentage=100

	while lifetimepercentage > 0 do
	x,y,z=Spring.GetUnitPosition(unitID)
	subValue=1
		if y < 0 then 
		subValue = 0.3 
		else
		subValue=(1/(y/50))
		end
	lifetimepercentage=lifetimepercentage-subValue
	Sleep(1000)
	end
	Spring.DestroyUnit(unitID,false,true)
end

function script.Create()
spinT(pieces, y_axis,0.02,12,22)
spinT(pieces, x_axis,0.02,12,22)
spinT(pieces, z_axis,0.02,12,22)
StartThread(lifetimeDependingOnWater)
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
	
	endofLifeFunc= 	function (x,y,z)
					T=getAllInCircle(x,z,30,unitID)
						if T then
							if not GG.GluedForLife then GG.GluedForLife ={} end
							for i=1,#T do
							if not	GG.GluedForLife[T[i]] then GG.GluedForLife[T[i]]=1 end
							GG.GluedForLife[T[i]]=GG.GluedForLife[T[i]]*0.9
							end	
						end	
					Sleep(500)
					Spring.DestroyUnit(unitID,true,false)
					end	
		for i=1,2 do
		x,y,z=Spring.GetUnitPosition(unitID)
		--cegDevil(cegname, x,y,z,rate, lifetimefunc, endofLifeFunc,boolStrobo, range, damage, behaviour)
		StartThread( cegDevil,"gluesfx", x,y,z,300, 
					function(Time) return Time < 5000 end, 
					endofLifeFunc, true, 250, 0)
		end
	
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
