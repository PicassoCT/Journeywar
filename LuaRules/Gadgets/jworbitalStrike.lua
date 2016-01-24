

function gadget:GetInfo()
  return {
    name      = "orbital Strike ",
    desc      = "",
    author    = "jK - always jk is there anyhting lua, that he didnt do long before you, making you look like a idiot in his fathers shoes. Oh, yeah, there it is, inferiority_complex.lua, author.. jk. of course. :(",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

if (gadgetHandler:IsSyncedCode()) then

	Range=3000
	NrOfShotsSuborbital=8
	addVal=(2*3.14159)/NrOfShotsSuborbital
	gaiaTeamID=Spring.GetGaiaTeamID()
	csubOrbDefID = WeaponDefNames["csuborbitalstrike"].id

	Script.SetWatchWeapon(csubOrbDefID , true)
--lines up all shots orthogonal to vector attacker-target
subOrbTable={}
	--scalar - point x,z  steigung
	function getProjectileTargetXYZ (proID)
		local targetTypeInt, target  = Spring.GetProjectileTarget (proID)
			if targetTypeInt == string.byte('g') then
				return target[1],target[2],target[3]
			end
			if targetTypeInt == string.byte('u') then
				return Spring.GetUnitPosition (target)
			end
			if targetTypeInt == string.byte('f') then
				return Spring.GetFeaturePosition (target)
			end
			if targetTypeInt == string.byte('p') then
				return Spring.GetProjectilePosition (target)
			end
	end


	function gadget:UnitDestroyed(unitid)
	if subOrbTable[unitid] then  subOrbTable[unitid] =nil end 
	end
	
	
local weapons={[csubOrbDefID]=true}
local projectiles={}

	function gadget:ProjectileCreated(proID, proOwnerID, weaponID)
	if weapons[weaponID] then
	

		tx,ty,tz = getProjectileTargetXYZ (proID)
		projectiles[proID] = {id=proOwnerID, x=tx,y=ty,z=tz};	
	end
	end	

function gadget:ProjectileDestroyed(proID)
	if projectiles[proID] then
			if   subOrbTable[projectiles[proID].id] == nil then
			local AttackerID=projectiles[proID].id
			px,py,pz=	projectiles[proID].x,	projectiles[proID].y,	projectiles[proID].z
			Spring.Echo("First SubOrbitalImpact")
			teamid=Spring.GetUnitTeam(AttackerID)
			x,y,z=Spring.GetUnitPosition(AttackerID)
			
			x,z=x-px,z-pz
			head=math.atan2(x,z)
			norm=math.sqrt(x*x+z*z)
			
			orthom =  {z=x/norm,x=-1*(z/norm)}

			
			subOrbTable[AttackerID]={x=px,z=pz, scalar=0, vec=orthom, team=teamid, heading=head	}
			id=Spring.CreateUnit("csuborbexplo",px,py,pz, 0, teamid)  
			Spring.SetUnitRotation(id,0,head,0)
			Spring.SetUnitAlwaysVisible(id,true)
			end
			
		  if   subOrbTable[projectiles[proID].id] then
			local AttackerID=projectiles[proID].id
			
		   subOrbTable[AttackerID].scalar=	   subOrbTable[AttackerID].scalar+addVal

			x,z=subOrbTable[AttackerID].x,subOrbTable[AttackerID].z
			offset=math.sin(subOrbTable[AttackerID].scalar)* Range
			local vec=subOrbTable[AttackerID].vec
			vec.x,vec.z=vec.x*offset,vec.z*offset
			
			id=Spring.CreateUnit("csuborbexplo",x+vec.x,0,z+vec.z, 1, subOrbTable[AttackerID].team)  
			Spring.SetUnitRotation(id,0,subOrbTable[AttackerID].heading,0)
			Spring.SetUnitAlwaysVisible(id,true)
			
		 end	
	end
end
	


 
end