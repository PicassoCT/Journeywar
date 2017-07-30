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

    function getNonAIPlayer(List)
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
	journeyUnits = getFactionCanBuild("beanstalk")
	centrailUnits = getFactionCanBuild("citadell")
	UnitsTotal = count(journeyUnits) + count(centrailUnits)
	selectedUnits = mergeDict(selectUnitDefs(journeyUnits,UnitDefNames),selectUnitDefs(centrailUnits, UnitDefNames))
    pow2 = math.ceil(math.sqrt(UnitsTotal*2))^2
		
  
		gaiaTeamID = Spring.GetGaiaTeamID()
      x,z= spawnUnitsForTeam(teamList[math.random(1, #teamList)],1,1,selectedUnits)
      spawnUnitsForTeam(gaiaTeamID,x,z,selectedUnits)
    end
	
	function spawnUnitsForTeam(teamID  x, z, selectedUnits)
	  mapSizeX, mapSizeZ = Game.mapSizeX , Game.mapSizeZ 
		shardX, shardZ =mapSizeX / math.sqrt(pow2), mapSizeZ / math.sqrt(pow2)
		echo("Shard Size Debug Units: "..shardX, shardZ)
      
        for k, v in pairs(selectedUnits) do

            x = (x + shardX) % mapSizeX
            if x > mapSizeX then
                z = z + shardZ % mapSizeZ, shardZ)
            end


            local defID = v.id
            local pos = { x = math.ceil(x), z = math.ceil(z)}

            UnitTest[#UnitTest + 1] = function()
						Spring.Echo("Creating Test Unit: "..v.name)
                id = Spring.CreateUnit(defID, pos.x, 0, pos.z, 1, teamID)
                Command(id, "stop", {}, { "shift" })
                Command(id, "move", { x = pos.x, y = 0, z = pos.z + 25 }, { "shift" })
                Command(id, "attack", { x = pos.x, y = 0, z = pos.z + 25 }, { "shift" })
                Command(id, "move", { x = pos.x, y = 0, z = pos.z - 25 }, { "shift" })
            end
        end
	
	return x, z
	end

    function initialize()
        teamList = getNonAIPlayer(Spring.GetTeamList())
         generateGenericTests()
    end

    index = 1
    function gadget:GameFrame(n)
			if n % 400 == 0 then Spring.Echo("Starting Test") end
			
        if n > 400 and n % 30 == 0  then
				if #UnitTest == 0 then initialize() end
				if  UnitTest[index] then
            UnitTest[index]()
            index = inc(index)
				end
        end
    end
end