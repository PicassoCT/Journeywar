function gadget:GetInfo()
	return {
		name = "timebubblegadget",
		desc = "This gadget handles timebubbling as applied by the shroudshrike",
		author = "",
		date = "Sep. 2008",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = false,
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
	local lethalBuffExecptionTypes = getExemptFromLethalEffectsUnitTypeTable(UnitDefNames)
	airTypeTable= getAirUnitTypeTable()
	abstractTypes= getAbstractTypes()
	infantryTypes = getInfantryTypeTable()
	local gaiaTeamID = Spring.GetGaiaTeamID()
	
	--Eine Mirrorbubble beginnt zu existieren, wenn das Shroudshrike kontinuierlich auf eine Position in der Landschaft schießt
	--Sie wächst langsam aber kontinuierlich, mit jedem darauf abgefeuerten Projektil (wirkt als Schild)
	--Begeht eine Einheit Selbstmord in einer Mirrorbubble, so wird die Bubble zurückgesetzt, alle Einheiten werden wiederhergestellt und transformiert
		-- Währendessen bildet die Bubble eine Skulptur
	
	
	--Stirbt das projezierende Shrike getötet oder Abgelenkt, entsteht eine Skulptur, die solange existiert,
	--wie die Bubble existiert hat
	--Einheiten die in einer Timebubble sind, können diese nicht verlassen, solange
	--Ein Shroudshrike kann in  seiner eigenen Blase gefangen sein
	
	--Skulptur ist eine Einheit die a)entweder in einem Orbit schwebt
								--  b) Stillsteht
	
	local timeBubble = {
	
	existTime=Spring.GetGameFrame(),
	orginalUnit=-1
	
	
	
	
	}
	
	
	function gadget:Explosion(weaponDefID, px, py, pz, AttackerID)
	end
	
	--===========UnitDamaged Functions ====================================================
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
	end

	function gadget:ProjectileCreated(proID, proOwnerID, projWeaponDefID)
	end
	
	function gadget:ProjectileDestroyed(proID, proOwnerID)
	end
	
	
	function gadget:GameFrame(frame)
	end
	
	function gadget:ShieldPreDamaged(proID, proOwnerID, shieldEmitterWeaponNum, shieldCarrierUnitID, bounceProjectile,startx, starty, startz, hitx, hity, hitz)
	end
end