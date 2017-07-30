function gadget:GetInfo()
    return {
        name = "jw_unit-test",
        desc = "Spawns one of every type of unit, issues commands of every type to that unit",
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
                return List[i]
            end
        end
        return List
    end

    function generateGenericTests()
	UnitsTotal = 0 
		for k,v in pairs (UnitDefNames) do
			UnitsTotal= inc(UnitsTotal)
		end

        pow2 = 2
		
        while pow2 < UnitsTotal do pow2 = pow2 * 2 end

        mapSizeX, mapSizeZ = 4096 , 4096 
		shardX, shardZ =mapSizeX / math.sqrt(pow2), mapSizeZ / math.sqrt(pow2)
		echo("Shard Size Debug Units: "..shardX, shardZ)
        x, z = 1, 1
        teamID = teamList[math.random(1, #teamList)]


        for k, v in pairs(UnitDefNames) do

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
                Command(id, "attack", { x = pos.x, y = 0, z = pos.z - 25 }, { "shift" })
            end
        end
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