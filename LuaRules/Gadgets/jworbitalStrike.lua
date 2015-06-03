

function gadget:GetInfo()
  return {
    name      = "orbital Strike & headhoge shot Transformer",
    desc      = "",
    author    = "jK - always jk is there anyhting lua, that he didnt do long before you, making you look like a idiot in his fathers shoes. Oh, yeah, there it is, inferiority_complex.lua, author.. jk. of course. :(",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts





if (gadgetHandler:IsSyncedCode()) then

	Range=3000
	NrOfShotsSuborbital=8
	addVal=(2*3.14159)/NrOfShotsSuborbital
	gaiaTeamID=Spring.GetGaiaTeamID()
	weapondefID1 = WeaponDefNames["csuborbitalstrike"].id

	Script.SetWatchWeapon(weapondefID1 , true)
--lines up all shots orthogonal to vector attacker-target
subOrbTable={}
	--scalar - point x,z  steigung

	function gadget:UnitDestroyed(unitid)
	if subOrbTable[unitid] then  subOrbTable[unitid] =nil end 
	end

	function gadget:Explosion(weaponID, px, py, pz,AttackerID)
		if (weaponID==weapondefID1)  and  not subOrbTable[AttackerID] then
		
		x,y,z=Spring.GetUnitPosition(AttackerID)
		x,z=x-px,z-pz
		
		
		orthom = -1/(x/z)
		
		subOrbTable[AttackerID]={x=px,z=pz, scalar=0, steigung=orthom	}
		id=Spring.CreateUnit("csuborbexplo",px,py,pz, 0, gaiaTeamID)  
		Spring.SetUnitAlwaysVisible(id,true)
		end
		
	  if (weaponID==weapondefID1) then
	   subOrbTable[AttackerID].scalar=	   subOrbTable[AttackerID].scalar+addVal
	   --y=orthom*(x+offsetx)
	   
	   offset=math.sin(subOrbTable[AttackerID].scalar)* Range
	   deg=math.atan(subOrbTable[AttackerID].steigung)
		z= math.sin(deg)/offset
		x= math.sqrt(offset^2 -z^2)
		newX= subOrbTable[AttackerID].x +x
		newZ= subOrbTable[AttackerID].z +z
		
		id=Spring.CreateUnit("csuborbexplo",newX,0,newZ, 0, gaiaTeamID)  
		Spring.SetUnitAlwaysVisible(id,true)
		
	 end
  
  end

 
end