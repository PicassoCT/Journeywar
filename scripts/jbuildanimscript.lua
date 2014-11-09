include "suddenDeath.lua"
include "toolKit.lua"
--HitByWeapon ( x, z, weaponDefID, damage ) -> nil | number newDamage 

center=piece"center"

piecesTable={}
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= center
Egg = piece"Egg"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Egg
Objekt01 = piece"Objekt01"
piecesTable[#piecesTable+1]={}
piecesTable[#piecesTable]= Objekt01

function script.Create()

end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
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

