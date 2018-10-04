--statue spawn gadget

function gadget:GetInfo()
	return {
		name = "Unit Data Collection",
		desc = "Collects Engagment Data and Displays it at exit of person",
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
	AccumulatedTotalDamage= 0
	
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
	if weaponDefID and damage then
		if not WeaponCostEffectiveness[weaponDefID] then WeaponCostEffectiveness[weaponDefID]  = 0 end
		WeaponCostEffectiveness[weaponDefID] = WeaponCostEffectiveness[weaponDefID] + damage	
		AccumulatedTotalDamage= AccumulatedTotalDamage+damage
	end
	end
	
	function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
		if UnitDefs[unitDefID] then
			attacker = Spring.GetUnitLastAttacker(unitID)
			if attacker then
								
				attackerDefID = Spring.GetUnitDefID(attacker)
				if not EncounterData[attackerDefID] then EncounterData[attackerDefID] = {} end
				if not EncounterData[attackerDefID][unitDefID] then EncounterData[attackerDefID] [unitDefID] = 0 end
				EncounterData[attackerDefID][unitDefID] = EncounterData[attackerDefID][unitDefID] + 1
				EncounterCounter = EncounterCounter + 1
			end
		end
	end
	
	function printAllStatistics()
		echo("===========================DamageData====================================")
			printEncounterData()
		echo("===========================UnitCreatedData===============================")
			printUnitCreatedData()
		echo("===========================WeaponDamageData==============================")
			printWDefData()
		echo("=========================================================================")
	end
	
	function gadget:PlayerRemoved(playerID, reason)
		printAllStatistics()
	end
	
	function printWDefData()
		NormalizedWeaponDefs={}
		biggestValue=-math.huge
		for weaponDefID, Data in pairs(WeaponCostEffectiveness) do
			weaponName = WeaponDefs[weaponDefID].name
			totalPercentDamage= Data/AccumulatedTotalDamage
			biggestValue= math.max(biggestValue, Data)			
			echo("Weapon "..weaponName.." has inflichted "..totalPercentDamage.." percent of all damage dealt.")
		end
		
		for weaponDefID, Data in pairs(WeaponCostEffectiveness) do
			NormalizedWeaponDefs[weaponDefID] = Data/ biggestValue
		end
		
	end

	--How much proportional economic damage did the unittype inflict
	function calcCostEffectiveness(Unit, EncountersWon, TotalEncounters, Enemy)
		uMetall,uEnergy = getUnitCost(Unit)
		eMetall,eEnergy = getUnitCost(Enemy)
		uCost = uMetall + uEnergy
		eCost = eMetall + eEnergy
	
	EncountersLost = TotalEncounters - EncountersWon
	
		return (uCost*EncountersWon)/ (eCost*EncountersLost)	
	end
	
	function printEncounterData()
		
		for k,v in pairs(EncounterData) do
			selftypeName = UnitDefs[k].name
			for victimType, number in pairs(v) do
				vicitmTypeName = UnitDefs[victimType].name
				Spring.Echo("Unit "..selftypeName.." destroyed "..number.." Units of Type "..vicitmTypeName .. " making up ".. number/EncounterCounter.." % of all encounters")
			end
		end
	end
	
	function printUnitCreatedData()
		for team, unitTable in pairs(UnitCreatedData) do
			for unitdefName, number in pairs(unitTable) do
				Spring.Echo("Team "..team.." Unit "..UnitDefs[unitdefName].name.." "..(number/ UnitCreatedCount[team]).." % ")
			end
		end	
	end
	WeaponCostEffectiveness= {}
	UnitCreatedData={}
	UnitCreatedCount={}
	
	function gadget:UnitCreated(unitID, unitDefID)
		
		teamID = Spring.GetUnitTeam(unitID)
		if not UnitCreatedData[teamID] then UnitCreatedData[teamID]= {} end
		if not UnitCreatedCount[teamID] then UnitCreatedCount[teamID]= 0 end
		if not UnitCreatedData[teamID][unitDefID] then UnitCreatedData[teamID][unitDefID]= 0 end
		UnitCreatedData[teamID][unitDefID] = UnitCreatedData[teamID][unitDefID] + 1
		UnitCreatedCount[teamID] = UnitCreatedCount[teamID] + 1
	end
end
