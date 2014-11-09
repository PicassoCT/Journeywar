
     
    function gadget:GetInfo()
    return {
    name = "Unittest Create",
    desc = "Creates Units - do de Debug Dance till you Dodo from Todo",
    author = "PicassoCT",
    date = "Oh, you wish, you had it with this file - but she got class and style",
    license = "GNU GPL, v2 its goes in all fields",
    layer = 0,
    enabled = false-- loaded by default?
    }
    end
     
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
     
    -- synced only
  if (gadgetHandler:IsSyncedCode()) then
UnitList={"jshroudshrike","jmeconverter","cawilduniverseappears","jmovingfac2","ghohymen", "jvaryfoo","comendbonker","csniper","strider",  "chedgehog", "paxcentrail","jmovingfac1","jviralfac","jsungodcattle","jabyss"}

            function gadget:GameFrame(f)
			if f ==900 then
			teamList=Spring.GetTeamList()
			gaiaTeamId=Spring.GetGaiaTeamID()
			if GG.UnitsToSpawn then
			tx,tz=Game.mapSizeX /math.max(4,#teamList), Game.mapSizeZ/math.max(4,#teamList)
				
				for i=1, #teamList do
				if teamList[i] ~= gaiaTeamId then
				x,z= tx*i,tz*i
				
					if x then
					
						for j=1,#UnitList,1 do
						GG.UnitsToSpawn:PushCreateUnit(UnitList[j],x+(j-#UnitList/2)*50,0,z+(j-#UnitList/2)*50,0,teamList[i])
						end
										
					end
				end
				end
			end
			end
			end
end
	
	