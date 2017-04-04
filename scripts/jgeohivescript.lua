
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "createCorpse.lua"

hivePiece=nil
myDefID = Spring.GetUnitDefID(unitID)
jGeoHiveID = UnitDefNames["jgeohive"].id
gaiaTeamID=Spring.GetGaiaTeamID()
function setHivePiece()
	--	Spring.Echo("ID",Spring.GetUnitDefID(unitID))
	--	Spring.Echo("Ids", UnitDefNames["gzombspa"].id, UnitDefNames["jgeohive"].id )
	if Spring.GetUnitDefID(unitID) == UnitDefNames["jgeohive"].id then
		Spring.Echo("jgeohive Piece detected")
		hivePiece=piece"jgeohive"
		Move(hivePiece,y_axis,-45,0,true)
		Move(hivePiece,y_axis,0,3)
	end
	if Spring.GetUnitDefID(unitID) == UnitDefNames["gzombspa"].id then
		Spring.Echo("ZombieSpawner Piece detected")
		hivePiece=piece"center"
	end
	
	x=math.random(0,360)
	
	Turn(hivePiece,y_axis,math.rad(x),0)
	
end


spawnCycleRestTime = 80000
howManyUnitsPerSpawnCycle=5

monsterTable={}
mapX,mapZ=Spring.GetMetalMapSize()
numX = mapX*8
numZ = mapZ*8
function sanitizeCoords(x,y,z)
	
	if (not x or not z ) or x<= 50 and z <= 50 or (x >=numX-50 or z >= numZ -50) then	
		x,z=math.random((numX*0.05),numX*0.95),math.random((numZ*0.05),numZ*0.95)
		return x,y,z
	else
		return x,y,z
	end
	
end
teamID=Spring.GetUnitTeam(unitID)
function spawner()
	
	repeat 
		Sleep(100)
		hp,maxhp,_,_,bP= Spring.GetUnitHealth(unitID)
		bP = bP or 0
	until (bP >= 1 or hp == maxhp) 
	
	
	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSpawnCEG=Spring.SpawnCEG
	local spCreateUnit=Spring.CreateUnit
	local spSetUnitMoveGoal=Spring.SetUnitMoveGoal
	local spEmitSfx=EmitSfx
	local spSetUnitNoSelect=Spring.SetUnitNoSelect
	
	local x,y,z = Spring.GetUnitPosition(unitID )
	
	
	
	while(true) do
		----Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")
		Sleep(spawnCycleRestTime)
		enemyID=Spring.GetUnitNearestEnemy(unitID)
		
		if enemyID ~= nil then
			--EmitSfx(jgeohive,1024)
			ex,ey,ez=spGetUnitPosition(enemyID)
			if math.random(0,1)==1 then 
				eteam=Spring.GetUnitTeam(enemyID)
				ex,ey,ez, boolValidStartPos=Spring.GetTeamStartPosition(eteam)
			end
			Spring.SetUnitBlocking(unitID,false)
			for i=1, howManyUnitsPerSpawnCycle,1 do
				spEmitSfx(hivePiece,1025)
				spEmitSfx(hivePiece,1025)
				randoval=math.random(-65,-45)
				bool=math.random(0,1)==1
				if bool==true then
					randoval=randoval*-1
				end
				sigNum= randSign()
				
				spSpawnCEG("dirt",x+randoval,y,z+randoval,0,1,0,50,0)
				dice=math.random(1,4)
				spawnedUnit=0
				if myDefID== jGeoHiveID then	
					if dice==1 then	
						spawnedUnit=spCreateUnit("jhoneypot",x+randoval,y,z+(randoval*sigNum), 0, teamID) 
					elseif dice==2 then
						spawnedUnit=spCreateUnit("jbugcreeper",x+randoval,y,z+(randoval*sigNum), 0, teamID) 
					else --we addd the crab here
						spawnedUnit=spCreateUnit("jcrabcreeper",x+randoval,y,z+(randoval*sigNum), 0, teamID) 
					end
				else
					if dice==2 then	
						spawnedUnit=spCreateUnit("gzombiehorse",x+randoval,y,z+(randoval*sigNum), 0, teamID) 
					else 
						spawnedUnit=spCreateUnit("zombie",x+randoval,y,z+(randoval*sigNum), 0, teamID) 
					end
				end
				
				if spawnedUnit and Spring.ValidUnitID(spawnedUnit) == true then 
					myTeam=Spring.GetUnitTeam(unitID)
					
					GG.AI_HiveAgentIndepentT[myTeam][spawnedUnit]=boolHiveMindActive
					
					spSetUnitNoSelect(spawnedUnit,true)
					if boolValidStartPos== true then
						spSetUnitMoveGoal(spawnedUnit,ex,ey,ez)
					end
					table.insert(monsterTable,spawnedUnit)
				end
				
				
				Sleep(350)
				spEmitSfx(hivePiece,1025)
				spEmitSfx(hivePiece,1025)
				
			end
			
			Spring.SetUnitBlocking(unitID,true)
		end
		Sleep(10000)
	end
end


BuildUPTime=900000
PEAKFADETIME=900000
PeakTime = 850000
RandVAl=math.ceil(math.random(40000,600000))
RELAXTIME=60000 + RandVAl

totalTable={
	["BUILDUP"]= BuildUPTime,
	["PEAKFADE"]= PeakTime,
	["PEAK"]= PEAKFADETIME,
	["RELAX"]= RELAXTIME
}

nextState={
	["BUILDUP"]= "PEAK",
	["PEAKFADE"]= "RELAX",
	["PEAK"]= "PEAKFADE",
	["RELAX"]= "BUILDUP"
}

function NextState(nState,times)
	
	--Spring.Echo("CurrentState:"..nState.." in "..(times-totalTable[nState]).." next State:"..nextState[nState] )
	if nState=="BUILDUP" and times > BuildUPTime then 
		times=0; --Spring.Echo("hivePiece::Peak") ;
		return "PEAK" , times , BuildUPTime
	end
	
	if nState=="PEAK" and times > PeakTime then 
		times=0; 
		return "PEAKFADE", times , PeakTime
	end
	
	if nState=="PEAKFADE" and times > PEAKFADETIME then 
		times=0; 
		return "RELAX", times, PEAKFADETIME
	end
	
	if nState=="RELAX" and times > RELAXTIME then 
		times=0 ;
		RELAXTIME= 60000+ math.ceil(math.random(4000,60000)) 
		--	Spring.Echo("hivePiece::BUILDUP") ;
		return "BUILDUP", times, RELAXTIME
	end	
	
	return nState, times, times/totalTable[nState]
end

function findBiggestCluster(team)
	mapX,mapZ=Spring.GetMetalMapSize()
	mapRepresentiv=makeTable(0,mapx,mapZ)
	teamUnits=Spring.GetTeamUnits(team)
	maxTuple={
		x=mapX/2,
		z=mapZ/2,
		val=0
	}
	if teamUnits then
		local spGetUnitPos= Spring.GetUnitPosition
		process(teamUnits,
		function(id)
			ix,_,iz= spGetUnitPos(id)
			ix,iz=math.ceil(ix/8),math.ceil(iz/8)
			if mapRepresentiv[ix] and mapRepresentiv[ix][iz] then
				mapRepresentiv[ix][iz] = mapRepresentiv[ix][iz] +1
			end
		end)
		
		for i=1,#mapX do
			for j=1,#mapZ do
				if mapRepresentiv[i][j] > maxTuple.val then
					maxTuple.val=mapRepresentiv[i][j] 
					maxTuple.x=i
					maxTuple.z=j
				end
			end
		end
	end
	return maxTuple.x*8, maxTuple.z*8
end


ax,ay,az=Spring.GetUnitPosition(unitID)
--attack relentless the biggest cluster
function PEAK(monsterID, enemyID,Time,mteam, factor)
	if math.random(0,1)==0 then
		eteam=Spring.GetUnitTeam(enemyID)
		ex,ez=findBiggestCluster(eteam)
		return false, 
	else
		ad=Spring.GetUnitNearestAlly(enemyID)
		ex,ey,ez=Spring.GetUnitPosition(ad)
		ex,ey,ez=sanitizeCoords(ex,ey,ez)
		return false,
	end
	
end
PEAKFADEHALF=PEAKFADETIME/4

function PEAKFADE(monsterID, enemyID,Time,mteam, factor)
	if Time/PEAKFADETIME < 0.5 or math.random(1,Time)/PEAKFADEHALF > 1 then
		-- Allow for the Unit to display its own behaviour usually attack
		
		return false, ex,ey,ez
	else
		-- 
		eteam=Spring.GetUnitTeam(enemyID)
		ex,ey,ez=Spring.GetTeamStartPosition(eteam)
		ax,ay,az=Spring.GetTeamStartPosition(mteam)
		cof=Time/PEAKFADETIME
		
		sinf=0
		if Time/PEAKFADETIME > 0.75 then sinf=math.sin(cof*math.pi*3)/10 end
		
		cof= math.min(math.max(cof+sinf,0.25),0.85) 
		x,y,z = sanitizeCoords((1-cof)*ex+ ax*cof, ay, (1-cof)*ez+ az*cof)
		return true, x,y,z
	end
	
end

function BUILDUP( enemyID,Time,mteam, factor)
	waveaddition=math.cos(factor* 3.14158*7)*(1/10)
	coef=math.min(math.max(0.25,Time/BuildUPTime + waveaddition),0.90)
	Inv=1-coef
	--we try to calc a midvalue -- and get everyone to assemble there
	enemyTeamID=Spring.GetUnitTeam(enemyID)
	if not enemyID or not enemyTeamID then return false end
	
	ecx,ecy,ecz=Spring.GetTeamStartPosition(enemyTeamID)
	vEc=makeVector(ecx,ecy,ecz)
	
	ax,ay,az=Spring.GetTeamStartPosition(mteam)
	vAs=makeVector(	ax,ay,az)
	
	offVec=subVector(vAs,vEc)
	resVec=blendVector(coef,vAs,vEc)
	
	
	
	resVec.x,resVec.y,resVec.z=sanitizeCoords(resVec.x,resVec.y,resVec.z)
	--well away from the mainbase
	return true,resVec.x,resVec.y,resVec.z 
	
end


function RELAX(monsterID, enemyID,Time,mteam, factor)
	allyTeamID=Spring.GetUnitTeam(monsterID)	
	ax,ay,az=Spring.GetTeamStartPosition(allyTeamID)
	ex,ey,ez=Spring.GetUnitPosition(enemyID)
	
	
	factor= math.min(0.75,math.max(0.35,(math.sin((Time/(RELAXTIME/3))*3.14159))))
	
	vDa= blendVector(factor,makeVector(ax,ay,az),makeVector(ex,ey,ez))
	
	return true, vDa.x,vDa.y,vDa.z
end

funcTable={}

funcTable["PEAK"]= PEAK
funcTable["PEAKFADE"]=PEAKFADE
funcTable["BUILDUP"]=BUILDUP
funcTable["RELAX"]=RELAX
local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
function getNearestEnemy(idID)
	if Spring.ValidUnitID(idId)==false then return end
	
	minDist=math.huge
	minDistID=math.huge
	
	local spGetUnitTeam=Spring.GetUnitTeam
	for _,id in ipairs(AllUnitsUpdated) do
		edTeam=spGetUnitTeam(id)
		if edTeam ~= teamID and edTeam ~= gaiaTeamID and id ~= idID then
			dist =distanceUnitToUnit(id,idID)
			
			if dist and id and dist + math.random(0,30) < minDist then 
				minDistID= id
				minDist=dist + math.random(0,30)
			end
		end
	end
	
	if minDistID == math.huge then return Spring.GetUnitNearestEnemy(idID) end
	
	return minDistID
end
AllUnitsUpdated={}
State="RELAX"
function TargetOS()
	
	
	times=0
	local spValidUnitID=Spring.GetUnitIsDead
	
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSetUnitMoveGoal=	Spring.SetUnitMoveGoal
	local lfuncTable=funcTable
	
	oldState="RELAX"
	while(true) do
		Sleep(5000)
		times=times+5000
		AllUnitsUpdated=Spring.GetAllUnits()
		myTeam=Spring.GetUnitTeam(unitID)
		
		if monsterTable and table.getn(monsterTable) > 0 then
			
			State, times, percent =NextState(State,math.ceil(times))
			if State ~= oldState then
				Spring.Echo("jgeohive:Switching from "..oldState.." to "..State)
				oldState=State
			end
			
			for i=1,table.getn(monsterTable),1 do
				monsterid=monsterTable[i]
				
				enemyID= getNearestEnemy(monsterid)
				if enemyID and stillInSamePosition(monsterid) == true then
					moveIfInSamePosition(enemyID,monsterID)
					
				else					
					if enemyID then						
						setStateDependantMoveGoal(unitID,enemyID,times,teamID, times,totalTable,State)
					end
				end
			end
		end
	end
end

function setStateDependantMoveGoal(unitID,enemyID,times,teamID, times,totalTable,State)
	boolHiveMindActive, ex,ey,ez = lfuncTable[State](unitID,enemyID,times,teamID, times/totalTable[State])
	if not GG.AI_HiveAgentIndepentT then GG.AI_HiveAgentIndepentT={}end
	if not GG.AI_HiveAgentIndepentT[myTeam] then GG.AI_HiveAgentIndepentT[myTeam]={}end
	GG.AI_HiveAgentIndepentT[myTeam][monsterid]=boolHiveMindActive
	
	if ex then
		StartThread(markPosOnMap,ex,ey,ez,"greenlight")						
		spSetUnitMoveGoal(monsterid,ex,ey,ez)
	end
end

function moveIfInSamePosition(enemyID,monsterID)
	eTeam=Spring.GetUnitTeam(enemyID)
	sx,sy,sz=Spring.GetTeamStartPosition(eTeam)
	if math.random(0,1)==1 then
		Command(monsterid, "go", {x=sx,y=sy,z=sz},{"shift"})
	else
		Command(monsterid, "go", {x=sx,y=sy,z=sz},{})
	end
end

function aliveAndWell(id)
	boolExists=Spring.ValidUnitID(id)
	if boolExists and boolExists==true then
		boolAlive=Spring.GetUnitIsDead(id)
		if boolAlive and boolAlive == true then
			return true
		end
	end
	return false
	
end


monsterPosTable={}
function stillInSamePosition(id)
	bRetVal=false
	mx,my,mz=Spring.GetUnitPosition(id)
	if mx then
		mVec=makeVector(mx,my,mz)
		if not monsterPosTable[id] then
			monsterPosTable[id]=mVec
			bRetVal=false
		else
			
			if distanceVec(mVec,monsterPosTable[id]) < 20 then
				
				monsterPosTable[id]=mVec
				bRetVal=true	
			end	
		end
	end
	return bRetVal
end



function script.Create()
	
	setHivePiece()
	
	StartThread(spawner)
	StartThread(TargetOS)
	
end


function script.Killed()
	Move(hivePiece,y_axis,-25,18)
	EmitSfx(hivePiece,1024)
	WMove(hivePiece,y_axis,-25,18)
	EmitSfx(hivePiece,1024)
end