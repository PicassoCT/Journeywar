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
	VFS.Include("scripts/lib_UnitScript.lua")
	
	gaiaTeam=Spring.GetGaiaTeamID()
	teamTable={}
	meridianTable={}
	spawnUnits={ 
		["journeyman"]={[1]="jgeohive", [2]="jbeehive",[3]="jghostdancer",[4]="jpoisonhive"},
		["centrail"]={[1]="goildrum",[2]="gzombspa", [3]="coverworldgate", [4]="crewarder"}
	}
		
	Distribution={}
	for _, t in ipairs (Spring.GetTeamList ()) do
		Distribution[t]= {
			[1]={x=1,y=1, sum=0},
			[2]={x=1,y=2, sum=0},
			[3]={x=2,y=2, sum=0},
			[4]={x=2,y=1, sum=0}	
		}	
	end
	
	function findPlaces(team, px, pz)
		Distro=Distribution[team]
		sumSums=-math.huge
		maxIndex=1
		for i=1,#Distribution do if Distro[i].sum > sumSums then sumSum=Distro[i].sum; maxIndex= i; end end
		
		T={}
		dirXSign=randSign()
		dirZSign=randSign()
		while totalAbortCount < 32 do	
			T={}
			if totalAbortCount % 2 == 0 then
				if math.random(0,1)==1 then
					dirXSign=randSign()
				else
					dirZSign=randSign()
				end
			end
			px=px +100 *dirXSign
			pz=pz +100 *dirZSign
			
			if Spring.GetGroundHeight(px,pz) > 0 then
				T=Spring.GetUnitsInCylinder(px,pz,90)
				if #T == 0 then
					return px,pz
				end
			end
			totalAbortCount=totalAbortCount+1	
		end
	end
		
	teamAccuVolume={}
	
	function spawnSpawners(frame,team,side)
		if not teamAccuVolume[team] then
			teamAccuVolume[team]=0 
		end
		
		volume=math.abs(math.sin(frame/10000))*4 + teamAccuVolume[team]
		teamAccuVolume[team]=0
		Spring.Echo("SpawnVolume "..volume.." -> "..team.." : "..side)
		totalAbortCount=0
		
		for _=1, volume,1 do
			if #meridianTable <=1 then echo("Not enough merdianTable"); return end			
			meridian=meridianTable[math.random(1,#meridianTable)]
			percent=math.random(10,90)/100
			px=math.abs(percent*(meridian.tab.x)- (1-percent)*(meridian.atab.x))
			pz=math.abs(percent*(meridian.tab.z)- (1-percent)*(meridian.atab.z))
			px,pz= findPlaces(team,px,pz)
			if px then	
				Spring.CreateUnit(spawnUnits[side][math.random(1,#spawnUnits[side])],px+math.random(10,20)*randSign(),0,pz+math.random(10,20)*randSign(),1,team)	
			else
				teamAccuVolume[team]=teamAccuVolume[team]+1			
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
			end
			
			px,py,pz= Spring.GetTeamStartPosition(t)
			if px and px ~= 0 and pz ~= 0 then
				teamTable[t]={x=px,z=pz}
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
					medianPoint={x=0,z=0}
					medianPoint.x,medianPoint.z=Game.mapSizeX-(tab.x+atab.x)/2,Game.mapSizeZ-(tab.z+atab.z)/2
					meridianTable[#meridianTable+1]=medianPoint			
			end			
			end
		end
		
		tempTable={}
		geoVentList= getGeoventList()
		for i=1,#geoVentList do
			for j=1,#geoVentList do
				if i~=j then
					tempTable[#tempTable+1]={tab=geoVentList[i],atab=geoVentList[j]}		
				end
			end
		end
		
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
			Spring.Echo("JwSpawnerAI:"..teamID.." - ".. leader.." - "..boolToString(isDead))
			if isDead == false then
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
		if frame > 0 and frame % total == 0 then
			checkOnTeams()
			
			for k,v in pairs(spawnerAI) do
				--Spring.Echo("jw_SpawnerAI:spawnTeam "..k..","..v )
				spawnSpawners(frame,k,v)
			end			
		end
	end
	
	function gadget:Shutdown()
		Spring.Echo("jw_SpawnerAIGadget: Shuting down")		
	end
end