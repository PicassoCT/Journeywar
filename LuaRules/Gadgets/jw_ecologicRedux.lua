function gadget:GetInfo()
    function isPlanetFlammeable()
        Spring.Echo(Game.mapHardness, Game.windMin, Game.gravity, Game.waterDamage)
        if Game.mapHardness > 0 and Game.windMin > 0 and Game.gravity > 30 then
            badwordsTable = { "cold", "ice", "frost", "dessert", "sand", "dune", "snow", "moon", "glacier", "comet", "red", "planet" }
            for i = 1, #badwordsTable, 1 do
                if string.find(Game.mapName, badwordsTable[i]) then
                    return false;
                end
            end
            Spring.Echo("ForrestFire:Gadget is activated")
            return true
        end
        Spring.Echo("ForrestFire:Gadget is deactivated")
        return false
    end




    return {
        name = "Ecology gadget",
        desc = "Controlls the Gaia Wildlife",
        author = "Picadorro",
        date = "3rd of May 2010",
        license = "Free",
        layer = 0,
        version = 1,
        enabled = isPlanetFlammeable()
    }
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then


    VFS.Include("luarules/Gadgets/animal_hohymen.lua")
    VFS.Include("luarules/Gadgets/animal_varyfoos.lua")
    VFS.Include("luarules/Gadgets/animal_seastar.lua")


    SEASTARDEF = UnitDefNames["gseastar"].id
    HOHYMDEF = UnitDefNames["ghohymen"].id
    VARYFOODEF = UnitDefNames["jvaryfoo"].id
    --AgentTable =[Agentid]={Type, SozialState, AgentState,  Values }

    VariousFoos = {}
    seastarcounter = 0
    HohymenCounter = 0


    function gadget:UnitDestroyed(unitid, unitdefid, unitTeam)

        if unitdefid == VARYFOODEF and VariousFoos and VariousFoos[unitTeam] then
            for i = #VariousFoos[unitTeam], 1, -1 do
                if VariousFoos[unitTeam][i] == unitid then
                    table.remove(VariousFoos[unitTeam], i)
                end
            end
        end

        if unitdefid == HOHYMDEF then
            HohymenCounter = HohymenCounter - 1
            if AgentTable[unitid] then
                x, y, z = Spring.GetUnitPosition(unitid)
                AgentTable[unitid].Memory["lastknownposition"] = { x = x, y = y, z = z }
                AgentTable[unitid].AgentState = "DEAD"
                AgentTable[unitid].Type = "ghohymen"

                everyOneNearBy = getAllInCircle(x, z, 400, unitid, unitTeam)
                process(everyOneNearBy,
                    function(id)
                        if AgentTable[id] then
                            AgentTable[id].Security = 0
                        end
                    end)
            end
        end

        if unitdefid == SEASTARDEF then
            seastarcounter = math.max(0, seastarcounter - 1)
        end
    end



    function gadget:UnitCreated(unitID, unitDefID, unitTeam)
        if unitDefID == VARYFOODEF then
            if not VariousFoos[unitTeam] then VariousFoos[unitTeam] = {} end
            VariousFoos[unitTeam][#VariousFoos[unitTeam] + 1] = unitID
        end

        if unitDefID == HOHYMDEF then
            HohymenCounter = HohymenCounter + 1
            x, y, z = Spring.GetUnitPosition(unitID)
            spawnAgent(unitDefID, x, y, z, unitID)
        end

        if unitDefID == SEASTARDEF then
            seastarcounter = seastarcounter + 1
        end
    end

    local boolInit = false

    function gadget:GameFrame(frame)
        if frame > 0 and frame % 10 == 0 then
            if boolInit == true then
                handleHymens(frame, HohymenCounter)
            else
                boolInit = true
            end

            handleVaryFoos(frame)

            if seastarcounter < 5 then
                handleSeaStars(frame, seastarcounter)
            end
        end
    end
end
	