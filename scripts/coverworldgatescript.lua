include "lib_OS.lua"
include "lib_UnitScript.lua" 
 include "lib_Animation.lua"

include "lib_Build.lua" 

include "createCorpse.lua"



buildSpot=piece"buildspot"
center=piece"center"
innergate=piece"innergate"
outergate=piece"outergate"
shaft1=piece"shaft1"
shaft2=piece"shaft2"
teamID=Spring.GetUnitTeam(unitID)
SIG_STILT=2

buildIconTable={}
for i=1,20 do
	strings="troop"..i
	buildIconTable[#buildIconTable+1]=piece(strings)
end
hideT(buildIconTable)

ringTable={}
for i=1,5, 1 do
	ringTable[i]={}
	piecename="gate"..i
	ringTable[i]=piece(piecename)
end

function rumpelStiltSkin()
	SetSignalMask(SIG_STILT)
	calcUp=0
	while true do
		
		randx=math.random(-0.3,0.3)
		randz=math.random(-0.3,0.3)
		Move(innergate,x_axis,randx,99)
		Move(innergate,z_axis,randz,99)
		Sleep(125)
		calcUp=calcUp+125
		EmitSfx(innergate,1024)
		if calcUp > 4500 then
			Spring.PlaySoundFile("sounds/cOverWorldGate/coverworldgateLoop.wav")		
			calcUp=0
		end
	end
end

naptime=90000
thatMuchMoreExpensive=1.5
teamID=Spring.GetUnitTeam(unitID)
monsterTable={}
boolPoweredUp=false

totalTime=0
boolReady=false
function estimateTotalTime()
	while boolReady==false do
		totalTime=totalTime+100
		Sleep(100)
	end
end

function LoadAnimation()
	step=math.floor(totalTime/20)
	for i=1,20, 1 do
		Show(buildIconTable[i])
		Sleep(step)
	end
	hideT(buildIconTable)
end

function powerUp()
	Move(outergate,y_axis,-359,0)
	Move(shaft1,y_axis,-17,0.3)
	Move(shaft2,y_axis,-35,0.3)
	if totalTime ~= 0 then StartThread(LoadAnimation) end
	if boolReady==false then StartThread(estimateTotalTime) end
	WaitForMove(shaft1,y_axis)
	WaitForMove(shaft2,y_axis)
	Spin(outergate,y_axis,math.rad(42),0.01)
	for i=1,table.getn(ringTable),1 do
		val=math.random(-80,80)
		Spin(ringTable[i],y_axis,val,0.05*i)
	end
	Move(shaft1,y_axis,0,9)
	Move(shaft2,y_axis,0,15)	
	Sleep(13000)
	boolReady=true
	Move(outergate,y_axis,0,32)
	Show(outergate)
	Spring.PlaySoundFile("sounds/cOverWorldGate/coverworldgateOpen.wav")		
	for i=1,3,1 do
		Spring.PlaySoundFile("sounds/cOverWorldGate/coverworldgateLoop2.wav")		
		Sleep(4700)
	end
	Show(innergate)
	Signal(SIG_STILT)
	StartThread(rumpelStiltSkin)
	boolPoweredUp=true
end

function powerDown()
	for i=1,table.getn(ringTable),1 do
		StopSpin(ringTable[i],y_axis,0.05)
	end
	Signal(SIG_STILT)
	Move(shaft1,y_axis,0,0.5)
	Move(shaft2,y_axis,0,0.5)
	Hide(innergate)
	Sleep(4000)
	Hide(outergate)
	Sleep(3000)
	for i=1,table.getn(ringTable),1 do
		StopSpin(ringTable[i],y_axis,0)
	end
	
	for i=1,table.getn(ringTable),1 do
		val=math.ceil(math.random(-8,8))
		Spin(ringTable[i],y_axis,math.rad(val),0.5)
	end
	boolPoweredUp=false
end

px,py,pz=Spring.GetUnitPiecePosDir(unitID,buildSpot)



function createUnitFunction(unitTypeString)
	if boolPoweredUp==false then powerUp() end
	spawnedID=Spring.CreateUnit(unitTypeString,px,py,pz,0,teamID)
	--Add impulse depending upon building direction..
	if spawnedID ~= nil then
		dx,dy,dz=Spring.GetUnitDirection(unitID)
		max=math.max(dx,dy,dz)
		dx=dx/max
		dz=dz/max
		dx=dx*31
		dz=dz*31
		Spring.AddUnitImpulse(spawnedID,dx,3,dz)
	end
	
	return spawnedID
end

function spawner()
	
	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSpawnCEG=Spring.SpawnCEG
	local lCreateUnitFunction=createUnitFunction
	local spSetUnitMoveGoal=Spring.SetUnitMoveGoal
	local spEmitSfx=EmitSfx
	local spSetUnitNoSelect=Spring.SetUnitNoSelect
	
	local x,y,z = Spring.GetUnitPosition(unitID)
	
	
	
	
	averageUnitCost=0
	
	amProCost=(UnitDefNames["campro"].metalCost+ UnitDefNames["campro"].energyCost)*0.5
	mtwCost=(UnitDefNames["mtw"].metalCost+UnitDefNames["mtw"].energyCost)*0.5
	artCost=(UnitDefNames["bg"].metalCost+UnitDefNames["bg"].energyCost)*0.5
	resCost=(UnitDefNames["restrictor"].metalCost+UnitDefNames["restrictor"].energyCost)*0.5
	bgCost=(UnitDefNames["csniper"].metalCost+UnitDefNames["csniper"].energyCost)*0.5
	cssCost=(UnitDefNames["css"].metalCost+UnitDefNames["css"].energyCost)*0.5
	sum=((amProCost+mtwCost+artCost+resCost+bgCost+cssCost)/6)*thatMuchMoreExpensive
	
	enemyID=spGetUnitNearestEnemy(unitID)
	ox,oy,oz=Game.mapSizeX/2,0,Game.mapSizeZ/2
	if enemyID then ox,oy,oz=spGetUnitPosition(enemyID) end
	
	while(true) do
		----Spring.Echo("Im-on-it,im-on-it.. jesus christ those bugs are in a hurry to die!")
		Sleep(naptime)
		enemyID=spGetUnitNearestEnemy(unitID)
		
		if enemyID ~= nil then
			spawnPortalEffect()
			
			ex,ey,ez=spGetUnitPosition(enemyID)-- this should allow the unit to follow a friend closest to a foe
			if math.abs(ex-ox+ey-oy+ez-oz) < 5 then
				eteamid=Spring.GetUnitTeam(enemyID)
				ex,ey,ez=Spring.GetTeamStartPosition(eteamid)
			end
			ox,oy,oz=ex,ey,ez
			-- acquire ressources
			intervall=math.ceil(math.random(5,10))
			
			metallTeam,_,_,_,_,_,_,_=Spring.GetTeamResources(teamID,"metal")
			energyTeam,_,_,_,_,_,_,_=Spring.GetTeamResources(teamID,"energy")
			
			boolThisCanWorkOut=false
			while (boolThisCanWorkOut ==false and intervall > 0) do		
				if metallTeam- (intervall*(sum/2)) > 0 and energyTeam- (intervall*(sum/2)) > 0 then
					boolThisCanWorkOut=true
				else
					intervall=intervall-1
				end
			end
			Spring.UseTeamResource(teamID,"metal",math.ceil(intervall*(sum/2)))
			Spring.UseTeamResource(teamID,"energy",math.ceil(intervall*(sum/2)))
			
			
			
			--randomRessourceDistribution 
			-- mtw 
			-- restrictor
			-- art
			-- ampro
			for i=1, intervall,1 do
				dice=math.random(1,5)
				Unittype=""
				if dice==1 then 	Unittype= "css" 
				elseif dice==2 then Unittype="mtw"
				elseif dice==3 then Unittype="restrictor"
				elseif dice==4 then Unittype="csniper"
			else Unittype= "campro" end
				
				
				
				spawnedUnit=lCreateUnitFunction(Unittype)
				if spawnedUnit~= nil then
					spSetUnitNoSelect(spawnedUnit,true)
					spawnPortalEffect()
					Sleep(1550)
					spSetUnitMoveGoal(spawnedUnit,ex,ey,ez)
					table.insert(monsterTable,spawnedUnit)
				end
			end
			Sleep(4000)
			powerDown()
		end
	end
end

function spawnPortalEffect()
	x,y,z=Spring.GetUnitPosition(unitID)
	Spring.SpawnCEG("portable",x,y+70,z,0,1,0,60)	
	Spring.SpawnCEG("holeinthesky",x,y+320,z,0,1,0,60)	
end

function TargetOS()
	
	local spValidUnitID=Spring.ValidUnitID
	local spGetUnitNearestEnemy=Spring.GetUnitNearestEnemy
	
	local spGetUnitPosition=Spring.GetUnitPosition
	local spSetUnitMoveGoal=	Spring.SetUnitMoveGoal
	local boolFlipFlop=true
	while(true) do
		Sleep(12000)
		if monsterTable ~= nil and table.getn(monsterTable) > 0 then
			enemyID=nil
			
			
			if GG.ComEnders and GG.ComEnders[teamID] then enemyID=GG.ComEnders[teamID]
			else
				if spValidUnitID(monsterTable[i])==true then
					enemyID	= spGetUnitNearestEnemy(monsterTable[i])
				end
			end
			
			
			for i=1,table.getn(monsterTable),1 do
				if (spValidUnitID(monsterTable[i]))== true then 		
					
					if enemyID ~= nil then
						ex,ey,ez = spGetUnitPosition(enemyID)
						if math.random(0,1)==1 then 
							eteam=Spring.GetUnitTeam(enemyID)
							ex,ey,ez=Spring.GetTeamStartPosition(eteam)
						end
						
						spSetUnitMoveGoal(monsterTable[i],ex,ey,ez)
					end
				end
			end
		end
		
		
	end
end

function script.Create()
	Hide(innergate)
	Hide(outergate)
	StartThread(spawner)
	StartThread(TargetOS)
	StartThread(powerDown)
end


function script.Killed(recentDamage,_)
	
	createCorpseCBuilding(unitID,recentDamage)
	return 0
end