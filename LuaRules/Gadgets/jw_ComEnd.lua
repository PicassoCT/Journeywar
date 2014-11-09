--NOTE: UNTESTED CODE, EXECUTE IT UNDER YOUR PANTS um i mean your RESPONSABILITY


--NOTE: PUT THIS AT YOUR CONSTANTS DECLARATION AREA IN THE FILE


if (gadgetHandler:IsSyncedCode()) then

local C_COMMANDER_DEF_ID = UnitDefNames["ccomender"].id
local J_COMMANDER_DEF_ID = UnitDefNames["jabyss"].id

--NOTE: PUT THIS AT YOUR FUNCTIONS AREA IN THE FILE
function gadget:UnitDestroyed(Unit, UnitDef, Team)
	if UnitDef == C_COMMANDER_DEF_ID or UnitDef == J_COMMANDER_DEF_ID then
		--any code to be executed when commander dies
		Spring.KillTeam(Team)
	end
	
	-- if UnitDef== J_SPACEPOTATOE then
	-- x,y,z=Spring.GetUnitPosition(Unit)
		-- if x~= nil then
		-- gaiaTeamID=Spring.GetGaiaTeamID()
		-- Spring.CreateUnit("gvolcano",x,y,z,0,gaiaTeamID)
			-- else
			-- Spring.Echo("UnitDestroyedGadget:: Position undefined")
			-- end
	-- end
	
end
--NOTE: EOF

end