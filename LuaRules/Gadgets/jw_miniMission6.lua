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
		if MissionFunctionTable[6][3] == -1 and mT > 9200 then
			--Drop Diamond
			
			MissionFunctionTable[6][3] =MissionFunctionTable[6][3] +1
			return false
		end
		
		if MissionFunctionTable[6][3] == 0 and mT > 14200 then
			Briefing=""
			T=prepSpeach(Briefing, Name,charPerLine, Alpha, DefaultSleepByline)
			say(T,25000, NameColour, TextColour,OptionString,UnitID)
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
					--	T=prepSpeach("JW_MiniMIssion::StateMachine_State ->"..i)
					
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
								T=prepSpeach(messages[dic].text, Name,charPerLine, Alpha, DefaultSleepByline)
								say(T,25000, NameColour, TextColour,OptionString,UnitID)
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
			"Gone are the barbarians- now true civilization can start."
			T=prepSpeach(CentrailSpeech, Name,charPerLine, Alpha, DefaultSleepByline)
			say(T,25000, NameColour, TextColour,OptionString,UnitID)
			spPlaySound("sounds/Missions/missionBriefing.ogg",1)
			return true
		end
		
		return false
	end
	