include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

include "lib_Build.lua" 


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

internalStorage = 0 

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
	Turn(center,x_axis,math.rad(90),0.5)
	Spin(deathpivot,z_axis,math.rad(42),0.5)
end

function script.StopMoving()
	Turn(center,x_axis,math.rad(0),1.5)
		StopSpin(deathpivot,z_axis,0.3)
end

function script.Activate()
	if internalStorage > 9000 then
		x,y,z= Spring.GetUnitPosition(unitID)
		teamID =Spring.GetUnitTeam(unitID)
		Spring.CreateUnit("beanstalk", x, y, z, 1, teamID)
		Spring.DestroyUnit(unitID,true,false)
	end
	return 1
end

function script.Deactivate()
	
	return 0
end

function script.QueryBuildInfo() 
	return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})