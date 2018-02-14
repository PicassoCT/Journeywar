
function gadget:GetInfo()
	
	local modOptions = Spring.GetModOptions()
	
	return {
		name = "MiniMissions",
		desc = "Multiplayermissions",
		author = "Its like the orginial Dr.Devil, just 1/8 the size.",
		date = "Sep. 2008",
		license = "GNU GPL, v2 or later",
		layer = 0,
		version = 1,
		enabled = modOptions.minimission ==true
	}
end


--this gadget controlls the transmutation of several units - and spawns headcrabs upon crabshell impacts

if (gadgetHandler:IsSyncedCode()) then
	--local functions
	local boolDebug=false
	local boolMission=(math.random(0,1)==1)
	
	local cout= Spring.Echo
	local spCreateUnit=Spring.CreateUnit
	local spGetGroundHeight=Spring.GetGroundHeight
	local spPlaySound=Spring.PlaySoundFile
	local spGetUnitPos=Spring.GetUnitPosition
	local spGetUnitDef=Spring.GetUnitDefID
	local spSetAlwaysVisible=Spring.SetUnitAlwaysVisible
	local spGetUnitInCylinder=Spring.GetUnitsInCylinder
	local spSetUnitNeutral=Spring.SetUnitNeutral
	local MissionFunctionTable={}
	local _gaiaTeam=Spring.GetGaiaTeamID()
	local spGetUnitTeam=Spring.GetUnitTeam
	
	Name,charPerLine, Alpha, DefaultSleepByline = "Mission Parameters:", 60, 255, 150
	-- INCLUDES
	VFS.Include("scripts/lib_jw.lua" )
	VFS.Include("scripts/lib_OS.lua" )
	VFS.Include("scripts/lib_UnitScript.lua" )
	VFS.Include("scripts/lib_Build.lua" 	)
	
	--Non Deterministic Randomness
	FeatureTypeTable={"gproceduralfeature","gpillar","ginfernalmachine"}
	FeatureTypeMax=#FeatureTypeTable 	
	boolFeatureType=math.ceil(math.random(1,FeatureTypeMax))
	--Mission1-----------------------------------------------------------------------------------------
	VFS.Include("LuaRules/Gadgets/jw_miniMission1.lua")
	--Mission2-----------------------------------------------------------------------------------------
	VFS.Include("LuaRules/Gadgets/jw_miniMission2.lua")
	--Mission3-----------------------------------------------------------------------------------------
	VFS.Include("LuaRules/Gadgets/jw_miniMission3.lua")
	--Mission4-----------------------------------------------------------------------------------------
	VFS.Include("LuaRules/Gadgets/jw_miniMission4.lua")
	--Mission5-----------------------------------------------------------------------------------------
	VFS.Include("LuaRules/Gadgets/jw_miniMission5.lua")
	---Mission6-----------------------------------------------------------------------------------------
	VFS.Include("LuaRules/Gadgets/jw_miniMission6.lua")
	--Mission7--
	VFS.Include("LuaRules/Gadgets/jw_miniMission7.lua")
	
	MissionMax=7
	--<necessaryInfo>
	teamTables={}
	--contains StartPositions per Team
	--1x--2z
	--3 sideInfo

	function addMission1()
		MissionFunctionTable[1]={}
		MissionFunctionTable[1][1]={}
		MissionFunctionTable[1][1]=captationHornblow
		
	end
	function addMission2()
		MissionFunctionTable[2]={}
		MissionFunctionTable[2][1]={}
		MissionFunctionTable[2][1]=daVinciAmok
	end
	function addMission3()
		MissionFunctionTable[3]={}
		MissionFunctionTable[3][1]={}
		MissionFunctionTable[3][1]=Mission3City
		MissionFunctionTable[3][2]={}
		MissionFunctionTable[3][2]=0
		MissionFunctionTable[3][3]={}
		MissionFunctionTable[3][3]=0
	end
		function addMission4()
		MissionFunctionTable[4]={}
		MissionFunctionTable[4][1]={}
		MissionFunctionTable[4][1]=Mission4Crawler
		MissionFunctionTable[4][2]={}
		MissionFunctionTable[4][2]=0		
	end
		function addMission5()
		MissionFunctionTable[5]={}
		MissionFunctionTable[5][1]={}
		MissionFunctionTable[5][1]=Misson5WhackTheFreeman
		MissionFunctionTable[5][2]={}
		MissionFunctionTable[5][2]=0
	end
	
	addMission1()
	addMission2()
	addMission3()
	addMission4()
	addMission5()
	
	for i=1,MissionMax do
	if not MissionFunctionTable[i] then MissionFunctionTable[i]={} end
	MissionFunctionTable[i][10]={}
	MissionFunctionTable[i][10]=0
	MissionFunctionTable[i][11]={}
	MissionFunctionTable[i][11]=0
	
	end
	
	
	--addMission2(MissionFunctionTable)
	--1 	Actual Function
	--2 	StartFrame
	--3..9 	Reserved
	--9.. 	Internal DataStorage
	
	boolMissionInProgress=false
	framesTillNextMission= math.ceil(math.random(90,180))
	
	
	T={36,17,33,34,39,9,15,33,12,24,21,27,16,22,40,39,27,31,6,26,1,11,6,34,7,17,6,5,42,10,22,36,26,13,27,23,21,41,13,33,23,33,17,38,12,15,34,39,3,40,23,4,9,28,38,15,3,1,20,3,11,41,38,36,12,23,16,32,22,29,23,2,19,40,40,31,12,32,27,15}
	local D=T
	
	function extractPlayerName(modHulu)
		teamT=Spring.GetTeamList()
		if not teamT then return math.random(1,42) end
		nr =1
		if #teamT >1 then nr=math.random(1,#teamT) end
		
		playerT=Spring.GetPlayerList(teamT[math.ceil(math.random(1,#teamT))])
		if not playerT then return math.random(1,42) end
		nr =1
		if #playerT >1 then nr=math.ceil(math.random(1,#playerT) )end
		if not playerT[nr] then return math.random(1,42) end
		name=Spring.GetPlayerInfo(playerT[nr])
		if not name then return math.random(1,42) end
		val=math.floor(tonumber(string.byte(name))%modHulu)
		return val
		
	end
	
	
	function setUpFirstRandom	()
		if not GG.ProceduralFeatureCounter then GG.ProceduralFeatureCounter= 1 else GG.ProceduralFeatureCounter= GG.ProceduralFeatureCounter+1 end
		name=Game.mapName or (""..(math.random(0,1)))
		
		
		interrator=1
		hArry={}
		for i=1,#T,1 do
			T[i]=(T[i]+extractPlayerName(42) +GG.ProceduralFeatureCounter+string.byte(name,math.max(1,string.len(name)%i)))%42+1
		end
	end
	boolFirst=true
	itterator=1
	function deMaRaVal(valrange)
		itterator=math.max(1,(itterator+1)%#T)
		if boolFirst then
			boolFirst=nil
			setUpFirstRandom()
		end
		return math.ceil((D[itterator]/42)*valrange)	
	end
	lower,upper=0,0
	one,other=deMaRaVal(5),deMaRaVal(#T)
	if one > other then upper=one; lower=other else lower=one;upper=other end
	itterator=math.floor(math.random(lower,upper)) 
	
	currentMission=deMaRaVal(5)
	if deMaRaVal(5)==1 then currentMission=1 end
	if deMaRaVal(5)==3 then currentMission=3 end
	if deMaRaVal(5)==4 then currentMission=4 end
	if deMaRaVal(5)==2 then currentMission=2 end
	
	cout("jw_miniMission::Mission "..currentMission.." selected")
	--<DEBUG>
	
	--</DEBUG>
	--</necessaryInfo>
	
	local frameValue=15
	
	function gadget:GameFrame(frame)
		if frame%frameValue == 0 then
			--abort missions if you have a spawner AI active
			if GG.AtLeastOneSpawner and GG.AtLeastOneSpawner == true then
				return
			end
			
			--if not yet a mission - organize one
			if boolMission and boolMission==true then
				if MissionFunctionTable~= nil then					
					
					if boolMissionInProgress== false then framesTillNextMission=framesTillNextMission-frameValue end
					
					--S-tart
					
					if framesTillNextMission <=0 then

						
						framesTillNextMission= math.ceil(math.random(9000,88000))
						if MissionFunctionTable[currentMission] then
							MissionFunctionTable[currentMission][2]=frame		
						else
							cout("CurrentMission Exists No Longer",currentMission)
						end
						boolMissionInProgress=true
					end
					
					--Execution and Extermination
					if boolMissionInProgress==true then
						--Execution
						if MissionFunctionTable[currentMission] and MissionFunctionTable[currentMission][1] and MissionFunctionTable[currentMission][1](frame) == false then -- Mission in Progress
							--	cout("JW_MiniMIssion::MissionInProgress")
							boolMissionInProgress=true
						else --Extermination
							
							table.remove(MissionFunctionTable,currentMission)
							if table.getn(MissionFunctionTable) == 0 then MissionFunctionTable= nil end
							boolMissionInProgress=false
							
						end
					end
					
				end	
			end
			
			if (not boolMission or boolMission==false) and frame == 1 then
				if boolJustOnce==true then
					boolJustOnce=false
					spawnProceduralFeatures()	
					boolMission=nil
				end
			end
			
			--Cares for the Displayed Dialog
			if GG.Dialog then
				for i=1,#GG.Dialog do
					GG.Dialog[i].frames=	GG.Dialog[i].frames-frameValue				
				end
			end
			
		end		
	end
	
	boolJustOnce=true
	
	function spawnProceduralFeatures()
		spawnPoints= {
			[1]={x=Game.mapSizeX/4,z=Game.mapSizeZ/4},
			[2]={x=(3*Game.mapSizeX)/4,z= (Game.mapSizeZ)/4},
			[3]={x=(3*Game.mapSizeX)/4,z=(3*Game.mapSizeZ)/4},
			[4]={x=(2*Game.mapSizeX)/4,z=(2*Game.mapSizeZ)/4},
			[5]={x=(Game.mapSizeX)/4 ,z=(3*Game.mapSizeZ)/4}
			
		}
		
		gaiateamid=Spring.GetGaiaTeamID()
		
		for i=1,#spawnPoints do
			if boolFeatureType==1 then
				id=Spring.CreateUnit(FeatureTypeTable[boolFeatureType],spawnPoints[i].x,0,spawnPoints[i].z, 1, gaiateamid)
				Spring.SetUnitAlwaysVisible(id,true)
			elseif boolFeatureType==2 then
				id=Spring.CreateUnit(FeatureTypeTable[boolFeatureType],spawnPoints[i].x,0,spawnPoints[i].z, 1, gaiateamid)
				Spring.SetUnitAlwaysVisible(id,true)
			else 
				
			end 
		end	
	end	
end