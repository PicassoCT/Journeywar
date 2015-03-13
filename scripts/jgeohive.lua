
jgeohive=piece"jgeohive"
naptime=80000
howManyHoneyPots=5

monsterTable={}

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


BuildUPTime=30000
PEAKFADETIME=30000

RandVAl=math.ceil(math.random(4000,60000))

function NextState(State,time)
if State=="BUILDUP" and time > BuildUPTime then time=0; return "PEAK" end
if State=="PEAK" and time > 85000 then time=0; return "PEAKFADE" end
if State=="PEAKFADE" and time > PEAKFADETIME then time=0; return "RELAX" end
if State=="RELAX" and time > 60000+RandVAl then 
time=0 ;
RandVAl= math.ceil(math.random(4000,60000)) 
return "BUILDUP" 
end
return State
end



--attack relentless
function PEAK(monsterID, enemyID,Time,mteam)
eteam=Spring.GetUnitTeam(enemyID)
ex,ey,ez=Spring.GetUnitPosition(enemyID)
if math.random(0,1)==1 then
ad=Spring.GetUnitNearestAlly(enemyID)
ex,ey,ez=Spring.GetUnitPosition(ad)
end
return ex,ey,ez
end
PEAKFADEHALF=PEAKFADETIME/4

function PEAKFADE(monsterID, enemyID,Time,mteam)
if Time/PEAKFADETIME < 0.5 or math.random(1,Time)/PEAKFADEHALF > 1 then
ex,ey,ez=Spring.GetUnitPosition(enemyID)
return ex,ey,ez
else
eteam=Spring.GetUnitTeam(enemyID)
ex,ey,ez=Spring.GetTeamStartPosition(eteam)
ax,ay,az=Spring.GetTeamStartPosition(mteam)
cof=Time/PEAKFADETIME
cof= math.max(cof,0.5)
return (1-cof)*ex+ax*cof,ay,(1-cof)*ez+az*cof
end

end

function BUILDUP(monsterID, enemyID,Time,mteam)
coef=Time/BuildUPTime
Inv=1-coef
--we try to calc a midvalue -- and get everyone to assemble there
ecx,ecy,ecz=Spring.GetUnitPosition(enemyID)
eteam=Spring.GetUnitTeam(enemyID)
ex,ey,ez=Spring.GetTeamStartPosition(eteam)
rx,ry,rz=(ecx*Inv+ex*coef),(ecy+ey),(ecz*Inv+ez*coef)
--well away from the mainbase
if math.abs(ex-rx)> 1000 and math.abs(ez-rz)> 1000 then 
return rx,ry,rz 
else --we assmeble at the middistance to our ally
ally=Spring.GetUnitNearestEnemy(enemyID)
ax,ay,az=Spring.GetUnitPosition(ally)
return(ex*Inv+ax*coef),(ey*Inf+ay*coef),(ez*Inv+az*coef)

end

end

function RELAX(monsterID, enemyID,Time,mteam)
ally=Spring.GetUnitNearestEnemy(enemyID)
eteam=Spring.GetUnitTeam(enemyID)
if ally then
ax,ay,az=Spring.GetUnitPosition(ally)
return ax+math.random(-100,100),ay,az+math.random(-100,100)
else
ax,ay,azz=Spring.GetTeamStartPosition(mteam)
ex,ey,ez=Spring.GetTeamStartPosition(eteam)
mx,my,mz=(ax+ex)*0.5+math.random(-100,100),(ay+ey)*0.5,(az+ez)*0.5+math.random(-100,100)
return mx,my,mz

end
end

funcTable={}

			funcTable["PEAK"]= PEAK
			funcTable["PEAKFADE"]=PEAKFADE
			funcTable["BUILDUP"]=BUILDUP
			funcTable["RELAX"]=RELAX


function TargetOS()
State="BUILDUP"
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
		State=NextState(State,time)
			for i=1,table.getn(monsterTable),1 do
				v=(spValidUnitID(monsterTable[i]))
				if  v and v == true then 
				
				
				
				
				
					enemyID= spGetUnitNearestEnemy(monsterTable[i])
						if enemyID then
						if not State then State="PEAK" end

						ex,ey,ez = lfuncTable[State](monsterTable[i],enemyID,time,teamID)
						if ex < 20 or ez < 20 then Spring.Echo("Jgeohive state.." ..State .." produces crap") break end

						spSetUnitMoveGoal(monsterTable[i],ex,ey,ez)
						end
				end
			
			end
		end


	end
end

function script.Create()
x=math.random(0,360)
Turn(jgeohive,y_axis,math.rad(x),0)
StartThread(spawner)
StartThread(TargetOS)
end


function script.Killed()
Move(jgeohive,y_axis,-25,18)
EmitSfx(jgeohive,1024)
Sleep(180)
EmitSfx(jgeohive,1024)
end

