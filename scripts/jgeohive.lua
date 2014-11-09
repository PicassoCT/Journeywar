
jgeohive=piece"jgeohive"
naptime=90000
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

local teamID=Spring.GetUnitTeam(unitID)

while(true) do
----Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")
Sleep(naptime)
enemyID=Spring.GetUnitNearestEnemy(unitID)

if enemyID ~= nil then
	--EmitSfx(jgeohive,1024)
	ex,ey,ez=spGetUnitPosition(enemyID)
	if math.random(0,1)==1 then 
	eteam=Spring.GetUnitTeam(enemyID)
	ex,ey,ez=Spring.GetTeamStartPosition(eteam)
	end
	
	for i=1, howManyHoneyPots,1 do
	spEmitSfx(jgeohive,1025)
	spEmitSfx(jgeohive,1025)
	randoval=math.random(-150,-45)
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
end
end
end

function TargetOS()

local spValidUnitID=Spring.ValidUnitID
local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
local spGetUnitPosition=Spring.GetUnitPosition
local spSetUnitMoveGoal=	Spring.SetUnitMoveGoal

	while(true) do
	Sleep(5000)
		if monsterTable ~= nil and table.getn(monsterTable) > 0 then
			for i=1,table.getn(monsterTable),1 do
				if  (spValidUnitID(monsterTable[i]))== true then 
					enemyID= spGetUnitNearestEnemy(monsterTable[i])
						if enemyID ~= nil then
						ex,ey,ez = spGetUnitPosition(enemyID)
							if math.random(0,1)==1 then 
							eteam=Spring.GetUnitTeam(enemyID)
							ex,ey,ez=Spring.GetTeamStartPosition(eteam)
							end
						spSetUnitMoveGoal(monsterTable[i],ex,ey,ez)
						end
				end
			Sleep(250)
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

