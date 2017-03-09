VFS.Include("scripts/lib_OS.lua")
VFS.Include("scripts/lib_UnitScript.lua")
VFS.Include("scripts/lib_Build.lua")


AgentTable={}
local distance=approxDist
--Constants
---------------------------------------------------------------------------------------------------
--Global Variables
WATER=0
GRASS=1
local BARELAND=2

local SIGHTDISTANCE=242
local NSIGHTDISTANCE=-242
local SOCIALRAD= 164
local NURSERAD= 32
local GRASSNUTRITION=42
local GEOVENTDISTANCE=350
---------------------------------------------------------------------------------------------------
local gaiaTeam=Spring.GetGaiaTeamID()
function printColumn(name,value)
	if type(value) =="number" and name ~="unitid" then
		startstr=name..":["
		for i=1,10 do
			if value/10 > i then startstr= startstr.."=" else startstr= startstr.." " end
		end
		startstr=startstr.."] =>"..value
		echo(startstr)
	end
end
function printAgent(name, AgentTable)
	echo("=====================================================")
	echo("Agent:"..name)
	for k,v in pairs(AgentTable) do 
		printColumn(k,v)
	end	
	echo("=====================================================")
	
end

function nearGeothermalVent(x,y,z)
	boolFoundOne=false
	for i=1,#GeoventList do
	local id= GeoventList[i]
		if id then
			fx,fy,fz=Spring.GetFeaturePosition(id.id)
			if distance(fx-x,fy-y,fz-z) < GEOVENTDISTANCE then
				boolFoundOne=true
			end
		end
	end
	return boolFoundOne
end
---------------------------------------------------------------------------------------------------
--State Functions
function Eat (unitid, other,x,y,z)
	if AgentTable[unitid].Type == "ghohymen" then
		
		if getMap(x,z).Food > 0 then
			setMapFood(x,z, 0)
			AgentTable[unitid]["Food"]=	math.min(AgentTable[unitid]["Food"]+ GRASSNUTRITION,100)
			return transferStatechangeToUnitScript(unitid,"Eat", other)
		end
	end
return false
end

function DrinkWater (unitid, other,x,y,z)
	if Spring.GetGroundHeight(x,z) <= 2 or nearGeothermalVent(x,y,z) == true then
		AgentTable[unitid]["Water"]= AgentTable[unitid]["Water"]+4
		return transferStatechangeToUnitScript(unitid,"DrinkWater")
	end
return false
end 	

function MoveCloser (unitid, other,x,y,z)
	AgentTable[unitid]["Social"]=math.min(AgentTable[unitid]["Social"]+20 ,100)
return transferStatechangeToUnitScript(unitid,"MoveCloser",{[1]=other})
end	

function Rest (unitid, other,x,y,z)
	AgentTable[unitid]["Energy"]= AgentTable[unitid]["Energy"]+1
return transferStatechangeToUnitScript(unitid,"Rest",{[1]=other})	
end

--Deer is in the State of Running from a threat
function 	 RunningForLive (unitid, other,x,y,z)
	-- Is it dead can we eat it?
	if not unitid or Spring.GetUnitIsDead(unitid) == true then killABeast(unitid) end 
	
	if other and type(other)=="number" and Spring.ValidUnitID(other) == true 	and Spring.GetUnitIsDead(other) == false then
		ox,oy,oz=Spring.GetUnitPosition(other)
		dist=distance(ox-x,oy-y,oz-z)
		if dist < SIGHTDISTANCESIGHTDISTANCE then
			AgentTable[unitid]["Energy"]= AgentTable[unitid]["Energy"]-2
			vx,vy,vz=x-ox,y-oy,z-oz
			vx,vy,vz=(vx/dist)*NSIGHTDISTANCE,(vy/dist)*NSIGHTDISTANCE,(vz/dist)*NSIGHTDISTANCE
			Spring.SetUnitMoveGoal(unitid,x+vx,y+vy,z+vz)
			return transferStatechangeToUnitScript(unitid,"RunningForLive",{[1]=other})	
		end
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
GeoventList={}
boolGeoventListInitialized=false



function getNearestGeoVent(gx,gy,gz)
	if boolGeoventListInitialized ==false then
	GeoventList= getGeoventList()
	boolGeoventListInitialized=true
	end
	if #GeoventList <= 0 then return nil end
	
	lastID=1
	distanceMin=math.huge

	for i=1,#GeoventList do

			--echo("Distance to "..GeoventList[i].id.." :"..distance(GeoventList[i].x-gx,GeoventList[i].y-gy,GeoventList[i].z-gz) )
			if distance(GeoventList[i].x-gx,GeoventList[i].y-gy,GeoventList[i].z-gz) < distanceMin then
				distanceMin=distance(GeoventList[i].x-gx,GeoventList[i].y-gy,GeoventList[i].z-gz)
				lastID=GeoventList[i].id
			end
	end
	return lastID
end
--Helperfunction using broadsearch, which is sort of shitty, especially as landscapefeatures are linear distributed, so yeah, spearsearch would be better
function FindValuePos(unitid,valueType)
	
	ux,uy,uz=Spring.GetUnitPosition(unitid)
	if not ux then Spring.Echo("Coords not found for hohymen"); return false, false end
	
	local lgetMap=getMap	
	if not lgetMap then 
		--Spring.Echo("No global RessourceMapTable found") 
		return 0,0,true
	end
	
	--get the current LandScapeCell
	LandScapeCell=lgetMap(ux,uz)
	
	
	if valueType == GRASS and LandScapeCell.Food > 0 then
		----Spring.Echo("Foodplace Reached")
		--echo("Node found food nearby ".. LandScapeCell.Food)
		return ux,uz , true , true
	end
	
	if valueType == WATER then
		
		if LandScapeCell.y < 0 then
			----Spring.Echo("Drink place Reached")
			--echo("Node found water nearby")
			return ux,uz , true , true
		end
		
		groundMin,groundMax=Spring.GetGroundExtremes()

		if groundMin > 0 then --time to go geovent searching
			id=getNearestGeoVent(ux,uy,uz)
			--echo("Nearest Geovent"..id .." to "..unitid)
			if id then 
				fx,fy,fz =Spring.GetFeaturePosition(id)
				if fx then
					if distance(fx-ux,0,fz-uz) < 75 then
						--echo("Node found water nearby/"..fx.."/"..fy.."/"..fz)
						return fx,fz,true,true
					else
						--echo("On Way to water")
						return fx,fz,false,true
					end
				end
			end
		end
	end
	
	tileSizeX, tileSizeZ=math.ceil((Game.mapSizeX)/48),math.ceil((Game.mapSizeZ)/48)	
	ux,uz= math.ceil(ux/tileSizeX),math.ceil(uz/tileSizeZ)	
	
	nodeTable={}
	unexploredNodes=(tileSizeX*tileSizeZ )-1
	
	openTable={}
	openTableCounter=1
	openTable[1]={x=ux,z=uz}
	exploreTable= makeTable(false,tileSizeX,tileSizeZ)
	exploreTable[ux][uz]=ALLREADY_EXPLORED	
	--roundhouse explore
	
	while unexploredNodes > 0 and openTableCounter > 0 do
		--explore openTable 
		for o=openTableCounter, 1, -1 do	
			
			--add all not explored cells neighbouring to current cell
			index=math.ceil(math.random(1,openTableCounter))
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
					--echo("Node found food remote:"..LandScapeCell.Food)
					return currentCell.x*tileSizeX, currentCell.z*tileSizeZ, false, true
				end
				
				if valueType == WATER and LandScapeCell and LandScapeCell.y <= 0 then 
					--echo("Node found water remote:")
					return currentCell.x*tileSizeX, currentCell.z*tileSizeZ, false, true
				end
				
				table.remove(openTable,o)
				openTableCounter=openTableCounter-1
				unexploredNodes= unexploredNodes-1
			end		
		end	
	end

	return ux,uz, false, false
end	

function GetDistBetweenTwo(idA,idB)
	x,y,z=Spring.GetUnitPosition(idA)	
	bx,by,bz=Spring.GetUnitPosition(idB)	
	return distance(x-bx,y-by,z-bz)	
end

function FindWater(unitid)
	----Spring.Echo("Thirsty")
	if AgentTable[unitid].Type == "ghohymen" then
		tx,tz, boolAllreadyThere, boolFoundSomething = FindValuePos(unitid,WATER)
		gh=Spring.GetGroundHeight(tx,tz)

		if boolFoundSomething== true then
			if boolAllreadyThere == false then
				Command(unitid, "stop", {})
				Command(unitid, "go", {x=tx,y=gh,z=tz})
				return false
			else
				Command(unitid, "stop", {})
				Command(unitid, "go", {x=tx,y=gh,z=tz})
				return true
			end
		end
		
		--Spring.Echo("Searching Food/Water failed")	
		return false 		
	end	
end 
--Transitionfunction: represent the Transitions from one State into another (if a unit fails a transition it returns to the original state)

function FindFood(unitid, other)
	tx,tz, boolAllreadyThere, boolFoundSomething = FindValuePos(unitid,GRASS)
	gh=Spring.GetGroundHeight(tx,tz)
	if boolFoundSomething == true then
		if boolAllreadyThere == false then
			Command(unitid, "stop", {})
			Command(unitid, "go", {x=tx,y=gh,z=tz})
			gh=Spring.GetGroundHeight(tx,tz)+25		
			return false
		else 
			Command(unitid, "stop", {})
			Command(unitid, "go", {x=tx,y=gh,z=tz})
			return true
		end
	end
	return false 		
end 

function FindCompany(unitid)
	----Spring.Echo("Searching Social")
	if AgentTable[unitid].Type == "ghohymen" then
		id=Spring.GetUnitNearestAlly(unitid)
		x,y,z=Spring.GetUnitPosition(unitid)
		if id then 
			px,py,pz=Spring.GetUnitPosition(id)
			dist= distance(px-x,0,pz-z)
			if dist > SIGHTDISTANCE then	
				Command(unitid, "stop", {})			
				Command(unitid, "go", {x=px-(math.random(1,SOCIALRAD/2)),y=py,z=pz-(math.random(1,SOCIALRAD/2))})
				return false
			else
					Command(unitid, "stop", {})
				Command(unitid, "go", {x=px-(math.random(1,SOCIALRAD/2)),y=py,z=pz-(math.random(1,SOCIALRAD/2))})
				return true
			end
		end
	end	
	return false	
end 

function FindRest(unitid, other)
	----Spring.Echo("Search Rest")
	if AgentTable[unitid].Type == "ghohymen" then
		ed=Spring.GetUnitNearestEnemy(unitid)
		
		if not ed then return true end
		ex,ey,ez=Spring.GetUnitPosition(ed)
		x,y,z=Spring.GetUnitPosition(unitid)
		
		--all the conditions for sleeping
		if 	AgentTable[unitid]["Security"] > 75 and AgentTable[unitid]["Social"] > 50 and 
		Spring.GetGroundHeight(x,z) > 0 and AgentTable[unitid]["Food"] > 50 and 
		AgentTable[unitid]["Energy"] < 50 then
			return true
		end
		return false		
	end	
end	

function FindDangers(unitid, other)
	----Spring.Echo("On Watch")
	if AgentTable[unitid].Type == "ghohymen" then			
		
		T=Spring.GetUnitNearestEnemy(unitid,SIGHTDISTANCE,true)
		if not T then
			SetUnitCobVal(unitid,COB.MAX_SPEED,157279)--2.4 *65533
			return true 
		end
		SetUnitCobVal(unitid,COB.MAX_SPEED,275238) --4.2 *65533
		x,y,z=Spring.GetUnitPosition(unitid)
		ex,ey,ez=Spring.GetUnitPosition(T)
		dx,dz=ex-x,ez-z
		norm= math.sqrt(dx*dx+ dz*dz)
		dx,dz= dx/norm*SIGHTDISTANCE*-1, dz/norm*SIGHTDISTANCE*-1

		Command(unitid, "stop", {})	
		Command(unitid, "go", {x=x+dx,y=0,z=z+dz})	
	end	
end 
--End Global Variables

local PriorityStateMap={
	["Security"]		="ESCAPE",
	["Water"]			="DRINK" ,
	["Social"]			="CLOSE",
	["Energy"]			="REST",
	["Food"]			="FOOD",							
}

function GetStateFromPriority(unitid, Priority)
	if Priority=="Food" and AgentTable[unitid].Type=="ghohymen" then return "FOOD" end
	
	return PriorityStateMap[Priority] 
end

RawHohymen={	Type	="ghohymen",
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
	
	if not GG.LandScapeT[itx] or not GG.LandScapeT[itx][itz]	 then Spring.Echo("NoLandscapetable at:"..x.." - ".. z) end
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
		--Spring.Echo("JW_ECOLOGOYGADGET::				ghohymen created")	
		local animalProto={}
		
		animalProto.AgentState= "REST"
		animalProto.Type="ghohymen"
		animalProto.Water=50
		animalProto.Food=50
		animalProto.Social=0
		animalProto.Security=100
		animalProto.Energy=100
		animalProto.Memory={}
		animalProto.unitid=id
		animalProto.Health=Spring.GetUnitHealth(id)								
		AgentTable[id]=animalProto
	end		
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
		Spring.UnitScript.CallAsUnit(id,Spring.UnitScript.SetUnitValue,cobvalue, valueToSet )		
		return true
	end
end

function evaluatePriorities(unitid)
	highestPriority="Security"
	if AgentTable[unitid].Health < 50 then return highestPriority end
	
	ValSoFar=AgentTable[unitid]["Security"]
	for k,v in pairs(AgentTable[unitid]) do
		if type(v)== "number" then
			if v < ValSoFar then
				highestPriority=k
				ValSoFar=v		
			end
		end
	end

	return highestPriority
end

function stateMostWanted(unitid)
	Priority=evaluatePriorities(unitid)
	----Spring.Echo("JW_ECOLOGOYGADGET:stateMostWanted:"..Priority)
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
	----Spring.Echo("Transition1")
	isDead=Spring.GetUnitIsDead(unitid)
	if isDead ==nil or isDead == true then return false, "DEAD" end
	
	LongedTransition=LongedStateLongedTransitionTable[LongedState]
	--Spring.Echo("JW_ECOLOGOYGADGET::Transition -> "..unitid.." -> is in State"..AgentTable[unitid].AgentState.." longing for "..LongedState.. "transition via"..LongedTransition)
	
	if AgentTable[unitid].Type=="ghohymen" then
		if HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedTransition] then

			boolTransfer= HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedTransition].StateChangeFunc(unitid)
			--assert(vallua=HohymenStates[AgentTable[unitid].AgentState].AgentTransition[LongedState].StateChangeFunc,"JW_ECOLOGOYGADGET "..LongedState)
			return 	boolTransfer ,LongedState
		end 
	end
	return false, LongedState
end

function DecrementAllValues(unitid)
	zeroCounter=0
	for k,v in pairs(AgentTable[unitid]) do	
		if k == "Food" or k== "Water"  or k== "Energy" then
			AgentTable[unitid][k]=math.max(0,v-2)			
			if v==0 then
				zeroCounter=zeroCounter+1
			end
		end
		
		if k== "Security"then
			AgentTable[unitid][k]=math.min(AgentTable[unitid][k]+1,100)
		end
	end
	
	Spring.AddUnitDamage(unitid,zeroCounter*10)
end

VaryFooAvatara={}

Timer=2500
function handleHymens(frame,HohymenCounter)
	if frame %128	 == 0 then
		Timer=Timer-128
		if Timer < 0 and HohymenCounter < 10 then 
			Timer=2500
			
			id=getNearestGeoVent(math.random(1,Game.mapSizeX),0,math.random(1,Game.mapSizeZ))
			x,y,z=Spring.GetFeaturePosition(id)
			if x and z then
				id=Spring.CreateUnit("ghohymen",x,0,z,1,gaiaTeam)
				ix,iy,iz = math.random(10,20), math.random(10,20), math.random(10,20)
				Spring.AddUnitImpulse(id,ix,iy,iz)
				Spring.SetUnitAlwaysVisible(id,true)
			end			
		end
		
		for id,v in pairs(AgentTable) do
		isDead=Spring.GetUnitIsDead(id)
		isValidUnit=Spring.ValidUnitID(id)
			if isValidUnit ~=nil and isValidUnit == true and isDead ~= nil and isDead == false then
			--printAgent(id,v)
			--evaluate Prioritys
			LongedState=stateMostWanted(id)

			-- if a Transition exists use it
			if LongedState then
			--Spring.Echo("JW_ECOLOGOYGADGET::Agent".. id .." longs for state ".. LongedState)
			
				boolSucessfullTransiton, ResultState= Transition(id,LongedState)
				if boolSucessfullTransiton==true then
					x,y,z=Spring.GetUnitPosition(id)
					if AgentTable[id].Type=="ghohymen" and z then
						other="none"						
						HohymenStates[LongedState].func(id, other,x,y,z)
					end					
				end						
			end
			DecrementAllValues(id)
			else
			 AgentTable[id]= nil 			
			end
		end
	end		
end