--statue spawn gadget

function gadget:GetInfo()
    return {
        name = "Unit Data Collection",
        desc = "Collects Engagment Data and Displays it at game end",
        author = "pica",
        date = "Anno Domini 2017",
        license = "Comrade Stallmans License",
        layer = 109,
        version = 1,
        enabled = true,
        hidden = true
    }
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear
if (gadgetHandler:IsSyncedCode()) then
	EncounterData ={}
	EncounterCounter = 0
	
    function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
	
		if UnitDefs[unitDefID] 
			attacker = Spring.GetUnitLastAttacker(unitID)
				if attacker then
				
				uexp = Spring.GetUnitExperience(unitID)
				aexp = 	Spring.GetUnitExperience(unitID)		
						
				attackerDefID = Spring.GetUnitDefID(attacker)
				if not EncounterData[attackerDefID] then  EncounterData[attackerDefID] = {} end
				if not EncounterData[attackerDefID][unitDefID] then  EncounterData[attackerDefID] [unitDefID] = 0 end
				EncounterData[attackerDefID][unitDefID] = EncounterData[attackerDefID][unitDefID] + 1
				EncounterCounter = EncounterCounter + 1
			end
		end
    end
	
	function gadget:GameOver()
		printEncounterData()
		printUnitCreatedData()
	end

	
	function printEncounterData()
		
		for k,v in pairs(EncounterData) do
		selftypeName = UnitDefs[k].name
			for victimType, number in pairs(v) do
			vicitmTypeName = UnitDefs[victimType].name
			Spring.Echo("Unit "..selftypeName.." destroyed  "..number.." Units of Type "..vicitmTypeName .. " making up ".. number/EncounterCounter.." %  of all encounters")
			end
		end
	end
	
	function printUnitCreatedData()
		for team, unitTable in pairs(UnitCreatedData) do
			for unitdefName, number in pairs(unitTable) do
				Spring.Echo("Team "..team.." Unit "..UnitDefs["unitdefName"].id..(number/ UnitCreatedCount[team]).." % ")
			end
		end	
	end

	UnitCreatedData={}
	UnitCreatedCount={}
	
    function gadget:UnitCreated(unitID, unitDefID)
	
		teamID = Spring.GetUnitTeamID(unitID)
        if not UnitCreatedData[teamID] then UnitCreatedData[teamID]= {} end
        if not UnitCreatedCount[teamID] then UnitCreatedCount[teamID]= 0 end
        if not UnitCreatedData[teamID][unitDefID] then UnitCreatedData[teamID][unitDefID]= 0 end
		UnitCreatedData[teamID][unitDefID] = UnitCreatedData[teamID][unitDefID] + 1
		UnitCreatedCount[teamID] = UnitCreatedCount[teamID] + 1
    end
end