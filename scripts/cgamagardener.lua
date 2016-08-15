
gamaemit=piece "gamaemit"
gama=piece "gama"


SIG_GAMA=1
SIG_STEAM=2
teamID=Spring.GetUnitTeam(unitID)

function script.Create()
	
end

function gamaSFX()
	
	SetSignalMask(SIG_GAMA)
	
	while(true)do
		EmitSfx(gama,1024)
		
		Sleep(50)
	end
end



function Steam(idof)
	SetSignalMask(SIG_STEAM)
	dice=math.random(1,10)
	if dice==1 then
		Spring.PlaySoundFile("sounds/cgama/steamone.wav",0.5)
	elseif dice==2 then
		Spring.PlaySoundFile("sounds/cgama/steamtwo.wav",0.5)
	elseif dice ==3 then
		Spring.PlaySoundFile("sounds/cgama/steamthree.wav",0.5)
	elseif dice ==4 then
		Spring.PlaySoundFile("sounds/cgama/steamfour.wav",0.5)
	end
	
	randDelay=math.random(50,950)
	Sleep(randDelay)
	x,y,z=Spring.GetUnitPosition(idof)
	if x ~= nil then
		rando=math.random(2,4)
		for i=1,rando,1 do
			Spring.SpawnCEG("gamasteam",x,y+4+i,z,0,1,0,50,0)
		end
	else
		
	end
	
	
end

function transFormTree(treeID)
	teamID=Spring.GetUnitTeam(treeID) 
	x,y,z=Spring.GetUnitPosition(treeID) 
	Spring.CreateUnit("jtree2activate",x,y,z,0,teamID)
	Spring.DestroyUnit(treeID,false,true)
	
end

function gamaDamage()
	HitPointsReduce=5
	selectRange=260
	SetSignalMask(SIG_GAMA)
	local spGetUnitHealth=Spring.GetUnitHealth
	local spSetUnitHealth=Spring.SetUnitHealth
	local spGetUnitDefID=Spring.GetUnitDefID
	local spGetUnitsInCylinder=Spring.GetUnitsInCylinder
	local spGetUnitPosition=Spring.GetUnitPosition
	local ltransformTree=transFormTree 
	
	while(true) do
		
		piecePosX,piecePosY,piecePosZ=spGetUnitPosition(unitID)
		proChoice={}
		proChoice=spGetUnitsInCylinder(piecePosX, piecePosZ,selectRange )
		
		if proChoice ~= nil then
			
			
			
			--Kill the Unit
			for i=1,table.getn(proChoice),1 do 
				if proChoice[i] ~= unitID then
					tempDefid=spGetUnitDefID(proChoice[i])
					tempHP=spGetUnitHealth(proChoice[i])
					boolSteam=true
					if tempDefid ~= UnitDefNames["jtree2"].id and tempDefid ~= UnitDefNames["jtree2activate"].id then
						
						tempHP=tempHP-HitPointsReduce
					else
						boolSteam=false
						if tempDefid== UnitDefNames["jtree2"].id then
							ltransformTree(proChoice[i])
						else
							tempHP=tempHP+HitPointsReduce
						end
						
						
						
					end
					
					
					if tempHP < 0 then
						Spring.DestroyUnit(proChoice[i],false,false)
					end
					spSetUnitHealth(proChoice[i],tempHP)
					if boolSteam==true then StartThread(Steam,proChoice[i]) end
				end
				
			end
			
		end
		
		
		Sleep(1000)
	end
end

----aimining & fire weapon

function script.Killed(recentDamage, maxHealth)
	
	Explode(gamaemit,SFX.SHATTER)
	Sleep(450)
	----Spring.Echo ("He is dead, Jim!")
end
--Building

function script.Activate()
	Signal(SIG_GAMA)
	StartThread(gamaSFX)
	StartThread(gamaDamage)
	
	return 1
end

function script.Deactivate()
	Signal(SIG_GAMA)
	return 0
end



function script.StartMoving()
	
	
end

function script.StopMoving()
	
end