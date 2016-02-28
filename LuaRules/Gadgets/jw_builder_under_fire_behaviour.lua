

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Allow Builder Hold Fire",
    desc      = "Sets whether a builder can fire while doing anything nanolathe related.",
    author    = "Google Frog",
    date      = "22 June 2014",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end
	
		local C_CITADEL_DEF_ID = UnitDefNames["citadel"].id
	local J_BEANSTALK_DEF_ID = UnitDefNames["beanstalk"].id
	

if ( gadgetHandler:IsSyncedCode()) then
	function gadget:AllowBuilderHoldFire(unitID, unitDefID, action)
		if UnitDef == C_CITADEL_DEF_ID or UnitDef == J_BEANSTALK_DEF_ID then
			return false
		else	
			return true
		end
	end
end


