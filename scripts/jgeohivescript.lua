
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "createCorpse.lua"

hivePiece=nil
myDefID = Spring.GetUnitDefID(unitID)
jGeoHiveID = UnitDefNames["jgeohive"].id

function setHivePiece()
	--	Spring.Echo("ID",Spring.GetUnitDefID(unitID))
	--	Spring.Echo("Ids", UnitDefNames["gzombspa"].id, UnitDefNames["jgeohive"].id )
	if Spring.GetUnitDefID(unitID) == UnitDefNames["jgeohive"].id then
		Spring.Echo("jgeohive Piece detected")
		hivePiece=piece"jgeohive"
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
function sanitizeCoords(x,y,z, sfactor)
	
	if (not x or not z ) or x<= 50 and z <= 50 or (x >=numX-50 or z >= numZ -50) then	
		x,z=math.random(numX*0.05,numX*0.95),math.random(numZ*0.05,numZ*0.95)
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
	
	local x,y,z = Spring.GetUnitPosition(unitID)
	
	
	
	while(true) do
		----Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")
		Sleep(spawnCycleRestTime)
		enemyID=Spring.GetUnitNearestEnemy(unitID)
		
		if enemyID ~= nil then
			--EmitSfx(jgeohive,1024)
			ex,ey,ez=spGetUnitPosition(enemyID)
			if math.random(0,1)==1 then 
				eteam=Spring.GetUnitTeam(enemyID)
				ex,ey,ez=Spring.GetTeamStartPosition(eteam)
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
				
				
				spSetUnitNoSelect(spawnedUnit,true)
				
				Sleep(350)
				spEmitSfx(hivePiece,1025)
				spEmitSfx(hivePiece,1025)
				spSetUnitMoveGoal(spawnedUnit,ex,ey,ez)
				table.insert(monsterTable,spawnedUnit)
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
RELAXTIME=600000 + RandVAl

totalTable={
	["BUILDUP"]= BuildUPTime,
	["PEAKFADE"]= PeakTime,
	["PEAK"]= PEAKFADETIME,
	["RELAX"]= RELAXTIME
}

function NextState(State,times)
	
	
	
	if State=="BUILDUP" and times > BuildUPTime then 
		times=0; --Spring.Echo("hivePiece::Peak") ;
		return "PEAK" , times , BuildUPTime
	end
	
	if State=="PEAK" and times > PeakTime then 
		times=0; 
		return "PEAKFADE", times , PeakTime
	end
	
	if State=="PEAKFADE" and times > PEAKFADETIME then 
		times=0; 
		return "RELAX", times, PEAKFADETIME
	end
	
	if State=="RELAX" and times > RELAXTIME then 
		times=0 ;
		RELAXTIME= 60000+ math.ceil(math.random(4000,60000)) 
		--	Spring.Echo("hivePiece::BUILDUP") ;
		return "BUILDUP", times, RELAXTIME
	end	
	
	return State, times, times/totalTable[State]
end

function findBiggestCluster(team)
	mapX,mapZ=Spring.GetMetalMapSize
	mapRepresentiv=makeTable(0,mapx,mapZ)
	teamUnits=Spring.GetTeamUnits(team)
	maxTuple{x=mapX/2,z=mapZ/2,val=0}
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
		return ex,0,ez
	else
		ad=Spring.GetUnitNearestAlly(enemyID)
		ex,ey,ez=Spring.GetUnitPosition(ad)
		ex,ey,ez=sanitizeCoords(ex,ey,ez,Time/8500)
		return ex,ey,ez
	end
	
end
PEAKFADEHALF=PEAKFADETIME/4

function PEAKFADE(monsterID, enemyID,Time,mteam, factor)
	if Time/PEAKFADETIME < 0.5 or math.random(1,Time)/PEAKFADEHALF > 1 then
		ex,ey,ez=Spring.GetUnitPosition(enemyID)
		
		return ex,ey,ez
	else
		eteam=Spring.GetUnitTeam(enemyID)
		ex,ey,ez=Spring.GetTeamStartPosition(eteam)
		ax,ay,az=Spring.GetTeamStartPosition(mteam)
		cof=Time/PEAKFADETIME
		cof= math.max(cof,0.5)
		x,y,z = sanitizeCoords((1-cof)*ex+ ax*cof, ay, (1-cof)*ez+ az*cof,Time/PEAKFADETIME)
		return x,y,z
	end
	
end

function BUILDUP( enemyID,Time,mteam, factor)
	coef=Time/BuildUPTime + math.max( math.min(0.1,math.cos(factor* 3.14158*7)*(1/10)),-0.1)
	Inv=1-coef
	--we try to calc a midvalue -- and get everyone to assemble there
	ecx,ecy,ecz=Spring.GetUnitPosition(enemyID)
	eteam=Spring.GetUnitTeam(enemyID)
	ex,ey,ez=Spring.GetTeamStartPosition(eteam)
	ecx,ecy,ecz= ecx-ex,ecy-ey,ecz-ez
	
	ex, ey, ez = ex + (math.cos(factor)/10) * ecx, ey, ez + (math.cos(Inv )/10)*ecz
	
	rx,ry,rz=sanitizeCoords(ex,ey,ez,Time/BuildUPTime)
	--well away from the mainbase
	if math.abs(ex-rx)> 1000 and math.abs(ez-rz)> 1000 then 
		return rx,ry,rz 
	else --we assmeble at the middistance to our ally
		eneMyne=Spring.GetUnitNearestEnemy(enemyID)
		if eneMyne and type(eneMyne) == "number" then
			unitDead =Spring.GetUnitIsDead(eneMyne) 
			if unitDead and unitDead == false then
				dax,day,daz=Spring.GetUnitPosition(eneMyne)
				dax,day,daz=sanitizeCoords((ex*Inv+dax*coef),(ey*Inv+day*coef),(ez*Inv+daz*coef),Time/BuildUPTime)
				return dax,day,daz
			end
		end
	end
	
end

ux,uy,uz=Spring.GetUnitPosition(unitID)
function RELAX(monsterID, enemyID,Time,mteam, factor)
	ally=Spring.GetUnitNearestEnemy(enemyID)
	
	ex,ey,ez=Spring.GetUnitPosition(enemyID)
	x,y,z=Spring.GetUnitPosition(monsterID)
	
	factor= math.max(0.35,(math.sin((Time/(RELAXTIME/3))*3.14159)))
	
	dax,day,daz= ux* math.abs(factor) + (1-factor)*ex,uy*math.abs(factor) + (1-factor)*ey,uz*math.abs(factor) + (1-factor)*ez
	
	dax,day,daz=sanitizeCoords(monsterID, dax+math.random(-100,100),day,daz+math.random(-100,100),Time/BuildUPTime)	
	return dax,day,daz
end

funcTable={}

funcTable["PEAK"]= PEAK
funcTable["PEAKFADE"]=PEAKFADE
funcTable["BUILDUP"]=BUILDUP
funcTable["RELAX"]=RELAX
local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
function getNearestEnemy(id)

	minDist=math.huge
	minDistID=nil
	
	process(AllUnitsUpdated,
	function(ed)
		edTeam=Spring.GetUnitTeam(ed)
		if edTeam == teamID or edTeam == gaiaTeamID then
		else
			return id
		end
	end,
	function(ed)
		if ed and id and GetUnitDistance(ed,id) <minDist then 
			minDistID= ed
			minDist=GetUnitDistance(ed,id)
		end
	end)		
	if minDistID~=nil then return minDistID end
	
	return Spring.GetUnitNearestEnemy(id)
end
AllUnitsUpdated={}
function TargetOS()
	
	State="RELAX"
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
		
		if monsterTable ~= nil and table.getn(monsterTable) > 0 then
			State, times, percent =NextState(State,math.ceil(times/30))
			if State ~= oldState then
			Spring.Echo("jgeohive:Switching from "..oldState.." to "..State)
			oldState=State
			end
			
			for i=1,table.getn(monsterTable),1 do
				v=(spValidUnitID(monsterTable[i]))
				if v and v == true then 
					
					enemyID= getNearestEnemy(monsterTable[i])
					if enemyID then						
						ex,ey,ez = lfuncTable[State](unitID,enemyID,times,teamID, times/totalTable[State])
						if ex then
							StartThread(markPosOnMap,ex,ey,ez,"greenlight")						
							spSetUnitMoveGoal(monsterTable[i],ex,ey,ez)
						end
					end
				end
				
			end
		end
		
		
	end
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