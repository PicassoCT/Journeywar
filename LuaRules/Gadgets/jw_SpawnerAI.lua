-- In-game, type /luarules kpai in the console to toggle the ai debug messages

function gadget:GetInfo()
	
	
	
	return {
		name = "spawner",
		desc = "Spawns Units",
		author = "Your Moma",
		date = "around since last tuesday",
		license = "GPOCNL - Gajop Pissed Off Cause Nonsense License ",
		layer = 82,
		enabled = true
	}
end



if (gadgetHandler:IsSyncedCode()) then
	gaiaTeam=Spring.GetGaiaTeamID()
	teamTable={}
	meridianTable={}
	spawnUnits={ 
		["journeyman"]={"jgeohive", "jbeehive",},
		["centrail"]={"goildrum","gzombspa","jrefugeetrap", "coverworldgate"}
	}
	
	function randSign()
	if math.random(0,1)==1 then return 1 else return -1 end 
	end
		
	function spawnSpawners(frame,team,side)
		
		volume=math.abs(math.sin(frame/10000))*4
		Spring.Echo("SpawnVolume "..team.." : "..side)
		totalAbortCount=0
		
		for _=1, volume,1 do
		
			if #meridianTable <=1 then return end			
			meridian=meridianTable[math.random(1,#meridianTable)]
			percent=math.random(0,100)/100
			
			px=math.abs(percent*(meridian.tab.x)- (1-percent)*(meridian.atab.x))
			pz=math.abs(percent*(meridian.tab.z)- (1-percent)*(meridian.atab.z))
			T=Spring.GetUnitsInCylinder(px,pz,50)
			dirXSign=randSign()
			dirZSign=randSign()
			T={}
			while T and table.getn(T) > 0 and totalAbortCount < 64 do	
				T={}
			if totalAbortCount % 4 == 0 then
				if math.random(0,1)==1 then
					dirXSign=randSign()
				else
					dirZSign=randSign()
				end
			end
				px=px +100 *dirXSign
				pz=pz +100 *dirZSign
				
				if Spring.GetGroundHeight(px,pz) > 0 then
					T=Spring.GetUnitsInCylinder(px,pz,50)
				end
			totalAbortCount=totalAbortCount+1	
			end
			
			if  table.getn(T) == 0 and totalAbortCount < 64 then
				Spring.CreateUnit(spawnUnits[side][math.random(1,#spawnUnits[side])],px,0,pz,1,team)	
			end
			
		end
	end
	
	function randomSide()
		if math.random(0,1)==1 then return "centrail" else return "journeyman" end
	end
	
	spawnerAI={}
	function gadget:Initialize()
		boolAtLeastOneSPawner=false

		for _, t in ipairs (Spring.GetTeamList ()) do
			
			local teamID, leader, isDead, isAI, side = Spring.GetTeamInfo (t)
			typeAI= "player"
			if isAI== true then
				typeAI =Spring.GetTeamLuaAI (teamID)
			end
			
			Spring.Echo("SpawnerAI::TeamInfo::".. teamID, typeAI , leader, isDead, isAI, side)
			
			if isAI and isAI ==true and typeAI== "spawner" then
				spawnerAI[teamID] = side
				if side ~="journeyman" and side ~="centrail" then
					spawnerAI[teamID] = randomSide()
				end
				
				boolAtLeastOneSPawner=true
			else
				px,py,pz= Spring.GetTeamStartPosition(t)
				if px then
					teamTable[t]={x=px,z=pz}
				end
			end
		end
		if boolAtLeastOneSPawner == false then
			gadgetHandler:RemoveGadget ()
		end
		
		for team, tab in ipairs (teamTable) do
			for ateam, atab in ipairs (teamTable) do
				
				if team ~=ateam then
					medianPoint={x=0,z=0}
					medianPoint.x,medianPoint.z=(tab.x+atab.x)/2,(tab.z+atab.z)/2
					meridianTable[#meridianTable+1]=medianPoint
				end
				
				
			end
		end
		tempTable={}
		for i=1,#meridianTable do
			for j=1,#meridianTable do
				if i~=j then
					tempTable[#tempTable+1]={tab=meridianTable[i],atab=meridianTable[j]}		
				end
			end
		end
		
		tempTable[#tempTable+1]={tab ={x=Game.mapSizeX/2,z=(Game.mapSizeZ/8)*7} ,atab={x=Game.mapSizeX/2,z=(Game.mapSizeZ/8)} }	
		meridianTable=tempTable
		
	end
	
	function checkOnTeams()
	okayCount=0
		for teamID, side in pairs(spawnerAI) do
		teamID,leader,isDead =	Spring.GetTeamInfo(teamID)
			if isDead and isDead == false then
				okayCount=okayCount+1
			else
				spawnerAI[teamID]= nil
			end
		end
		
		if okayCount == 0 then
			gadgetHandler:RemoveGadget ()
		end
	end
	
	counter=0
	total=30*60*5
	function gadget:GameFrame(frame)
		if ((frame %total) % 15)== 0 then
			Spring.Echo("jw_SpawnerAI:timeToGo "..(total-(frame %total)) )
		end
		
		if frame > 0 and frame % total == 0 then
		
		checkOnTeams()

			for k,v in pairs(spawnerAI) do
				spawnSpawners(frame,k,v)
			end			
		end
	end
	
	
end