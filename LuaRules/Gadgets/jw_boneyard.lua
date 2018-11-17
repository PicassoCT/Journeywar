-- $Id: unit_terraform.lua 4610 2009-05-12 13:03:32Z google frog $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Boneyard",
    desc      = "Handles the boneyard gamemode - converting scrap to small terraforms",
    author    = "Picasso",
    date      = "Nov, 2009",
    license   = "GNU GPL, v2 or later",
	handler = true,
    layer     = 0,
    enabled   = false--(Spring.GetModOptions().boneyard ~= "l") or false  --  loaded by default?
  }
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
if gadgetHandler:IsSyncedCode() then
	VFS.Include("scripts/lib_jw.lua" )
	VFS.Include("scripts/lib_OS.lua" )
	VFS.Include("scripts/lib_UnitScript.lua" )
	VFS.Include("scripts/lib_Build.lua" 	)
--------------------------------------------------------------------------------
-- SYNCED
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
	gaiaTeamID = Spring.GetGaiaTeamID()
	function gadget:Initialize()
		if ( Spring.GetModOptions().boneyard ~= "l" and gadget.Shutdown)  then
			gadget:Shutdown()
		end
	end
	
	battleScarDecals = getScrapYardDecalNames()
	
	function runningUpThatHill(x,z, sizefactor)
		jw_AddTerrainDeformation(x, z, size, 22,  2, prepareHalfSphereTable, "melt", "borderblur")	
	end	
	
	local jw_corpses = getCorpseTypeTable()
	local jw_features = getScrapYardFeatures(FeatureDefNames)
		
	function gadget:UnitCreated(unitID, unitDefID)

		if jw_corpses[unitDefID] then
			x,y,z = Spring.GetUnitPosition(unitID)

			Spring.DestroyUnit(unitID, true, false)
			 GG.UnitsToSpawn:PushCreateUnit(battleScarDecals[math.random(1,#battleScarDecals)],x,y,z,0,gaiaTeamID)
		end
	end	
	
	
	function gadget:FeatureCreated(featureID, allyTeam)
	featureID= Spring.GetFeatureDefID(featureID)
		if jw_features[featureID] then
			x,y,z = Spring.GetFeaturePosition(featureID, true)
				if x and y and x ~= featureID and y ~= true then
				Spring.DestroyFeature(featureID, false, false)
				if z and GG.UnitsToSpawn then
					GG.UnitsToSpawn:PushCreateUnit(battleScarDecals[math.random(1,#battleScarDecals)],x,y,z,0,gaiaTeamID)
				end
			end
		end
	end
	
	function gadget:Shutdown()
	
	end

end