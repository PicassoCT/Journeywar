

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

if ( gadgetHandler:IsSyncedCode()) then

	local C_CITADEL_DEF_ID = UnitDefNames["citadell"].id
	local J_BEANSTALK_DEF_ID = UnitDefNames["beanstalk"].id
	


	function gadget:AllowBuilderHoldFire(unitID, unitDefID, action)
		if unitDefID == C_CITADEL_DEF_ID or unitDefID == J_BEANSTALK_DEF_ID then
			return false
		else	
			return true
		end
	end
end


