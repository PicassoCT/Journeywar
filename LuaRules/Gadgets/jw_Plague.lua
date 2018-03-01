function gadget:GetInfo()
    return {
        name = "j Plague",
        desc = "Kills the infected ",
        author = "zwzsg",
        date = "3rd of May 2010",
        license = "Free",
        layer = 0,
        version = 1,
        enabled = true
    }
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then
	VFS.Include('scripts/lib_jw.lua')
    local doneFor = {}



    -- Configuration:

    local spValidUnitID = Spring.ValidUnitID
    local spGetUnitPosition = Spring.GetUnitPosition
    local spCreateUnit = Spring.CreateUnit

    local spGetUnitDEFID = Spring.GetUnitDefID
    local teamID = Spring.GetGaiaTeamID()
	sparedUnits= getFungiImuneUnitTypeTable(getUnitDefNames(UnitDefs))
	
	
	function handleSpores(frame, tableToItterate, sporeToSpawn)
		if tableToItterate then
            max = table.getn(tableToItterate)
		
            for i = 1, max, 1 do
				id= tableToItterate[i]
                if id  then
					
                    --make sure the unit still exists
                    tempID = nil
					
                    if spValidUnitID(id) == true and not doneFor[id] then
					Spring.Echo("jw_plague:Unit".."1" )                
				-- get DefID to make sure i aint a spore
                        tempDefID = spGetUnitDEFID(id)
                        if tempDefID and not sparedUnits [tempDefID] then
						Spring.Echo("jw_plague:Unit".."2" )  
                            --get location to spawn the jspore
                            tx, ty, tz = spGetUnitPosition(id)
                            --spawn the spore nearby with the units team
                            tempID = spCreateUnit(sporeToSpawn, tx, ty, tz, 0, teamID)
                            --now lets get the units Table
                            env = Spring.UnitScript.GetScriptEnv(tempID)
                            if env then
								Spring.Echo("jw_plague:Unit".."3" )  
                                Spring.UnitScript.CallAsUnit(tempID, env.handsUpAhemDown, id)
                            end
                        end
                    end

                    if tempID  then
					    doneFor[id] = tempID
                    end                   
                end
            end
        end	
	end
	
	
	
    function gadget:GameFrame(frame)

        if frame % 250 == 0 then
			if GG.Spores then
				handleSpores(frame, GG.Spores, "jspore")
				GG.Spores={}
			end
			
			if GG.GoldSpore then
				handleSpores(frame, GG.GoldSpore, "jgoldspore")
				GG.GoldSpores={}
			end
        end
    end
end
