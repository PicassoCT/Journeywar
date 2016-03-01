
include "lib_UnitScript.lua"
include "suddenDeath.lua"

jgeohive=piece"jgeohive"
naptime=80000
howManyHoneyPots=5

monsterTable={}
numX = (Game.mapSizeX )-1
numZ = (Game.mapSizeZ )-1
function sanitizeCoords(monsterID,x,y,z, sfactor)
	
	if (not x or not z ) or x== 0 and z == 0 or (x >=numX or z >= numZ) then	
		x,y,z=Spring.GetUnitPosition(unitID)
		ez=Spring.GetUnitNearestEnemy(unitID)
		if ez then
			ex,ey,ez=Spring.GetUnitPosition(ez)
			sfactor= math.sin(sfactor* 3.14159)
			ox,oz=ex*sfactor, ez*sfactor
			x,z=x+ox,z+oz
		else
			dx,dy,dz=Spring.GetUnitDirection(monsterID)	
			if dx then 
				x,z= x + dx * 7,z+ dz*7
			end
		end
	end
	
	if x > 10 and z > 10 and x < Game.mapSizeX -10 and z < Game.mapSizeZ - 10 then 			
		return x,y,z
	end		
	
	x,z=  (math.random(1,9)/10)*Game.mapSizeX, (math.random(1,9)/10)* Game.mapSizeZ
	return x,y,z
	
end

function spawner()
	
	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSpawnCEG=Spring.SpawnCEG
	local spCreateUnit=Spring.CreateUnit
	local spSetUnitMoveGoal=Spring.SetUnitMoveGoal
	local spEmitSfx=EmitSfx
	local spSetUnitNoSelect=Spring.SetUnitNoSelect
	
	local x,y,z = Spring.GetUnitPosition(unitID)
	
	teamID=Spring.GetUnitTeam(unitID)
	
	while(true) do
		----Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")
		Sleep(80000)
		enemyID=Spring.GetUnitNearestEnemy(unitID)
		
		if enemyID ~= nil then
			--EmitSfx(jgeohive,1024)
			ex,ey,ez=spGetUnitPosition(enemyID)
			if math.random(0,1)==1 then 
				eteam=Spring.GetUnitTeam(enemyID)
				ex,ey,ez=Spring.GetTeamStartPosition(eteam)
			end
			Spring.SetUnitBlocking(unitID,false)
				for i=1, howManyHoneyPots,1 do
					spEmitSfx(jgeohive,1025)
					spEmitSfx(jgeohive,1025)
					randoval=math.random(-65,-45)
					bool=math.random(0,1)
					if bool==1 then
						randoval=randoval*-1
					end
					booltoo=-1
					if (math.random(0,1)) == 1 then
						booltoo=1
					end
					
					spSpawnCEG("dirt",x+randoval,y,z+randoval,0,1,0,50,0)
					dice=math.random(1,3)
					spawnedUnit=0
					if dice==1 then	
						spawnedUnit=spCreateUnit("jhoneypot",x+randoval,y,z+(randoval*booltoo), 0, teamID) 
					elseif dice==2 then
						spawnedUnit=spCreateUnit("jbugcreeper",x+randoval,y,z+(randoval*booltoo), 0, teamID) 
					else --we addd the crab here
						spawnedUnit=spCreateUnit("jcrabcreeper",x+randoval,y,z+(randoval*booltoo), 0, teamID) 
					end
					
					
					spSetUnitNoSelect(spawnedUnit,true)
					
					Sleep(350)
					spEmitSfx(jgeohive,1025)
					spEmitSfx(jgeohive,1025)
					spSetUnitMoveGoal(spawnedUnit,ex,ey,ez)
					table.insert(monsterTable,spawnedUnit)
				end
			Sleep(10000)
			Spring.SetUnitBlocking(unitID,true)
		end
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

function NextState(State,time)



	if State=="BUILDUP" and time > BuildUPTime then 
	time=0; --Spring.Echo("jgeohive::Peak") ;
	return "PEAK" , time ,  BuildUPTime
	end
	
	if State=="PEAK" and time > PeakTime then 
	time=0; 
	return "PEAKFADE", time , PeakTime
	end
	
	if State=="PEAKFADE" and time > PEAKFADETIME then 
	time=0; 
	return "RELAX", time, PEAKFADETIME
	end
	
	if State=="RELAX" and time > RELAXTIME then 
		time=0 ;
		RELAXTIME= 60000+ math.ceil(math.random(4000,60000)) 
	--	Spring.Echo("jgeohive::BUILDUP") ;
		return "BUILDUP", time, RELAXTIME
	end	

	return State, time, time/totalTable[State]
end

ax,ay,az=Spring.GetUnitPosition(unitID)
--attack relentless
function PEAK(monsterID, enemyID,Time,mteam, factor)
	eteam=Spring.GetUnitTeam(enemyID)
	ex,ey,ez=Spring.GetUnitPosition(enemyID)
	ex,ey,ez=sanitizeCoords(monsterID,ex,ey,ez,Time/8500)
	if math.random(0,1)==1 then
		ad=Spring.GetUnitNearestAlly(enemyID)
		ex,ey,ez=Spring.GetUnitPosition(ad)
		ex,ey,ez=sanitizeCoords(monsterID,ex,ey,ez,Time/8500)
	end
	return ex,ey,ez
end
PEAKFADEHALF=PEAKFADETIME/4

function PEAKFADE(monsterID, enemyID,Time,mteam, factor)
	if Time/PEAKFADETIME < 0.5 or math.random(1,Time)/PEAKFADEHALF > 1 then
		ex,ey,ez=Spring.GetUnitPosition(enemyID)
		
		return ex,ey,ez
	else
		eteam=Spring.GetUnitTeam(enemyID)
		ex,ey,ez=Spring.GetTeamStartPosition(eteam)
		
		cof=Time/PEAKFADETIME
		cof= math.max(cof,0.5)
		x,y,z = sanitizeCoords(monsterID,(1-cof)*ex+ ax*cof, ay, (1-cof)*ez+ az*cof,Time/PEAKFADETIME)
		return x,y,z
	end
	
end

function BUILDUP(monsterID, enemyID,Time,mteam, factor)
	coef=Time/BuildUPTime +  math.max( math.min(0.1,math.cos(factor* 3.14158*7)*(1/10)),-0.1)
	Inv=1-coef
	--we try to calc a midvalue -- and get everyone to assemble there
	ecx,ecy,ecz=Spring.GetUnitPosition(enemyID)
	eteam=Spring.GetUnitTeam(enemyID)
	ex,ey,ez=Spring.GetTeamStartPosition(eteam)
	ex, ey, ez = ex + (math.cos(factor)/10) *  ex, ey,  ez + (math.cos(Inv )/10)*ez
	
	rx,ry,rz=sanitizeCoords(monsterID,(ecx*Inv+ex*coef),(ecy+ey),(ecz*Inv+ez*coef),Time/BuildUPTime)
	--well away from the mainbase
	if math.abs(ex-rx)> 1000 and math.abs(ez-rz)> 1000 then 
		return rx,ry,rz 
	else --we assmeble at the middistance to our ally
		eneMyne=Spring.GetUnitNearestEnemy(enemyID)
		if eneMyne and type(eneMyne) == "number" then
		unitDead =Spring.GetUnitIsDead(eneMyne) 
		if unitDead and unitDead == false then
			dax,day,daz=Spring.GetUnitPosition(eneMyne)
			dax,day,daz=sanitizeCoords(monsterID,(ex*Inv+dax*coef),(ey*Inv+day*coef),(ez*Inv+daz*coef),Time/BuildUPTime)
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


function TargetOS()
	State="RELAX"
	time=0
	local spValidUnitID=Spring.GetUnitIsDead
	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSetUnitMoveGoal=	Spring.SetUnitMoveGoal
	local lfuncTable=funcTable
	
	
	while(true) do
		Sleep(5000)
		time=time+5000
		if monsterTable ~= nil and table.getn(monsterTable) > 0 then
			State, time, percent =NextState(State,math.ceil(time/30))
			
			
			for i=1,table.getn(monsterTable),1 do
				v=(spValidUnitID(monsterTable[i]))
				if v and v == true then 
					
					enemyID= spGetUnitNearestEnemy(monsterTable[i])
					if enemyID then						
						ex,ey,ez = lfuncTable[State](unitID,enemyID,time,teamID, time/totalTable[State])
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

function DebugTargetOS()
	State="RELAX"
	time=0
	local spValidUnitID=Spring.GetUnitIsDead
	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSetUnitMoveGoal=	Spring.SetUnitMoveGoal
	local lfuncTable=funcTable
	
	
	while(true) do
		Sleep(500)
		time=time+5000		
		
	

			State, time,percent =NextState(State, time)
		--	Spring.Echo("JGeohive::State::"..State.." -> ".. percent)	
					
					enemyID= spGetUnitNearestEnemy(unitID)
					if enemyID then
						
						
						
						ex,ey,ez = lfuncTable[State](unitID,enemyID,time,teamID, time/totalTable[State])
						StartThread(markPosOnMap,ex,ey,ez,"greenlight")
						
					end
	end
				
end

		
		


function script.Create()
	x=math.random(0,360)
	Turn(jgeohive,y_axis,math.rad(x),0)
	StartThread(spawner)
	StartThread(TargetOS)
	--StartThread(DebugTargetOS)
end


function script.Killed()
	Move(jgeohive,y_axis,-25,18)
	EmitSfx(jgeohive,1024)
	Sleep(180)
	EmitSfx(jgeohive,1024)
end