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
    local doneFor = {}

    function allreadyDoneFor(id)
        if doneFor == nil or table.getn(doneFor) == 0 then return false end
        for i = 1, #doneFor, 1 do
            if doneFor[i] == id then return true end
        end
        return false
    end


    -- Configuration:

    local spValidUnitID = Spring.ValidUnitID
    local spGetUnitPosition = Spring.GetUnitPosition
    local spCreateUnit = Spring.CreateUnit

    local spGetUnitDEFID = Spring.GetUnitDefID
    local teamID = Spring.GetGaiaTeamID()
	sparedUnits= {
	 [UnitDefNames["jgoldspore"].id]= true,
	 [UnitDefNames["jspore"].id]= true,
	 [UnitDefNames["jfungiforrest"].id]= true,
	}
	
	
	function handleNormalSpores(frame)
		if GG.Spore then
            max = table.getn(GG.Spore)


            for i = 1, max, 1 do
                if GG.Spore[i]  then
                    --make sure the unit still exists
                    tempID = nil
                    if spValidUnitID(GG.Spore[i]) == true and not doneFor[GG.Spore[i]] == false then
                        -- get DefID to make sure i aint a spore
                        tempDefID = spGetUnitDEFID(GG.Spore[i])
                        if tempDefID and not sparedUnits [tempDefID] then
                            --get location to spawn the jspore
                            tx, ty, tz = spGetUnitPosition(GG.Spore[i])
                            --spawn the spore nearby with the units team
                            tempID = spCreateUnit("jspore", tx, ty, tz, 0, teamID)
                            --now lets get the units Table
                            env = Spring.UnitScript.GetScriptEnv(tempID)
                            if env then
                                Spring.UnitScript.CallAsUnit(tempID, env.handsUpAhemDown, GG.Spore[i])
                            end
                        end
                    end

                    if tempID  then
					    doneFor[GG.Spore[i]] = tempID

                    end                   
                end
            end
        end	
		GG.Spore = {}	
	end
	
	function handleGoldSpores(frame)
		if GG.Spore then
            max = table.getn(GG.GoldSpore)
           
            for i = 1, max, 1 do
                if GG.GoldSpore[i]  then
                    --make sure the unit still exists
                    tempID = nil
                    if spValidUnitID(GG.GoldSpore[i]) == true and not doneFor[GG.GoldSpore[i]] == false then
                        -- get DefID to make sure i aint a spore
                        tempDefID = spGetUnitDEFID(GG.GoldSpore[i])
                        if tempDefID and not sparedUnits [tempDefID] then
                            --get location to spawn the jspore
                            tx, ty, tz = spGetUnitPosition(GG.GoldSpore[i])
                            --spawn the spore nearby with the units team
                            tempID = spCreateUnit("jgoldspore", tx, ty, tz, 0, teamID)
                            --now lets get the units Table
                            env = Spring.UnitScript.GetScriptEnv(tempID)
                            if env then
                                Spring.UnitScript.CallAsUnit(tempID, env.handsUpAhemDown, GG.GoldSpore[i])
                            end
                        end
                    end

                    if tempID  then
					    doneFor[GG.Spore[i]] = tempID

                    end                   
                end
            end
        end	
		GG.Spore = {}	
	end
	
    function gadget:GameFrame(frame)

        if frame % 250 == 0 then
				handleNormalSpores(frame)
				handleGoldSpores(frame)
        end
    end
end
