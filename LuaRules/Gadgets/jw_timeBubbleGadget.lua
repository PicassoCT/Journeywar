function gadget:GetInfo()
	return {
		name = "jw_timebubblegadget",
		desc = "This gadget handles timebubbling as applied by the shroudshrike",
		author = "",
		date = "Sep. 2008",
		license = "GNU GPL, v2 or later",
		layer = 2048,
		enabled = true,
	}
end

if (gadgetHandler:IsSyncedCode()) then
	VFS.Include("scripts/lib_OS.lua")
	VFS.Include("scripts/lib_UnitScript.lua")
	VFS.Include("scripts/lib_Animation.lua")
	VFS.Include("scripts/lib_Build.lua")
	VFS.Include("scripts/lib_jw.lua")
	
	
	--Centrail Weapons
	jshroudtimerrayWeaponDefID = WeaponDefNames["jshroudtimerray"].id

	Script.SetWatchWeapon(jshroudtimerrayWeaponDefID, true)
	--units To be exempted from instantly lethal force

	--
	
	function gadget:Explosion(weaponDefID, px, py, pz, AttackerID)

		if weaponDefID == jshroudtimerrayWeaponDefID then
			Spring.CreateUnit("jmirrorbubble",px,py,pz,1, Spring.GetUnitTeam(AttackerID))
			return true
		end
	end
	
	
	

end