include "createCorpse.lua"
include "lib_OS.lua"
include "lib_UnitScript.lua" 
include "lib_Animation.lua"
include "lib_Build.lua" 
include "jsunShipComonScript.lua"

--Declared pieces
center=piece"center"
Main= piece"Main"
circDanceCenter= piece"circDanceCenter"
crysCenter= piece"crysCenter"
centerCore = piece"centerCore"
Sun1 = piece"Sun1"
inRotX = piece"inRotX"
inRotY = piece"inRotY"
center = piece"center"
waterPivot= piece"waterPivot"
diamond1= piece"diamond1"
diamond2= piece"diamond2"

TablesOfPiecesGroups={}
cCircleRange= 1200
dragInRange= 1500
liftUpRange= 900
maxDepth = 800

_,maxHP=Spring.GetUnitHealth(unitID)
function script.HitByWeapon ( x, z, weaponDefID, damage ) 
	RemainLifeTime=RemainLifeTime - math.floor(damage/100)
	return damage
end

LifeTimeMax= 80
SunyCycleMax= 7
center=piece"center"
boolAlive=true
sunStage=1
local LupsApi = GG.Lups
function script.Create()
	Hide(inRotX)
	Hide(inRotY)
	Hide(Main)
	
	
	TablesOfPiecesGroups=makePiecesTablesByNameGroups(false,true)
	for k,v in pairs(TablesOfPiecesGroups) do
		resetT(v)
		hideT(v)
	end
	
	if LupsApi then
		--LupsApi.AddParticles(class,options)
	end
	StartThread(sunLifeTimeControll)
	StartThread(damageDealer)
	StartThread(playSoundTillYouDie)
	StartThread(constDistanceDrag)
	StartThread(setSunCol)
	
end
function setSunCol()

defaultConfig=  GG.SunConfig:getDefaultConfg()
defaultConfig.sunColor={255,128,0,255}
defaultConfig.lifeTime=LifeTimeMax*1000
 GG.SunConfig:PushSunConfig(defaultConfig)
end
function constDistanceDrag()
	it=0
	while true do
		it=(it+50)%200
		--Units
		px,py,pz=Spring.GetUnitPosition(unitID)
		T=getAllInCircle(px,pz,dragInRange,unitID)
		myDefID=Spring.GetUnitDefID(unitID)
		
		if T then
			process(T,
			function(id) if Spring.ValidUnitID(id)==true then return id end end,
			function (id)
				defID= Spring.GetUnitDefID(id)
				if UnitDefs[defID].isBuilding== false then
					idID =Spring.GetUnitDefID(id)
					
					if idID ==UnitDefNames["jdarkgate"].id and distanceUnitToUnit(id,unitID) < 100 then
						Spring.DestroyUnit(id,true,false)
						Spring.DestroyUnit(unitID,true,false)
					end
					
					if id ~= unitID and idID ~= UnitDefNames["jsunshipfire"].id then 
						return id 
					end 
				end
			end,		
			function(id)
				if id and  type(id)=="number" then
					dist=distanceUnitToUnit(id,unitID) 
					
					if dist and dist < dragInRange and dist > liftUpRange then
						ix,iy,iz= Spring.GetUnitPosition(id)
						vec= makeVector(px- ix,py-iy,pz-iz)
						vec= normVector(vec) 
						mass =Spring.GetUnitMass(id)
						vec= mulVector(vec,(1-((dist-liftUpRange)/(dragInRange-liftUpRange))))
						Spring.AddUnitImpulse(id,vec.x*(1/mass),vec.y*(1/mass),vec.z*(1/mass))		
	
						if it == 0 then
							Spring.SpawnCEG("jsunshipburnup",ix,iy+10,iz,vec.x*-1,vec.y*-1,vec.z*-1,10,0)							
						end
					end
					
					if dist and dist < liftUpRange then
						StartThread(moveTowards,id,50, 10, px,py,pz,1-(dist/liftUpRange))
					end
				
					if id then
						Spring.AddUnitDamage(id,4)	
					end
				end
				
				
			end
			)
		end
		
		Sleep(50)			
	end
	
end

function moveTowards(id, times,resolution, px,py,pz, percentageCompleted)
	if id then
		
		Spring.MoveCtrl.Enable(id)
		
		
		for i=1,times,resolution do
			ox,oy,oz= Spring.GetUnitPosition(id)
			if ox then
				ox = ox*(1-percentageCompleted)+ px *percentageCompleted
				oy = oy*(1-percentageCompleted)+ py *percentageCompleted + (percentageCompleted*100)
				oz = oz*(1-percentageCompleted)+ pz *percentageCompleted
				
				Spring.MoveCtrl.SetPosition(id,ox, oy,oz)
			end
			Sleep(resolution)
		end
		
		
		Spring.MoveCtrl.Disable(id)
	end
end



function damageDealer()
	timeCounter=0
	--StartThread(stabilize)
	StartThread(sfxCreator)
	
	while true do
		timeCounter=timeCounter+1
		ux,uy,uz=Spring.GetUnitPosition(unitID)
		filterOutTypeTable={[unitDefID]=true}
		
		allUnits= getAllInCircle(ux,uz, cCircleRange,unitID)
		allUnits= filterOutUnitsOfType(allUnits,filterOutTypeTable )
		
		if allUnits then
			for i=1, table.getn(allUnits) do
				if allUnits[i]== unitID then
					allUnits[i]= nil
				end
			end
			
			allUnitsEvaporating= getAllInCircle(ux,uz, cCircleRange/2,unitID)
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
			process(
			allUnitsEvaporating, 
			function(id) 
				x,y,z=Spring.GetUnitPosition(id)
				y=math.max(15,y)
				--at least one falme per evaporating unit
				Spring.SpawnCEG("fireDisolveFx",x,y+10,z,0,1,0,0)	
				
				pieceMap= Spring.GetUnitPieceMap(id)
				--burn for everyPiece
				convertedPieceMap={}
				for key,value in pairs(pieceMap)do convertedPieceMap[#convertedPieceMap+1] =value end
				--evaporate by piece if piece is bigger in volume then 2000
				
				process(convertedPieceMap,
				function (pieceID)
					scaleX, scaleY, scaleZ = Spring.GetUnitPieceCollisionVolumeData(id,pieceID)
					if scaleX then
						volume=scaleX*scaleY*scaleZ 
						if volume > 2000 then
							return pieceID
						end
					end
				end,				
				function (pieceID) 
					if pieceID then
						fx,fy,fz= Spring.GetUnitPiecePosDir(id,pieceID)
						Spring.SpawnCEG("fireDisolveFx",fx,fy+10,fz,0,1,0,0)					
					end				
				end				
				)
				
				
				Spring.DestroyUnit(id,true,true);
				return id; 
				
			end)
			
			allFeatures = getAllFeatureNearUnit(unitID,cCircleRange)
			if allFeatures then
				process(allFeatures,
				function(id)
					hp=Spring.GetFeatureHealth(id)
					hp=math.max(0,hp-20)
					
					if hp > 0 then
						fx,fy,fz=Spring.GetFeaturePosition(id)
						Spring.SpawnCEG("fireDisolveFx",fx,fy+10,fz,0,1,0,0)	
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
					
					fx,fy,fz=Spring.GetFeaturePosition(id)
					fy= math.max(5,fy)
					Spring.SpawnCEG("fireDisolveFx",fx,fy+10,fz,0,1,0,0)	
				Spring.DestroyFeature(id,true,true) end
				)
			end
			
			
		end
		
		Sleep(250)
	end
	
end

function stabilize()
	while true do
		
		
		Spring.SetUnitDirection(unitID,0,1,0)
		Sleep(10)
	end
end

function spawnCorona()
	
	while true do
		
		x,y,z =Spring.GetUnitPiecePosDir(unitID,center)
		Spring.SpawnCEG("jsunshipcorona",x,y,z,0,1,0)	
		Sleep(800)
	end
	
	
end

function sfxCreator()
	StartThread(spawnCorona)
	timeCounter=0
	while true do
		timeCounter=timeCounter+1
		ux,uy,uz=Spring.GetUnitPosition(unitID)
		
		--Landscape melting
		meltLandscape(ux,uy,uz,timeCounter)
		setFireToLandscape(ux,uy,uz, 1212)
		gh=Spring.GetGroundHeight(ux,uz)
		
		Spring.SpawnCEG("jsunwave",ux+math.random(-20,20),math.max(10,gh+10),uz+math.random(-20,20),0,1,0,0)
		Sleep(250)
		
		
		--decal
		if timeCounter % 30 == 0 then
			Spring.CreateUnit("jsunshipscardecalfactory",ux+ 50,gh,uz+ 50,math.ceil(math.random(0,3)),gaiaTeamId)
		end
	end
	
end
gaiaTeamId=Spring.GetGaiaTeamID()
function setFireToLandscape(x,y,z, range)
	
	sfxFunction = function (LanscapeCell)
		LanscapeCell.boolBurning= true
		return LanscapeCell
	end
	
	if GG.LandScapeT.setAreaEffect then
		GG.LandScapeT.setAreaEffect(x,z, range, sfxFunction)
	end	
	
end

function meltLandscape(x,y,z,timeCounter)
	if Spring.GetGroundHeight(x,z) < maxDepth then
		
		
		if timeCounter % 8== 0 then
			if GG.DynDefMap == nil then GG.DynDefMap={} end
			if GG.DynRefMap == nil then GG.DynRefMap={} end
			size=160
			GG.DynDefMap[#GG.DynDefMap+1]=	{x=x/8, z=z/8,Size=size,blendType ="melt", filterType="j"}
			GG.DynRefMap[#GG.DynRefMap+1]=	prepareHalfSphereTable(size,-0.1)
			--printT(GG.DynRefMap[#GG.DynRefMap],size)
			GG.boolForceLandLordUpdate=true
		end
	end
	
end
function playSoundTillYouDie()
	myDefID=Spring.GetUnitDefID(unitID)
	Sleep(350)
	Spring.PlaySoundFile("sounds/jsunship/ignite.ogg", 1)
	timeLoudness=0
	while true do 
		
		StartThread(PlaySoundByUnitDefID,myDefID,"sounds/jsunship/sunBurning"..math.ceil(math.random(1,3))..".ogg",1, 14000, 1,0)
		timeLoudness=timeLoudness+ math.pi/4
		Sleep(5000)
	end
	
	
	
end




function init()
	spinT(TablesOfPiecesGroups["Sun"],y_axis,12, -122)
	recProcess(TablesOfPiecesGroups, function(id) Hide(id) end)
end

function showSun(index)
	hideT(TablesOfPiecesGroups["Sun"])
	Show(TablesOfPiecesGroups["Sun"][index])
end

RemainLifeTime=LifeTimeMax
SunyCycleMax=1
function sunLifeTimeControll()
	init()
	
	
	for i=1, LifeTimeMax, LifeTimeMax/7 do
		showSun(SunyCycleMax)
		SunyCycleMax=SunyCycleMax+1
		Sleep(math.ceil(LifeTimeMax/7)*1000)
		RemainLifeTime=RemainLifeTime-math.ceil(LifeTimeMax/7)*1000
		if RemainLifeTime < RemainLifeTime-math.ceil(LifeTimeMax+1/7)*1000 then
			SunyCycleMax=SunyCycleMax+1
		end
	end
	x,y,z=Spring.GetUnitPiecePosDir(unitID,center)
	recProcess(TablesOfPiecesGroups, function(id) Hide(id) end)
	Spring.SpawnCEG("jsupernovaprep",x,y+10,z, 0, 1,0 )	
	Sleep(4000)
	Spring.SpawnCEG("jsupernova",x,y+10 ,z, 0, 1,0 )	
	Spring.DestroyUnit(unitID,true,true)
end

function script.Killed(recentDamage,_)
	return 1
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