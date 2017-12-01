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
		 UnitNames = {"bg","css","mtw","csniper","campro","cadvisor","cgamagardener","restrictor",
				 "coperatrans","art","sentrynell","cheadlauncher",
				 "chunterchopper","cgunship","callygator",
				 "paxcentrail","chunter",	"strider","ccrabsynth", "chunter",
				 "sentry","bonker","crailgun","chopper",
				 "jhivewulfmoma","jbeefeater","hc","zombie", "jantart","jatlantai",
				 "jglowworms","jbeherith","jeliah","tiglil","skinfantry",
				"jswiftspear", "jtigeggnogg","jskineggnogg","jghostdancer",
				 "vort", "jantart",	"jviralfac", "jfiredancer",
				 "jhunter", "jvaryfoo",
				 "jgalatea","jmotherofmercy","jsempresequoia","jrecycler","jresistancewarrior","jmadmax"
	  }
	-- UnitNames = {"bg","ccontrain","css","mtw","csniper","campro","cadvisor","cgamagardener","restrictor",
				-- "coperatrans","art","sentrynell","cwallbuilder","cheadlauncher",
				-- "chunterchopper","conair","csuborbital","cgunship","callygator",
				-- "paxcentrail","cgatefort","cnanorecon","chunter",	"strider","ccrabsynth", "chunter",
				-- "sentry","bonker","crailgun","chopper",
				-- "jhivewulfmoma","jbeefeater","hc","zombie", "jantart","jatlantai","jhoneypot",
				-- "jglowworms","jbeherith","jeliah","tiglil","skinfantry",
				-- "jshroudshrike","jswiftspear", "jtigeggnogg","jskineggnogg","jghostdancer",
				-- "vort", "jantart",	"jviralfac", "jhoneypot","jfiredancer",
				-- "jhunter", "jvaryfoo",
				-- "jfireflower", "jdragongrass", "jbeehive", "jswamp", "jpoisonhive",	
				-- "ggluemine","jtree1", "jgalatea","jmotherofmercy","jsempresequoia","jrecycler","jresistancewarrior","jmadmax"
	-- }
		UnitAmount = {
				["bg"]=50,["ccontrain"]=1,["css"]=1,["mtw"]=4,["csniper"]=1,["campro"]=3,["cadvisor"]=1,["cgamagardener"]=1,["restrictor"]=4,
				["coperatrans"]=1,["art"]=1,["sentrynell"]=3,["cwallbuilder"]=1,["cheadlauncher"]=1,
				["chunterchopper"]=1,["conair"]=1,["csuborbital"]=1,["cgunship"]=1,["callygator"]=1,
				["paxcentrail"]=1,["cgatefort"]=1,["cnanorecon"]=0,["chunter"]=1,	["strider"]=1,["ccrabsynth"]=1,["chunter"]=3,
				["sentry"]=4,["bonker"]=1,["crailgun"]=1,["chopper"]=1,
				["jhivewulfmoma"]=2,["jbeefeater"]=1,["hc"]=1,["zombie"]=1, ["jantart"]=1,["jatlantai"]=1,["jhoneypot"]=1,
				["jglowworms"]=1,["jbeherith"]=1,["jeliah"]=1,["tiglil"]=5,["skinfantry"]=5,
				["jshroudshrike"]=1,["jswiftspear"]=1, ["jtigeggnogg"]=1,["jskineggnogg"]=1,["jghostdancer"]=1,
				["vort"]=3, ["jantart"]=2,	["jviralfac"]=1, ["jhoneypot"]=1,
				["jhunter"]=3, ["jvaryfoo"]=1,["jfiredancer"]=4,
				["jfireflower"]=1, ["jdragongrass"]=1, ["jbeehive"]=1, ["jswamp"]=1, ["jpoisonhive"]=1,	
				["ggluemine"]=1,["jtree1"]=1, ["jgalatea"]=1,["jmotherofmercy"]=1,["jsempresequoia"]=1,["jrecycler"]=1,["jresistancewarrior"]=1,["jmadmax"]=1
	}
	
	boolStartTest= true
	HALF_MAP = math.ceil((Game.mapSizeZ/2 + Game.mapSizeX/2)/2)
		
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
	
	 function gadget:RecvLuaMsg(msg, playerID)
	 
		start,ends= string.find(msg,"DBG:UNITTEST:Start")
		if ends then
			boolStartTest = true
		end
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
	
	function randAmount()
		for k,v in pairs(UnitAmount) do
			UnitAmount[k]= math.random(0,7)
		end
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

					
					
					local x,z = getRotatedPosition(valueIndex, circleFraction*100, valueIndex *25, HALF_MAP, HALF_MAP )
					y= Spring.GetGroundHeight(x,z) 
					
					
					UnitTest[#UnitTest + 1] = function()
						for k=1, UnitAmount[name] do
							--echo(type(id))
							id = Spring.CreateUnit(_defID, x, y +5 ,z, 1, teamID)
							
							
							Spring.SetUnitMoveGoal(id,randSign()*HALF_MAP+k,0,HALF_MAP)
							Command(id, "move", { x =randSign()*HALF_MAP, y = 0, z = randSign()*HALF_MAP }, { "shift" })
							Command(id, "move", { x =x, y = 0, z = z }, { "shift" })
						end
					end
				end		
			end		
		end		
		
	end

	
	function gadget:Initialize()
	  gadgetHandler.actionHandler.AddChatAction(gadget, "unittest", StartUnitTest, " : starts a unittest session")
	end
	
	function initialize()
		generateGenericTests()
	end
	
	local index = 1
	boolInitialized = false

	function gadget:GameFrame(n)
		if boolStartTest == true then
			randAmount()
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
				--boolStartTest= false
				index= 1
			end
		end
	end
else
	
	local function StartUnitTest()
		Spring.SendLuaRulesMsg("DBG:UNITTEST:Start")		
	end
	
	function gadget:Initialize()
	  gadgetHandler.actionHandler.AddChatAction(gadget, "unittest", StartUnitTest, " : starts a unittest session")
	end

end