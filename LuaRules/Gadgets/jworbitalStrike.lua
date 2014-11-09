

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


	gaiaTeamID=Spring.GetGaiaTeamID()
	weapondefID1 = WeaponDefNames["csuborbitalstrike"].id

	Script.SetWatchWeapon(weapondefID1 , true)







  function gadget:Explosion(weaponID, px, py, pz)
	  if (weaponID==weapondefID1) then
		 Spring.CreateUnit("csuborbexplo",px,py,pz, 0, gaiaTeamID)  
	 end
  
  end

 
end