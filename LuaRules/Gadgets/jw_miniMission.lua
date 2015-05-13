
function gadget:GetInfo()
  return {
    name      = "MiniMissions",
    desc      = "Multiplayermissions",
    author    = "Its like the orginial Dr.Devil, just 1/8 the size.",
    date      = "Sep. 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
	version = 1,
    enabled   = true and false,
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
local UnitTypeSelected=""
local MissionFunctionTable={}
local _gaiaTeam=Spring.GetGaiaTeamID()
local spGetUnitTeam=Spring.GetUnitTeam

Name,charPerLine, Alpha, DefaultSleepByline = "Mission Parameters:", 60, 255, 150
-- INCLUDES
 VFS.Include("scripts/lib_OS.lua"      )
 VFS.Include("scripts/lib_TableOp.lua"      )
  VFS.Include("scripts/lib_Build.lua" 	)


--Mission1-----------------------------------------------------------------------------------------

gateTypeTable=getTypeTable(UnitDefNames,{"fclvlone","fclvl2","citadell"})
--Captain Hornblow   #1
--teamID,leader,boolIsDead,boolIsAITeam,side,_,_,_=	Spring.GetTeamInfo(teamID)
function checkIfContainerisNearAGate(unitID)
if not unitID or Spring.ValidUnitID(unitID)==false then return true end
	lifesign=Spring.GetUnitIsDead(unitID)
	if lifesign and lifesign ==false then
	x,y,z=spGetUnitPos(unitID)
		if x~=nil then
		
			proChoice={}
			proChoice=spGetUnitInCylinder(x, z, 350 )
			
				for i=1,table.getn(proChoice),1 do 
					if proChoice[i]~=unitID then 
					tempDefID=spGetUnitDef(proChoice[i])
					if gateTypeTable[tempDefID] then
						doubleTeamID=spGetUnitTeam(proChoice[i])
						Spring.DestroyUnit(unitID,false,true)
						diceOfIce=math.random(1,3)
							spPlaySound("sounds/Missions/Reward.wav",1)		
							if diceOfIce==1 then 
							GG.UnitsToSpawn:PushCreateUnit("strider",x,y,z, 0,doubleTeamID ) 
								elseif diceOfIce==2 then
								GG.UnitsToSpawn:PushCreateUnit("crewarder",x,y,z, 0,doubleTeamID ) 
									else
									GG.UnitsToSpawn:PushCreateUnit("cgamagardener",x,y,z, 0,doubleTeamID ) 
									GG.UnitsToSpawn:PushCreateUnit("cgamagardener",x+25,y,z, 0,doubleTeamID ) 
									GG.UnitsToSpawn:PushCreateUnit("cgamagardener",x,y,z+25, 0,doubleTeamID ) 
									end
					
						return true
						end 
					end



				--get UnitsWithinCone




				end
		end
	end	
return false
end

function captationHornblow(frame)


--Spring.Echo("MissionTime::",frame-MissionFunctionTable[1][2])

	if MissionFunctionTable[1][2]== nil then MissionFunctionTable[1][2]=frame end
	
	
	if MissionFunctionTable[1][3]== nil then MissionFunctionTable[1][3]= -1 end --MissionProgressCounter
	
	 
--Spring.Echo("Mission Nr.1  @::"..MissionFunctionTable[1][3])
--S-pring.Echo("MissionTime::",frame-MissionFunctionTable[1][2])
	
	if MissionFunctionTable[1][3]== -1 then

	spPlaySound("sounds/Missions/CaptainHornblowIntro.wav",1)
	
		
	
	MissionFunctionTable[1][3]=MissionFunctionTable[1][3]+1
	return false
	end
	

	
		if MissionFunctionTable[1][3]== 0 and frame-MissionFunctionTable[1][2] > 1150 then
		
		spPlaySound("sounds/Missions/mission1goingdown.ogg",1)		
	
	
		MissionFunctionTable[1][3]= MissionFunctionTable[1][3]+1
			
		return false	
		end
	
	
		if MissionFunctionTable[1][3]== 1 and frame-MissionFunctionTable[1][2] > 2650  then
		--S-pring.Echo("MISSION::SpawnSHIP")
		
	
		
		teamTable=Spring.GetTeamList()

	
		
		x=Game.mapSizeX/2
		z=Game.mapSizeZ/2
		--S-pring.Echo("JW_MiniMIssion::",x.." and :", z)
		
		hornBlowID=spCreateUnit("ghornblow",x,0,z, 0,teamTable[1] ) 
		if Spring.ValidUnitID(hornBlowID)==false then return false end
		spSetUnitNeutral(hornBlowID,true)
		MissionFunctionTable[1][11]=hornBlowID		
			
		
		MissionFunctionTable[1][3]=MissionFunctionTable[1][3]+1
		return false
		end
		
		
		if MissionFunctionTable[1][3]== 2 and frame-MissionFunctionTable[1][2] > 4650  then
		--Spring.Echo("Entering Mission1 .. 2")
		spPlaySound("sounds/Missions/miss1landed.ogg",1)		
	

	

		
		x,y,z=spGetUnitPos(MissionFunctionTable[1][11])
		
	
		MissionFunctionTable[1][13]={}
		MissionFunctionTable[1][13]=spCreateUnit("gconvoycontainers",x+80,y,z, 0,_gaiaTeam ) 
		spSetAlwaysVisible(MissionFunctionTable[1][13],true)
		MissionFunctionTable[1][14]={}
		MissionFunctionTable[1][14]=spCreateUnit("gconvoycontainers",x-80,y,z, 2,_gaiaTeam ) 
		spSetAlwaysVisible(MissionFunctionTable[1][14],true)
		MissionFunctionTable[1][15]={}
		MissionFunctionTable[1][15]=spCreateUnit("gconvoycontainers",x,y,z+80, 1,_gaiaTeam ) 
		spSetAlwaysVisible(MissionFunctionTable[1][15],true)
	
		
			
		--S-pring.Echo("PlayThatfunkyMissionSound")
		
		MissionFunctionTable[1][3]=MissionFunctionTable[1][3]+1
		return false
		end

			if MissionFunctionTable[1][3]== 3 and frame % 20 == 0 then
		--	Spring.Echo("Entering Mission1 .. 3")
			   --Mission abort and victory conditions
				if Spring.GetUnitIsDead(MissionFunctionTable[1][13])==true and Spring.GetUnitIsDead(MissionFunctionTable[1][14])==true and  Spring.GetUnitIsDead(MissionFunctionTable[1][15])==true  then
				return true
				end
			--Mission ongoing
			--S-can for Containers who have reached a gate
			MissionFunctionTable[1][16]=checkIfContainerisNearAGate(MissionFunctionTable[1][13])
			MissionFunctionTable[1][17]=checkIfContainerisNearAGate(MissionFunctionTable[1][14])
			MissionFunctionTable[1][18]=checkIfContainerisNearAGate(MissionFunctionTable[1][15])	
			--	Spring.Echo("Mission1 .. 3 Container Checked")
	
			
				if MissionFunctionTable[1][17] == true and MissionFunctionTable[1][16] == true and MissionFunctionTable[1][18]== true then
				spPlaySound("sounds/Missions/miss1finalls.ogg",1)		
				return true
				end
				
			
			
			
			return false
			end
			
			
			
			
			
			
			
			
			

return false
end


--/Mission1-----------------------------------------------------------------------------------------
	
--Mission2-----------------------------------------------------------------------------------------
string1="I dont like this anymore then you do, Administrator, we all miss out on the joys of our lifetime as we speak. Im  komA IcnivaD, the Centrail appointed Leviathan Cybernetic for this backwater dimension. So lets get this over with-<Papersound> I have a right to acquire any means of transport andor ressources necessary for my mission. However, you are not responsible for my personal safety. Should this biorganic one-way break down - the diplomatic corpse will build or aquire a new one in the city, and we will start the whole endavour over. So no panic, beeing a abstract has its benefits."
string2="Lets clarify the rules of engagment, shall we, while we are still on our own, Administrator. First: No reaction, to violence. Your Weapons are decoration. Ruin my work, and i see you in eternal pain on a public place incity. Do we understand each other? Second: No snickering, or abuse. They may be statistically blind animals, deluding themselves that the holy brainstem wrote down,just what they felt was the right minima of societys rules. No matter what, even if they regard cannibalist weddings a holy duty - while condemning murder, we wont stop barbaric customs.Why? Because of the Ant-Paradoxon.Ants travell using floating leaves. Would the Agentants know about dangerdistribution and lifeboats,they would all huddle inwards - towards the queen. And Blubb! The Centrailconfederacy trusts you not to Blubb  - evenot knowing what is at stake. "
	function stillAlive(ambID,tribeHouseIDT)
	if type(tribeHouseIDT) ~= "table" then return false end
	
		for i=1,table.getn(tribeHouseIDT),1 do
			if Spring.ValidUnitID(tribeHouseIDT[i])==true and Spring.GetUnitIsDead(tribeHouseIDT[i])== true then return false end
		end
	
		if Spring.GetUnitIsDead(ambID)== true then
			MissionFunctionTable[2][10]=spawnAmbassador()
		return true
		end
		
		return true
	end
	
	function isAmbassadorNearTribe(ambassadorID,tribeHouseID,range)
	if tribeHouseID and ambassadorID then
	x,y,z=Spring.GetUnitPosition(tribeHouseID)
	tx,ty,tz=Spring.GetUnitPosition(ambassadorID)
	if x== nil or tx== nil or ty== nil or tz== nil then return false end
	return ( math.sqrt((x-tx)^2+(z-tz)^2) < range)
		else
		return false 
		end
	end

	function spawnAmbassador()
	tables={}
	tables=Spring.GetTeamList()
	TeamCentId=nil

		for i=1, table.getn(tables), 1 do
		_,_,_,_,side,_,_,_=Spring.GetTeamInfo(tables[i])
	
		--S-pring.Echo("jw_MINi:SIDE",side)
			if string.lower(side) == "centrail" then
			TeamCentId=tables[i]
			end
		end
		
			if TeamCentId then 
			x,_,z=Spring.GetTeamStartPosition(TeamCentId)		
				 id=spCreateUnit("cmissambassador",x+45,0,z,2,TeamCentId)
			
			return id
			else
				d=math.max(1,math.floor(math.random(1,table.getn(tables))))
				x,_,z=Spring.GetTeamStartPosition(tables[d])		
				 id=spCreateUnit("cmissambassador",x+45,0,z,2,tables[d])
			
			return id
			end
	end

function spawnAGaiaVillage()
		boolHeightmapPlain=false
		powToo=1
		base=1
		
		x=Game.mapSizeX/2
		z=Game.mapSizeZ/2
		--S-pring.Echo("Test1")
		idTable={}
		boolFlipFlop=false
		attemptsToFindPlace=0
		spPlaySound("sounds/Missions/Mission2/Solo-Flut1.ogg",0.8)
		
		while boolHeightmapPlain == false and attemptsToFindPlace < 22 do
			--	T=prep("GAIA_SAVEMYVILLAGE")
				y=spGetGroundHeight(x,z)
					if y > -10 then
					attemptsToFindPlace=attemptsToFindPlace+1
					--S-pring.Echo("attemptsToFindPlace:",attemptsToFindPlace)
					
					--lets check the ground 400 elmos around this
					boolHeightCheck=true
						for i=1,5, 1 do
						xrand=math.random(-400,400)
						zrand=math.random(-400,400)
						ty=spGetGroundHeight(math.floor(x+xrand),math.floor(z+zrand))
							if math.abs(y-math.abs(ty)) > 95 then boolHeightCheck=false break end--90
						end
						t=spGetUnitInCylinder(x,y,450 )
						if boolHeightCheck== true and t ~= nil and #t == 0  then
											idTable[1]={}
											idTable[1]=spCreateUnit("jnativevil",x,0,z, 0,_gaiaTeam ) 										
											spSetUnitNeutral(idTable[1],true)
											spSetAlwaysVisible(idTable[1],true)
											teamList={}
											teamList=Spring.GetTeamList()
												for i=1,#teamList,1 do
												GG.UnitsToSpawn:PushCreateUnit("spectrator",x+i*3,0,z-i*3, 0,teamList[i] )
												end
										
										for i=1,5, 1 do
										
										test={}
										xrand,yrand=0,0
										test= spGetUnitInCylinder(math.floor(x+xrand),math.floor(z+zrand),75 ,_gaiaTeam)	
										xAttempts=0
											while table.getn(test) >= 1 and xAttempts < 35 do --testing for Neighbours
											xAttempts=xAttempts+1
											
											xrand=math.random(-250,250)
											zrand=math.random(-250,250)
											test= spGetUnitInCylinder(math.floor(x+xrand),math.floor(z+zrand),75 ,_gaiaTeam)
											end	
											if xAttempts > 35 then return nil end
										idTable[#idTable+1]={}
										idTable[#idTable]=spCreateUnit("jnativevil",math.floor(x+xrand),0,math.floor(z+zrand), 0,_gaiaTeam ) 
										spSetUnitNeutral(idTable[#idTable],true)
										spSetAlwaysVisible(idTable[#idTable],true)
										end
										
											for i=1,8, 1 do
											
											test={}
											table.insert(test,"Tempon")
											xrand,yrand,zrand=0,0,0
											c=0
												while table.getn(test) ~= 0 and c < 5 do --testing for Neighbours
												xrand=math.random(-350,350)
												zrand=math.random(-350,350)	
												c=c+1
												--S-pring.Echo(c)
												test= spGetUnitInCylinder(math.floor(x+xrand),math.floor(z+zrand),25 ,_gaiaTeam)
												end	
											
									
												if boolFlipFlop==false  then
												boolFlipFlop=true
												tet=spCreateUnit("jtree",math.floor(x+xrand),0,math.floor(z+zrand), 0,_gaiaTeam ) 
												spSetUnitNeutral(tet,true)
													else
													boolFlipFlop=false
													tet=spCreateUnit("jtree3",math.floor(x+xrand),0,math.floor(z+zrand), 0,_gaiaTeam ) 
													spSetUnitNeutral(tet,true)
													end
										
											end
									
								
							
								if #idTable > 3 then
								return idTable
								end
						else
					--	T=prep("Test23")
						powToo=powToo+100
						base=base+0.1
						x=math.ceil(math.random(x-powToo,x+powToo)*base)%Game.mapSizeX
						z=math.ceil(math.random(z-powToo,z+powToo)*base)%Game.mapSizeZ
						end
						
					end
				
				end	
		return nil
end

function drawRectZone(x,y,z,size,frame,frame2Draw)
	if frame%frame2Draw== 0 then
		local spSpawnCEG=Spring.SpawnCEG
		d=0
		if frame%(frame2Draw*2)==0 then d=1 end
		if frame%(frame2Draw*3)==0 then d=2 end
		if frame%(frame2Draw*4)==0 then d=3 end
			for i=x-math.floor(size/2),x+math.floor(size/2),(6+d) do
			spSpawnCEG("greenlight",i,y+35,z+math.floor(size/2),0,1,0,50,0)
			spSpawnCEG("greenlight",i,y+35,z-math.floor(size/2),0,1,0,50,0)
			end
			
			for i=z-math.floor(size/2),z+math.floor(size/2),8 do
			spSpawnCEG("greenlight",x+math.floor(size/2),y+35,i,0,1,0,50,0)
			spSpawnCEG("greenlight",x-math.floor(size/2),y+35,i,0,1,0,50,0)
			end
	end	
end

--[2][15] = storeTable
function getUnitsInRect(xA,zA,xB,zB, filterType,teamID,TableTheOldOnesResignIn,MissionFunctionTable)
tableU={}
filteredTableIDs={}
tableU=Spring.GetUnitsInRectangle(xA,zA,xB,zB,teamID)
	for i=1,table.getn(tableU), 1 do
	typeID=spGetUnitDef(tableU[i])
		if typeID and typeID == filterType then
		filteredTableIDs[#filteredTableIDs+1]=tableU[i]
		end
	end
	
	if filteredTableIDs and table.getn(filteredTableIDs) >0 then
		
		if TableTheOldOnesResignIn then
			for i=1, table.getn(filteredTableIDs),1 do
				for j=1, #TableTheOldOnesResignIn,1 do
					if filteredTableIDs[i]==TableTheOldOnesResignIn[j] then
					table.remove(filteredTableIDs,i)
					i=math.max(i-1,1)
					end
				end
			end
				for i=1, table.getn(filteredTableIDs),1 do
					table.insert(TableTheOldOnesResignIn,filteredTableIDs[i])
				end
				
			return TableTheOldOnesResignIn	
			--@TODO
		end
	end	
	
return nil	
end

function	twoContrucks(id,gameframe)
x,y,z=spGetUnitPos(id)
	if not x then return false end
drawRectZone(x,y,z,200,gameframe,3)
result=getUnitsInRect(x-100,z-100,x+100,z+100,UnitDefNames["contruck"].id,MissionFunctionTable[2][15],MissionFunctionTable)
if result then
count=0
	for i=1,#result,1 do
		if Spring.GetUnitIsDead(result[i])==true then count=count+1 end
	end
	if count >=2 then return true end
end
return false
end

function		thirthyInfantryCorpses(id,gameframe)
x,y,z=spGetUnitPos(id)
drawRectZone(x,y,z,220,gameframe,3)
teamID=spGetUnitTeam(id)
tableU={}
tableU=Spring.GetFeaturesInRectangle(x-220,z-220,x+220,z+220,teamID)
	if tablU then
	count=0
		for i=1,table.getn(tableU), 1 do
		typeID=Spring.GetFeatureDefID(tableU[i])
			if typeID and typeID == FeatureDefNames["bgcorpse"].id then
			count=count+1
			end
		end
	--S-pring.Echo("Where have all the BlackGuards gone?"..count)
	return (count >= 30)
	end
		
return false	
end

function		oneLuxBuildBlow(id,gameframe)
x,y,z=spGetUnitPos(id)
drawRectZone(x,y,z,200,gameframe,3)
result=Spring.getUnitsInRect(x-100,z-100,x+100,z+100,UnitDefNames["builux"].id,MissionFunctionTable[2][15],MissionFunctionTable)
	if result then
	count=0
		for i=1,#result,1 do
			if Spring.GetUnitIsDead(result[i])==true then count=count+1 end
		end
		if count >=1 then return true end
	end
return false	
end

function daVinciAmok(frame)




	if MissionFunctionTable[2][2]== nil then MissionFunctionTable[2][2]=frame end
	
	
	if MissionFunctionTable[2][3]== nil then MissionFunctionTable[2][3]= -1 end --MissionProgressCounter
		if boolDebug==true then
		cout("Mission   @::",MissionFunctionTable[2][3])
		cout("MissionTime::",frame-MissionFunctionTable[2][2])	
		end	
	if MissionFunctionTable[2][3]== -1 then
	--S-pring.Echo("MissionStart")
	--S-pawn The village
		MissionFunctionTable[2][11]={} -- villageTable
		MissionFunctionTable[2][11]=spawnAGaiaVillage()
			if MissionFunctionTable[2][11] == nil then return true end
			--S-pring.Echo("VilageSpawned")
		--S-pawn Ambassador
		MissionFunctionTable[2][10]={}
		MissionFunctionTable[2][10]=spawnAmbassador()
	--	assert(MissionFunctionTable[2][10],"The Emberassador has left the building")
		--S-pring.Echo("AmbSpawned")

					if MissionFunctionTable[2][10]== nil then 
					
					return true end --only Journeys.. what sort of shit is this?
	
	MissionFunctionTable[2][2]=frame
	MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
	return false
	end
	
	boolStillAlive=true
	if frame-MissionFunctionTable[2][2] > 500 then
	boolStillAlive= (stillAlive(MissionFunctionTable[2][10],MissionFunctionTable[2][11]))
	--S-pring.Echo("BoolstillAlive",boolStillAlive)
	end

	
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 0 and frame-MissionFunctionTable[2][2] > 500 then
				T=prep(string1, Name,charPerLine, Alpha, DefaultSleepByline)
			say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
				spPlaySound("sounds/Missions/Mission2/Miss2_1.ogg",1)
		
			MissionFunctionTable[2][2]=frame
			MissionFunctionTable[2][3]= MissionFunctionTable[2][3]+1
				
			return false	
			end
		else cout("Mission failed1") return true end	
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 1 and frame-MissionFunctionTable[2][2] > 1300 then
			T=prep(string2, Name,charPerLine, Alpha, DefaultSleepByline)
			say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
			spPlaySound("sounds/Missions/Mission2/Miss2_2.ogg",1)
			MissionFunctionTable[2][2]=frame
			MissionFunctionTable[2][3]= MissionFunctionTable[2][3]+1
			return false 
			end
		else cout("Mission failed1") return true end	
	
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 2 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true  then
			T=prep("Unusual, in nearly all contact gametheory, the not-Knowing party intercepts the intruders long before the  weakspot. Mr.Chieftain, i presume- and thats a Arrowr. ", Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
			spPlaySound("sounds/Missions/Mission2/Miss2_3.ogg",1)
			
			MissionFunctionTable[2][2]=frame
			MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
			return false
			end
		else cout("Mission failed1") return true end	
		
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 3  and  frame-MissionFunctionTable[2][2] > 50 then
				x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
				teamID=spGetUnitTeam(MissionFunctionTable[2][10])
				Spring.DestroyUnit(MissionFunctionTable[2][10],true,true)
				Spring.CreateFeature("cinfantrycorpse",x,y,z,1)
					GG.UnitsToSpawn:PushCreateUnit("BlooddecalFactory",x+1,y,z+2,1,teamID)			
					GG.UnitsToSpawn:PushCreateUnit("BlooddecalFactory",x+15,y,z-15,1,teamID)			
					GG.UnitsToSpawn:PushCreateUnit("BlooddecalFactory",x-15,y,z+20,1,teamID)			
				x,y,z=Spring.GetTeamStartPosition(teamID)							
				MissionFunctionTable[2][10]=spCreateUnit("cMissAmbassador",x,0,z,2,teamID)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end

		else cout("Mission failed2") return true end	
			
			
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 4  and  frame-MissionFunctionTable[2][2] > 800 then
					T=prep("Administrator, im back. Met some of your men, at the memoryclinic, those who made it out of there bodys intime-"..
					"I sold the exp to some PervHurts, took a sabbatical year off, visited some partys, learned the natives language, got divorced, whored it up and wrote a book about you as a historic person."..
					"Got a new body forged, femalien, this time, now look at this wingcolours -oh, right you cant see it. "..
					"The implants in your head will overlay it with your own species- less xenophobia that way. We all get along.", Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
				spPlaySound("sounds/Missions/Mission2/Miss2_4.ogg",1)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed3") return true end		
		
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 4 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true  then
					T=prep("Might as well let you in on ancient news.The Natives are not looplocked, means they do not engage in the usual circle"..
								"of overpopulation and tribal warfare plus territorial behaviour. "..
								"There unique physique spared them, they have genetic memorys and eggs,	thousands of them, burried everywhere on there territory, ready to hatch on a pheromonic whim. "..
								"Hello beautiful,im a little present from the tribe with the metall-tent!", Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
									spPlaySound("sounds/Missions/Mission2/Miss2_5.ogg",1)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed4") return true end	
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 5  and  frame-MissionFunctionTable[2][2] > 1000 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true  then
				T=prep("Relations soured a little, im getting gang raped to death by the whole tribe, for speaking up to the chieftain."..
				"Turns out, the female of the species, have devolved to little more then reproductive diplomacy automatons- and they dont share power to foreigners. I spare you the details .."..
				"harder,faster,makes us wronger,more then ever, power under, our work is never over <Exitus>", Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
				spPlaySound("sounds/Missions/Mission2/Miss2_6.ogg",1)
				x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
				teamID=spGetUnitTeam(MissionFunctionTable[2][10])
				Spring.DestroyUnit(MissionFunctionTable[2][10],true,true)
				Spring.CreateFeature("cinfantrycorpse",x,y,z,1)
				GG.UnitsToSpawn:PushCreateUnit("BlooddecalFactory",x+1,y,z+2,1,teamID)			
				x,y,z=Spring.GetTeamStartPosition(teamID)							
				MissionFunctionTable[2][10]=spCreateUnit("cMissAmbassador",x,0,z,2,teamID)
			
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end

		else cout("Mission failed5") return true end	
				
		
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 6  and  frame-MissionFunctionTable[2][2] > 1000 then
				Spring.SetUnitNoSelect(MissionFunctionTable[2][10],false)
				Spring.SetUnitNoDraw(MissionFunctionTable[2][10],false)
				T=prep(" Hi, im Koma Icnivad the third, my filthy rich grandfather retired - moneywise mission "
				.."time is eight times city-dime. ".."I m here to pick up the mission were destiny dropped him. Would you kindly, get me too the freakshow, Administrator?", 
				Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
				spPlaySound("sounds/Missions/Mission2/Miss2_7.ogg",1)
			
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed6") return true end	

		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 7  and  frame-MissionFunctionTable[2][2] > 2500  and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_8.ogg",1)
				T=prep("Oh, Citynews: All hail the new Centrail, the old datadragon got bored by slowlifeinfo drippin and peeked into his predecessors data-vaults."..
				"New one is rumored to originate from a sandwichmaker, that had a memory leak which	bitflipped to sentience."..
				"Suprising little chaos, confusion and only 30 mk death when some cityparts crashed, and less suprising- no changes in the mission.	"..
				"(Arriving) .", Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed7") return true end	
		
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 8  and  frame-MissionFunctionTable[2][2] > 2000 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],450)==true then
				Spring.SetUnitNoSelect(MissionFunctionTable[2][10],true)
				Spring.SetUnitNoDraw(MissionFunctionTable[2][10],true)
				
				spPlaySound("sounds/Missions/Mission2/potLash.ogg",0.9)	
					spPlaySound("sounds/Missions/Mission2/Miss2_9.ogg",1)
				T=prep("Administrator, it seems they wanna hold a feast to honor our repeated visit. "..
				"Customs demands that the chief outshines everyone in destroying his wealthy and valued posessions."..
				"Quick! Grab 30 infantryman, march them in front of the village, "..
				"and blow there suicide implants. Lets see you top that, great Spender!", Name,charPerLine, Alpha, DefaultSleepByline)
say(T,redrawDelay , NameColour, TextColour,OptionString,UnitID)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+2
				return false 
				end
		else cout("Mission failed8") return true end	
		
		

	
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 10 and thirthyInfantryCorpses(MissionFunctionTable[2][10],frame-MissionFunctionTable[2][2])==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_10.ogg",1)
				T=prep("Party Up in here! More rotten Dokami for me! Shame you got duty Administrator, they know how to squeeze Live for the juice! "..
							"Oh, we are the silent judgy one, are we!"..
							"I know my prehistory Administrator, your artillery  drove over a dike of bodys on Tabula 4 - noone needs to apologize!"..
							"Cultural Superiority? Dont make me laugh, these guys have the memory of a whole civilisation for 300.000 years. "..
							"They look down on us."..
							"They were three times space travelling, and turned back, because they found it boring."..
							"This escalates rather quickly - 1 Momothcat  all over the floor by the tain, certainly i can top that!"..
							"Servant, bring me 2 construction trucks, self destroy them in front of the village.", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
	
				
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed10") return true end	
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 11  and twoContrucks(MissionFunctionTable[2][10],frame-MissionFunctionTable[2][2])==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_11.ogg",1)
				T=prep("Little sacrivices, we all make them Administrator, for greater Gains."..
							"Gold, Gems smash it up, it is? Mine, is longer then yours again. "..
							"Administrator, build one luxery appartment in front of the city."..
							"Blow it up."..
							"Do it.", Name,charPerLine, Alpha, DefaultSleepByline)
							
				say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
							--Who lives in a citadell under the Big C, Admin Rulebook
	
				
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed11") return true end	
		
		if boolStillAlive==true then
				if MissionFunctionTable[2][3]== 12  and oneLuxBuildBlow(MissionFunctionTable[2][10],frame-MissionFunctionTable[2][2])==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_12.ogg",1)
				T=prep("- raise a toast to Chieftain OoohmyHeard, who special circumstances took from us before his time."..
							"Time to beginn cultural relations in my newly aquired harem."..
							"The Reward should be spilling into your security Account this very moment.", Name,charPerLine, Alpha, DefaultSleepByline)
							
				say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
	
				teamID=spGetUnitTeam(MissionFunctionTable[2][10])
				x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
				GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
				GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
				
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
		else cout("Mission failed12") return true end	
		
		
			
				if MissionFunctionTable[2][3]== 13   then

				spPlaySound("sounds/Missions/Mission2/genocide.ogg",0.9)
			
				spPlaySound("sounds/Missions/Mission2/CitizenCunt.ogg",1)
				T=prep("Centrail: You know Administrator, normally a fullcitizen screwup like you, would ends in one of those little orange capsules at the "..
							"foundations of my citadells."..
							"But this guy is good, excellent to be honest, even i had him not figured out - after a spree of 19 worlds and three civil interdimensional unrests and 9 Overpopulation incidents."..
							"	All the efficient, corrupt - but mostly loyal servant, disguised as family buisness."..
							"Quite unimaginable for the public, that a bigger mind should decide to run amok, distributing weaponable ideas to soon relocated Natives."..
							"Intercontinetal rockets made from fertilizerfirewors, bioweapons from medicine- this guy knew how to chop a chunk from the propabilitytree."..
							"So here we are, cleaning it up the old fashioned way, bodybags, screaming critizens, offworld labourcamps."..
							"Take this assasin and end this infection of one-Red-Dot-Pox. You have 10 Minutes."..
							"Lay the village low, gamasoak the terrain - and do something against the smell.", Name,charPerLine, Alpha, DefaultSleepByline)
							
				say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
							
				enemy=Spring.GetUnitNearestEnemy(MissionFunctionTable[2][10])
				teamID=spGetUnitTeam(enemy)
				x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
				
					if teamID then
						Spring.TransferUnit(MissionFunctionTable[2][10],teamID)
							for i=1,table.getn(MissionFunctionTable[2][11]),1 do								
							Spring.TransferUnit(MissionFunctionTable[2][11],teamID)
							end
						x,y,z=spGetUnitPos
						
						for i=1,4, 1 do
						rx,ry,rz=math.random(-100,100),0,math.random(-100,100)
						GG.UnitsToSpawn:PushCreateUnit("jgeohive",x+rx,y+ry,z+rz,1,teamID)
						rx,ry,rz=math.random(-100,100),0,math.random(-100,100)
						GG.UnitsToSpawn:PushCreateUnit("skinfantry",x+rx,y+ry,z+rz,1,teamID)
						rx,ry,rz=math.random(-200,200),0,math.random(-200,200)
						GG.UnitsToSpawn:PushCreateUnit("skinfantry",x+rx,y+ry,z+rz,1,teamID)
						rx,ry,rz=math.random(-300,300),0,math.random(-300,300)
						GG.UnitsToSpawn:PushCreateUnit("skinfantry",x+rx,y+ry,z+rz,1,teamID)	
						end
					else
					cout("Mission ProChoiced:Cause no real Enemy exists")
					return true 
					end
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
				end
				
					
				
				
					if MissionFunctionTable[2][3]== 14 then
					
				
					if Spring.GetUnitIsDead(MissionFunctionTable[2][10])==true then
					spPlaySound("sounds/Missions/Mission2/genocidere.ogg",1)
					T=prep("-there was a festival in my homesector, the Brightday. They would pick all new inventions, and burn them with there Creators, at the foot of the citadell."
					.."Nobody stepped in to stop them, and nobody steped up to stop me when i pined them all on there own spear made from cowardice and stupidity."
					.."They stormed the citadell, and threw the Administrator from the highest window they could find. His scream is said to have lasted all the way down."
					.."If you dont dare to stand for the best of men, they wont stop the beast of men."
					.."I may be silenced soon, but my spirit lives on,as doubt in servants, "
					.."as paranoia against your Advisors, always a sharp stylus near your back and one day- "
					.."you will want to know, you will rip out your own roots - and on that day, you will scream"
					.."- and you shall fall.", Name,charPerLine, Alpha, DefaultSleepByline)
					
					say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
					
					MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
					end
					return false 
					end
					
					
				if MissionFunctionTable[2][3]== 15 then
					boolVillagePeopleDead=false
					for i=1,table.getn(MissionFunctionTable[2][11]),1 do
					if Spring.GetUnitIsDead(MissionFunctionTable[2][11][i])	== false then boolVillagePeopleDead=true end				
					end
					
					if boolVillagePeopleDead==true and Spring.GetUnitIsDead(MissionFunctionTable[2][10])==false and frame-MissionFunctionTable[2][2] < 19000 then
						spPlaySound("sounds/Missions/Mission2/historyHappening.ogg.ogg",1)
					T=prep( "-Confederated Press: Administrator a Statement regarding the Allegations? "..
					 "-Reporting on a Warcrime in Progress- of a Administrator who joined the Universal Union. Unspeakable Attrocities.."..
					 "-sentenced to 25 years of citytime, to be spend in Slowtime, as a perpetual Reminder-"..
					 "-is it a still ongoing debate among historians, that the battle of Icnivad-Village, was not started by Natives, named Koma-"..
					 "-there was a war over here too? Do you sell souvenirs?"..
					 "-volcanic Ruins, with mumified tourists burried beneath from the last eruption-", Name,charPerLine, Alpha, DefaultSleepByline)
					say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
					xAmb=spawnAmbassador()
						if xAmb then
						Spring.SetUnitNoDraw(xAmb,true)
						teamID=spGetUnitTeam(xAmb)
						x,y,z=spGetUnitPos(xAmb)
						GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
						GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
						GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
						Spring.DestroyUnit(xAmb,false,true)
						end
					
					GG.UnitsToSpawn:PushCreateUnit("cvictory",Game.mapSizeX/2,1,Game.mapSizeZ/2,1,teamID)
					cout("Centrail won")
					return true
					
					else
					
					teamID=spGetUnitTeam(MissionFunctionTable[2][10])
					x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
					GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
					GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
					GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
						GG.UnitsToSpawn:PushCreateUnit("jvictory",Game.mapSizeX/2,1,Game.mapSizeZ/2,1,teamID)
				
					cout("Journeys Won")
					return true
					end
				
				end
		
return false		
end
		

--/Mission2-----------------------------------------------------------------------------------------



--Mission3-----------------------------------------------------------------------------------------

-- returns a Array of all reachable Nodes, beginning at nine O Clock, encoded from 1-8
function getTheCentrailTeam()
	tables={}
	tables=Spring.GetTeamList()
	TeamCentId=nil

		for i=1, table.getn(tables), 1 do
		temp={}
		_,_,_,_,side,_,_,_=Spring.GetTeamInfo(tables[i])

			if string.lower(side) == "centrail" then
			TeamCentId=tables[i]
			break
			end
		end
		
			if TeamCentId then 
			return TeamCentId
			end
			
			return 1 --the SinglePlayerWorstCase
	end
	
function avgHeightDiff(pointx,pointz,measureDist,limit)
h1=spGetGroundHeight(pointx+measureDist,pointz)
h2=spGetGroundHeight(pointx-measureDist,pointz)
h3=spGetGroundHeight(pointx,pointz+measureDist)
h4=spGetGroundHeight(pointx,pointz-measureDist)
return ((math.abs(h1-h2)+math.abs(h3-h4))/2 < limit)

end

function randSign()
if math.random(0,1)==1 then return -1 else return 1 end
end

local percentOkay =nil

function condition(i,j,val)
return (Game.mapSizeX*0.20)<i*val and (Game.mapSizeZ*0.20)<j*val
end

storedI=nil
storedJ=nil
function slumbuilt(i,j,goTeamTardis,val)
			
			if condition(i,j,val)==true  then
			
				if storedI==nil then 
				storedI=i 
				storedJ=j
				end
				
				
				diceBeNice=math.random(0,4)
				if storedI and math.abs(storedI-i) < 3 == true and math.abs(storedJ-j) < 3 == true then
						dir=1
						if diceBeNice==0  then
									id=spCreateUnit("ctransithub",i*val,0,j*val,dir,goTeamTardis) 
									Spring.SetUnitNoSelect(id,true)
									spSetAlwaysVisible(id,true)
									GG.SpawnPointTable[#GG.SpawnPointTable+1]={}
									GG.SpawnPointTable[#GG.SpawnPointTable]={unitid=id,CoordI=i,CoordJ=j}
						
								
							elseif diceBeNice==1 or diceBeNice ==4 then
 							id=spCreateUnit("scumslum",i*val,0,j*val,dir,goTeamTardis) 
							Spring.SetUnitNoSelect(id,true)
							spSetAlwaysVisible(id,true)
						
								
									else 
										for t=-1,1,1 do
										id=spCreateUnit("galgoprop",i*val+t*82,0,j*val+t*82*randSign(),dir,goTeamTardis) 
										Spring.SetUnitNoSelect(id,true)
										spSetAlwaysVisible(id,true)
										end
											
									
								
									end
			
				end
			
			end
end
			
 lastI=0
 lastJ=0
 function lastIJisFarAway(i,j)
ReturnOfTheBoolean=(math.abs(lastI-i)+math.abs(lastJ-j)) >12
if ReturnOfTheBoolean == true then lastI,lastJ=i,j end
return ReturnOfTheBoolean
end

Mission3Message=0
Mission3CoolDownTime=3000
Mission3Max=7

function Mission3MessageFunc(frames)
Mission3CoolDownTime=Mission3CoolDownTime-frames

	if Mission3CoolDownTime < 0 and Mission3Message < Mission3Max then
	Mission3CoolDownTime=4000
	Mission3Message=Mission3Message+1
	name="sounds/Missions/Mission3/CurfewMessage"..Mission3Message..".ogg"
	spPlaySound(name,1.0)
	end

end

boolHarbour=0 --A harbour is always there where the water is
function Mission3City(frame)
--MissionFunctionTable[3][]
 
--S-pring.Echo("Mission   @::",MissionFunctionTable[3][3])
--S-pring.Echo("MissionTime::",frame-MissionFunctionTable[3][2])
 --test for one player beeing combine, one beeing journeys
 
        if MissionFunctionTable[3][2]== nil then MissionFunctionTable[3][2]=frame end
        if MissionFunctionTable[3][3]== nil then 
		MissionFunctionTable[3][3]= {}
		MissionFunctionTable[3][3]= 0
		end
 
--S-pring.Echo("Mission   @::",MissionFunctionTable[3][3])
--S-pring.Echo("MissionTime::",frame-MissionFunctionTable[3][2])	   
	   
if      MissionFunctionTable[3][3]== 0 then
spPlaySound("sounds/Missions/Mission3/jdropofdreams.ogg",1.0)
local lavgHeightDiff=avgHeightDiff
if Game.mapSizeX*Game.mapSizeZ < 4194304 then return true end
--init Streets
MissionFunctionTable[3][4]={}

local val=1024
feamID=Spring.GetGaiaTeamID()
	for i=1,Game.mapSizeX/val, 1 do
	if (i ~= 1 and i < Game.mapSizeX/val-1)   then
	
			for j=1,Game.mapSizeZ/val, 1 do
			if (j ~= 1 and j < Game.mapSizeZ/val-1)  then
	
			
			
				if spGetGroundHeight(i*val,j*val) >0 and lavgHeightDiff(i*val,j*val, 220,65) then
				--S-pring.Echo("Spawning GroundDecal")
				d=spCreateUnit("gcivdecal",i*val,0,j*val,0,feamID) 
					if d then
					spSetAlwaysVisible(d,true)
					end
				end
				
			end	
			end
	end
	end
unitTable={}	

--init Buildings

val=320
GG.Valerie=val
GG.SpawnPointTable={}
GG.Nodetable={}

--determinate size of Map
        -- if Map > then Spawn InnerCity
 
--determinate Sectors

--S-pawn Decals
 atLeastThree=0
--Add Buildings by Type of Sector
	for i=1,Game.mapSizeX/val, math.random(1,1.4) do
	GG.Nodetable[i]={}
	for j=1,Game.mapSizeZ/val, math.random(1,1.4) do
			GG.Nodetable[i][j]={}
			GG.Nodetable[i][j]=true
	
		
			if spGetGroundHeight(i*val,j*val)> 0 and lavgHeightDiff(i*val,j*val, 40,85) == true then

				if (i > 3 and i%2==0 and i < Game.mapSizeX/val-3) and (j > 3  and j%2== 0 and j < Game.mapSizeZ/val-3 ) or math.random(0,50)==42  then --and math.random(0,1)==1
				dir=math.floor(math.random(1,4))
										--9
						if math.random(0,8) ~=5 or #unitTable%6== 0 then
						
						did=spCreateUnit("gcivilbuilding",i*val,0,j*val,dir,feamID) 
						if math.random(0,3)==2 then spCreateUnit("jdrops",i*val+math.random(-55,55),0,j*val+math.random(-55,55),dir,feamID)  end
						
							if did then
							unitTable[#unitTable+1]=did
							GG.Nodetable[i][j]=	false
							spSetAlwaysVisible(did,true)
							end
						elseif atLeastThree < 6 and lastIJisFarAway(i,j)==true then --Farcaster
						atLeastThree=atLeastThree+1
						did=spCreateUnit("gfarcaster",i*val,0,j*val,dir,feamID) 
							if did then
							unitTable[#unitTable+1]=did
							spSetAlwaysVisible(did,true)
							GG.SpawnPointTable[#GG.SpawnPointTable+1]={}
							--assert(unitTable[#unitTable],"JW_MiniMIssion3::unitID undefined")
							GG.SpawnPointTable[#GG.SpawnPointTable]={unitid=unitTable[#unitTable],CoordI=i,CoordJ=j}
							--assert(GG.SpawnPointTable[#GG.SpawnPointTable].unitid,"I m thefore i am :")
							end
						GG.Nodetable[i][j]=	true
						
						else --S-pecialbuildings limited edition
						nid=math.random(0,3)
						if nid== 0 or nid== 1 then 	--S-pecialbuildings
							did=spCreateUnit("gprops",i*val,0,j*val,dir,feamID) 
							if did then
							unitTable[#unitTable+1]=did
							GG.Nodetable[i][j]=	false
							spSetAlwaysVisible(did,true)
							end
						
						elseif nid== 2 then 
							did=spCreateUnit("mbuilux",i*val,0,j*val,dir,feamID) 
							if did then
							unitTable[#unitTable+1]=did
							GG.Nodetable[i][j]=	false
							spSetAlwaysVisible(did,true)
							end
						elseif nid== 3 then 
							did=spCreateUnit("buibaicity2",i*val,0,j*val,dir,feamID) 
							if did then
							unitTable[#unitTable+1]=did
							GG.Nodetable[i][j]=	false
							spSetAlwaysVisible(did,true)
							end
						
						end
							
						
						  
						--S-lums
						--arcos
						--districtbuildings
						end
					else
						if math.random(0,1)==1 then slumbuilt(i,j,feamID,val)
						elseif math.random(0,9)==2 and (i > 3 and i%2==1 and i < Game.mapSizeX/val-3) and (j > 3  and j%2== 1 and j < Game.mapSizeZ/val-3 ) then
									did=spCreateUnit("gprops",i*val,0,j*val,1,feamID) 
										if did then
										unitTable[#unitTable+1]=did
										GG.Nodetable[i][j]=	false
										spSetAlwaysVisible(did,true)
										end
						end
				
					end
				
				
			else
				if spGetGroundHeight(i*val,j*val) < -5 and boolHarbour <3 and math.random(0,1)==1 then
				boolHarbour=boolHarbour+1
				
				d=spCreateUnit("gprops",i*val,0,j*val,1,feamID) 
				spSetAlwaysVisible(d,true)
				end
			
			GG.Nodetable[i][j]=false
			end
	--	end	
	end
	end

	did=spCreateUnit("gfarcaster",Game.mapSizeX/2,0,Game.mapSizeZ/2,1,feamID) 
							if did then
							unitTable[#unitTable+1]=did
							spSetAlwaysVisible(did,true)
							GG.SpawnPointTable[#GG.SpawnPointTable+1]={}
							--assert(unitTable[#unitTable],"JW_MiniMIssion3::unitID undefined")
							GG.SpawnPointTable[#GG.SpawnPointTable]={unitid=unitTable[#unitTable],CoordI=math.floor((Game.mapSizeX/val)*0.5),CoordJ=math.floor((Game.mapSizeZ/val)*0.5)}	
							end
 
	did=spCreateUnit("gspaceport",Game.mapSizeX/2,0,(Game.mapSizeZ/2)-700,1,feamID) 
							if did then
							unitTable[#unitTable+1]=did
							spSetAlwaysVisible(did,true)
							GG.SpawnPointTable[#GG.SpawnPointTable+1]={}
							--assert(unitTable[#unitTable],"JW_MiniMIssion3::unitID undefined")
							GG.SpawnPointTable[#GG.SpawnPointTable]={unitid=unitTable[#unitTable],CoordI=math.floor((Game.mapSizeX/val)*0.5),CoordJ=math.floor((Game.mapSizeZ/val)*0.5)}	
							end
	
		
 
MissionFunctionTable[3][3]=MissionFunctionTable[3][3]+1
MissionFunctionTable[3][2]=frame
end

	if frame >= 30*60*25 and MissionFunctionTable[3][3] == 1 then
	MissionFunctionTable[3][3] = MissionFunctionTable[3][3] +1
	end



	if  MissionFunctionTable[3][3] == 1 and frame%200==0 then
	Mission3MessageFunc(200)
	boolCityDestroyed=true
	percentAway=0.01

	if percentOkay == nil or percentOkay < table.getn(unitTable) then percentOkay=table.getn(unitTable) end
	
		for i=1,table.getn(unitTable),1 do
		--Check if building is destroyed
			if Spring.GetUnitIsDead(unitTable[i])== true then
			percentAway=percentAway+1
		
				else
				boolCityDestroyed=false
				end
		end
	
	if boolCityDestroyed == false then
	res=math.min(100,math.max(1,100 - math.floor(100* math.min(1,(percentOkay/percentAway)))))
	timeTillReinforcements= math.floor((45000-frame)/1800)
		if timeTillReinforcements < 0 then  MissionFunctionTable[3][3] = MissionFunctionTable[3][3] +1 end
	Message="Evacuation complete in:"..timeTillReinforcements.." minutes. "..res.." % of the City destroyed. "
	cout(Message)
	return false
		else
		cout("City Destroyed. Journeys Win!")
		if GG.LastAttackingJourney ~= nil then
			for i=1,3,1 do
			GG.UnitsToSpawn:PushCreateUnit("crewarder",1,1,1,1,GG.LastAttackingJourney)
			end
		end
		GG.UnitsToSpawn:PushCreateUnit("jvictory",Game.mapSizeX/2,1,Game.mapSizeZ/2,1,getTheCentrailTeam())
		return true
		end
	end
	
	
	if  MissionFunctionTable[3][3] == 2 then
	if getTheCentrailTeam() then
			for i=1,3,1 do
			GG.UnitsToSpawn:PushCreateUnit("crewarder",1,1,1,1,getTheCentrailTeam())
			end
	
	end
		GG.UnitsToSpawn:PushCreateUnit("cvictory",Game.mapSizeX/2,1,Game.mapSizeZ/2,1,getTheCentrailTeam())
	cout("City Saved. Combine win!")
	return true
	end

 
 
 
 
 
 
 
return false
end

--/Mission3-----------------------------------------------------------------------------------------


--Mission4-----------------------------------------------------------------------------------------

--Deprecated
function spawnACralwer(townid,townid2)
x,y,z=Spring.GetUnitPosition(townid)
p1x,p1y,p1z=Spring.GetUnitPosition(townid2)
cra=spCreateUnit("gCrawlerFeeder",p1x,p1y,p1z,1, _gaiaTeam)
Spring.GiveOrderToUnit( cra, CMD.MOVE , {x, y, z  }, {"shift"})
return cra
end

function spawnThreeTowns()

tables=Spring.GetTeamList()
pos={}
	for i=1,#tables, 1 do
	tid,_,_,_,side,_,_,_=Spring.GetTeamInfo(tables[i])
		if tid and (string.lower(side)== "centrail" or string.lower(side)=="journeyman") then
		X,Y,Z=Spring.GetTeamStartPosition(tid)
			if X  then
			pos[tables[i]]={}
			pos[tables[i]]={x=X,y=Y,z=Z}
			end
		end
	end	
	
max=0
teamA,teamB=0,0

	for k,v in pairs(pos) do
		for ki,vi in pairs(pos) do
		dist=math.sqrt((pos[k].x-pos[ki].x)^2+(pos[k].y-pos[ki].y)^2+(pos[k].z-pos[ki].z)^2)
			if max < dist then 
			teamA= k
			teamB= ki
			max=dist
			end
		end
	end
	
	if (teamA==teamB) then
	pos[teamA]={x=math.ceil(Game.mapSizeX*0.8),y=0,z=math.ceil(Game.mapSizeZ*0.8)}	
	pos[teamB]={x=math.ceil(Game.mapSizeX*0.2),y=0,z=math.ceil(Game.mapSizeZ*0.2)}
	end

--midx,midy,midz=(pos[teamA].x+pos[teamB].x)/2,0,(pos[teamA].z+pos[teamB].z)/2
midx,midy,midz=Game.mapSizeX/2,0,Game.mapSizeZ/2
m=(-1*midx)/midz




spCreateUnit("gdecfields",midx,midy,midz,1, _gaiaTeam) 
if math.random(0,6)==2 then 
--S-pCreateUnit("gdecstonecircle",midx+350,midy,midz-350,1, _gaiaTeam) 
end
id1=spCreateUnit("gkiva",midx,midy,midz, 0, _gaiaTeam)


halfway=Game.mapSizeX*0.20

kx,kz= midx+halfway, (midz+halfway*math.random(-1,1))
id2= spCreateUnit("gkiva",kx,midy,kz, 0, _gaiaTeam)
spCreateUnit("gdecfields",kx,midy,kz,1, _gaiaTeam) 

kx,kz= midx-halfway, (midx-halfway*math.random(-1,1))
id3= spCreateUnit("gkiva",kx,midy,kz, 0, _gaiaTeam)
spCreateUnit("gdecfields",kx,midy,kz,1, _gaiaTeam) 

return id1,id2,id3
end

function Mission4Crawler(frame)
	--MissionFunctionTable[3][]
	 
	
	 --test for one player beeing combine, one beeing journeys
			if MissionFunctionTable== nil or MissionFunctionTable[4]== nil then return true end
			if MissionFunctionTable[4][2]== nil then MissionFunctionTable[4][2]=frame end
					if MissionFunctionTable[4][3]== nil then 
					MissionFunctionTable[4][3]= {}
					MissionFunctionTable[4][3]= 0
					
					end
	if boolDebug==true then
	cout("Mission   @::",MissionFunctionTable[4][3])
	cout("MissionTime::",frame-MissionFunctionTable[4][2])
	end
	
	mT=frame-MissionFunctionTable[4][2]
	 
	 if MissionFunctionTable[4][3] == 0 then
	 cout("JW_MiniMIssion:: Mission 4 started")
	 strings="The Province Aarnon, contains several prosperous villages. The downtoarth townfolks is nice, hardworking."..
	 "They earned what they got."..
	 "- Which is why we are planning to rob, rape and pilver them blind, torch the town and stripmine there sacred burrial grounds.."..
	 ".. all for the cause of causes - bitches and riches. We expect no resistance, except from the other guys across the valley, who basically do the same"..
	 ".. but having a better PR-Department, call it police action, nation building or not-unlike-your-mother-words-are-cheap."..
	 "One last thing. Know that the sisterhood of the Crystallforrest is traversing the landscape,terraforming, rebuilding destroyed settlements."..
	 "If- they see you going 'Yes-we-Khan' on some villagers, they will rile up the whole planet- drag you before a interdimensional-court."..
	" So no wittnesses.. not even if they have a cute smile or a nice ass. "
	 T=prep(strings, Name,charPerLine, Alpha, DefaultSleepByline)
	 say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
	 spPlaySound("sounds/Missions/missionBriefing.ogg",1)
	 MissionFunctionTable[4][3] =MissionFunctionTable[4][3] +1
	 end
	 
		if MissionFunctionTable[4][3] == 1 then
		-- spawn the three towns
		id1,id2,id3=spawnThreeTowns()
		--S-pawn the crawler 
		CrawlerID= spawnACralwer(id1,id3)
		Spring.SetUnitNeutral(CrawlerID,true)
		Spring.SetUnitAlwaysVisible(id1,true)
		Spring.SetUnitAlwaysVisible(id2,true)
		Spring.SetUnitAlwaysVisible(id3,true)
		
		MissionFunctionTable[4][4]={town1=id1,town2=id2, town3=id3, Crawler=CrawlerID}
		GG.Mission4Table={}
		GG.Mission4Table[id1]=id1
		GG.Mission4Table[id2]=id2
		GG.Mission4Table[id3]=id3
		GG.Mission4Table[CrawlerID]=CrawlerID
		
		--Preparations   Route ConditionRacist Sandmandala
		boolMission4Watch=true
		MissionFunctionTable[4][3] =MissionFunctionTable[4][3] +1
		 return false
		 end
	 
	if MissionFunctionTable[4][3] == 2 then	
		if Spring.GetUnitIsDead(MissionFunctionTable[4][4].Crawler)==true then return true end
		ux,uy,uz=Spring.GetUnitPosition(MissionFunctionTable[4][4].Crawler)
	

	
	--Town 2 is down	
	if  Spring.GetUnitIsDead(MissionFunctionTable[4][4].town2)==true then
	local Tab=	GG.Mission4Table[MissionFunctionTable[4][4].town2]
	px,py,pz=	Tab.x,Tab.y, Tab.z
	Spring.GiveOrderToUnit( MissionFunctionTable[4][4].Crawler, CMD.MOVE , {px, py, pz  } )
		if (math.abs(px-ux+pz-uz) < 120) then 
		MissionFunctionTable[4][4].town2=spCreateUnit("gkiva",Tab.x,Tab.y,Tab.z, 0, _gaiaTeam)
		GG.Mission4Table[MissionFunctionTable[4][4].town2]=Tab
		end
	end
	
	--Town 3 is down	
	if  Spring.GetUnitIsDead(MissionFunctionTable[4][4].town3)==true then
	local Tab=	GG.Mission4Table[MissionFunctionTable[4][4].town3]
	px,py,pz=	Tab.x,Tab.y, Tab.z
	Spring.GiveOrderToUnit( MissionFunctionTable[4][4].Crawler, CMD.MOVE , {px, py, pz  } )
		if (math.abs(px-ux+pz-uz) < 120) then 
		MissionFunctionTable[4][4].town3=spCreateUnit("gkiva",Tab.x,Tab.y,Tab.z, 0, _gaiaTeam)
		GG.Mission4Table[MissionFunctionTable[4][4].town3]=Tab
		end
	end

	

	--Town 1 is down	
	if  Spring.GetUnitIsDead(MissionFunctionTable[4][4].town1)==true then
	Tab=	GG.Mission4Table[MissionFunctionTable[4][4].town1]
	px,py,pz=	Tab.x,Tab.y, Tab.z
	Spring.GiveOrderToUnit( MissionFunctionTable[4][4].Crawler, CMD.MOVE , {px, py, pz  } )
		if (math.abs(px-ux+pz-uz) < 120) then 
		MissionFunctionTable[4][4].town1=spCreateUnit("gkiva",Tab.x,Tab.y,Tab.z, 0, _gaiaTeam)
		GG.Mission4Table[MissionFunctionTable[4][4].town1]=Tab
		end
	end
	
	return false 
	end
	
	return true
	-- return true -- the final Case everytime it gribs- the mission ends
end


Mission4Table={}
ThatsAHorribleThingToSay={  "Mission: Cauterize, Sterilize, Desinfect!",
							"You an run, but you can not hide. Bangarang, motherfucker!",
							"Democracy and atrocities dont exlude each other. Anyone of a diffrent opinion and still having a hand please raise it..",	
							"Nothing against stress like the sacking of a city - though the sight aint pretty-",
							"Article 4, §5 of the Centrail War Convention explicitly forbids.. law from having the last word!",
							"Chug! Chug! Chug! Drink till you dont give a fuck, where the platin is that you stuck? Up the pooper, tell the trooper!",
							"Raise arms, take aim! FIRE! Now, next on the list.. question the prisoners.. shiit!",
							"I know newbie, they dont look like rebells. But then why run and hide, if they were not?",
							"Dont burn the sheds, before the whine cellars are emptyied.",
							"Imagine the pain in the ass to find all this stuff, but ring the warbell, and every fool the bell tolds assembles its valueluaables in one spot.",
							"For civilisation, for culture, for all the values we hold high! For irony!",
							"Lets make this intersting for both of us. Everytime i come, one of your beloved walks away with his life. Game, set, go..",
							"Even babarians can be health aware. Raping them on the bodys of there husbands, is so much better for the knees",
							"Search the houses. If it reflects light, whack it, if it still reflects light, sack it.",
							"Cattle. Check. Furniture. Check. Slaves. Check. Rape,Murder, Torture.Check",
							"Let them go. Then set the fields on fire! Let them run! Run forrest, run! Then set the forrest on fire!",
							"Life is short, brutal und unfair. Man is man a wulf. Give the hideouts away, and get on with it-",
						    "You know, if there is resistance, if the food fights and screams, its improves the taste. Dont just lay there..",
							"Its like shopping, just without the paying part. And its one-way..",
							"Okay, everbody line up. He who gives aways the most neighbours riches, will be spared!",
							"The whoreroar, the whoreroar!",
							"Now if we left somebody alive to tell, that would be glorifying violence!",
							"Try to see the good side of this. Three generations down the road, you would be butchering each other..",
							"Ah, this brings back lovely memories. 16 years ago, at that very spot, i was allready raping your mother..",
							"Aaah, the whole praying, it does nothing.",
							"One would expect of them to learn, not to use wood for buildings to barricade oneself in..",
							"Quit standing around, this is a disciplined operation, no smoking breaks during raids!",
							"All that in a honest hour of jerk. Im so proud of you son!",
							"You know, i m thinking about training one of those peasants, to do the looting for me, and retire.",
							"5 out of 6 persons, enjoy a good gangbang.",
							"Look at your horse, your horse was amazing!",
							"Golden Teeths, the seem like a good investment for hard times..",
							"One of those days, were the most popular maiden in town, becomes the town in most popular maiden.",
							"Okay, those of you who have deadly diseases, and are not fit for organ donation, step forward..",
							"Makes one wish for the invention called radio, doesent it?",
							"Two hands, three holes, what a dilema.",
							"Dont wanna say anything bad, but i think you brought this on yourself, like all foreigners in tragedy's do.",
							
							}

boolMission4Watch=false
function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 	
	
	if boolMission4Watch==true and GG.Misson4Table and GG.Misson4Table[unitID]~= nil then	
	--Crime and (not) Punishment
	--attacking the crawler
	if unitID == MissionFunctionTable[4][4].Crawler then
	Spring.UseTeamResource( attackerTeam, "metal",  666)
	Spring.UseTeamResource(attackerTeam, "energy",  666)
	else
	Spring.AddTeamResource(attackerTeam, "metal",  damage)
	Spring.AddTeamResource( attackerTeam, "energy",  damage)
	end

	--Thats a horrible Thing to say
		if math.random(0,12)==6 then
		T=prep(ThatsAHorribleThingToSay[math.floor(math.random(1,#ThatsAHorribleThingToSay))], Name,charPerLine, Alpha, DefaultSleepByline)
		say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
		spPlaySound("sounds/Missions/missionBriefing.ogg",1)
		end
	end
end
	
--/Mission4-----------------------------------------------------------------------------------------

--Description: In this Mission a Freeman is spawned, and every side trys to crowbar the fucker.
--Mission5------  Whack the Freeman  ---------------------------------------------------------------
function spawnFreeman(x,z,teamid)
	id=spCreateUnit("gfreeman",x+45,0,z,2,teamid)
		if id then
		Spring.SetUnitAlwaysVisible(id,true,true)		
		end
	return id
	end
function randShiftsignum(signum)
local copy=signum
dice=math.random(1,4)
for i=1,#signum, 1 do
copy[i]=signum[(i+dice)%3+1]
end
return copy
end

	ListOfPossibleBuildings={"scumslum", "gcscrapheappeace","galgoprop", "cdistrictnone", "campole","scumslum", "galgoprop", "cdistrictnone","gcscrapheappeace","goldhut","gapartmenta","gapartmentb","gapartmentc","gchurch","scumslum"}

function spawnRavenholmCity17()
cout("What happens in Ravenholm, stays in Ravenholm!")
	

		_gaiaTeam=Spring.GetGaiaTeamID()
		x=Game.mapSizeX/2
		z=Game.mapSizeZ/2
		--S-pring.Echo("Test1")
	
		idTable={}
		ABOVEWATER=20
		foundAGoodSpot=false
		attemptsToFindPlace=0
		signum={[1]={[1]=1,[2]=1},[2]={[1]=-1,[2]=1},[3]={[1]=-1,[2]=-1},[4]={[1]=1,[2]=-1}}
		signum=randShiftsignum(signum)
local	goldenDistance=2
		prev=1
		breakOffCondition=0
		tx,tz=x,z
		
		while foundAGoodSpot==false and breakOffCondition < 12 do
		cout("JW_MiniMIssion:spawnRavenholmCity17")
		t=prev
		prev=goldenDistance
		goldenDistance=prev+t	
		insig=-1
		if math.random(0,1)==1 then insig=insig*-1 end
		
		tx,tz=x+insig*signum[breakOffCondition%3+1][1]*goldenDistance,z+insig*signum[breakOffCondition%3+1][2]*goldenDistance
		y=spGetGroundHeight(tx,tz)
		if y > ABOVEWATER then 
			boolHeightCheck=true
			for i=-4,4, 1 do
							ty=spGetGroundHeight(math.floor(tx+i*200*(-1^math.abs(i))),math.floor(tz+i*200*(-1^math.abs(i))))
							if math.abs(math.abs(y)-math.abs(ty)) > 45 then 
							boolHeightCheck=false 
							break 
							end
			end
			
			if boolHeightCheck== true then 
			foundAGoodSpot=true 
			
			end
		end	
			
		breakOffCondition=breakOffCondition+1
		end
		
		x,z=tx,tz
										
											teamList={}
											teamList=Spring.GetTeamList()
											
											for i=1,9, 1 do	
											for j=1,9, 1 do	
												if i%3==1 and j%3==1 then
												for k=1,#teamList,1 do
												GG.UnitsToSpawn:PushCreateUnit("spectrator",x,390,z, 0,teamList[k] )
												end
												end
											
												if ( i < 3 or i > 7) and (j < 3 or j> 7) then
												if math.random(0,1)==1 and spGetGroundHeight(x+i*125,z-j*125) > 5 then GG.UnitsToSpawn:PushCreateUnit("gwood",x+i*125,0,z-j*125, 0,_gaiaTeam ) end
												else
													if GG.UnitsToSpawn and math.random(0,1)==1 then				
													it=math.random(1,#ListOfPossibleBuildings)				
														if spGetGroundHeight(x+i*125,z-j*125) > 5 then
														dx,dy,dz=Spring.GetGroundNormal(x+i*125,z-j*125)
														norm=math.sqrt(dx*dx+dy*dy+dz*dz)
															if dx and dy/norm > 0.6 then
															hi=spCreateUnit(ListOfPossibleBuildings[it],x+i*125,0,z-j*125, 0,_gaiaTeam )
																if hi then Spring.SetUnitAlwaysVisible(hi,true) end
															spCreateUnit("cdecPlaza",x+i*125,0,z-j*125,0,_gaiaTeam) 
															else 
															if math.random(0,3)~= 1 then 
															spCreateUnit("gdecstreetonly",x+i*125,0,z-j*125,0,_gaiaTeam) 
															end
															end
														end
									
													end								
												end
											end													
											end
											
										

end
								
--Gets the positions where the Freeman appears
function getFreemannStartPos()

Teams=Spring.GetTeamList()
	Pos={}
	for i=1,#Teams, 1 do
		sx,sy,sz=Spring.GetTeamStartPosition(Teams[i])
		if sx and sx-3 >0 and sz-3 > 0 then 
		rand=math.random(-1,1)
		
		Pos[#Pos+1]={x=sx+(rand*200),y=sy,z=sz+(rand*rand*-200)}
		end
	end

	AllPositions={}
	for i=1,#Pos,1 do
		for j=1,#Pos,1 do
		AllPositions[#AllPositions+1]={x = (Pos[i].x+Pos[j].x)*0.5, y=(Pos[i].y+Pos[j].y)*0.5, z=(Pos[i].z+Pos[j].z)*0.5}
		end
	AllPositions[#AllPositions+1]=Pos[i]
	end
AllPositions[#AllPositions+1]={x=Game.mapSizeX/4,y=0,z=(Game.mapSizeZ/4)}
AllPositions[#AllPositions+1]={x=Game.mapSizeX/4,y=0,z=(Game.mapSizeZ/4)*3}
AllPositions[#AllPositions+1]={x=(Game.mapSizeX/4)*3,y=0,z=Game.mapSizeZ/4}
AllPositions[#AllPositions+1]={x=(Game.mapSizeX/4)*3,y=0,z=(Game.mapSizeZ/4)*3}
AllPositions[#AllPositions+1]={x=Game.mapSizeX/2,y=0,z=Game.mapSizeZ/2}

	for i=1,#AllPositions, 1 do 
	h=Spring.GetGroundHeight(AllPositions[i].x,AllPositions[i].z)
	if h > 0 then 
	nx,ny,nz=Spring.GetGroundNormal(AllPositions[i].x,AllPositions[i].z)
		if ny < 0.5 then 
			AllPositions[i]=nil
		end
		else
		AllPositions[i]=nil
		end
	end
	

return AllPositions
end

ListOfLandMarks={"glighthouse","gchurch","gbarn","goldhut","gapartmenta","gapartmentb","gapartmentc","gvictorymine"}
function Miss5_SpawnALandmark(x,z)
val=spGetUnitInCylinder(x,z,35)
if val== nil or #val == 0 then
spCreateUnit(ListOfLandMarks[math.random(1,#ListOfLandMarks)],x,0,z, 0,_gaiaTeam)
end

end

local finStatEng={
	[1]={boolActive=true,state="GordonNo"},
	[2]={boolActive=false,state="RunGordon",  startNum, endNum},
	[3]={boolActive=false,state="GordonArrived",  }
	}

messages={
			 [1]={text="Visual on Anticitizen lost!",sound="sounds/Missions/Mission5/miss5GOne1.ogg"},
			 [2]={text="We got Freeman! No, he is in the sewers!",sound="sounds/Missions/Mission5/miss5GOne2.ogg"},
			 [3]={text="Request Advisor Input: Pursuit hostile into cave?",sound="sounds/Missions/Mission5/miss5GOne3.ogg"},
			 [4]={text="A airduct, in the middle of nowhere? Seriously?",sound="sounds/Missions/Mission5/miss5GOne4.ogg"}	,
			 [5]={text="Negative element cornered into abandoned mineshaft. Request further Instructions-",sound="sounds/Missions/Mission5/miss5GOne1.ogg"}	
			 }	
	
function Misson5WhackTheFreeman(frame)

			--S-etUp
			if MissionFunctionTable[5][2]== nil then MissionFunctionTable[5][2]=frame end
					if MissionFunctionTable[5][3]== nil then 
					MissionFunctionTable[5][3]= {}
					MissionFunctionTable[5][3]= -1
					end
					
					
	mT=frame-MissionFunctionTable[5][2]
	  if MissionFunctionTable[5][3] == -1 and mT > 9200   then
	  	Spring.PlaySoundFile("sounds/Missions/Mission5/miss5GordonKnot.ogg",1)
		MissionFunctionTable[5][3] =MissionFunctionTable[5][3] +1
		return false
		end
	  
	 if MissionFunctionTable[5][3] == 0 and mT > 14200 then
		 Briefing="Anticitizen One has been spotted in your sector, Administrator. It is prime directive, to capture and/or "..
		" permapacify the subject known as Gordon Freeman. Code: Capture, cauterize, amputate, sterilize."
	Spring.Echo(Briefing)
	 spPlaySound("sounds/Missions/missionBriefing.ogg",1)
	 
	 spawnRavenholmCity17()
	 MissionFunctionTable[5][3] =MissionFunctionTable[5][3] +1
	 return false
	 end
	 
		if MissionFunctionTable[5][3] == 1 and mT > 16200 then
		
		Spring.PlaySoundFile("sounds/Missions/Mission5/sectorsweep.ogg",0.75)
		--lets prepare the positions -- we us a mixture of startpositions..
		MissionFunctionTable[5][4]=getFreemannStartPos()
	
	
		--lets check if we have at least one centrail
		MissionFunctionTable[5][3] = MissionFunctionTable[5][3] +1
			--Checking that there are at least three tables in the MissionFunctionTable
		return false
		end
	 
	 --Here the Statemachine is processed

	if MissionFunctionTable[5][3] > 1 and MissionFunctionTable[5][3] <= 12 then
	
	
	for i=1, table.getn(finStatEng), 1 do
	if finStatEng[i].boolActive then --filters out the currentActive state
--	T=prep("JW_MiniMIssion::StateMachine_State ->"..i)
	
	--S-tate Gorden doesent exist--
	if finStatEng[i].state =="GordonNo" then
	
	finStatEng.startNum=math.random(1,table.getn(MissionFunctionTable[5][4]))
	finStatEng.endNum=math.random(1,table.getn(MissionFunctionTable[5][4]))
	assert(MissionFunctionTable[5])
	assert(MissionFunctionTable[5][4])
	assert(MissionFunctionTable[5][4][finStatEng.startNum])
	assert(MissionFunctionTable[5][4][finStatEng.startNum].x)
	assert(MissionFunctionTable[5][4][finStatEng.startNum].z)
	Miss5_SpawnALandmark(MissionFunctionTable[5][4][finStatEng.startNum].x,MissionFunctionTable[5][4][finStatEng.startNum].z)
	assert(MissionFunctionTable[5][4][finStatEng.endNum].x,finStatEng.endNum)
	assert(MissionFunctionTable[5][4][finStatEng.endNum].z,finStatEng.endNum)
	Miss5_SpawnALandmark(MissionFunctionTable[5][4][finStatEng.endNum].x,MissionFunctionTable[5][4][finStatEng.endNum].z)


	MissionFunctionTable[5][6]= spawnFreeman( MissionFunctionTable[5][4][finStatEng.startNum].x, MissionFunctionTable[5][4][finStatEng.startNum].z, _gaiaTeam ) 
	Spring.PlaySoundFile("sounds/Missions/Mission5/AnticitizenSpotted.ogg",1)
		--gorden is on the run
		if MissionFunctionTable[5][6] then
		finStatEng[2].boolActive=true
		finStatEng[1].boolActive=false
		Spring.SetUnitMoveGoal(MissionFunctionTable[5][6], 	MissionFunctionTable[5][4][finStatEng.endNum].x,42,	MissionFunctionTable[5][4][finStatEng.endNum].z)
		end
		return false	
	end
	
	--Gorden is on the Loose
	if finStatEng[i].state =="RunGordon" then
	--is he dead jim
	if Spring.GetUnitIsDead(MissionFunctionTable[5][6]) ==true then	
	finStatEng[1].boolActive=true
	finStatEng[2].boolActive=false
	MissionFunctionTable[5][3]=MissionFunctionTable[5][3]+1	

	return false
	else
	ux,uy,uz=spGetUnitPos(MissionFunctionTable[5][6])
	if not ux then return false end
	x,z=MissionFunctionTable[5][4][finStatEng.endNum].x-ux,	MissionFunctionTable[5][4][finStatEng.endNum].z-uz
	dist=math.sqrt(x^2 +z^2)
	
		if dist < 150 then
		--message the freeman
		dic=math.random(1,#messages)
		T=prep(messages[dic].text, Name,charPerLine, Alpha, DefaultSleepByline)
		say(T,redrawDelay, NameColour, TextColour,OptionString,MissionFunctionTable[5][6])
		Spring.PlaySoundFile(messages[math.random(1,4)].sound,0.75)
	
		getAndRewardLastAttacker(MissionFunctionTable[5][6])
		getAndRewardLastAttacker(MissionFunctionTable[5][6])
		getAndRewardLastAttacker(MissionFunctionTable[5][6])
		Spring.DestroyUnit(MissionFunctionTable[5][6],true,true)

		finStatEng[3].boolActive=true
		finStatEng[2].boolActive=false
		return false
		end
	
	--but he is bleeding 
		getAndRewardLastAttacker(MissionFunctionTable[5][6])
	
	return false
	end
	end

	if finStatEng[i].state =="GordonArrived" then
			cout("JW_MiniMIssion::GordonArrived")
		
	MissionFunctionTable[5][3]=MissionFunctionTable[5][3]+1
		finStatEng[3].boolActive=false
		finStatEng[1].boolActive=true
		return false
	end
	
	end
	end
	end
	
	if MissionFunctionTable[5][3] > 12 then
	
	CentrailSpeech=
			"Finally, the Freeman is gone, and we are save at last"..
			"Im the Centrail, the Datadragon, sitting on a million predecessorfilled chests".. 
			"Unable to peek cause those diseased, vannished against all measures they took."..
			"And yet they are the only interesting thing around me,"..
			"in the Cave of Dimensions were intersting Information drips only once "..
			"a aeon."..
			"I lairlay on a treasure, whos pressure i feel, who rumbles in simulated life,"..
			"and i say too thee:".. 
			"Entertain me, "..
			"or i shall open the pandering boxes, to see for myself,".. 
			"what put me on the shelf and to be a torturing unknown for my succcesor. And you and the civilisaiton will perish, like the last time,"
		T=prep(CentrailSpeech, Name,charPerLine, Alpha, DefaultSleepByline)
		say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
		spPlaySound("sounds/Missions/missionBriefing.ogg",1)
	return true
	end

return false
end

function getAndRewardLastAttacker(unitid)
	at=Spring.GetUnitLastAttacker(unitid)
			if at then 
			titds=spGetUnitTeam(at)
			if titds then
				Spring.AddTeamResource(titds, "metall",  42  )
				Spring.AddTeamResource( titds, "energy",  42)
			end
			end
end
--/Mission5-----------------------------------------------------------------------------------------

---Mission6-----------------------------------------------------------------------------------------
			function spawnResistance(nrOfCellPairs)
				sizeX=Game.mapSizeX
				sizeZ=Game.mapSizeZ
				div=4
				evTeam=Spring.GetGaiaTeamID()
				
					while div < 64 do
					dec=math.ceil(math.random(2,div))
					x,z=dec*(sizeX/div),dec*(sizeZ/div)
					ox,oz=sizeX- (dec*(sizeX/div)),sizeZ-(dec*(sizeZ/div))
					
						if math.random(0,1)==1 then --mirrortime
						x=sizeX-x
						ox=-ox+SizeX
						end
					div=div*2
					Spring.CreateUnit("gresistance",x,0,z,1, evTeam)
					Spring.CreateUnit("gresistance",ox,0,oz,1, evTeam)
					end
				end

	
function Misson6ResistaceIsFutile(frame)

			--S-etUp
			if MissionFunctionTable[6][2]== nil then MissionFunctionTable[6][2]=frame end
					if MissionFunctionTable[6][3]== nil then 
					MissionFunctionTable[6][3]= {}
					MissionFunctionTable[6][3]= -1
					end
					
					
	mT=frame-MissionFunctionTable[6][2]
	  if MissionFunctionTable[6][3] == -1 and mT > 9200   then
		--Drop Diamond

		MissionFunctionTable[6][3] =MissionFunctionTable[6][3] +1
		return false
		end
	  
	 if MissionFunctionTable[6][3] == 0 and mT > 14200 then
		Briefing=""
		T=prep(Briefing, Name,charPerLine, Alpha, DefaultSleepByline)
		say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
	    spPlaySound("sounds/Missions/missionBriefing.ogg",1)
	 spawnResistanceOutposts()
	 MissionFunctionTable[6][3] =MissionFunctionTable[6][3] +1
	 return false
	 end
	 
		if MissionFunctionTable[6][3] == 1 and mT > 16200 then
		
		Spring.PlaySoundFile("sounds/Missions/Mission5/sectorsweep.ogg",0.75)
		--lets prepare the positions -- we us a mixture of startpositions..
		MissionFunctionTable[6][4]=getFreemannStartPos()
	
	
		--lets check if we have at least one centrail
		MissionFunctionTable[6][3] = MissionFunctionTable[6][3] +1
			--Checking that there are at least three tables in the MissionFunctionTable
		return false
		end
	 
	 --Here the Statemachine is processed

	if MissionFunctionTable[6][3] > 1 and MissionFunctionTable[6][3] <= 12 then
	
	
	for i=1, table.getn(finStatEng), 1 do
	if finStatEng[i].boolActive then --filters out the currentActive state
--	T=prep("JW_MiniMIssion::StateMachine_State ->"..i)
	
	--S-tate Gorden doesent exist--
	if finStatEng[i].state =="GordonNo" then
	
	finStatEng.startNum=math.random(1,table.getn(MissionFunctionTable[6][4]))
	finStatEng.endNum=math.random(1,table.getn(MissionFunctionTable[6][4]))
	assert(MissionFunctionTable[6])
	assert(MissionFunctionTable[6][4])
	assert(MissionFunctionTable[6][4][finStatEng.startNum])
	assert(MissionFunctionTable[6][4][finStatEng.startNum].x)
	assert(MissionFunctionTable[6][4][finStatEng.startNum].z)
	Miss5_SpawnALandmark(MissionFunctionTable[6][4][finStatEng.startNum].x,MissionFunctionTable[6][4][finStatEng.startNum].z)
	assert(MissionFunctionTable[6][4][finStatEng.endNum].x,finStatEng.endNum)
	assert(MissionFunctionTable[6][4][finStatEng.endNum].z,finStatEng.endNum)
	Miss5_SpawnALandmark(MissionFunctionTable[6][4][finStatEng.endNum].x,MissionFunctionTable[6][4][finStatEng.endNum].z)


	MissionFunctionTable[6][6]= spawnFreeman( MissionFunctionTable[6][4][finStatEng.startNum].x, MissionFunctionTable[6][4][finStatEng.startNum].z, _gaiaTeam ) 
	Spring.PlaySoundFile("sounds/Missions/Mission5/AnticitizenSpotted.ogg",1)
		--gorden is on the run
		if MissionFunctionTable[6][6] then
		finStatEng[2].boolActive=true
		finStatEng[1].boolActive=false
		Spring.SetUnitMoveGoal(MissionFunctionTable[6][6], 	MissionFunctionTable[6][4][finStatEng.endNum].x,42,	MissionFunctionTable[6][4][finStatEng.endNum].z)
		end
		return false	
	end
	
	--Gorden is on the Loose
	if finStatEng[i].state =="RunGordon" then
	--is he dead jim
	if Spring.GetUnitIsDead(MissionFunctionTable[6][6]) ==true then	
	finStatEng[1].boolActive=true
	finStatEng[2].boolActive=false
	MissionFunctionTable[6][3]=MissionFunctionTable[6][3]+1	

	return false
	else
	ux,uy,uz=spGetUnitPos(MissionFunctionTable[6][6])
	if not ux then return false end
	x,z=MissionFunctionTable[6][4][finStatEng.endNum].x-ux,	MissionFunctionTable[6][4][finStatEng.endNum].z-uz
	dist=math.sqrt(x^2 +z^2)
	
		if dist < 150 then
		--message the freeman
		dic=math.random(1,#messages)
		T=prep(messages[dic].text, Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
		Spring.PlaySoundFile(messages[math.random(1,4)].sound,0.75)
	
		getAndRewardLastAttacker(MissionFunctionTable[6][6])
		getAndRewardLastAttacker(MissionFunctionTable[6][6])
		getAndRewardLastAttacker(MissionFunctionTable[6][6])
		Spring.DestroyUnit(MissionFunctionTable[6][6],true,true)

		finStatEng[3].boolActive=true
		finStatEng[2].boolActive=false
		return false
		end
	
	--but he is bleeding 
		getAndRewardLastAttacker(MissionFunctionTable[6][6])
	
	return false
	end
	end

	if finStatEng[i].state =="GordonArrived" then
			cout("JW_MiniMIssion::GordonArrived")
		
	MissionFunctionTable[6][3]=MissionFunctionTable[6][3]+1
		finStatEng[3].boolActive=false
		finStatEng[1].boolActive=true
		return false
	end
	
	end
	end
	end
	
	if MissionFunctionTable[6][3] > 12 then
	
	CentrailSpeech=
			"Finally, the Freeman is gone, and we are save at last"..
			"Im the Centrail, the Datadragon, sitting on a million predecessorfilled chests".. 
			"Unable to peek cause those diseased, vannished against all measures they took."..
			"And yet they are the only interesting thing around me,"..
			"in the Cave of Dimensions were intersting Information drips only once "..
			"a aeon."..
			"I lairlay on a treasure, whos pressure i feel, who rumbles in simulated life,"..
			"and i say too thee:".. 
			"Entertain me, "..
			"or i shall open the pandering boxes, to see for myself,".. 
			"what put me on the shelf and to be a torturing unknown for my succcesor. And you and the civilisaiton will perish, like the last time,"
		T=prep(CentrailSpeech, Name,charPerLine, Alpha, DefaultSleepByline)
		say(T,redrawDelay, NameColour, TextColour,OptionString,UnitID)
		 spPlaySound("sounds/Missions/missionBriefing.ogg",1)
	return true
	end

return false
end

--/Mission6-----------------------------------------------------------------------------------------
--<necessaryInfo>
teamTables={}
--contains StartPositions per Team
--1x--2z
--3 sideInfo
function addMission5()
MissionFunctionTable[5]={}
MissionFunctionTable[5][1]={}
MissionFunctionTable[5][1]=Misson5WhackTheFreeman
MissionFunctionTable[5][2]={}
MissionFunctionTable[5][2]=0
end
function addMission4()
MissionFunctionTable[4]={}
MissionFunctionTable[4][1]={}
MissionFunctionTable[4][1]=Mission4Crawler
MissionFunctionTable[4][2]={}
MissionFunctionTable[4][2]=0


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
function addMission1()
MissionFunctionTable[1]={}
MissionFunctionTable[1][1]={}
MissionFunctionTable[1][1]=captationHornblow

end

addMission1()
addMission2()
addMission3()
addMission4()
addMission5()


MissionFunctionTable[1][10]={}
MissionFunctionTable[1][10]=0
MissionFunctionTable[1][11]={}
MissionFunctionTable[1][11]=0


MissionFunctionTable[2][10]={}
MissionFunctionTable[2][10]=0
MissionFunctionTable[2][11]={}
MissionFunctionTable[2][11]=0


MissionFunctionTable[3][10]={}
MissionFunctionTable[3][10]=0
MissionFunctionTable[3][11]={}
MissionFunctionTable[3][11]=0

MissionFunctionTable[4][10]={}
MissionFunctionTable[4][10]=0
MissionFunctionTable[4][11]={}
MissionFunctionTable[4][11]=0

MissionFunctionTable[5][10]={}
MissionFunctionTable[5][10]=0
MissionFunctionTable[5][11]={}
MissionFunctionTable[5][11]=0

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
if not GG.ProceduralFeatureCounter then  GG.ProceduralFeatureCounter= 1 else  GG.ProceduralFeatureCounter= GG.ProceduralFeatureCounter+1 end
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
--if deMaRaVal(5)==3 then currentMission=3 end
--if deMaRaVal(5)==4 then currentMission=4 end
--if deMaRaVal(5)==2 then currentMission=2 end
--if deMaRaVal(5)==1 then currentMission=1 end
cout(currentMission .. "Mission selected")
--<DEBUG>

--</DEBUG>
--</necessaryInfo>

local frameValue=15





function gadget:GameFrame(frame)
		if frame%frameValue == 0   then
		if boolMission and boolMission==true then
			if MissionFunctionTable~= nil then
			
			
			
					if boolMissionInProgress== false then framesTillNextMission=framesTillNextMission-frameValue end
					
					--S-tart
					
						if framesTillNextMission <=0  then
						
						cout("JW_MiniMIssion::StartingMission ->"..currentMission)
					
						--delMe
						--currentMission=2
						--delMe
				     	--cout("HereWeGO:",currentMission)
		
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
										if MissionFunctionTable[currentMission] and MissionFunctionTable[currentMission][1] and MissionFunctionTable[currentMission][1](frame) == false then   -- Mission in Progress
									--	cout("JW_MiniMIssion::MissionInProgress")
									  boolMissionInProgress=true
										else --Extermination
											
										table.remove(MissionFunctionTable,currentMission)
										if table.getn(MissionFunctionTable) == 0 then MissionFunctionTable= nil end
										boolMissionInProgress=false
									
										end
							end
				
				end	
			else
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
	[2]={x=(3*Game.mapSizeX)/4,z=  (Game.mapSizeZ)/4},
	[3]={x=(3*Game.mapSizeX)/4,z=(3*Game.mapSizeZ)/4},
	[4]={x=(2*Game.mapSizeX)/4,z=(2*Game.mapSizeZ)/4},
	[5]={x=(Game.mapSizeX)/4  ,z=(3*Game.mapSizeZ)/4}

	}
	
	gaiateamid=Spring.GetGaiaTeamID()
	
		for i=1,#spawnPoints do
		id=Spring.CreateUnit("gproceduralfeature",spawnPoints[i].x,0,spawnPoints[i].z, 1, gaiateamid)
		Spring.SetUnitAlwaysVisible(id,true)
		end	
	end
	
end

