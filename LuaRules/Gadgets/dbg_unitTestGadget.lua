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

	
	function getNonAIAkaPlayer(List)
		for i=1,#List do
		   teamID, leader, isDead,isAiTeam,side,allyTeam,customTeamKeys,incomeMultiplier =	Spring.GetTeamInfo(List[i])
			if isAiTeam and isAiTeam == false then 
				return List[i]
			end
		end
	return List[math.random(1,#List)]
	end
	
	UnitTest={}
	function initialize()
			teamList = Spring.GetTeamList()			
			UnitTest= generateGenericTests()
	
	end
	
	function gadget:GameFrame(n)
		if n == 1 and n % 900 == 0 then		
			initialize()
		end
		
		if UnitTest[n] then
			UnitTest[n].startTest( UnitTest[n].defID,  UnitTest[n].pos)
		end
		
	end
	
	frameOffset= 0
	function generateGenericTests()

	UnitsTotal = table.getn(UnitDefNames)
	
	GenericUnitTests={}
		
		pow2 = 2
		while pow2 < UnitsTotal do pow2 = pow2 * 2 end
		
		mapSizeX, mapSizeZ = Game.mapSizeX / (pow2 / 2), Game.mapSizeZ / (pow2 / 2)
		x, z = 1, 1
		teamID = playerTeamID or Spring.GetGaiaTeamID()

		
		for k, v in pairs(UnitDefNames) do
			frameOffset =frameOffset+50
			frame = Spring.GetGameFrame() + 200 + frameOffset
		

			x = ringcrement(x, mapSizeX, 1)
			if x == mapSizeX then
				z = ringcrement(z, mapSizeZ, 1)
			end
			
				GenericUnitTests[frame] ={defID  = v.id, pos = {x=x, z= z }, startTest = function (defID, pos)
				id = Spring.CreateUnit(defID, pos.x, 0, pos.z, 1, teamID)
				Command(id, "stop", {}, { "shift" })
				Command(id, "move", { x = pos.x, y = 0, z = pos.z + 25 }, { "shift" })
				Command(id, "attack", { x = pos.x, y = 0, z = pos.z + 25 }, { "shift" })
				Command(id, "move", { x = pos.x, y = 0, z = pos.z - 25 }, { "shift" })
				Command(id, "attack", { x = pos.x, y = 0, z = pos.z - 25 }, { "shift" })
				return id

			end}
		end
		
		return GenericUnitTests
	end
	

	

end