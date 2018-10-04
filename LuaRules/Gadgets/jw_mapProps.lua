function gadget:GetInfo()
    return {
        name = "Map Probs spawner",
        desc = "Spawns features",
        author = "Bill Gates",
        date = "Sep. 2014",
        license = "GPL",
        layer = math.huge,
        enabled = true,
    }
end

if (gadgetHandler:IsSyncedCode()) then
    function isMoonOrComet()
        if Game.windMax <= 2 and Game.gravity < 80 then
            return true
        end
        whiteListComet = { "moon", "speed", "asteroid", "comet", "apophis", "akilon", "red", "planet" }
        for i = 1, #whiteListComet, 1 do
            if string.find(string.lower(Game.mapName), whiteListComet[i]) then
                return true;
            end
        end

        return false
    end

    function spawnDecoType(name, number, x, z)
        if number == 0 then return end
        gaiaTeam = Spring.GetGaiaTeamID()

        for i = 1, number do
            id = Spring.CreateUnit(name, x, 0, z, 0, gaiaTeam)
            Spring.SetUnitNoSelect(id, true)
        end
    end

    function spawnCometsAndBackgroundPlanet()

        spawnDecoType("gcrystallsteroids", math.random(0, 3), Game.mapSizeX / 2, Game.mapSizeZ / 2)
        spawnDecoType("gasteroids", math.random(0, 3), Game.mapSizeX / 2, Game.mapSizeZ / 2)
        spawnDecoType("gplanetoid", math.random(0, 1), Game.mapSizeX / 2, -1000)
    end

    boolOnce = false

    function gadget:GameFrame(n)
        if boolOnce == false then

            boolOnce = true
            if isMoonOrComet() == true then
                spawnCometsAndBackgroundPlanet()
            end
        end
    end
end
	
	


