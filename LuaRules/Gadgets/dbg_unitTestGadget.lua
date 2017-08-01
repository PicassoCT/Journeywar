function gadget:GetInfo()
	return {
		name = "jw_unit-test",
		desc = "Create eternal warfare",
		author = "Picasso",
		date = "SPAM/SPAM/SPAM/LOVELYSPAM",
		version = "v0.1.ham.and.jam.and...",
		license = "GPL spam v3.0 or later",
		layer = 699,
		handler = true,
		enabled = true
	}
end

if gadgetHandler:IsSyncedCode() then
	-------------------------------------
	-- Includes
	VFS.Include('scripts/lib_UnitScript.lua')
	
	---------------- SYNCED---------------
	-- Every Tests consists of a preparation function, called once and returning the handed over persistancepackage
	-- It also consists of a testFunction, which returns the testCompletness and the persistancepackage
	
	-- CONFIG --
	UnitTest = {}
	teamList = {}
	
	function getNonAIPlayer()
		List = Spring.GetTeamList()
		PlayerList = {}
		
		for i = 1, #List do
			teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(List[i])
			if isAiTeam and isAiTeam == false then
				PlayerList[#PlayerList+1] = List[i]
			end
		end
		
		if #PlayerList > 0 then return PlayerList end
		
		return List
	end
	
	function generateGenericTests()
		UnitsTotal = 0 
		
		journeyUnitList = getUnitCanBuildList(UnitDefNames["beanstalk"].id)
		centrailUnitList= getUnitCanBuildList(UnitDefNames["citadell"].id)
		UnitsTotal = count(journeyUnitList) + count(centrailUnits)
		
		selectedUnits = mergeDict(selectUnitDefs(journeyUnitList,UnitDefs),selectUnitDefs(centrailUnitList, UnitDefs))
		pow2 = math.ceil(math.sqrt(UnitsTotal*2))* math.ceil(math.sqrt(UnitsTotal*2))
				
		gaiaTeamID = Spring.GetGaiaTeamID()
	spawnUnitsForTeam(teamList[math.random(1, #teamList)],selectedUnits)
		spawnUnitsForTeam(gaiaTeamID,selectedUnits)
	end
	
	function getRotatedPosition(index, x, z, mx, mz)	
		x,z = Rotate(x,z, index*10)
		return mx + x, mz + z
	end
	
	function spawnUnitsForTeam(teamID, selectedUnits)
		if not GG.DebugIndex then GG.DebugIndex = 0 end

		for k, v in pairs(selectedUnits) do			
		GG.DebugIndex = GG.DebugIndex  + 1
		
		x,z = getRotatedPosition(GG.DebugIndex * 10, 0, GG.DebugIndex*125, 4096, 4096 )

			
			UnitTest[#UnitTest + 1] = function()
				
				id = Spring.CreateUnit(v.id, x, 0,z, 1, teamID)
				Command(id, "move", { x =4096, y = 0, z = 4096 }, { "shift" })
				Command(id, "stop", {}, { "shift" })
			end
		end

	end
	
	function initialize()
		teamList = getNonAIPlayer()
		generateGenericTests()
	end
	
	index = 1
	function gadget:GameFrame(n)
		if n % 400 == 0 then Spring.Echo("Starting Test") end
		
		if n > 400 and n % 30 == 0 then
			if #UnitTest == 0 then initialize() end
			if UnitTest[index] then
				UnitTest[index]()
				index = inc(index)
			end
		end
		if index % 8000 == 0 then
		index= 1
		end
	end
end