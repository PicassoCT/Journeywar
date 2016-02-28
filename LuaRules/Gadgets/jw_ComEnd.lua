--NOTE: UNTESTED CODE, EXECUTE IT UNDER YOUR PANTS um i mean your RESPONSABILITY


--NOTE: PUT THIS AT YOUR CONSTANTS DECLARATION AREA IN THE FILE


if (gadgetHandler:IsSyncedCode()) then
	
	local C_COMMANDER_DEF_ID = UnitDefNames["ccomender"].id
	local J_COMMANDER_DEF_ID = UnitDefNames["jabyss"].id

	function gadget:UnitDestroyed(Unit, UnitDef, Team)
		if (UnitDef == C_COMMANDER_DEF_ID and ( GG.LazarusDeviceActive[Unit] == nil or GG.LazarusDeviceActive[Unit] <= 0 )) 
		or UnitDef == J_COMMANDER_DEF_ID then
			--any code to be executed when commander dies
			Spring.KillTeam(Team)
		end
		
		
	end
	--NOTE: EOF
	
end