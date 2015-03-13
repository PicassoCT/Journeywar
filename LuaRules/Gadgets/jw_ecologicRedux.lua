
  function gadget:GetInfo()
		function isPlanetFlammeable()
			if Game.mapHardness > 0 and Game.windMin > 0 and Game.gravity > 80 and Game.waterDamage == 0 then
			badwordsTable={"cold","ice","frost","dessert","sand","dune"} 
				for i=1, 6,1 do 
					if string.find(Game.mapName, badwordsTable[i]) then 
					return false; 
					end  
				end 
			return true  
			end
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
	

	VFS.Include("LuaRules/Gadgets/animal_hohymen.lua")
	VFS.Include("LuaRules/Gadgets/animal_varyfoos.lua")
	VFS.Include("LuaRules/Gadgets/animal_seastar.lua")
	
	SEASTARDEF		= 	UnitDefNames["gseastar"].id
	HOHYMDEF		=	UnitDefNames["ghohymen"].id
	VARYFOODEF 		=	UnitDefNames["jvaryfoo"].id
		--AgentTable =[Agentid]={Type, SozialState, AgentState,  Values }

	VariousFoos={}
	seastarcounter=0
	HohymenCounter=0
	
	
	function gadget:UnitDestroyed(unitid,unitdefid, unitTeam)
	
	if unitdefid== VARYFOODEF then
	table.remove(VariousFoos[unitTeam],unitID)
	end
	
	if unitdefid== HOHYMDEF then
		HohymenCounter=HohymenCounter-1
		if AgentTable[unitid] then
		x,y,z=Spring.GetUnitPosition(unitid)
		AgentTable[unitid].Memory["lastknownposition"]= {x=x,y=y,z=z}
		AgentTable[unitid].AgentState="DEAD"
		end
	end
	
		if unitdefid==SEASTARDEF then
		seastarcounter=seastarcounter-1	
		end
	end
	
	
	
    function gadget:UnitCreated(unitID, unitDefID, unitTeam)
		if unitDefID== VARYFOODEF then
			if not VariousFoos[unitTeam] then VariousFoos[unitTeam]={} end
		table.insert(VariousFoos[unitTeam],unitID)
		end
	
		if unitDefID== HOHYMDEF  then
		HohymenCounter=HohymenCounter+1
		x,y,z=Spring.GetUnitPosition(unitID)
		spawnAgent(unitDefID, x,y,z,unitID)
		end
		
		if unitDefID== SEASTARDEF then
		seastarcounter=	seastarcounter+1	
		end
	end
	
	local boolInit=false

	function gadget:GameFrame(frame)
	
		if boolInit==true then
		handleHymens(frame,HohymenCounter)
		else
		init()
		boolInit=true		
		end
		
		handleVaryFoos(frame)
		handleSeaStars(frame,seastarcounter)
	
	end	
	
	end
	