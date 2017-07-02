function gadget:GetInfo()
	return {
		name = "jw_unit-test",
		desc = "Spawns one of every type of unit, issues commands of every type to that unit",
		author = "Picasso",
		date = "SPAM/SPAM/SPAM/LOVELYSPAM",
		version = "v0.1.ham.and.jam.and...",
		license = "GPL spam v3.0 or later",
		layer = math.huge,
		handler = true,
		enabled = true
	}
end

if gadgetHandler:IsSyncedCode() then	
	-------------------------------------
	-- Includes
	VFS.Include('scripts/lib_UnitScript.lua')
	
	---------------- SYNCED---------------
	--Every Tests consists of a preparation function, called once and returning the handed over persistancepackage
	--It also consists of a testFunction, which returns the testCompletness and the persistancepackage
	Tests={}
	-- CONFIG --
	boolUnitTestInProgress= false
	testedUnitTypeIDs= {}
	function gadget:RecvLuaMsg(msg, playerID)
		if msg then
			ident = string.lower(string.sub(msg, 1, 3))
			if ident then
				testmode= "generic"
				if ident == "tct" then testmode ="custom" end
					if ident == "tct" or ident == "tgt" then
						playerTeamID = tonumber(string.sub(msg, 5, string.len(msg)))
						boolUnitTestInProgress= true
						testedUnitTypeIDs = {}
		
					end
			end
		end
	end
	
	function getNonAIAkaPlayer(List)
		for i=1,#List do
		   teamID, leader, isDead,isAiTeam,side,allyTeam,customTeamKeys,incomeMultiplier =	Spring.GetTeamInfo(List[i])
			if isAiTeam and isAiTeam == false then 
				return List[i]
			end
		end
	return List[math.random(1,#List)]
	end
	
	function gadget:GameFrame(n)
		if n > 1 and n % 900 == 0 then		
			teamList = Spring.GetTeamList()			
			unitTest(getNonAIAkaPlayer(teamList), "generic")	
		end
	end
	
	function generateGenericTests()

	UnitsTotal = table.getn(UnitDefNames)
	
	GenericUnitTests={}
		
		pow2 = 2
		while pow2 < UnitsTotal do pow2 = pow2 * 2 end
		
		mapSizeX, mapSizeZ = Game.mapSizeX / (pow2 / 2), Game.mapSizeZ / (pow2 / 2)
		x, z = 1, 1
		teamID = playerTeamID or Spring.GetGaiaTeamID()

		
		for k, v in pairs(UnitDefNames) do
		GenericUnitTests[#GenericUnitTests+1] ={persPackage = {id = v.id}} 
			x = ringcrement(x, mapSizeX, 1)
			if x == mapSizeX then
				z = ringcrement(z, mapSizeZ, 1)
			end
		
		persPackage.x,persPackage.z = x,z
		
		GenericUnitTests[#GenericUnitTests].preparation = function (persPackage)
				id = Spring.CreateUnit(persPackage.id, x, 0, z, 1, teamID)
				Command(id, "stop", {}, { "shift" })
				Command(id, "move", { x = persPackage.x, y = 0, z = persPackage.z + 25 }, { "shift" })
				Command(id, "attack", { x = persPackage.x, y = 0, z = persPackage.z + 25 }, { "shift" })
				Command(id, "move", { x = persPackage.x, y = 0, z = persPackage.z - 25 }, { "shift" })
				Command(id, "attack", { x = persPackage.x, y = 0, z = persPackage.z - 25 }, { "shift" })
				persPackage.unitID = id
			return persPackage
			end
		
			GenericUnitTests[#GenericUnitTests].fullfilled =    function(evtID, frame, persPack, startFrame)
                --Spring.Echo("EventStream Poisoned by active for"..persPack.victimID)
                --only apply if Unit is still alive
                if Spring.GetUnitIsDead(persPackage.unitID) == true then
                    return nil, persPack
                end      

                return frame + 50, persPack
            end		
		end
		
		return GenericUnitTests
	end
	
	function executeTests(Tets)
		for num, Test in pairs(Tests) do
			persPackage= Test.preparation(Test.persPackage)			

			GG.EventStream:CreateEvent(Test.fullfilled,
             persPackage,
             Spring.GetGameFrame() + num * 5)
		end
	end
	
	function unitTest(playerTeamID, mode)
		if mode == "generic" then
			Tests= generateGenericTests()
		end
		
		executeTests(Tests)
	end
	
else
	local function startCustomUnitTest()
		tID = Spring.GetMyTeamID()
		Spring.SendLuaRulesMsg("TCT|" .. tID)
		Spring.Echo("Unittest custom starts")
	end

	local function startGenericUnitTest()
		tID = Spring.GetMyTeamID()
		Spring.SendLuaRulesMsg("TGT|" .. tID)
		Spring.Echo("Unittest generic starts")
	end

	function gadget:Initialize()
		gadgetHandler.actionHandler.AddChatAction(gadget,'utest_cust', startCustomUnitTest,  "starts a generic unittest")
		gadgetHandler.actionHandler.AddChatAction(gadget,'utest_gen', startGenericUnitTest, "starts the users specified tests")
	end
end