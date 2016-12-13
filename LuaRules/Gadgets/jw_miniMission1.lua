--Mission1-----------------------------------------------------------------------------------------
	
	gateTypeTable=getTypeTable(UnitDefNames,{"fclvlone","fclvl2","citadell","jdarkgate"})
	--Captain Hornblow #1
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
							spPlaySound("sounds/Missions/Mission1/Reward.wav",1)		
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
		
		
		--Spring.Echo("Mission Nr.1 @::"..MissionFunctionTable[1][3])
		--S-pring.Echo("MissionTime::",frame-MissionFunctionTable[1][2])
		
		if MissionFunctionTable[1][3]== -1 then
			
			spPlaySound("sounds/Missions/Mission1/CaptainHornblowIntro.wav",1)
			
			
			
			MissionFunctionTable[1][3]=MissionFunctionTable[1][3]+1
			return false
		end
		
		
		
		if MissionFunctionTable[1][3]== 0 and frame-MissionFunctionTable[1][2] > 1150 then
			
			spPlaySound("sounds/Missions/Mission1/mission1goingdown.ogg",1)		
			
			
			MissionFunctionTable[1][3]= MissionFunctionTable[1][3]+1
			
			return false	
		end
		
		
		if MissionFunctionTable[1][3]== 1 and frame-MissionFunctionTable[1][2] > 2650 then
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
		
		
		if MissionFunctionTable[1][3]== 2 and frame-MissionFunctionTable[1][2] > 4650 then
			--Spring.Echo("Entering Mission1 .. 2")
			spPlaySound("sounds/Missions/Mission1/miss1landed.ogg",1)		
			
			
			
			
			
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
			if Spring.GetUnitIsDead(MissionFunctionTable[1][13])==true and Spring.GetUnitIsDead(MissionFunctionTable[1][14])==true and Spring.GetUnitIsDead(MissionFunctionTable[1][15])==true then
				return true
			end
			--Mission ongoing
			--S-can for Containers who have reached a gate
			MissionFunctionTable[1][16]=checkIfContainerisNearAGate(MissionFunctionTable[1][13])
			MissionFunctionTable[1][17]=checkIfContainerisNearAGate(MissionFunctionTable[1][14])
			MissionFunctionTable[1][18]=checkIfContainerisNearAGate(MissionFunctionTable[1][15])	
			--	Spring.Echo("Mission1 .. 3 Container Checked")
			
			
			if MissionFunctionTable[1][17] == true and MissionFunctionTable[1][16] == true and MissionFunctionTable[1][18]== true then
				spPlaySound("sounds/Missions/Mission1/miss1finalls.ogg",1)		
				return true
			end
			
			
			
			
			return false
		end
		
		
		
		
		
		
		
		
		
		
		return false
	end
	
	
	--/Mission1-----------------------------------------------------------------------------------------