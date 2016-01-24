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
		spawnUnits={ ["journeyman"]={"jgeohive", "jbeehive"}
		,["centrail"]={"bonker","sentry","coverworldgate","crewarder","combinedfeature"}
	}
	
	
	
	function spawnSpawners(frame,team,side)
		
		volume=math.sin(frame/10000)*15
		
		boolBio= volume < 0
		volume=math.abs(volume)
		
		for _=1, volume do
			if #meridianTable <=1 then return end
			
			meridian=meridianTable[math.random(1,#meridianTable)]
			percent=math.random(0,1)
			
			px=math.abs(percent*(meridian.tab.x)- (1-percent)*(meridian.atab.x))
			pz=math.abs(percent*(meridian.tab.z)- (1-percent)*(meridian.atab.z))
			T=Spring.GetUnitsInCylinder(px,pz,50)
			dirXSign=math.random(-1,1);dirXSign=math.abs(dirXSign)/dirXSign
			dirZSign=math.random(-1,1);dirZSign=math.abs(dirZSign)/dirZSign
			
			while T and #T > 0 do	
				if math.random(0,1)==1 then
					dirXSign=math.random(-1,1);dirXSign=math.abs(dirXSign)/dirXSign
				else
					dirZSign=math.random(-1,1);dirZSign=math.abs(dirZSign)/dirZSign
				end
				px=px +100 *dirXSign
				pz=pz +100 *dirZSign
				
				if Spring.GetGroundHeight(px,pz) > 0 then
					T=Spring.GetUnitsInCylinder(px,pz,50)
				end
				
			end
	
				Spring.CreateUnit(spawnUnits[side][math.random(1,#spawnUnits[side])],px,0,pz,0,team)	
			
		end
	end
	
	
	spawnerAI={}
	function gadget:Initialize()
		boolAtLeastOneSPawner=false
		Spring.Echo("(Initializing SpawnerAI")
		for _, t in ipairs (Spring.GetTeamList ()) do
			
			local teamID, leader, isDead, isAI, side = Spring.GetTeamInfo (t)
			typeAI= "player"
			if isAI== true then
				typeAI =Spring.GetTeamLuaAI (teamID)
			end
			
			Spring.Echo("SpawnerAI::TeamInfo::".. teamID, typeAI , leader, isDead, isAI, side)
			
			if isAI and isAI ==true and typeAI== "spawner" then
				spawnerAI[teamID] = side
				
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
	
	
	
	incRate=0
	total=9000-incRate
	function gadget:GameFrame(frame)
		if frame > 0 and frame % total == 0 then
			for k,v in pairs(spawnerAI) do
				spawnSpawners(frame,k,v)
			end
			incRate=math.abs(math.sin(frame/1000)*1024)
			total=9000-incRate
		end
	end
	
	
end