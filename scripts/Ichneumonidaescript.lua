include "suddenDeath.lua"
include "toolKit.lua"

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

function script.Create()
generatepiecesTableAndArrayCode(unitID)

end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
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

boolOpInProgress=false
boolLoaded=false
function operationInProgress(id)
boolOpInProgress=true
--Animation
Sleep(22000)
boolOpInProgress=false
TransportDrop(id)
end

function CreateDecoy(id)


end

function DropAnimation(id, x,y,z)

boolLoaded=false
return true
end

function healAnimation(id)


end

local gaiaTeamID=Spring.GetGaiaTeamID()
local ourTeam = Spring.GetUnitTeam(unitID)

function script.TransportPickup(passengerID)
if boolOpInProgress==true or boolLoaded== true then return end

if passengerTeam == gaiaTeamID then return end
	-- no napping!
	local passengerTeam = Spring.GetUnitTeam(passengerID)
	
	if   Spring.AreTeamsAllied(passengerTeam,ourTeam)== false  then
	StartThread(CreateDecoy,passengerID)
	StartThread(operationInProgress, passengerID)
	return true
	else --Transport
	boolLoaded=true
	StartThread(healAnimation,passengerID)
	return true
	end
	
end

function script.TransportDrop(passengerID, x, y, z)
	if boolLoaded  then  
	return DropAnimation(passengerID,x,y,z)
	end

	
end



function script.StartMoving()

end

function script.StopMoving()
		
		
end
