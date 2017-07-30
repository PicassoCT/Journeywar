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
	
	function spawnUnitsForTeam(teamID, selectedUnits)
		mapSizeX, mapSizeZ = Game.mapX / 8, Game.mapY/ 8
		if not GG.DebugIndex then GG.DebugIndex = {x= 128, z= 128}end

		shardX  = (mapSizeX / math.sqrt(pow2)) 
		shardZ = (mapSizeZ / math.sqrt(pow2))
		for k, v in pairs(selectedUnits) do			

				 GG.DebugIndex.x = GG.DebugIndex.x +  shardX
				if GG.DebugIndex.x >= math.max(mapSizeX,8192) then
					GG.DebugIndex.x= shardX
					GG.DebugIndex.z= GG.DebugIndex.z + shardZ
					if GG.DebugIndex.z > math.max(mapSizeZ, 8192) then GG.DebugIndex.z = shardZ end
				end

			
			UnitTest[#UnitTest + 1] = function()

				id = Spring.CreateUnit(v.id, math.ceil( GG.DebugIndex.z), 0, math.ceil( GG.DebugIndex.z), 1, teamID)
				Command(id, "stop", {}, { "shift" })
				Command(id, "move", { x =4096, y = 0, z = 4096 }, { "shift" })
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
	end
end