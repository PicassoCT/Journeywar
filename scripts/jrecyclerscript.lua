include "suddenDeath.lua"
include "toolKit.lua"

 piecesTable={}
 deathpivot = piece"deathpivot"
 piecesTable[#piecesTable+1]= deathpivot
 center = piece"center"
 piecesTable[#piecesTable+1]= center
 Body = piece"Body"
 piecesTable[#piecesTable+1]= Body
 UpJoin01 = piece"UpJoin01"
 piecesTable[#piecesTable+1]= UpJoin01
 UpJoin02 = piece"UpJoin02"
 piecesTable[#piecesTable+1]= UpJoin02
 UpJoin03 = piece"UpJoin03"
 piecesTable[#piecesTable+1]= UpJoin03
 UpJoin04 = piece"UpJoin04"
 piecesTable[#piecesTable+1]= UpJoin04
 UpJoin05 = piece"UpJoin05"
 piecesTable[#piecesTable+1]= UpJoin05
 UpJoin06 = piece"UpJoin06"
 piecesTable[#piecesTable+1]= UpJoin06
 reclaimspot = piece"reclaimspot"
 piecesTable[#piecesTable+1]= reclaimspot


function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"

function script.Create()
generatepiecesTableAndArrayCode(unitID)

end

function script.Killed(recentDamage,_)

suddenDeathjBuildCorpse(unitID, recentDamage)
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

