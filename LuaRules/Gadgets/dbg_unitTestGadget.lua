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
	VFS.Include('scripts/lib_jw.lua')
	
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
	
	function buildUnitsToTestList ()	
		local journeyUnitList = getUnitCanBuildList(UnitDefNames["beanstalk"].id)
		--echoUnitDefT(journeyUnitList)
		local centrailUnitList= getUnitCanBuildList(UnitDefNames["citadell"].id)	
		
		
		allUnitTypes= mergeDict(selectUnitDefs(journeyUnitList),selectUnitDefs(centrailUnitList))
		
		mobileUnits={}
		process(allUnitTypes,
		function(defID)
			if defID and UnitDefs[defID].isImmobile == true then 
				mobileUnits[defID] =defID
			end
		end		
		)
		
		
		

		return mobileUnits --mergeDict(mobileUnits, defBuildings)	
	end
	
	
	function generateGenericTests()
		
		selectedUnits = buildUnitsToTestList()
		UnitsTotal = count( selectedUnits) or 0
		
		gaiaTeamID = Spring.GetGaiaTeamID()
		
		spawnUnitsForTeam(teamList[math.random(1, #teamList)], selectedUnits)
		spawnUnitsForTeam(gaiaTeamID, selectedUnits)
	end
	
	function getRotatedPosition(index, x, z, mx, mz)	
		x,z = Rotate(x,z, math.rad(index*5))
		return mx + x, mz + z
	end
	
	
	
	function spawnUnitsForTeam(teamID, selectedUnits)
		if not GG.DebugIndex then GG.DebugIndex = 0 end
			for defID, _defID in pairs(selectedUnits) do	
			if   _defID then
				x,y,z=0,0,0
				
						GG.DebugIndex = GG.DebugIndex + 1							
							x,z = getRotatedPosition(GG.DebugIndex, 0, GG.DebugIndex*75, 4096, 4096 )
							y= Spring.GetGroundHeight(x,z) 
					
							
							UnitTest[#UnitTest + 1] = function()
								--echo(type(id))
								id = Spring.CreateUnit(_defID, x, y +5 ,z, 1, teamID)
								Command(id, "move", { x =4096, y = 0, z = 4096 }, { "shift" })
								Command(id, "move", { x = x, y = 0, z = z }, { "shift" })
							end
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
		if n % 1000 == 0 then
			index= 1
		end
	end
end