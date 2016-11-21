--Gadget for stress/unitscript testing, made by Bluestone
--code deliberately not optimized!

function gadget:GetInfo()
	return {
		name = "jw_unit-test",
		desc = "SHUT THAT BLOODY BOUZOUKI UP!",
		author = "Camembert, perhaps?",
		date = "SPAM/SPAM/SPAM/LOVELYSPAM",
		version = "v0.1.ham.and.jam.and...",
		license = "GPL spam v3.0 or later",
		layer = -1, 
		enabled = true,
		spam 	 = spam,
	}
end


if gadgetHandler:IsSyncedCode() then
	-------------------------------------
	----------------SYNCED---------------
	UnitList={"jshroudshrike","jmeconverter","cawilduniverseappears","jmovingfac2","ghohymen", "jvaryfoo","comendbonker","csniper","strider", "chedgehog", "paxcentrail","jmovingfac1","jviralfac","jsungodcattle","jabyss"}
	-- CONFIG --
	
	--mode
	--fight=false simulates unit movement only, fight=true simulates fighting too
	local fight = true
	
	--vars
	--some of these are duplicated in unsynced
	local unitSpamD = 1 --initial unit density (units per map square)
	local runSteps = 22 --how many steps (at the end of each step, unitSpamD increases by 1)
	local stepTime = 8 --minutes each step of settings is run for
	
	--other
	local orderRate = 120 --average time an order is kept before being replaced
	local pAirUnit = 0.0 --proportion of (extra) aircraft
	
	
	------------
	
	numX = (Game.mapSizeX )-1
	numZ = (Game.mapSizeZ)-1
	mapX = numX
	mapZ = numZ
	local uSD = unitSpamD
	local cmdTable = {CMD.MOVE, CMD.FIGHT, CMD.PATROL} 
	local over = false
	local unitDefIDTable = {}
	local maxUnitDefIDs
	
	--------------------------------------
	----------------Funcs-----------------
	
	UnitDefPairsTable={}
	for	k,_ in pairs(UnitDefs) do
		
		T={}
		T.def=k
		for	v,_ in pairs(UnitDefs) do
			if math.random(0,1)==1 and math.random(0,1)==1 then
				T[#T+1]=v
			end
		end
		UnitDefPairsTable[#UnitDefPairsTable+1]=T
	end
	
	function RandomCoord()
		local x = math.random() * mapX
		local z = math.random() * mapZ
		return x,z
	end
	
	function makeAPair(x,z,typdefid,typdefIDother,team,teamother)
		randx,randz=math.random(-100,100),math.random(-100,100)
		idA=Spring.CreateUnit(typdefid,x+randx,0,z+randz,1,team)
		idB=Spring.CreateUnit(typdefIDother,x,0,z,1,teamother)
		return idA,idB
	end
	
	function RandomSquare()
		local x = math.random(1,numX)
		local z = math.random(1,numY)
		return x,z
	end
	
	function RandomCoordInSquare(sx,sz)
		local x = 512 * sx + math.random(-512,512)
		local z = 512 * sz + math.random(-512,512)
		return x,z
	end
	
	function RandomOrder()
		local n = math.random(3)
		return cmdTable[n]
	end
	
	function RandomOrderToUnitPair(unitID, enemyID)
		
		if Spring.ValidUnitID(enemyID) then
			local x,z = Spring.GetUnitPosition(enemyID)
			local id = RandomOrder()
			if Spring.ValidUnitID(unitID) then
				y = Spring.GetGroundHeight(x,z)
				Spring.GiveOrderToUnit(unitID,id,{x,y,z},{"meta"})
			end
		end
	end
	
	
	-----------------------------------------------
	-----------------Calls-------------------------
	
	
	function Over()
		
		
		--remove all units
		
	end
	
	function destroyTable(T)
		for i=1,#T,1 do
			if Spring.GetUnitIsDead(T[i])==false then
				Spring.DestroyUnit(T[i],false,true)
			end
		end
	end	
	itterator=1
	i=1
	idTable={}
	boolCreateThem=false
	teamList=Spring.GetTeamList()
	tad=math.ceil(1,#teamList)
	teamA=teamList[tad]
	teamB=teamList[tad%#teamList+1]
	
	if teamA==teamB then Spring.Echo("dbg_unitTestGadget:: Same Team Selection ") end
	
	function gadget:GameFrame(n)
		
		if (n>0 and n%8000==0) then
			destroyTable(idTable)
			idTable={}
			boolCreateThem=true
			i=1
		end
		
		if boolCreateThem==true and n% 18000 ==0 then
			x,z=math.random(1,numX),math.random(1,numZ)
			x,z=math.ceil(x),math.ceil(z)
			--(x,z,typdefid,typdefIDother,team,teamother)
			idA,idB=makeAPair(x,z,UnitDefPairsTable[itterator].def,UnitDefPairsTable[itterator][i],teamA,teamB)
			RandomOrderToUnitPair(idA,idB)
			table.insert(idTable, idA)
			table.insert(idTable, idB)
			i=i+1
			if i==#UnitDefPairsTable[itterator] then
				i=1
				itterator=itterator+1	
			end
		end
		
		if n ==900 then
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