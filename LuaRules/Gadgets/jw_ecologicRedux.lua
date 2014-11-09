
  function gadget:GetInfo()
  	return {
			name = "Ecology gadget",
			desc = "Controlls the Gaia Wildlife",
			author = "Picadorro",
			date = "3rd of May 2010",
			license = "Free",
			layer = 0,
			version = 1,
			enabled = true
		}
	end

	-- modified the script: only corpses with the customParam "featuredecaytime" will disappear

	if (gadgetHandler:IsSyncedCode()) then
	
	-- INCLUDES
	VFS.Include("scripts/toolKit.lua")
	
	local roughDistance=approxDist
	--Global Variables
	local SIGHTDISTANCE=242
	local NSIGHTDISTANCE=-242
	local SOCIALRAD= 64
	local NURSERAD= 32
	local GRASSNUTRITION=42
	local gaiaTeam=Spring.GetGaiaTeamID()
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
					AgentState= "REST",
					
					Values	= {	["Water"]		=0, 
								["Food"]		=0,
								["Social"]		=0,

								["Energy"]		=0,
								["Security"]	=100,
								},	
					 Memory={}
						
			   }	

AT={}	
								

									AT["Water"]={ StateChangeFunc=FindWater, TargetState="DRINK" }
									AT["Food"]={ StateChangeFunc=FindFood, TargetState="FOOD" }
									AT["Social"]={ StateChangeFunc=FindCompany, TargetState="CLOSE" }
									AT["Energy"]={ StateChangeFunc=FindRest,TargetState="REST"}
									AT["Security"]={StateChangeFunc=MakeEscape, TargetState="ESCAPE" }
							  

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
	function 	Eat  (unitid, nr, other,x,y,z)
		if AgentTable[unitid].Type == "Hohymen" then
			if getMap(x,z)==GRASS then
			setMap(x,z,BARELAND)
			AgentTable[unitid].Values["Food"]=	math.min(AgentTable[unitid].Values["Food"]+ GRASSNUTRITION,100)
			return transferStatechangeToUnitScript(unitid,"Eat", other)
			end
		return false
		end
	end
		
	function 	 DrinkWater  (unitid, nr, other,x,y,z)
		if Spring.GetGroundHeight(x,z) <= 0 then
		AgentTable[unitid].Values["Water"]= 100
		return transferStatechangeToUnitScript(unitid,"DrinkWater")
		end
	end 	
	
	function 	 MoveCloser  (unitid, nr, other,x,y,z)
		AgentTable[unitid].Values["Water"]=math.max(0,AgentTable[unitid].Values["Water"]-0.5)
		AgentTable[unitid].Values["Food"]=math.max(0,AgentTable[unitid].Values["Food"]-0.5)
		AgentTable[unitid].Values["Social"]=math.min(AgentTable[unitid].Values["Social"]+1,100)
		AgentTable[unitid].Values["Mate"]=math.min(100,AgentTable[unitid].Values["Mate"]+1)
	return transferStatechangeToUnitScript(unitid,"MoveCloser",{[1]=other})
	end	
	
	
	function 	 Rest  (unitid, nr, other,x,y,z)
		AgentTable[unitid].Values["Water"]=math.max(0,AgentTable[unitid].Values["Water"]-0.5)
		AgentTable[unitid].Values["Food"]=math.max(0,AgentTable[unitid].Values["Food"]-0.5)
		AgentTable[unitid].Values["Energy"]= AgentTable[unitid].Values["Energy"]+1
		AgentTable[unitid].Values["Mate"]=math.min(100,AgentTable[unitid].Values["Mate"]+1)
	return transferStatechangeToUnitScript(unitid,"Rest",{[1]=other})	
	end
	
    function GetFood(unitid, nr, other,x,y,z)
	other=Spring.GetUnitNearestEnemy(unitID)
	return transferStatechangeToUnitScript(unitid,"FindFood",{[1]=other})	
	
	end
	
	
	--Deer is in the State of Running from a thread
	function 	 RunningForLive  (unitid, nr, other,x,y,z)
	-- Is it dead can we eat it?
	if not unitid or Spring.GetUnitIsDead(unitid) == true then killABeast(unitid) end 
	
	if not other or Spring.GetUnitIsDead(other) == true then return false end 
	ox,oy,oz=Spring.GetUnitPosition(other)
	dist=roughDistance(ox-x,oy-y,oz-z)
		if dist < SIGHTDISTANCESIGHTDISTANCE then
		AgentTable[unitid].Values["Energy"]= AgentTable[unitid].Values["Energy"]-2
		vx,vy,vz=x-ox,y-oy,z-oz
		vx,vy,vz=(vx/dist)*NSIGHTDISTANCE,(vy/dist)*NSIGHTDISTANCE,(vz/dist)*NSIGHTDISTANCE
		Spring.SetUnitMoveGoal(unitid,x+vx,y+vy,z+vz)
		return transferStatechangeToUnitScript(unitid,"RunningForLive",{[1]=other})	
		end
	return false
	end
	
	
	--Transitionfunction: represent the Transitions from one State into another (if a unit fails a transition it returns to the original state)
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
		
	--Helperfunction using broadsearch, which is sort of shitty, especially as landscapefeatures are linear distributed, so yeah, spearsearch would be better
	function FindValuePos(unitid,valueType)

	x,y,z=Spring.GetUnitPosition(unitid)
	
	if getMap(x,z)== valueType then return true, true end

	local lVec=Vec
	local lMap=getMap
		for i=1,#lMap, 1 do
				for j=1,#Vec,1 do
					if lMap(x+i*lVect[j].x,z+i*lVect[j].z) ==valueType then 
					--we found water but it is it visible to the animal 
					a=(i*lVect[j].x)*8
					b=(i*lVect[j].z)*8
					dist=roughDistance(a,0,b)
					if dist < SIGHTDISTANCE then
					return (x+i*lVect[j].x)*8,(z+i*lVect[j].z)*8 end
						else
						return false, false
						end
				end
		end
	return false,false
	end	
	
	function GetDistBetweenTwo(idA,idB)
    x,y,z=Spring.GetUnitPosition(idA)	
    bx,by,bz=Spring.GetUnitPosition(idB)	
	return roughDistance(x-bx,y-by,z-bz)	
	end
	
	function FindWater(unitid)
		if AgentTable[unitid].Type == "Hohymen" then
			tx,tz= FindValuePos(unitid,0)

				if tx and tx ~= true and tx ~= false then
				Spring.SetUnitMoveGoal(unitid,tx,tz)
				end
				
				if tx == true then --StateSwitch to drinking function
				return true
				end
			return false 		
		end	
		
	end 

	function FindFood(unitid, other)
		if AgentTable[unitid].Type == "Hohymen" then
				tx,tz= FindValuePos(unitid,1)

					if tx and tx ~= true and tx ~= false then
					Spring.SetUnitMoveGoal(unitid,tx,tz)
					end
					
					if tx == true then --StateSwitch to eating function
					return true
					end
					return false  	
		end	
	end 

	function FindCompany(unitid)
		if AgentTable[unitid].Type == "Hohymen" then
			id=Spring.GetUnitNearestAlly(unitid)
			x,y,z=Spring.GetUnitPosition(unitid)
				if id then 
				px,py,pz=Spring.GetUnitPosition(id)
				dist= roughDistance(px-x,0,pz-z)
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
		if AgentTable[unitid].Type == "Hohymen" then
			ed=Spring.GetUnitNearestEnemy(unitid)
			
			if not ed then return true end
			ex,ey,ez=Spring.GetUnitPosition(ed)
			x,y,z=Spring.GetUnitPosition(unitid)
				
			--all the conditions for sleeping
				if 	AgentTable[unitid].Values["Security"] > 75 and AgentTable[unitid].Values["Social"] > 50 and 
				Spring.GetGroundHeight(x,z) > 0 and AgentTable[unitid].Values["Food"] > 50 and 
				AgentTable[unitid].Values["Energy"] < 75 and AgentTable[unitid].Values["Mate"]==0 then
				return true
				end
			return false		
		end	
	end	



	function MakeEscape(unitid, other)
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
				norm= roughDistance(dx,dz)
				dx,dz= dx/norm*SIGHTDISTANCE*-1, dz/norm*SIGHTDISTANCE*-1
				Spring.SetUnitMoveGoal(unitid,x+dx,0,z+dz)
						
		end	
	end 

		
	function RemoveAnimal(unitid)
	AgentTable[unitid]= nil
	end
	
    local WATER=0
    local GRASS=1
    local BARELAND=2
	
	--Map encoding
	-- 0 Water --1 Grass --2  Grass Goone -- 3 Meat
	local spGetHeight=Spring.GetGroundHeight
	local Map={}
		for i=1,#Map,1 do
		Map[i]={}
			for j=1,#Map[1],1 do
			Map[i][j]={}
			k,l=((i-1)*8)+1,((j-1)*8)+1
			if spGetHeight(k,l) > WATER and math.random(0,1)==1 then Map[i][j] =GRASS else Map[i][j]= BARELAND end
			end
		end
		
	function getMap(x,z)
	return Map[math.floor(x/8)+1][math.floor(z/8)+1]	
	end

	function setMap(x,z,val)
	Map[math.floor(x/8)+1][math.floor(z/8)+1]=val	
	end
		
   
	local HOHYMDEF		=UnitDefNames["ghohymen"].id

	
    function gadget:UnitCreated(unitID, unitDefID, unitTeam)
		if unitDefID== HOHYMDEF  then
		Spring.Echo("JW_ECOLOGOYGADGET:UnitCreated")
		x,y,z=Spring.GetUnitPosition(unitID)
		spawnAgent(unitDefID, x,y,z,unitID)
		--TODO Find out where you stored the positions
		end
	end
			   
	--AgentTable =[Agentid]={Type, SozialState, AgentState,  Values }
	AgentTable={}
	--initialisises the eco-system
	function spawnAgent(typename, x,y,z, id)
	uid=0
	
	if typename== HOHYMDEF then 
	Spring.Echo("JW_ECOLOGOYGADGET::				Hohymen created")	
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
		

	
	function gadget:UnitDestroyed(unitid)
		if AgentTable[unitid] then
		x,y,z=Spring.GetUnitPosition(unitid)
		AgentTable[unitid].Memory["lastknownposition"]= {x=x,y=y,z=z}
		AgentTable[unitid].AgentState="DEAD"
		end
	end
	
	function evaluatePriorities(unitid)
	highestPriority="Security"
	ValSoFar=AgentTable[unitid].Values["Security"]
		for k,v in pairs(AgentTable[unitid].Values) do
			if v < ValSoFar  then
			highestPriority=k
			ValSoFar=v		
			end
		end
		Spring.Echo("JW_ECOLOGOYGADGET::HighestPriority"..highestPriority)
	return highestPriority
	end
	

	
	function stateMostWanted(unitid)
	Priority=evaluatePriorities(unitid)
	Spring.Echo("JW_ECOLOGOYGADGET:stateMostWanted:"..Priority)
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
	LongedState=LongedStateLongedTransitionTable[LongedState]
	Spring.Echo("JW_ECOLOGOYGADGET::Transition -> "..unitid.." -> is in State"..AgentTable[unitid].AgentState.."  longing for "..LongedState)
	--DODO --

		if AgentTable[unitid].Type=="Hohymen" then
		Spring.Echo(AgentTable[unitid].AgentState)
	
			--Spring.Echo("JW_ECOLOGOYGADGET:TypeOfTransition",type(Transition),type(Transition[LongedState]))
			if HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState] then
				for k,v in pairs(HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState]) do
					Spring.Echo("AgentTransitionTableMemberType"..type(v))
				end
			--assert(vallua=HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState].StateChangeFunc,"JW_ECOLOGOYGADGET "..LongedState)
			return 	HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState].StateChangeFunc(unitid),LongedState
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
	
	local boolInit=false
	
	function gadget:GameFrame(frame)
	
		if boolInit==true then
		
			if  frame %128	 == 0 then

				for k,v in pairs(AgentTable) do
				--evaluate Prioritys
				 LongedState=stateMostWanted(k)
				 Spring.Echo("JW_ECOLOGOYGADGET::Agent".. k .." longs for state ".. LongedState)
				 assert(LongedState,"JW_ECOLOGOYGADGET::LóngedState not found")
				-- if a Transition exists use it
					if LongedState then
						boolSucessfullTransiton, ResultState= Transition(k,LongedState)
						if boolSucessfullTransiton==true then
						x,y,z=Spring.GetUnitPosition(k)
							if AgentTable[k].Type=="Hohymen" then
								HohymenStates[LongedState].func(k, other,x,y,z)
							end
							
						end				
					DecrementAllValues(k)
					end
				end
			end		
		else
		init()
		boolInit=true		
		end
	end	

	end--GlobalEnd
