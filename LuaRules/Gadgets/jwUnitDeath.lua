--statue spawn gadget

function gadget:GetInfo()
	return {
		name = "Eliah ReSpawner/ Death Catcher",
		desc = "Respawns the eliah, catches dieing units",
		author = "zwzsg",
		date = "3rd of May 2010",
		license = "Free",
		layer = 0,
		version = 1,
		enabled = true
	}
end

-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

if (gadgetHandler:IsSyncedCode()) then
	VFS.Include("scripts/lib_OS.lua")
	VFS.Include("scripts/lib_UnitScript.lua")
	VFS.Include("scripts/lib_jw.lua" )
	VFS.Include("scripts/lib_Build.lua")
	
	-- Configuration:
	
	numberOfButterflys=5
	timeInMsTillRespawn=1500
	circleRange=500
	GoneForGood={}
	--1 Counter
	--2 FatherID
	--3 - 3+numberOfButterflys
	intIntervall=250
	--/Configuration
	ELIAHMERGEDISTANCE=200
	
	jTree3RespawnTable={}
	
	function mergeButterflys(sTable)
	
	distanceTable={}
	for k,kuid in ipairs(sTable)do
		for i, iuid in ipairs(sTable) do
		if i~=k then
			distance=distanceUnitToUnit(sTable[k],sTable[i])
			if  sTable[k] and sTable[i] and distance < ELIAHMERGEDISTANCE then
					if not distanceTable[sTable[k]] then  distanceTable[sTable[k]] = 0 end
				distanceTable[sTable[k]] = distanceTable[sTable[k]] +1
				if distanceTable[sTable[k]] > 2 then
					return sTable[k]
				end
			end
		end
		end
	end

	end
	
	function countSurvivors(jDeadEliahIndex)
		local survivorCount=0			
		survivors={}
		for indx, id in pairs(GoneForGood[jDeadEliahIndex].butterflys) do
				validUnitID=Spring.ValidUnitID(id)
				isDead=Spring.GetUnitIsDead(id)
				if  validUnitID ~= nil and validUnitID == true and isDead ~= nil and isDead == false then 
					survivors[#survivors+1]=id
					survivorCount=survivorCount+1	
				end
		end
	return survivorCount, survivors
	end
		
	--respawns the Eliah
	function reIncarnateAfterTime(jDeadEliahIndex)
		--check the butterflies for beeing still alive
		-- if at least one is still in existance then
		--respawn then eliah
		--none of the butterflys is- nil entry	

		survivorCount, survivors = countSurvivors(jDeadEliahIndex)
		
		if survivorCount < 2 then
			table.remove(GoneForGood,jDeadEliahIndex)
			return
		end
		
		spawnPointOfEliah = mergeButterflys(survivors)

		if spawnPointOfEliah and Spring.ValidUnitID(spawnPointOfEliah)== true  then
			x,y,z = Spring.GetUnitPosition(spawnPointOfEliah)
			likeHisFathersFather=Spring.GetUnitTeam(spawnPointOfEliah)
			id=Spring.CreateUnit("jeliah",x,y,z,0,likeHisFathersFather)
			if id then
				Spring.SetUnitExperience(id, GoneForGood[jDeadEliahIndex].stats.exp)
			end
			for index, id in pairs(GoneForGood[jDeadEliahIndex].butterflys) do
				if Spring.GetUnitIsDead(id)==false then 
					Spring.DestroyUnit(id,false,true)
				end
			end
		end
			
	
	
		--Lets get this out of here before it starts to rot
	end
	
	function reSpawnTree(ix)
		--check the butterflies for beeing still alive
		-- if at least one is still in existance then
		--respawn then eliah
		--nil the entry
		--none of the butterflys is- nil entry	
		
		likeHisFathersFather=jTree3RespawnTable[ix][5]
		Spring.CreateUnit("jtree3",jTree3RespawnTable[ix][1],jTree3RespawnTable[ix][2],jTree3RespawnTable[ix][3],0,likeHisFathersFather)
				
		jTree3RespawnTable[ix]=nil
		--Lets get this out of here before it starts to rot
	end
	
	function gadget:GameFrame (f)
		if f % intIntervall == 0 then
			--itterate over the whole GoneForGood table
			--decrease the time 
			for i,val in ipairs(GoneForGood) do
				if GoneForGood[i] and GoneForGood[i].stats then
					GoneForGood[i].stats.ms=GoneForGood[i].stats.ms-intIntervall
					--to avoid n² we do this onloop
					if GoneForGood[i].stats.ms < 0 then
						reIncarnateAfterTime(i)						
					end
				end
			end
			
			for nr,treeT in ipairs(jTree3RespawnTable) do
				if treeT then
					treeT[6]=treeT[6]-intIntervall
					--to avoid n² we do this onloop
					if treeT[6] < 0 then
						reSpawnTree(nr)
						jTree3RespawnTable[nr]=nil
					end
				end
			end
		
		end
		
	end
	eliahDefID=UnitDefNames["jeliah"].id
	jtree3DefID=UnitDefNames["jtree3"].id
	conAirDefID=UnitDefNames["conair"].id
	
	function inRandomRange(x,z,Range)
		offx,offz= Rotate(0,Range, (math.random(0,360)+Spring.GetGameFrame())%360)
		return x+offx,z+offz
	end
	
	blooddecals={"blooddecalfactory","blooddecalfactory1","blooddecalfactory2","blooddecalfactory3","blooddecalfactory4"}
	local spGetUnitPosition=Spring.GetUnitPosition
	local c_infantryTypeTable=getTypeTable(UnitDefNames,{"css","bg","gcivillian","advisor","zombie","bg2","jhivehoundmoma"})
	local j_infantryTypeTable=getTypeTable(UnitDefNames,{"tiglil","skinfantry","jcrabcreeper","jconroach","vort","jvaryfoo"})
	
	function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
		if c_infantryTypeTable[unitDefID] then
			x,y,z=spGetUnitPosition(unitID)
			name="blooddecal".."factory"
			if x then
				Spring.CreateUnit(blooddecals[math.random(1,#blooddecals)],x,y,z,0,teamID)
			end
		end
		
		if j_infantryTypeTable[unitDefID] then
			x,y,z=spGetUnitPosition(unitID)
			if x then
				if math.random(0,1)==1 then
					Spring.CreateUnit("blueblooddecalfactory",x,y,z,0,teamID)
				else
					Spring.CreateUnit("blueblooddecalfactory2",x,y,z,0,teamID)
				end
			end
		end
		
		if unitDefID== conAirDefID and attackerID and teamID ~= attackerTeamID then
			x,y,z=Spring.GetUnitPosition(unitID)
			vx,vy,vz,vl=Spring.GetUnitVelocity(unitID)
			
			id=Spring.CreateUnit("cconaircontainer",x,y,z,0,teamID)
			Spring.SetUnitVelocity(id,vx,vy,vz)
			Spring.SetUnitNeutral(id,true)
			Spring.SetUnitNoSelect(id,true)
			
		end
		
		if unitDefID== eliahDefID then
			--Spring.Echo("Eliah died")
			--get the Position where he died
			x,y,z=Spring.GetUnitPosition(unitID)
			newIndex=#GoneForGood+1
			GoneForGood[newIndex]={}
			GoneForGood[newIndex].stats={}
			GoneForGood[newIndex].stats.ms=timeInMsTillRespawn
			GoneForGood[newIndex].stats.ancestor=unitID
			GoneForGood[newIndex].stats.exp=Spring.GetUnitExperience(unitID)


			GoneForGood[newIndex].butterflys={}
			for i=1,numberOfButterflys,1 do
				tx,tz=inRandomRange(x,z,circleRange)
				ty=Spring.GetGroundHeight(tx,tz)
				GoneForGood[newIndex].butterflys[i]=Spring.CreateUnit("jbutterfly",tx,ty,tz,0,teamID)
				Spring.SetUnitMoveGoal(GoneForGood[newIndex].butterflys[i],x,y,z)				
			end
			
			--spawnWithinCircle
		end
		if unitDefID== jtree3DefID then
			x,y,z=Spring.GetUnitPosition(unitID)
			jTree3RespawnTable[#jTree3RespawnTable+1]={}
			jTree3RespawnTable[#jTree3RespawnTable][1]=x
			jTree3RespawnTable[#jTree3RespawnTable][2]=y
			jTree3RespawnTable[#jTree3RespawnTable][3]=z
			jTree3RespawnTable[#jTree3RespawnTable][4]=unitID
			jTree3RespawnTable[#jTree3RespawnTable][5]=teamID
			jTree3RespawnTable[#jTree3RespawnTable][6]=math.ceil((math.random(3500,120000)))			
		end
		
		
		
	end
	
	
end