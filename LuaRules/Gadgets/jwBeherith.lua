

function gadget:GetInfo()
  return {
    name      = "Cares for the Behes Shoes",
    desc      = "",
    author    = "Nothing and NoOne, and NoOne and Nothing",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts




if (gadgetHandler:IsSyncedCode()) then



	weapondefID1 = WeaponDefNames["jfootstomp"].id
	Script.SetWatchWeapon(weapondefID1 , true)







  function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
	  if (weaponID==weapondefID1) then
		  Spring.DestroyUnit(unitID,true,false)  
	  end
  
   
  end

end