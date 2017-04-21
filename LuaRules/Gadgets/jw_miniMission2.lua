davinciSpeach1="I dont like this anymore then you do, Administrator, we all miss out on the joys of our lifetime as we speak. Im komA IcnivaD, the Centrail appointed Leviathan Cybernetic for this backwater dimension. So lets get this over with-<Papersound> I have a right to acquire any means of transport andor ressources necessary for my mission. However, you are not responsible for my personal safety. Should this biorganic one-way break down - the diplomatic corpse will build or aquire a new one in the city, and we will start the whole endavour over. So no panic, beeing a abstract has its benefits."
	davinciSpeach2="Lets clarify the rules of engagment, shall we, while we are still on our own, Administrator. First: No reaction, to violence. Your Weapons are decoration. Ruin my work, and i see you in eternal pain on a public place incity. Do we understand each other? Second: No snickering, or abuse. They may be statistically blind animals, deluding themselves that the holy brainstem wrote down,just what they felt was the right minima of societys rules. No matter what, even if they regard cannibalist weddings a holy duty - while condemning murder, we wont stop barbaric customs.Why? Because of the Ant-Paradoxon.Ants travell using floating leaves. Would the Agentants know about dangerdistribution and lifeboats,they would all huddle inwards - towards the queen. And Blubb! The Centrailconfederacy trusts you not to Blubb - evenot knowing what is at stake. "
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
			MissionFunctionTable[2]["TeamCentId"]=TeamCentId
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
			--	T=prepSpeach("GAIA_SAVEMYVILLAGE")
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
				if boolHeightCheck== true and t ~= nil and #t == 0 then
					idTable[1]={}
					idTable[1]=spCreateUnit("jnativevil",x,0,z, 0,_gaiaTeam ) 										
					spSetUnitNeutral(idTable[1],true)
					spSetAlwaysVisible(idTable[1],true)
					teamList={}
					teamList=Spring.GetTeamList()
					for i=1,#teamList,1 do
						GG.UnitsToSpawn:PushCreateUnit("spectrator",x+i*3,0,z-i*3, 0,teamList[i] )
					end
					
					for _=1,5, 1 do
						
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
						
						
						if boolFlipFlop==false then
							boolFlipFlop=true
							tet=spCreateUnit("jtree1",math.floor(x+xrand),0,math.floor(z+zrand), 0,_gaiaTeam ) 
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
					--	T=prepSpeach("Test23")
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
			cout("Mission @::",MissionFunctionTable[2][3])
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
				T=prepSpeach(davinciSpeach1, Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				spPlaySound("sounds/Missions/Mission2/Miss2_1.ogg",1)
				
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]= MissionFunctionTable[2][3]+1
				
				return false	
			end
	else cout("Mission failed1") return true end	
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 1 and frame-MissionFunctionTable[2][2] > 1300 then
				T=prepSpeach(davinciSpeach2, Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,UnitID)
				spPlaySound("sounds/Missions/Mission2/Miss2_2.ogg",1)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]= MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed1") return true end	
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 2 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true then
				T=prepSpeach("Unusual, in nearly all contact gametheory, the not-Knowing party intercepts the intruders long before the weakspot. Mr.Chieftain, i presume- and thats a Arrowr. ", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				spPlaySound("sounds/Missions/Mission2/Miss2_3.ogg",1)
				
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false
			end
	else cout("Mission failed1") return true end	
		
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 3 and frame-MissionFunctionTable[2][2] > 50 then
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
			if MissionFunctionTable[2][3]== 4 and frame-MissionFunctionTable[2][2] > 800 then
				T=prepSpeach("Administrator, im back. Met some of your men, at the memoryclinic, those who made it out of there bodys intime-"..
				"I sold the exp to some PervHurts, took a sabbatical year off, visited some partys, learned the natives language, got divorced, whored it up and wrote a book about you as a historic person."..
				"Got a new body forged, femalien, this time, now look at this wingcolours -oh, right you cant see it. "..
				"The implants in your head will overlay it with your own species- less xenophobia that way. We all get along.", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				spPlaySound("sounds/Missions/Mission2/Miss2_4.ogg",1)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed3") return true end		
		
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 4 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true then
				T=prepSpeach("Might as well let you in on ancient news.The Natives are not looplocked, means they do not engage in the usual circle"..
				"of overpopulation and tribal warfare plus territorial behaviour. "..
				"There unique physique spared them, they have genetic memorys and eggs,	thousands of them, burried everywhere on there territory, ready to hatch on a pheromonic whim. "..
				"Hello beautiful,im a little present from the tribe with the metall-tent!", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				spPlaySound("sounds/Missions/Mission2/Miss2_5.ogg",1)
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed4") return true end	
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 5 and frame-MissionFunctionTable[2][2] > 1000 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true then
				T=prepSpeach("Relations soured a little, im getting raped to death by the whole tribe, for speaking up to the chieftain."..
				"Turns out, the female of the species, have devolved to little more then reproductive diplomacy automatons- and they dont share power to foreigners. I spare you the details .."..
				"harder,faster,makes us wronger,more then ever, power under, our work is never over <Exitus>", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
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
			if MissionFunctionTable[2][3]== 6 and frame-MissionFunctionTable[2][2] > 1000 then
				Spring.SetUnitNoSelect(MissionFunctionTable[2][10],false)
				Spring.SetUnitNoDraw(MissionFunctionTable[2][10],false)
				T=prepSpeach(" Hi, im Koma Icnivad the third, my filthy rich grandfather retired - moneywise mission "
				.."time is eight times city-dime. ".."I m here to pick up the mission were destiny dropped him. Would you kindly, get me too the freakshow, Administrator?", 
				Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				spPlaySound("sounds/Missions/Mission2/Miss2_7.ogg",1)
				
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed6") return true end	
		
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 7 and frame-MissionFunctionTable[2][2] > 2500 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],250)==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_8.ogg",1)
				T=prepSpeach("Oh, Citynews: All hail the new Centrail, the old datadragon got bored by slowlifeinfo drippin and peeked into his predecessors data-vaults."..
				"New one is rumored to originate from a sandwichmaker, that had a memory leak which	bitflipped to sentience."..
				"Suprising little chaos, confusion and only 30 mk death when some cityparts crashed, and less suprising- no changes in the mission.	"..
				"(Arriving) .", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,Mission,FunctionTable[2][10])
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed7") return true end	
		
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 8 and frame-MissionFunctionTable[2][2] > 2000 and isAmbassadorNearTribe(MissionFunctionTable[2][10],MissionFunctionTable[2][11][1],450)==true then
				Spring.SetUnitNoSelect(MissionFunctionTable[2][10],true)
				Spring.SetUnitNoDraw(MissionFunctionTable[2][10],true)
				
				spPlaySound("sounds/Missions/Mission2/potLash.ogg",0.9)	
				spPlaySound("sounds/Missions/Mission2/Miss2_9.ogg",1)
				T=prepSpeach("Administrator, it seems they wanna hold a feast to honor our repeated visit. "..
				"Customs demands that the chief outshines everyone in destroying his wealthy and valued posessions."..
				"Quick! Grab 30 infantryman, march them in front of the village, "..
				"and blow there suicide implants. Lets see you top that, great Spender!", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000 , NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				MissionFunctionTable[2][2]=frame
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+2
				return false 
			end
	else cout("Mission failed8") return true end	
		
		
		
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 10 and thirthyInfantryCorpses(MissionFunctionTable[2][10],frame-MissionFunctionTable[2][2])==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_10.ogg",1)
				T=prepSpeach("Party Up in here! More rotten Dokami for me! Shame you got duty Administrator, they know how to squeeze Live for the juice! "..
				"Oh, we are the silent judgy one, are we!"..
				"I know my prehistory Administrator, your artillery drove over a dike of bodys on Tabula 4 - noone needs to apologize!"..
				"Cultural Superiority? Dont make me laugh, these guys have the memory of a whole civilisation for 300.000 years. "..
				"They look down on us."..
				"They were three times space travelling, and turned back, because they found it boring."..
				"This escalates rather quickly - 1 Momothcat all over the floor by the tain, certainly i can top that!"..
				"Servant, bring me 2 construction trucks, self destroy them in front of the village.", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				
				
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed10") return true end	
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 11 and twoContrucks(MissionFunctionTable[2][10],frame-MissionFunctionTable[2][2])==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_11.ogg",1)
				T=prepSpeach("Little sacrivices, we all make them Administrator, for greater Gains."..
				"Gold, Gems smash it up, it is? Mine, is longer then yours again. "..
				"Administrator, build one luxery appartment in front of the city."..
				"Blow it up."..
				"Do it.", Name,charPerLine, Alpha, DefaultSleepByline)
				
				say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				--Who lives in a citadell under the Big C, Admin Rulebook
				
				
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed11") return true end	
		
		if boolStillAlive==true then
			if MissionFunctionTable[2][3]== 12 and oneLuxBuildBlow(MissionFunctionTable[2][10],frame-MissionFunctionTable[2][2])==true then
				spPlaySound("sounds/Missions/Mission2/Miss2_12.ogg",1)
				T=prepSpeach("- raise a toast to Chieftain OoohmyHeard, who special circumstances took from us before his time."..
				"Time to beginn cultural relations in my newly aquired harem."..
				"The Reward should be spilling into your security Account this very moment.", Name,charPerLine, Alpha, DefaultSleepByline)
				
				say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				
				teamID=spGetUnitTeam(MissionFunctionTable[2][10])
				x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
				GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
				GG.UnitsToSpawn:PushCreateUnit("cRewarder",x,y,z,1,teamID)
				
				MissionFunctionTable[2][3]=MissionFunctionTable[2][3]+1
				return false 
			end
	else cout("Mission failed12") return true end	
		
		
		
		if MissionFunctionTable[2][3]== 13 then
			
			spPlaySound("sounds/Missions/Mission2/genocide.ogg",0.9)
			
			spPlaySound("sounds/Missions/Mission2/CitizenCunt.ogg",1)
			T=prepSpeach("Centrail: You know Administrator, normally a fullcitizen screwup like you, would ends in one of those little orange capsules at the "..
			"foundations of my citadells."..
			"But this guy is good, excellent to be honest, even i had him not figured out - after a spree of 19 worlds and three civil interdimensional unrests and 9 Overpopulation incidents."..
			"	All the efficient, corrupt - but mostly loyal servant, disguised as family buisness."..
			"Quite unimaginable for the public, that a bigger mind should decide to run amok, distributing weaponable ideas to soon relocated Natives."..
			"Intercontinetal rockets made from fertilizerfirewors, bioweapons from medicine- this guy knew how to chop a chunk from the propabilitytree."..
			"So here we are, cleaning it up the old fashioned way, bodybags, screaming critizens, offworld labourcamps."..
			"Take this assasin and end this infection of one-Red-Dot-Pox. You have 10 Minutes."..
			"Lay the village low, gamasoak the terrain - and do something against the smell.", Name,charPerLine, Alpha, DefaultSleepByline)
			
			say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
			x,y,z=Spring.GetUnitPosition(MissionFunctionTable[2][11][1])
			if x and 	MissionFunctionTable[2]["TeamCentId"] then 
				teamid= Spring.GetUnitTeam()
				Spring.CreateUnit("gworldengine",x,y,z,2,	MissionFunctionTable[2]["TeamCentId"])
			end
			
			
			enemy=Spring.GetUnitNearestEnemy(MissionFunctionTable[2][10])
			teamID=spGetUnitTeam(enemy)
			x,y,z=spGetUnitPos(MissionFunctionTable[2][10])
			
			if teamID then
				Spring.TransferUnit(MissionFunctionTable[2][10],teamID)
				for _=1,table.getn(MissionFunctionTable[2][11]),1 do								
					Spring.TransferUnit(MissionFunctionTable[2][11],teamID)
				end
				x,y,z=spGetUnitPos
				
				for _=1,4, 1 do
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
				T=prepSpeach("-there was a festival in my homesector, the Brightday. They would pick all new inventions, and burn them with there Creators, at the foot of the citadell."
				.."Nobody stepped in to stop them, and nobody steped up to stop me when i pined them all on there own spear made from cowardice and stupidity."
				.."They stormed the citadell, and threw the Administrator from the highest window they could find. His scream is said to have lasted all the way down."
				.."If you dont dare to stand for the best of men, they wont stop the beast of men."
				.."I may be silenced soon, but my spirit lives on,as doubt in servants, "
				.."as paranoia against your Advisors, always a sharp stylus near your back and one day- "
				.."you will want to know, you will rip out your own roots - and on that day, you will scream"
				.."- and you shall fall.", Name,charPerLine, Alpha, DefaultSleepByline)
				
				say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
				
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
				T=prepSpeach( "-Confederated Press: Administrator a Statement regarding the Allegations? "..
				"-Reporting on a Warcrime in Progress- of a Administrator who joined the Universal Union. Unspeakable Attrocities.."..
				"-sentenced to 25 years of citytime, to be spend in Slowtime, as a perpetual Reminder-"..
				"-is it a still ongoing debate among historians, that the battle of Icnivad-Village, was not started by Natives, named Koma-"..
				"-there was a war over here too? Do you sell souvenirs?"..
				"-volcanic Ruins, with mumified tourists burried beneath from the last eruption-", Name,charPerLine, Alpha, DefaultSleepByline)
				say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[2][10])
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
	