	VFS.Include("scripts/lib_OS.lua" )
	VFS.Include("scripts/lib_UnitScript.lua" )
	VFS.Include("scripts/lib_Build.lua" 	)


	AgentTable={}
	local distance=approxDist
	--Global Variables
	 WATER=0
	 GRASS=1
	local BARELAND=2

	local SIGHTDISTANCE=242
	local NSIGHTDISTANCE=-242
	local SOCIALRAD= 64
	local NURSERAD= 32
	GRASSNUTRITION=42
	local gaiaTeam=Spring.GetGaiaTeamID()

	--State Functions
	function 	Eat (unitid, other,x,y,z)
		--Spring.Echo("Eating")
		if AgentTable[unitid].Type == "Hohymen" then
			
			if getMap(x,z).Food > 0 then
				setMapFood(x,z, 0)
				AgentTable[unitid].Values["Food"]=	math.min(AgentTable[unitid].Values["Food"]+ GRASSNUTRITION,100)
				return transferStatechangeToUnitScript(unitid,"Eat", other)
			end
			
		end
		return false
	end

	function 	 DrinkWater (unitid, other,x,y,z)
		--Spring.Echo("Drinking")
		if Spring.GetGroundHeight(x,z) <= 2 then
			AgentTable[unitid].Values["Water"]= 100
			return transferStatechangeToUnitScript(unitid,"DrinkWater")
		end
		return false
	end 	

	function 	 MoveCloser (unitid, other,x,y,z)
		--Spring.Echo("Agent is socializing")
		AgentTable[unitid].Values["Water"]=math.max(0,AgentTable[unitid].Values["Water"]-0.5)
		AgentTable[unitid].Values["Food"]=math.max(0,AgentTable[unitid].Values["Food"]-0.5)
		AgentTable[unitid].Values["Social"]=math.min(AgentTable[unitid].Values["Social"]+2 ,100)
		
		return transferStatechangeToUnitScript(unitid,"MoveCloser",{[1]=other})
	end	


	function 	 Rest (unitid, other,x,y,z)
		--Spring.Echo("Sleeping")
		AgentTable[unitid].Values["Water"]=math.max(0,AgentTable[unitid].Values["Water"]-0.5)
		AgentTable[unitid].Values["Food"]=math.max(0,AgentTable[unitid].Values["Food"]-0.5)
		AgentTable[unitid].Values["Energy"]= AgentTable[unitid].Values["Energy"]+1
		
		return transferStatechangeToUnitScript(unitid,"Rest",{[1]=other})	
	end



	--Deer is in the State of Running from a thread
	function 	 RunningForLive (unitid, other,x,y,z)
		--Spring.Echo("RunningForLive")
		-- Is it dead can we eat it?
		if not unitid or Spring.GetUnitIsDead(unitid) == true then killABeast(unitid) end 
		
		if not other or Spring.GetUnitIsDead(other) == true then return false end 
		ox,oy,oz=Spring.GetUnitPosition(other)
		dist=distance(ox-x,oy-y,oz-z)
		if dist < SIGHTDISTANCESIGHTDISTANCE then
			AgentTable[unitid].Values["Energy"]= AgentTable[unitid].Values["Energy"]-2
			vx,vy,vz=x-ox,y-oy,z-oz
			vx,vy,vz=(vx/dist)*NSIGHTDISTANCE,(vy/dist)*NSIGHTDISTANCE,(vz/dist)*NSIGHTDISTANCE
			Spring.SetUnitMoveGoal(unitid,x+vx,y+vy,z+vz)
			return transferStatechangeToUnitScript(unitid,"RunningForLive",{[1]=other})	
		end
		return false
	end


	Vec={
		[1]={x=1,z=1},
		[2]={x=0,z=1},
		[3]={x=-1,z=1},
		[4]={x=-1,z=0},
		[5]={x=1,z=0},
		[6]={x=-1,z=-1},
		[7]={x=0,z=-1},
		[8]={x=1,z=-1},
	}

	function locClamp(x)
		if x < 2 then return 2 end
		if x > 47 then return 47 end
		return x
	end

	ALLREADY_EXPLORED= true
	
	--Helperfunction using broadsearch, which is sort of shitty, especially as landscapefeatures are linear distributed, so yeah, spearsearch would be better
	function FindValuePos(unitid,valueType)
		
		ux,uy,uz=Spring.GetUnitPosition(unitid)
		if not ux then Spring.Echo("Coords not find for hohymen"); return false, false end
		
		local lgetMap=getMap	
		if not lgetMap then 
		Spring.Echo("No global RessourceMapTable found") 
		end
		
		--get the current LandScapeCell
		LandScapeCell=lgetMap(ux,uz)
		
		
		if valueType == GRASS and LandScapeCell.Food > 0 then
			--Spring.Echo("Foodplace Reached")
			return true, true 
		end
		
		if valueType == WATER and LandScapeCell.y < 0 then
			--Spring.Echo("Drink place Reached")
			return true, true 
		end
		
		
		tileSizeX, tileSizeZ=math.ceil((Game.mapSizeX)/48),math.ceil((Game.mapSizeZ)/48)	
		
		ux,uz= math.ceil(ux/tileSizeX),math.ceil(uz/tileSizeZ)
		
		
		nodeTable={}
		unexploredNodes=(tileSizeX*tileSizeZ )-1
		
		openTable={}
		openTable[1]={x=ux,z=uz}
		exploreTable= makeTable(false,tileSizeX,tileSizeZ)
		exploreTable[ux][uz]=ALLREADY_EXPLORED

		--roundhouse explore
		
		while unexploredNodes > 0 and table.getn(openTable) > 0 do
			--explore openTable 
			for o=table.getn(openTable), 1, -1 do	
			
			--add all not explored cells neighbouring to current cell
			index=math.ceil(math.random(1,table.getn(openTable)))
			local currentCell= openTable[index]
			if currentCell then
			
				for xi=currentCell.x -1,currentCell.x+1,1 do
					for zi=currentCell.z -1,currentCell.z+1,1 do
					if exploreTable[xi] and exploreTable[xi][zi] and exploreTable[xi][zi] ~= ALLREADY_EXPLORED then
					table.insert(openTable,{x=xi,z=zi})
					 exploreTable[xi][zi] = ALLREADY_EXPLORED 
					end
					end
				end
								
					LandScapeCell=lgetMap(currentCell.x,currentCell.z)
					if valueType == GRASS and LandScapeCell and LandScapeCell.Food > 0 then 
	
						return currentCell.x*tileSizeX, currentCell.z*tileSizeZ
					end
					
					if valueType == WATER and LandScapeCell and LandScapeCell.y <= 0 then 
						return currentCell.x*tileSizeX, currentCell.z*tileSizeZ
					end
					
					table.remove(openTable,o)
					unexploredNodes= unexploredNodes-1
				end
			
			end	
			end
			
			
		
		
		
		Spring.Echo("Searching Food/Water failed")	
		return false,false
	end	

	function GetDistBetweenTwo(idA,idB)
		x,y,z=Spring.GetUnitPosition(idA)	
		bx,by,bz=Spring.GetUnitPosition(idB)	
		return distance(x-bx,y-by,z-bz)	
	end

	function FindWater(unitid)
		--Spring.Echo("Thirsty")
		if AgentTable[unitid].Type == "Hohymen" then
			tx,tz= FindValuePos(unitid,0)
			
			if tx and tx ~= true and tx ~= false then
				Spring.SetUnitMoveGoal(unitid,tx,0, tz)
			end
			
			if tx == true then --StateSwitch to drinking function
				return true
			end
			Spring.Echo("Searching Food/Water failed")	
			return false 		
		end	
		
	end 
	--Transitionfunction: represent the Transitions from one State into another (if a unit fails a transition it returns to the original state)

	function FindFood(unitid, other)
		
		--Spring.Echo("Searching Food")
		
		
		tx,tz= FindValuePos(unitid,1)
		
		if type(tx) ~= "boolean" then
			if tx then
				--Spring.Echo("Setting Hohymen movegoal")
				Spring.SetUnitMoveGoal(unitid,tx,0,tz)
			end
		else					
			if tx == true then --StateSwitch to eating function
				return true
			end
		end
		return false 		
	end 

	function FindCompany(unitid)
		--Spring.Echo("Searching Social")
		if AgentTable[unitid].Type == "Hohymen" then
			id=Spring.GetUnitNearestAlly(unitid)
			x,y,z=Spring.GetUnitPosition(unitid)
			if id then 
				px,py,pz=Spring.GetUnitPosition(id)
				dist= distance(px-x,0,pz-z)
				if dist < SIGHTDISTANCE then
					Spring.SetUnitMoveGoal(unitid,px-(math.random(1,SOCIALRAD/2)),py,pz-(math.random(1,SOCIALRAD/2)))
					
					if dist < SOCIALRAD then
						return true				
					end 
				else --we search the Memory of the creature
					--TODO
					return false
				end
			else -- for ever alone
				return false
			end
			return false	
		end	
	end 

	function FindRest(unitid, other)
		--Spring.Echo("Search Rest")
		if AgentTable[unitid].Type == "Hohymen" then
			ed=Spring.GetUnitNearestEnemy(unitid)
			
			if not ed then return true end
			ex,ey,ez=Spring.GetUnitPosition(ed)
			x,y,z=Spring.GetUnitPosition(unitid)
			
			--all the conditions for sleeping
			if 	AgentTable[unitid].Values["Security"] > 75 and AgentTable[unitid].Values["Social"] > 50 and 
			Spring.GetGroundHeight(x,z) > 0 and AgentTable[unitid].Values["Food"] > 50 and 
			AgentTable[unitid].Values["Energy"] < 75 then
				return true
			end
			return false		
		end	
	end	



	function FindDangers(unitid, other)
		--Spring.Echo("On Watch")
		if AgentTable[unitid].Type == "Hohymen" then
			
			
			
			T=Spring.GetUnitNearestEnemy(unitid,SIGHTDISTANCE,true)
			if not T then
				SetUnitCobVal(unitid,COB.MAX_SPEED,157279)--2.4 *65533
				return true 
			end
			SetUnitCobVal(unitid,COB.MAX_SPEED,275238) --4.2 *65533
			x,y,z=Spring.GetUnitPosition(unitid)
			ex,ey,ez=Spring.GetUnitPosition(T)
			dx,dz=x-ex,z-ez
			norm= distance(dx,dz)
			dx,dz= dx/norm*SIGHTDISTANCE*-1, dz/norm*SIGHTDISTANCE*-1
			Spring.SetUnitMoveGoal(unitid,x+dx,0,z+dz)
			
		end	
	end 




	--End Global Variables

	local PriorityStateMap={
		["Water"]			="DRINK" ,
		["Social"]			="CLOSE",
		["Energy"]			="REST",
		["Security"]		="ESCAPE",
		["Food"]			="FOOD",							
	}

	function GetStateFromPriority(unitid, Priority)
		if Priority=="Food" and AgentTable[unitid].Type=="Hohymen" then return "FOOD" end
		
		return PriorityStateMap[Priority] 
	end

	RawHohymen={	Type	="Hohymen",
		AgentState= "FOOD",
		
		Values	= {	["Water"]		=0, 
			["Food"]		=0,
			["Social"]		=0,
			
			["Energy"]		=0,
			["Security"]	=100,
		},	
		Memory={}
		
	}	

	AT={}	


	AT["Water"]={ StateChangeFunc=	FindWater, 	TargetState="DRINK" }
	AT["Food"]={ StateChangeFunc=	FindFood, 		TargetState="FOOD" }
	AT["Social"]={ StateChangeFunc=	FindCompany, TargetState="CLOSE" }
	AT["Energy"]={ StateChangeFunc=	FindRest,		TargetState="REST"}
	AT["Security"]={StateChangeFunc=FindDangers, 	TargetState="ESCAPE" }


	HohymenStates={ 
		["FOOD"]={
			func=Eat, 
			AgentTransition=AT
		},
		["DRINK"]={
			func=DrinkWater, 
			AgentTransition=AT
		},
		["CLOSE"]={						
			func=MoveCloser, 
			AgentTransition=AT
		},	
		["REST"]={
			func=Resting, 
			AgentTransition=AT
		},
		["ESCAPE"]={
			func=RunningForLive, 
			AgentTransition=AT
		},				 
		["DEAD"]={
			func=RemoveAnimal, 
			AgentTransition=AT
		},					 
		
	}

	--Statefunctions --returns true once successfull execution alters the Values

	function RemoveAnimal(unitid)
		AgentTable[unitid]= nil
	end



	--Map encoding
	-- 0 Water --1 Grass --2 Grass Goone -- 3 Meat
	local spGetHeight=Spring.GetGroundHeight


	function clampR(x, resolution)
		return math.floor(math.min(math.max(1,x/resolution),resolution)	)
	end


	function getMap(x,z)
		local xRes = GG.LandScapeT.ResX
		local zRes = GG.LandScapeT.ResZ
		
		local itx= clampR(x, xRes)
		local itz= clampR(z, zRes)
		
		if not GG.LandScapeT[itx] or not GG.LandScapeT[itx][itz]	 then --Spring.Echo("NoLandscapetable at:"..x.." - ".. z) end
		return GG.LandScapeT[itx][itz]	
	end


	function setMapFood(x,z,val)
		
		local xRes = GG.LandScapeT.ResX
		local zRes = GG.LandScapeT.ResZ
		
		local itx= clampR(x, xRes)
		local itz= clampR(z, zRes)
		
		if not GG.LandScapeT[itx] or not GG.LandScapeT[itx][itz]	 then Spring.Echo("NoLandscapetable at:"..x.." - ".. z) end
		
		GG.LandScapeT[itx][itz].Food = val
		
	end



	--initialisises the eco-system
	function spawnAgent(typename, x,y,z, id)
		uid=0
		
		if typename== HOHYMDEF then 
			--Spring.Echo("JW_ECOLOGOYGADGET::				Hohymen created")	
			animalProto={}
			animalProto.Values	= {	
				["Water"]		=100, 
				["Food"]		=50,
				["Social"]		=60,								
				["Energy"]		=100,
				["Security"]	=100,
			}
			animalProto.AgentState= "REST"
			animalProto.Type="Hohymen"
			animalProto.Water=50
			animalProto.Food=50
			animalProto.Social=0
			animalProto.Security=100
			animalProto.Energy=100
			animalProto.Memory={}
			animalProto.unitid=id
			animalProto.Health=Spring.GetUnitHealth(id)
			AgentTable[id]= {}										
			AgentTable[id]=animalProto
		end	
		
		
	end

	function init()
		
	end

	--Sets the Unit to its new state
	function transferStatechangeToUnitScript(id,functionname,argumentTable)
		env = Spring.UnitScript.GetScriptEnv(id)
		if env then
			Spring.UnitScript.CallAsUnit(id,env.functionswitch,functionname )		
			return true
		end
		return false
	end

	function SetUnitCobVal(id, cobvalue, valueToSet)
		env = Spring.UnitScript.GetScriptEnv(id)
		if env then
			Spring.UnitScript.CallAsUnit(id,env.SetUnitValue,cobvalue, valueToSet )		
			return true
		end
	end



	function evaluatePriorities(unitid)
		highestPriority="Security"
		ValSoFar=AgentTable[unitid].Values["Security"]
		for k,v in pairs(AgentTable[unitid].Values) do
			if v < ValSoFar then
				highestPriority=k
				ValSoFar=v		
			end
		end
		--Spring.Echo("JW_ECOLOGOYGADGET::HighestPriority"..highestPriority)
		return highestPriority
	end



	function stateMostWanted(unitid)
		Priority=evaluatePriorities(unitid)
		--Spring.Echo("JW_ECOLOGOYGADGET:stateMostWanted:"..Priority)
		if Priority then -- a prioritized urge has emerged
			return GetStateFromPriority(unitid,Priority)
		end
	end
	LongedStateLongedTransitionTable=
	{
		["FOOD"]="Food",
		["DRINK"]="Water",
		["CLOSE"]="Social",
		["REST"]="Energy",
		["ESCAPE"]="Security"
	}

	function Transition(unitid,LongedState)
		--Spring.Echo("Transition1")
		isDead=Spring.GetUnitIsDead(unitid)
		if isDead == true then return false, "DEAD" end
		
		
		LongedState=LongedStateLongedTransitionTable[LongedState]
		--Spring.Echo("JW_ECOLOGOYGADGET::Transition -> "..unitid.." -> is in State"..AgentTable[unitid].AgentState.." longing for "..LongedState)
		--DODO --
		
		if AgentTable[unitid].Type=="Hohymen" then
			--Spring.Echo("Ghohymen:Agentstate:"..AgentTable[unitid].AgentState)
			
			----Spring.Echo("JW_ECOLOGOYGADGET:TypeOfTransition",type(Transition),type(Transition[LongedState]))
			if HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState] then
				--Spring.Echo("AgentTransitionTableType"..type(HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState]))
				
				isDead=Spring.GetUnitIsDead(unitid)
				if isDead == true then return false, "DEAD" end
				
				boolTransfer= HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState].StateChangeFunc(unitid)
				
				--assert(vallua=HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState].StateChangeFunc,"JW_ECOLOGOYGADGET "..LongedState)
				return 	boolTransfer ,LongedState
			end 
		end
	end

	function DecrementAllValues(unitid)
		
		for k,v in pairs(AgentTable[unitid].Values) do	
			if k == "Food" or k== "Water" or k=="Social" then
				AgentTable[unitid].Values[k]=math.max(0,v-1)			
			end
		end
		
		echoTable(AgentTable[unitid].Values)
	end

	VaryFooAvatara={}

	Timer=2500

	function handleHymens(frame,HohymenCounter)
		if frame %128	 == 0 then
			Timer=Timer-128
			if Timer < 0 and HohymenCounter < 10 then 
				Timer=2500
				x,z=getADryWalkAbleSpot()
				if x and z then
					id=Spring.CreateUnit("ghohymen",x,0,z,1,gaiaTeam)
					ix,iy,iz = math.random(10,20), math.random(10,20), math.random(10,20)
					Spring.AddUnitImpulse(id,ix,iy,iz)
					Spring.SetUnitAlwaysVisible(id,true)
				end
				
			end
			for k,v in pairs(AgentTable) do
				--evaluate Prioritys
				LongedState=stateMostWanted(k)
				--Spring.Echo("JW_ECOLOGOYGADGET::Agent".. k .." longs for state ".. LongedState)
				assert(LongedState,"JW_ECOLOGOYGADGET::LóngedState not found")
				-- if a Transition exists use it
				if LongedState then
					--Spring.Echo("Transition")
					boolSucessfullTransiton, ResultState= Transition(k,LongedState)
					if boolSucessfullTransiton==true then
						x,y,z=Spring.GetUnitPosition(k)
						if AgentTable[k].Type=="Hohymen" and z then
							other="none"
							
							HohymenStates[LongedState].func(k, other,x,y,z)
						end
						
					end				
					DecrementAllValues(k)
				end
			end
		end	
		
	end