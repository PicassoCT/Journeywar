

function gadget:GetInfo()
  return {
    name      = "Beefeaterlua",
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





	weapondatID= WeaponDefNames["jbeefeatermarker"].id
	Script.SetWatchWeapon(weapondatID , true)
	
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID,  projectileID, attackerID, attackerDefID, attackerTeam) 
	----Spring.Echo("Unit damaged")
		  if (weapondatID==weaponDefID) and Spring.GetUnitIsDead(attackerID) == false then
		 -- --Spring.Echo("And the beefeater was it") 
			env = Spring.UnitScript.GetScriptEnv(attackerID)
			if env then
			 Spring.UnitScript.CallAsUnit(attackerID, env.hitIt, unitID )		
			--env.hitIt(attackerID)
			end
		  end
  

	end

 
end