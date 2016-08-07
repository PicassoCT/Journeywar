include "suddenDeath.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 

TablesOfPiecesGroups={}
cCircleRange= 1200
maxDepth = 800

function script.HitByWeapon ( x, z, weaponDefID, damage ) 
end
center=piece"center"
boolAlive=true
sunStage=1
function script.Create()
	--generatepiecesTableAndArrayCode(unitID)
	--TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	StartThread(LiveTimer)
	StartThread(damageDealer)
end
unitDefID= Spring.GetUnitDefID(unitID)
function damageDealer()
timeCounter=0
	while true do
	timeCounter=timeCounter+1
	x,y,z=Spring.GetUnitPosition(unitID)
	filterOutTypeTable={[unitDefID]=true}
	
	allUnits= getAllInCircle(x,z, cCircleRange,unitID)
	allUnits= filterOutUnitsOfType(allUnits,filterOutTypeTable )
	
	if allUnits  then
	for i=1, table.getn(allUnits) do
		if allUnits[i]== unitID then
		 allUnits[i]= nil
		end
	end
	
	allUnitsEvaporating= getAllInCircle(x,z, cCircleRange/2,unitID)
	allUnitsEvaporating= filterOutUnitsOfType(allUnitsEvaporating,filterOutTypeTable )
	for i=1, table.getn(allUnitsEvaporating) do
		if allUnitsEvaporating[i]== unitID then
		 allUnitsEvaporating[i]= nil
		end
	end

		if GG.OnFire == nil then GG.OnFire={} end			
			-- Units taking Firdamage
			dict=TableToDict(allUnits)
			groupOnFire(dict)
			
			--Units evaporating
			process(allUnitsEvaporating, 
			function(id) 
			x,y,z=Spring.GetUnitPosition(id)
				if y > - 30 then
				y=math.max(15,y)
				Spring.SpawnCEG("fireDisolveFx",x,y+10,z,0,1,0,0)	
				Spring.DestroyUnit(id,true,true);
				return id; 
				end
			end)
			
			allFeatures = getAllFeatureNearUnit(unitID,cCircleRange)
			if allFeatures then
			process(allFeatures,
			function(id)
			hp=Spring.GetFeatureHealth(id)
			hp=math.max(0,hp-20)
			
			if hp > 0 then
			x,y,z=Spring.GetFeaturePosition(id)
			Spring.SpawnCEG("fireDisolveFx",x,y+10,z,0,1,0,0)	
			else
			Spring.DestroyFeature(id,true,true)
			end
				Spring.SetFeatureHealth(id,hp)
				
			return id
			end)
			end
			
			--Features Evaporating
			allFeatures = getAllFeatureNearUnit(unitID,cCircleRange/2)
			if allFeatures then
				process(allFeatures,
				function(id)
		
				x,y,z=Spring.GetFeaturePosition(id)
				y= math.max(5,y)
				Spring.SpawnCEG("fireDisolveFx",x,y+10,z,0,1,0,0)	
				Spring.DestroyFeature(id,true,true) end
				)
			end


	end

	--Landscape melting
	meltLandscape(x,y,z,timeCounter)
	
Sleep(250)

	end

end

function meltLandscape(x,y,z,timeCounter)
if Spring.GetGroundHeigth(x,z) < maxDepth then


	if timeCounter % 8== 0 then
			if GG.DynDefMap == nil then GG.DynDefMap={} end
	if GG.DynRefMap == nil then GG.DynRefMap={} end
	size=160
	GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="j"}
	GG.DynRefMap[#GG.DynRefMap+1]=	preparhalfSphereTable(size,-0.1)
	printT(GG.DynRefMap[#GG.DynRefMap],size)
	GG.boolForceLandLordUpdate=true
	end
	end

end

function LiveTimer()
Sleep(3*1000*60)
boolAlive = false
end

function script.Killed(recentDamage,_)

suddenDeathV(recentDamage)
return 1
end


----aimining & fire weapon
function script.AimFromWeapon1() 
	return aimpiece 
end



function script.QueryWeapon1() 
	return aimpiece
end

function script.AimWeapon1( Heading ,pitch)	
	--aiming animation: instantly turn the gun towards the enemy

	return true

end
 

function script.FireWeapon1()	

	return true
end



function script.StartMoving()

end

function script.StopMoving()
		
		
end

function script.Activate()

return 1
end

function script.Deactivate()

return 0
end

function script.QueryBuildInfo() 
  return center 
end

Spring.SetUnitNanoPieces(unitID,{ center})

