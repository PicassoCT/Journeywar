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
		enabled = false
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
	
	UnitNames = {"bg","ccontrain","css","mtw","csniper","campro","cadvisor","cgamagardener","restrictor",
				"coperatrans","art","sentrynell","cwallbuilder","cheadlauncher",
				"chunterchopper","conair","csuborbital","cgunship","callygator",
				"paxcentrail","cgatefort","cnanorecon","chunter",	"strider","ccrabsynth", "chunter",
				"sentry","bonker","crailgun","chopper",
				"jhivewulfmoma","beefeater","hc","zombie", "jantart","jatlantai","jhoneypot",
				"jglowworms","jbeherith","jeliah",
				"jshroudshrike","jswiftspear", "jtigeggnogg","jskineggnogg","jghostdancer",
				"jhivewulfmoma","vort", "jantart",	"jviralfac", "jhoneypot",
				"jhunter", "jvaryfoo",
				"jfireflower", "jdragongrass", "jbeehive", "jswamp", "jpoisonhive",	
				"ggluemine","jtree", "jgalatea","jmotherofmercy","jsempresequoia","jrecycler","jresistancewarrior","jmadmax"
	}
	
	function getAIPlayer()
		List = Spring.GetTeamList()
		PlayerList = {}
		AiList = {}
		
		for i = 1, #List do
			teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(List[i])
			if isAiTeam and isAiTeam == false then
				PlayerList[#PlayerList+1] = List[i]
			else
				AiList[#AiList+1] = List[i]				
			end
		end
		
		
		return PlayerList,AiList
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
		
		teamList, aiList = getAIPlayer()
		-- ind= 1
		-- if #teamList > 1 then ind =math.random(1, #teamList)end
		spawnUnitsForTeam(1)
		-- ind= 1
		-- if #aiList > 1 then ind =math.random(1, #aiList)end
		spawnUnitsForTeam(2)
		
	end
	
	function getRotatedPosition(index, x, z, mx, mz)	
		x,z = Rotate(x,z, math.rad(index*15))
		return math.ceil(mx + x), math.ceil(mz + z)
	end
	
	
	GG.DebugIndex = 0
	function spawnUnitsForTeam(teamID)
		local teamID = teamID
		for i=1, #UnitNames do	
			name = UnitNames[i]
			if UnitDefNames[name]then 
				local _defID = UnitDefNames[name].id
				if _defID then
					x,y,z=0,0,0
					
					GG.DebugIndex = GG.DebugIndex + 1		
					local valueIndex= GG.DebugIndex
					local circleFraction= math.ceil(GG.DebugIndex/#UnitNames)

					
					
					local x,z = getRotatedPosition(valueIndex, circleFraction*100, valueIndex *25, 4096, 4096 )
					y= Spring.GetGroundHeight(x,z) 
					
					
					UnitTest[#UnitTest + 1] = function()
						--echo(type(id))
						id = Spring.CreateUnit(_defID, x, y +5 ,z, 1, teamID)
						Spring.SetUnitMoveGoal(id,4096,0,4096)
						Command(id, "move", { x =4096, y = 0, z = 4096 }, { "shift" })
						Command(id, "move", { x =x, y = 0, z = z }, { "shift" })
					end
				end		
			end		
		end		
		
	end
	
	function initialize()
		generateGenericTests()
	end
	
	local index = 1
	boolInitialized = false
	function gadget:GameFrame(n)
		if n % 400 == 0 then Spring.Echo("Starting Test") end
		if boolInitialized == false then
		initialize()
		boolInitialized = true
		end
		if n > 400 and n % 30 == 0 then
			if UnitTest[index] then
				UnitTest[index]()
				index = inc(index)
			end
		end
		if index >= #UnitTest then
			index= 1
		end
	end
end