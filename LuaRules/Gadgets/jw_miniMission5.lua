--Description: In this Mission a Freeman is spawned, and every side trys to crowbar the fucker.
	--Mission5------ Whack the Freeman ---------------------------------------------------------------
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
		[2]={boolActive=false,state="RunGordon", startNum, endNum},
		[3]={boolActive=false,state="GordonArrived", }
	}
	
	messages={
		[1]={text="Visual on Anticitizen lost!",sound="sounds/Missions/Mission5/miss5GOne1.ogg"},
		[2]={text="We got Freeman! No, he is in the sewers!",sound="sounds/Missions/Mission5/miss5GOne2.ogg"},
		[3]={text="Request Advisor Input: Pursuit hostile into cave?",sound="sounds/Missions/Mission5/miss5GOne3.ogg"},
		[4]={text="A airduct, in the middle of nowhere? Seriously?",sound="sounds/Missions/Mission5/miss5GOne4.ogg"}	,
		[5]={text="Negative element cornered into abandoned mineshaft. Request further Instructions-",sound="sounds/Missions/Mission5/miss5GOne1.ogg"}	,
		[6]={text="Who is that guy in the suit, with the briefcase? No, its a crowbar and he is-",sound="sounds/Missions/Mission5/miss5GOne4.ogg"}	,
		[7]={text="Die speciestraitor. Black mesa scum sent us down this hole without bottom, i hope they paid well for hell.",sound="sounds/Missions/Mission5/miss5GOne3.ogg"}	,
	}	
	
	function Misson5WhackTheFreeman(frame)
		
		--S-etUp
		if MissionFunctionTable[5][2]== nil then MissionFunctionTable[5][2]=frame end
		if MissionFunctionTable[5][3]== nil then 
			MissionFunctionTable[5][3]= {}
			MissionFunctionTable[5][3]= -1
		end
		
		
		mT=frame-MissionFunctionTable[5][2]
		if MissionFunctionTable[5][3] == -1 and mT > 9200 then
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
					--	T=prepSpeach("JW_MiniMIssion::StateMachine_State ->"..i)
					
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
								T=prepSpeach(messages[dic].text, Name,charPerLine, Alpha, DefaultSleepByline)
								say(T,25000, NameColour, TextColour,OptionString,MissionFunctionTable[5][6])
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
			"And yet they and the freeman where the only interesting thing around me,"..
			"in the Cave of Dimensions were intersting Information drips only once "..
			"a aeon."..
			"I lairlay on a treasure, whos pressure i feel, who rumbles in simulated life,"..
			"and i say too thee:".. 
			"Entertain me, "..
			"or i shall open the pandering boxes, to see for myself,".. 
			"what put me on the shelf and to be a torturing unknown for my succcesor. And you and the civilisaiton will perish, like the last time,"
			T=prepSpeach(CentrailSpeech, Name,charPerLine, Alpha, DefaultSleepByline)
			say(T,25000, NameColour, TextColour,OptionString,UnitID)
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
				Spring.AddTeamResource(titds, "metall", 42 )
				Spring.AddTeamResource( titds, "energy", 42)
			end
		end
	end
	--/Mission5-----------------------------------------------------------------------------------------