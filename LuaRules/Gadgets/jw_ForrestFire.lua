

function gadget:GetInfo()
	
	function isPlanetFlammeable()
		if Game.mapHardness > 0 and Game.windMin > 0 and Game.gravity > 80 and Game.waterDamage == 0 then
			badwordsTable={"cold","ice","frost","dessert","sand","dune"} 
			for i=1, 6,1 do 
				if string.find(Game.mapName, badwordsTable[i]) then 
					return false; 
				end 
			end 
			return true 
		end
		return false
	end
	
	return {
		name = "Gadget:Weltenbrand",
		desc = "Only you can prevent Forrest Gump from firing up.",
		author = "..you, your family, your descendants and everyone you love, what do you mean not the letter to the Bonaccio-family?",
		date = "Sep. 2015",
		license = "GNA PPL ASM MOV EAX 3ST LOG BLA BLU B42",
		layer = 0,
		enabled = isPlanetFlammeable()
	}
	
end



if (gadgetHandler:IsSyncedCode()) then
	
	VFS.Include("scripts/lib_OS.lua" )
	VFS.Include("scripts/lib_UnitScript.lua" )
	VFS.Include("scripts/lib_jw.lua" 	)
	VFS.Include("scripts/lib_Build.lua" 	)
	
	local METAMAP_RES = 48
	--Food
	--AccumulatedHeat
	
	windVector={x=5,z=10}
	InHeat=25
	costPerFrame=10
	--x --z
	local fireT={}
	--TestData DelMe	
	
	--TestData DelMe
	local fireCounter=1	
	local mapX=Game.mapSizeX/METAMAP_RES
	local mapY=Game.mapSizeZ/METAMAP_RES
	local PointOfIgnition=120
	
	local counter=1
	local delayMap={}
	local bigdelayMap={}
	
	local spGetGroundHeight=Spring.GetGroundHeight
	local spGetGroundNormal=Spring.GetGroundNormal
	local spSpawnCEG=Spring.SpawnCEG
	_,extrema= 	Spring.GetGroundExtremes()
	MaxFood=150
	--testcase
	
	
	function plotLanscapeTable(tableP)
		
		for x=1,METAMAP_RES do
			RowString="||"
			
			for z=1,METAMAP_RES do
				boolprintOnce=true
				if not tableP[x][z] then RowString =RowString.."X";boolprintOnce=false end
				if boolprintOnce==true and	tableP[x][z].y < 0 then RowString =RowString.."S" ;boolprintOnce=false ; end
				if boolprintOnce==true and	tableP[x][z].Food > 0 then RowString= RowString.." ";boolprintOnce=false;end		
				
			end
			RowString=	RowString.."||"
			Spring.Echo(RowString)
		end
		
	end
	
	
	function init()
		local	localLandScapeTable={}
		
		for x=1,math.ceil(mapX), 1 do
			localLandScapeTable[x]={}
			
			for z =1, math.ceil(mapY),1 do
				
				xValue= x*METAMAP_RES
				zValue= z*METAMAP_RES
				groundHeigth= Spring.GetGroundHeight(xValue,zValue)
				
				localLandScapeTable[x][z]={}
				localLandScapeTable[x][z].boolBurning=false
				localLandScapeTable[x][z].Food= amountFlamableMaterial(xValue, zValue)
				localLandScapeTable[x][z].y= groundHeigth
				localLandScapeTable[x][z].AccumulatedHeat= 0
				
			end
		end
		plotLanscapeTable(localLandScapeTable)
		GG.LandScapeT=	localLandScapeTable
		
	end
	
	function amountFlamableMaterial(x,z)
		nx,ny,nz=spGetGroundNormal(x,z)
		nx,ny,nz=math.abs(nx),math.abs(ny),math.abs(nz)
		norm=math.sqrt(nx*nx+ny*ny+nz*nz)
		nx,ny,nz=nx/norm,ny/norm,nz/norm
		terrainflatFactor=ny/(math.max(math.abs(nx)+math.abs(nz),0.1))
		
		if ny < 0.5 then terrainflatFactor=0 end
		T=Spring.GetFeaturesInCylinder(x,z,METAMAP_RES)
		T=#T
		featureFactor=T+1 or 1
		h=spGetGroundHeight(x,z)
		Groundfactor=0
		if h-15 > 0 then Groundfactor= (1-(math.log(h)/math.log(extrema))) end
		if Groundfactor >0.7 then Groundfactor=0 else Groundfactor=Groundfactor*15 end
		
		return math.min(150*terrainflatFactor*featureFactor*Groundfactor ,MaxFood)
	end
	
	if not GG.LandScapeT then init() end
	
	--SETUP
	
	
	function addRareSFX()
		--adds sfx that are expensive eyecatchers to ordinary fire extremas
	end
	
	function gadget:Explosion(weaponID, px, py, pz, AttackerID)
	end
	
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam) 
	end
	
	local bigFireTable={}
	
	function mergeSmallFiresToPermaFire()
		local LT=GG.LandScapeT
		for x=2,#LT-1,3 do
			for z=2,#LT[x]-1,3 do
				if LT[x-1][z-1].boolBurning==true and LT[x-1][z].boolBurning==true and LT[x-1][z+1].boolBurning==true and
				LT[x][z-1].boolBurning==true and LT[x][z].boolBurning==true and LT[x][z+1].boolBurning==true and
				LT[x+1][z-1].boolBurning==true and LT[x+1][z].boolBurning==true and LT[x+1][z+1].boolBurning==true then
					bigFireTable[#bigFireTable+1]={x=x*METAMAP_RES,y=spGetGroundHeight(x*METAMAP_RES,z*METAMAP_RES),z=z*METAMAP_RES}
					removeFromFireTable({{x-1,z-1},{x-1,z},{x-1,z+1},{x,z-1},{x,z},{x,z+1},{x+1,z-1},{x+1,z},{x+1,z+1}})
				end
			end
		end
		fireCounter=fireCounter-8
	end
	
	
	function removeFromFireTable(T)
		KeyX={}
		KeyZ={}
		for i=1, #T do KeyX[T[i][1]*METAMAP_RES]=true ;KeyZ[T[i][2]*METAMAP_RES]=true end 
		
		for i= #fireT,1,-1 do
			if KeyX[fireT[i].x] and KeyZ[fireT[i].z] then
				table.remove(fireT,i)
			end
		end
		
	end
	
	function addFiresFromGG()
		local LandScapeT= GG.LandScapeT
		if not GG.AddFire then GG.AddFire={} end
		for i=1,#GG.AddFire,1 do
			
			xClamped=clamp(math.ceil(GG.AddFire[i].x/METAMAP_RES),1,METAMAP_RES)
			zClamped=clamp(math.ceil(GG.AddFire[i].z/METAMAP_RES),1,METAMAP_RES)
			
			if GG.AddFire[i].Food and LandScapeT[xClamped] and LandScapeT[xClamped][zClamped] then
				if not LandScapeT[xClamped][zClamped].Food then LandScapeT[xClamped][zClamped].Food = GG.AddFire[i].Food end
				LandScapeT[xClamped][zClamped].Food =GG.AddFire[i].Food
			end
			
			if LandScapeT[xClamped] and LandScapeT[xClamped][zClamped] and LandScapeT[xClamped][zClamped].Food > 0 then
				fireT[#fireT+1]={x=GG.AddFire[i].x,y=spGetGroundHeight(GG.AddFire[i].x,GG.AddFire[i].z)+15, z=GG.AddFire[i].z}
			end
		end
		GG.AddFire={} 
		GG.LandScapeT=	 LandScapeT
	end
	
	
	
	ProofTypes=getPyroProofTable(UnitDefNames)
	
	
	function drawFlames_AddDamage(delayMap, nr) 
		boolOnce=false
		local dMap=delayMap
		for i=1,#fireT,1 do
			if dMap[i] and dMap[i] % nr==0 then
				
				if math.random(0,3)~=1 then
					boolOnce=true
					spSpawnCEG("foorestfire", fireT[i].x+math.random(-16,16), fireT[i].y+math.random(1,5), fireT[i].z+math.random(-16,16),math.random(0,0.1),math.random(0.8,1),math.random(0,0.1),METAMAP_RES,20)
				end
				FT=Spring.GetFeaturesInCylinder(fireT[i].x,fireT[i].z,METAMAP_RES)
				if FT and #FT > 0 then
					for k=1,#FT do
						Spring.DestroyFeature(FT[k])
					end
				end
				T=getAllInCircle("placeholder", fireT[i].x, fireT[i].z,METAMAP_RES)
				T,ShitWasSoCache=filterOutUnitsOfType(T,ProofTypes, ShitWasSoCache)
				if T and #T> 0 then
					
					
					for k=1,#T do
						if Spring.ValidUnitID(T[k])==true then Spring.AddUnitDamage(T[k],10) end
					end
				end
			end
		end	
		
		return boolOnce
	end	
	
	ShitWasSoCache={}
	function drawPermaFlames_AddDamage(delayMap, frame) 
		local dMap=delayMap
		for i=1,#bigFireTable,1 do			
			if dMap[i] and dMap[i] % frame ==0 then
				spSpawnCEG("bigfoorestfire", bigFireTable[i].x+math.random(-16,16), bigFireTable[i].y+math.random(1,15), bigFireTable[i].z+math.random(-16,16),math.random(0,0.1),math.random(0.8,1),math.random(0,0.1))
				
				T=getAllInCircle("placeholder", bigFireTable[i].x, bigFireTable[i].z,52)
				T,ShitWasSoCache=filterOutUnitsOfType(T,ProofTypes,ShitWasSoCache)
				
				if T and #T > 0 then
					for k=1,#T do
						if Spring.ValidUnitID(T[k])==true then Spring.AddUnitDamage(T[k],10) end
					end
				end
				
			end
		end
		
	end
	
	function updateWind() 
		windVector.x,windVector.y,windVector.z=Spring.GetWind()
		windVector.x, windVector.y, windVector.z = windVector.x*0.09, windVector.y*0.09, windVector.z*0.09	
	end
	
	function addHeatToSurroundingArea(nr,heat)
		local LandScapeT= GG.LandScapeT
		wX=math.floor(windVector.x/math.max(math.abs(windVector.x),math.abs(windVector.z)))
		wZ=math.floor(windVector.z/math.max(math.abs(windVector.x),math.abs(windVector.z)))
		X,Y=math.floor(fireT[nr].x/METAMAP_RES),math.floor(fireT[nr].z/METAMAP_RES)
		X,Y=math.floor(X+wX),math.floor(Y+wZ)
		
		
		startX,endX=math.max(1,X-1),math.min(X+1,mapX)
		startY,endY=math.max(1,Y-1),math.min(Y+1,mapY)
		for x=startX,endX,1 do
			for z=startY,endY,1 do
				if math.abs(fireT[nr].y- LandScapeT[x][z].y) < 60 then 
					LandScapeT[x][z].AccumulatedHeat=LandScapeT[x][z].AccumulatedHeat+20
					--Spring.Echo("JW:foorestfire.."..LandScapeT[x][z].AccumulatedHeat)
					if 	LandScapeT[x][z].AccumulatedHeat > PointOfIgnition*math.random(1,2) and math.random(0,1) and
					LandScapeT[x][z].boolBurning==false and 
					LandScapeT[x][z].Food >0 and
					spGetGroundHeight(x*METAMAP_RES,z*METAMAP_RES)>0 then
						fireT[#fireT+1]={x=x*METAMAP_RES,y=15+spGetGroundHeight(x*METAMAP_RES, z*METAMAP_RES),z=z*METAMAP_RES}
						spSpawnCEG("baarestfire", fireT[#fireT].x, fireT[#fireT].y, fireT[#fireT].z,math.random(0,0.1),math.random(0.8,1),math.random(0,0.1))
						LandScapeT[x][z].boolBurning=true
						fireCounter=fireCounter+1
					end
				end
			end
		end
		GG.LandScapeT= LandScapeT
	end
	
	local teamGaia=Spring.GetGaiaTeamID()
	
	function updateFire() 
		local LandScapeT= GG.LandScapeT
		--Spring.Echo("Jw:Foorestfire3")
		for i= table.getn(fireT),1,-1 do
			x,z= math.ceil(fireT[i].x/METAMAP_RES), math.ceil(fireT[i].z/METAMAP_RES)
			
			if not LandScapeT[ x][ z].Food then 
				LandScapeT[ x][ z].Food = 0 
			end
			
			LandScapeT[ x][ z].Food =		LandScapeT[ x][ z].Food-costPerFrame
			
			if not LandScapeT[ x][ z].AccumulatedHeat then
				LandScapeT[ x][ z].Food = InHeat
			end
			
			LandScapeT[ x][ z].AccumulatedHeat =		LandScapeT[ x][ z].AccumulatedHeat+InHeat
			addHeatToSurroundingArea(i,LandScapeT[ x][ z].AccumulatedHeat)
			
			if LandScapeT[ x][ z].Food < 0 then 
				
				LandScapeT[ x][ z].boolBurning=false
				table.remove(fireT,i);
				fireCounter=fireCounter-1 
			end
			
		end
		
		for i= table.getn(bigFireTable),1,-1 do
			x,z= math.ceil(bigFireTable[i].x/METAMAP_RES), math.ceil(bigFireTable[i].z/METAMAP_RES)
			tri(x,z,10)
			if LandScapeT[ x][ z].Food < 0 and math.random(0,3)==2 then 
				table.remove(bigFireTable,i);		
				fireCounter	=fireCounter-1
				GG.UnitsToSpawn:PushCreateUnit("gforrestfiredecalfactory",x*METAMAP_RES,0,z*METAMAP_RES,0,teamGaia)			
			end
		end
		
		GG.LandScapeT=LandScapeT
	end
	
	function tri(x,z, amount)
		local LandScapeT=GG.LandScapeT
		for i=x-1,x+1 do
			for j=z-1,z+1 do
				LandScapeT[i][j].Food=LandScapeT[i][j].Food-amount
				LandScapeT[i][j].AccumulatedHeat=LandScapeT[i][j].AccumulatedHeat+10
				if LandScapeT[i][j].Food == 0 then
					LandScapeT[i][j].boolBurning=false
					
				end
			end
		end
		GG.LandScapeT=LandScapeT
	end
	
	function generateRandomDelayMap(map,val)
		T={}
		for i=1,#map do
			T[i]=math.ceil(math.random(1,val))
		end
		return T
	end
	
	function regrowFlameableMaterial()
		local LandScapeT=GG.LandScapeT
		for i=1,Game.mapSizeX/METAMAP_RES, 1 do
			for j=1,Game.mapSizeZ/METAMAP_RES,1 do
				LandScapeT[i][j].Food=math.min(MaxFood,LandScapeT[i][j].Food+math.ceil(amountFlamableMaterial(i*METAMAP_RES,j*METAMAP_RES)/100))
			end
		end
		GG.LandScapeT=LandScapeT
	end
	
	Boolfire=false
	function gadget:GameFrame(frame)
		
		if frame % 50 == 0 then
			updateWind()
			bigdelayMap=generateRandomDelayMap(bigFireTable,5)	
			delayMap=generateRandomDelayMap(fireT,9)		
		end
		
		if frame % 15 > 0 and frame % 15 < 5 then
			drawPermaFlames_AddDamage(bigdelayMap, math.max(1,frame %5))
		end
		
		
		if frame % 12 > 0 and frame % 12 < 9 then
			Boolfire= drawFlames_AddDamage(delayMap, math.max(1,frame %12))
		end
		
		if frame % 100 == 0 then
			addFiresFromGG()
			updateFire()	
		end
		
		if frame % 333== 0 then
			addRareSFX()
			
			if fireCounter > 0 and Boolfire==true then
				Spring.PlaySoundFile("sounds/gadgetsound/wildfire1.ogg",1.0)
			end
			
			if fireCounter > METAMAP_RES then mergeSmallFiresToPermaFire()	end
		end
		
		if fireCounter== 0 and frame % 400 == 0 then
			regrowFlameableMaterial()
		end
		
	end
	
	
end