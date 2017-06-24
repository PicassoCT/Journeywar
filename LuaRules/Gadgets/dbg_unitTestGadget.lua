function gadget:GetInfo()
	return {
		name = "jw_unit-test",
		desc = "Spawns one of every type of unit, issues commands of every type to that unit",
		author = "Picasso",
		date = "SPAM/SPAM/SPAM/LOVELYSPAM",
		version = "v0.1.ham.and.jam.and...",
		license = "GPL spam v3.0 or later",
		layer = -1,
		enabled = true
	}
end

local function startCustomUnitTest()
	tID = Spring.GetMyTeamID()
	Spring.SendLuaRulesMsg("TCT|" .. tID)
	Spring.Echo("Unittest starts")
end

local function startGenericUnitTest()
	tID = Spring.GetMyTeamID()
	Spring.SendLuaRulesMsg("TGT|" .. tID)
	Spring.Echo("Unittest starts")
end

if gadgetHandler:IsSyncedCode() then
	
	-------------------------------------
	-- Includes
	VFS.Include('scripts/lib_UnitScript.lua')
	
	---------------- SYNCED---------------
	--Every Tests consists of a preparation function, called once and returning the handed over persistancepackage
	--It also consists of a testFunction, which returns the testCompletness and the persistancepackage
	Tests={}
	function gadget:Initialize()
		gadgetHandler.actionHandler.AddChatAction(gadget,"unittest custom", startCustomUnitTest, "")
		gadgetHandler.actionHandler.AddChatAction(gadget,"unittest generic", startGenericUnitTest, "")
	end
	
	-- CONFIG --

	function gadget:RecvLuaMsg(msg, playerID)
		if msg then
			ident = string.lower(string.sub(msg, 1, 3))
			if ident 
				testmode= "generic"
				if ident == "tct" then testmode ="custom" end
				playerTeamID = tonumber(string.sub(msg, 5, string.len(msg)))
				unitTest(playerTeamID, testmode)
				
			end
		end
	end
	
	function generateGenericTests()

	UnitsTotal = table.getn(UnitDefNames)
	
	GenericUnitTests={}
		
		pow2 = 2
		while pow2 < UnitsTotal do pow2 = pow2 * 2 end
		
		mapSizeX, mapSizeZ = Game.mapSizeX / (pow2 / 2), Game.mapSizeZ / (pow2 / 2)
		x, z = 1, 1
		teamID = playerTeamID 
		if 
		
		for k, v in pairs(UnitDefNames) do
		GenericUnitTests[#GenericUnitTests+1] ={}
			x = ringcrement(x, mapSizeX, 1)
			if x == mapSizeX then
				z = ringcrement(z, mapSizeZ, 1)
			end
		
		GenericUnitTests[#GenericUnitTests].preparation= function (persPackage)
			id = Spring.CreateUnit(v.id, x, 0, z, teamID)
			Command(id, "stop", {}, { "shift" })
			Command(id, "cloak", {}, { "shift" })
			Command(id, "cloak", {}, { "shift" })
			Command(id, "move", { x = x, y = 0, z = zunit + 25 }, { "shift" })
			Command(id, "setactive", {}, { "shift" })
			Command(id, "setactive", {}, { "shift" })
			Command(id, "attack", { x = x, y = 0, z = z + 25 }, { "shift" })
			Command(id, "setactive", {}, { "shift" })
			Command(id, "attack", { x = x, y = 0, z = z - 25 }, { "shift" })
			persPackage.id = id
			return persPackage
			end
		
			GenericUnitTests[#GenericUnitTests].fullfilled =    function(evtID, frame, persPack, startFrame)
                --Spring.Echo("EventStream Poisoned by active for"..persPack.victimID)
                --only apply if Unit is still alive
                if Spring.GetUnitIsDead(persPack.id) == true then
                    return nil, persPack
                end

       

                return frame + 50, persPack
            end
			
		end
		
		return GenericUnitTests
	end
	
	function executeTests(Tets)
		for num,Test in pairs(Tests) do
			persPackage={}
			persPackage= Test.preparation(persPackage)			

         GG.EventStream:CreateEvent(Test.fullfilled,
             persPackage,
             Spring.GetGameFrame() + 1)
                 
                 
		end
	end
	
	function unitTest(playerTeamID, mode)
		if mode == "generic" then
			Tests= generateGenericTests()
		end
		
		executeTests(Tests)
	end
	
end