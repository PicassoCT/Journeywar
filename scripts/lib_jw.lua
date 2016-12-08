


--===================================================================================================================
--Journeywar specific functions 
--> creates a table from names to check unittypes against
function getTypeTable(UnitDefNames,StringTable)
	local Stringtable=StringTable
	retVal={}
	for i=1,#Stringtable do
		assert(UnitDefNames[Stringtable[i]], "Error: Unitdef of Unittype "..Stringtable[i].. " does not exists")
		retVal[UnitDefNames[Stringtable[i]].id]=true
	end
	return retVal
end

--> JW specific function returning the factorys of the game
function getFactoryTypeTable(UnitDefNames,IWant)
	FactoryTypes={}	
	
	
	if IWant=="c" then
		FactoryTypes[UnitDefNames["fclvlone"].id]=true
		FactoryTypes[UnitDefNames["fclvl2"].id]=true
		FactoryTypes[UnitDefNames["condepot"].id]=true
		return FactoryTypes
	end
	
	if IWant=="j" then
		FactoryTypes[UnitDefNames["jtrafactory"].id]=true
		FactoryTypes[UnitDefNames["jtransportedeggstack"].id]=true
		FactoryTypes[UnitDefNames["jmovingfac1"].id]=true
		return FactoryTypes
	end
	
	--I want it all
	FactoryTypes[UnitDefNames["jtrafactory"].id]=true
	FactoryTypes[UnitDefNames["jtransportedeggstack"].id]=true
	FactoryTypes[UnitDefNames["jmovingfac1"].id]=true
	FactoryTypes[UnitDefNames["fclvlone"].id]=true
	FactoryTypes[UnitDefNames["fclvl2"].id]=true
	FactoryTypes[UnitDefNames["condepot"].id]=true
	return FactoryTypes
	
end

function getAirUnitTable(UnitDefNames)
	retTab={}
	retTab[UnitDefNames["callygator"].id]=true
	retTab[UnitDefNames["conair"].id]=true
	retTab[UnitDefNames["chunterchopper"].id]=true
	retTab[UnitDefNames["csuborbital"].id]=true
	retTab[UnitDefNames["cgunship"].id]=true
	
	retTab[UnitDefNames["gnewsdrone"].id]=true
	
	retTab[UnitDefNames["jsunshipfire"].id]=true
	retTab[UnitDefNames["jmotherofmercy"].id]=true
	retTab[UnitDefNames["jsempresequoia"].id]=true
	retTab[UnitDefNames["jrecycler"].id]=true
	retTab[UnitDefNames["beanstalk"].id]=true
	retTab[UnitDefNames["jatlantai"].id]=true
	retTab[UnitDefNames["jwatchbird"].id]=true
	
	return reTab
end
function getPyroProofTable(UnitDefNames)
	FireProofTypes={}
	FireProofTypes[UnitDefNames["jfiredancebomb"].id]=true
	FireProofTypes[UnitDefNames["jsunshipfire"].id]=true
	FireProofTypes[UnitDefNames["css"].id]=true
	FireProofTypes[UnitDefNames["jfireflower"].id]=true
	FireProofTypes[UnitDefNames["citadell"].id]=true
	FireProofTypes[UnitDefNames["beanstalk"].id]=true
	FireProofTypes[UnitDefNames["jtree3"].id]=true
	return FireProofTypes
end

function getTreeTypeTable(UnitDefNames)
	FactoryTypes={}
	FactoryTypes[UnitDefNames["jscrapheap_tree"].id]=true
	FactoryTypes[UnitDefNames["jtree2"].id]=true
	FactoryTypes[UnitDefNames["jtree2activate"].id]=true
	FactoryTypes[UnitDefNames["jtree3"].id]=true
	FactoryTypes[UnitDefNames["jtree41"].id]=true
	FactoryTypes[UnitDefNames["jtree42"].id]=true
	FactoryTypes[UnitDefNames["jtree43"].id]=true
	FactoryTypes[UnitDefNames["jtree44"].id]=true
	FactoryTypes[UnitDefNames["jtree45"].id]=true
	FactoryTypes[UnitDefNames["jtree46"].id]=true
	FactoryTypes[UnitDefNames["jtree47"].id]=true
	FactoryTypes[UnitDefNames["jtree48"].id]=true
	FactoryTypes[UnitDefNames["jtree"].id]=true
	return FactoryTypes
end

function getPokerTypeTable(UnitDefNames)
	BattleTypes={}
	BattleTypes[UnitDefNames["art"].id]=true
	BattleTypes[UnitDefNames["cadvisor"].id]=true
	BattleTypes[UnitDefNames["campro"].id]=true
	BattleTypes[UnitDefNames["csniper"].id]=truer
	BattleTypes[UnitDefNames["cgunship"].id]=true
	BattleTypes[UnitDefNames["cichneumonidae"].id]=true
	BattleTypes[UnitDefNames["strider"].id]=true
	BattleTypes[UnitDefNames["coperatrans"].id]=true
	BattleTypes[UnitDefNames["mtw"].id]=true
	BattleTypes[UnitDefNames["res"].id]=true
	BattleTypes[UnitDefNames["zombie"].id]=true
	BattleTypes[UnitDefNames["gfreeman"].id]=true
	
	BattleTypes[UnitDefNames["jbeefeater"].id]=true
	BattleTypes[UnitDefNames["jglowworm"].id]=true
	BattleTypes[UnitDefNames["jbugcreeper"].id]=true
	BattleTypes[UnitDefNames["jeliah"].id]=true
	BattleTypes[UnitDefNames["jcrabcreeper"].id]=true
	BattleTypes[UnitDefNames["jgalatea"].id]=true
	BattleTypes[UnitDefNames["jghostdancer"].id]=true
	
	BattleTypes[UnitDefNames["jhivehound"].id]=true
	BattleTypes[UnitDefNames["jresistancewarrior"].id]=true
	BattleTypes[UnitDefNames["jswiftspear"].id]=true
	BattleTypes[UnitDefNames["jviciouscycler"].id]=true
	BattleTypes[UnitDefNames["jwatchbird"].id]=true
	BattleTypes[UnitDefNames["tiglil"].id]=true
	BattleTypes[UnitDefNames["vort"].id]=true
	return BattleTypes
end
function getInfantryTypeTable()
	Infantry={}
	Infantry[UnitDefNames["bg"].id]=true
	Infantry[UnitDefNames["bg2"].id]=true
	Infantry[UnitDefNames["tiglil"].id]=true
	Infantry[ UnitDefNames["skinfantry"].id]=true
	Infantry[ UnitDefNames["jhivehound"].id]=true
	Infantry[ UnitDefNames["vort"].id]=true
	Infantry[ UnitDefNames["css"].id]=true
	return Infantry
end

function getNeutralTypeTable()
	TypeTable={}
	TypeTable[UnitDefNames["ggluemine"].id]=true
	TypeTable[UnitDefNames["ghohymen"].id]=true
	TypeTable[UnitDefNames["gcar"].id]=true
	TypeTable[UnitDefNames["jmadmax"].id]=true
	return TypeTable
end


function getCorpseTypeTable()
	Creep={}
	Creep[UnitDefNames["gzombiehorse"].id]=true
	Creep[UnitDefNames["zombie"].id]=true
	Creep[UnitDefNames["hc"].id]=true
	return Creep
end
function getJourneyCorpseTypeTable()
	TypeTable={}
	TypeTable[UnitDefNames["gjbigbiowaste"].id]=true
	TypeTable[UnitDefNames["gjmeatballs"].id]=true
	TypeTable[UnitDefNames["gjmedbiogwaste"].id]=true
	return TypeTable
end
function getCentrailCorpseTypeTable()
	TypeTable={}
	TypeTable[UnitDefNames["gcvehiccorpse"].id]=true
	TypeTable[UnitDefNames["gcvehiccorpsemini"].id]=true
	return TypeTable
end
function getCorpseTypeTable()
	CorpseTable=getJourneyCorpseTypeTable()
	for key,v in pairs(getCentrailCorpseTypeTable()) do
		CorpseTable[key]=true
	end
	return CorpseTable
end

function getJourneyCreeperTypeTable()
	Creep={}
	Creep[UnitDefNames["jhoneypot"].id]=true
	Creep[UnitDefNames["jbugcreeper"].id]=true
	Creep[UnitDefNames["jcrabcreeper"].id]=true
	Creep[UnitDefNames["jsungodcattle"].id]=true
	return Creep
end

function getCentrailCreeperTypeTable()
	Creep={}
	Creep[UnitDefNames["gzombiehorse"].id]=true
	Creep[UnitDefNames["zombie"].id]=true
	Creep[UnitDefNames["hc"].id]=true
	return Creep
end
function getCreeperTypeTable()
	CreepTable=getJourneyCreeperTypeTable()
	
	for key,v in pairs(getCentrailCreeperTypeTable()) do
		CreepTable[key]=true
	end
	
	return CreepTable
end

function getRecycleableUnitTypeTable()
	 TransportTable={
	[UnitDefNames["gjbigbiowaste"].id ]=true,
	[UnitDefNames["gjmedbiogwaste"].id ]=true,
	[UnitDefNames["gcvehiccorpse"].id ]=true,
	[UnitDefNames["gcvehiccorpsemini"].id ]=true,
	[UnitDefNames["gjmeatballs"].id ]=true,
	[UnitDefNames["gseastar"].id ]=true
	}

return TransportTable
end

function getRewardTable()
 Rewards ={
	[UnitDefNames["gjmeatballs"].id ] = {	ereward=1000
	,mreward=500},	
	[UnitDefNames["gjmedbiogwaste"].id ] = {	ereward=1000
	,mreward=500},
	[UnitDefNames["tiglil"].id] = {ereward=100
	,mreward=100},
	[UnitDefNames["skinfantry"].id] = {ereward=100
	,mreward=100},
	[UnitDefNames["gjbigbiowaste"].id ] = {	ereward=2000
	,mreward=1000},
	[UnitDefNames["vort"].id ] = {},
	[UnitDefNames["gtreetrunk"].id] = {},
	[UnitDefNames["gcvehiccorpsemini"].id ] = {	mreward=1000
	,ereward=500},
	[UnitDefNames["gcvehiccorpse"].id] = {	mreward=2000,
	ereward=1000},
	[UnitDefNames["gzombiehorse"].id] = {	mreward=2000,
	ereward=1000},
	[UnitDefNames["ghohymen"].id] = {	mreward=2000,
	ereward=1000},
	[UnitDefNames["bg"].id] = {ereward=100
	,mreward=100},
	[UnitDefNames["bg2"].id] = {ereward=100
	,mreward=100},
	[UnitDefNames["css"].id] = {ereward=100
	,mreward=100}
	
}
return Rewards

end
function setDenial(key)
	if not GG.jw_denyCommunication then GG.jw_denyCommunication = {} end
	if not GG.jw_denyCommunication[key] then GG.jw_denyCommunication[key]=true end
end

-->denies a tree - withdraw percentage of health of the invested resources
function deactivateAndReturnCosts(key,UnitDef,ratio,delay)
	local lratio= ratior or 1
	ldelay = delay or 2000
	
	Sleep(ldelay)
	if not GG.jw_denyCommunication then GG.jw_denyCommunication = {} end
	GG.jw_denyCommunication[key]=false
	local boolThreadEnded=false
	
	while boolThreadEnded == false do
		
		if GG.jw_denyCommunication[key]==true then
			
			-- metalMake, metalUse, energyMake, energyUse=Spring.GetUnitResources(unitID)
			
			defID=Spring.GetUnitDefID(unitID)
			if not defID then return end
			health,maxhealth=Spring.GetUnitHealth(unitID)
			if not health then return end
			ecosts=UnitDef[defID].energyMake*(health/maxhealth)
			mcosts =UnitDef[defID].metalMake*(health/maxhealth)
			
			teamID=Spring.GetUnitTeam(key)
			if not teamID then return end
			
			Spring.AddTeamResource(teamID,"m",math.abs(mcosts*lratio))
			Spring.AddTeamResource(teamID,"e",math.abs(ecosts*lratio))
			x,y,z=Spring.GetUnitPosition(unitID)
			
			Spring.SetUnitResourcing(key,"ume",0)
			Spring.SetUnitResourcing(key,"umm",0)
			Spring.SetUnitResourcing(key,"uue",1)
			
			x,y,z=Spring.GetUnitPosition(key)
			Spring.SpawnCEG("jtreedenial" ,x,y+150,z,0,1,0,50,0)
			Spring.PlaySoundFile("sounds/jtree/denial.ogg",1.0)
			boolThreadEnded=true
		end
		Sleep(250)
	end
	
end
--
-->StartThread(dustCloudPostExplosion,unitID,1,600,50,0,1,0)
--Draws a long lasting DustCloud
function dustCloudPostExplosion(unitID,Density,totalTime,SpawnDelay, dirx,diry,dirz)
	x,y,z=Spring.GetUnitPosition(unitID)
	y=y+15
	firstTime=true
	for j=1,totalTime,SpawnDelay do
		for i=1, Density do		
			Spring.SpawnCEG("lightuponsmoke",x,y,z,dirx,diry,dirz)	
		end
		
		
		Sleep(SpawnDelay)		
	end
	Sleep(550-totalTime)
	
	if math.random(0,1)==1 then
		Spring.SpawnCEG("earcexplosion",x,y+30,z,0,-1,0)		
	end
end

function getBuiLuxSoundScapeDefinition()
	
	soundScapeDefinition={}
	soundScapeDefinition.opener={
		[1]=1000,
		[2]=1000,
		[3]=1000,
		[4]=1000
	}
	
	soundScapeDefinition.closer={
		[1]=1000,
		[2]=1000
	}
	
	soundScapeDefinition.background={
		[1]=10000,
		[2]=10000,
		[3]=10000,
		[4]=10000,
		[5]=10000,
		[6]=10000
	}
	--1sec9_2sec12_4sec21_8sec22_10sec25_16sec26
	soundScapeDefinition.solo={}
	for i=1, 27, 1 do
		
		soundScapeDefinition.solo[i]=1
		if i >= 9 then soundScapeDefinition.solo[i]=2	end
		if i >= 12 then soundScapeDefinition.solo[i]=4 end
		if i >=21 then soundScapeDefinition.solo[i]=8 end
		if i >= 22 then soundScapeDefinition.solo[i]=16 end
		if i >= 25 then soundScapeDefinition.solo[i]=20 end
		soundScapeDefinition.solo[i]=soundScapeDefinition.solo[i]*1000
	end
	
	return soundScapeDefinition
	
end

function spawnFlareCircle(unitID)
	spiralcenter =piece "spiralcenter"
	fireFx =piece "fireFx"
	x,y,z=Spring.GetUnitPosition(unitID)
	local spSpawnCEG=Spring.SpawnCEG
	
	
	temp=25
	max=600
	allReadyImpulsed={}
	while(temp < 350 ) do
		Move(fireFx,x_axis,temp,0)
		temp=temp+18.4
		for i=1, 360, 1 do
			holyRandoma=math.random(0,1)
			if holyRandoma==1 then
				Turn(spiralcenter,y_axis,math.rad(i),0,true)
				x,y,z=Spring.GetUnitPiecePosDir(unitID,fireFx)
				if y < 0 then y = 1 end
				
				if math.random(0,4)==2 then
					spSpawnCEG("csuborbscrap",x,y,z,0,1,0,0)
				else
					spSpawnCEG("portalflares",x,y,z,0,1,0,0)
				end
			end
		end
		
		Units=Spring.GetUnitsInCylinder(x,z, temp)
		table.remove(Units, unitID)
		if Units then
			for i=1, #Units do 
				if 	Units[i] ~= unitID and not allReadyImpulsed[Units[i]] then
					allReadyImpulsed[Units[i]]=true
					defID= Spring.GetUnitDefID(Units[i])
					mass= UnitDefs[defID].mass
					if mass < 500 then
						
						Spring.AddUnitImpulse(Units[i],0, mass/100,0) 
					end
				end
			end
		end
		
		Turn(spiralcenter,y_axis,math.rad(0),0,true)
		Sleep(2)
	end
	
end

function portalStormWave(unitID)
	local spSpawnCEG=Spring.SpawnCEG
	ax,ay,az=Spring.GetUnitPosition(unitID)
	spSpawnCEG("portalspherespawn",ax,ay+50,az,0,1,0,0)	
	
	StartThread(spawnFlareCircle,unitID)
	
	for i=1, 2 do
		Sleep(50*i)
		spSpawnCEG("portalspherespawn",ax,ay+50,az,0,1,0,0)	
	end
	
end

function groupOnFire(DictionaryOfUnits,argtimeToburnMin, argtimeToburnMax)
	
	timeToburnMax= argtimeToburnMax or 1000
	timeToburnMin = argtimeToburnMin or 150
	
	if GG.OnFire == nil then GG.OnFire={} end
	--	Spring.Echo("jw_projectileimpacts: Fire WeaponfDetected")
	boolInsertIt=true
	--very bad sollution n-times
	for k,v in pairs(DictionaryOfUnits) do
		DictionaryOfUnits[k]=true
	end
	
	for i=1, table.getn(GG.OnFire), 1 do
		if 	GG.OnFire[i][1]	~= nil and	DictionaryOfUnits[GG.OnFire[i][1]] then
			GG.OnFire[i][2]=math.ceil(math.random(timeToburnMin,timeToburnMax)) 
			DictionaryOfUnits[GG.OnFire[i][1]]=false						
		end
	end
	
	for k,v in pairs(DictionaryOfUnits) do
		if v== true then
			GG.OnFire[#GG.OnFire+1]={}
			GG.OnFire[#GG.OnFire][1]=k
			GG.OnFire[#GG.OnFire][2]=math.ceil(math.random(timeToburnMin,timeToburnMax)) 
		end
	end
	
end

function setOnFire(unitID, argtimeToburnMin, argtimeToburnMax)
	
	timeToburnMax= argtimeToburnMax or 1000
	timeToburnMin = argtimeToburnMin or 15
	
	if not GG.OnFire  then GG.OnFire={} end
	--	Spring.Echo("jw_projectileimpacts: Fire WeaponfDetected")
	
	--very bad solution n-times
	for i=1, table.getn(GG.OnFire), 1 do
		if 	GG.OnFire[i][1]	~= nil and	GG.OnFire[i][1]	== unitID then
			GG.OnFire[i][2]= math.ceil(math.random(timeToburnMin,timeToburnMax)) 
			break
		else
			GG.OnFire[#GG.OnFire+1]={}
			GG.OnFire[#GG.OnFire][1]=unitID
			GG.OnFire[#GG.OnFire][2]=math.ceil(math.random(timeToburnMin,timeToburnMax))  
			break
		end
	end
	
end



-->Attack Nearest Non-Gaia Enemy
function defaultEnemyAttack(unitID,SignalMask, delayTime)
	Signal(SIG_DEFAULT)
	SetSignalMask(SIG_DEFAULT)
	gaiaTeam=Spring.GetUnitTeam(unitID)
	Sleep(15000)
	delayTime=delayTime or 1500
	
	while true do
		Sleep(delayTime)
		ed=Spring.GetUnitNearestEnemy(unitID)
		if ed and Spring.GetUnitTeam(ed) ~= gaiaTeam then
			x,y,z=Spring.GetUnitPosition(ed)
			if x then
				Spring.SetUnitMoveGoal(unitID,x,y,z)
			end
		end
	end
end

--=======================================Tech Tree=============================================================

function getCombinNewTechTree()
		return {["origin"]={
			["cupgshield"]={lvl=0, unlocks={}, unlockedBy=""},
			["cadvisorstalker"]={lvl=0, unlocks={},unlockedBy=""},
			["ccontrainheal"]={lvl=0, unlocks={},unlockedBy=""},
			["cresthumper"]={lvl=0, unlocks={},unlockedBy=""}
		}
	}			
end

function getSideNewTechTree(team, side)
	if not GG.orgTechTree then GG.orgTechTree={} end
	
	if not GG.orgTechTree[team] and side == "centrail" then 
		GG.orgTechTree[team]=getCombinNewTechTree() 
		flattenTechTree(team)
	end
	
	if not GG.orgTechTree[team] and side == "journeyman" then 
		GG.orgTechTree[team]={} 
		flattenTechTree(team)
	end	
end

function flattenTechTree(team)
	if not GG.TechTree then GG.TechTree ={} end
	GG.TechTree[team] ={}
	
	local Tree = GG.orgTechTree[team][origin]
	if not Tree then GG.TechTree[team]={} ; return end
	
	for key,values in pairs(Tree) do
		if Tree[values.unlockedBy] and Tree[values.unlockedBy].lvl > 0 then 
			GG.TechTree[team][key]=values.lvl
		else
			GG.TechTree[team][key]=0
		end
	end
	
	return 
end

function alterTechTree(team, TechName, funcModifier, boolOverride)
	parent=GG.orgTechTree[team]["origin"][TechName].unlockedBy
	
	if GG.orgTechTree[team]["origin"][parent].lvl > 0 or boolOverride == true then
		GG.orgTechTree[team]["origin"][TechName].lvl= funcModifier(GG.orgTechTree[team]["origin"][TechName])
		flattenTechTree(team)
	end
end


function checkOnTech(team, TechName)
	if not 	GG.TechTree or not 	GG.TechTree[team] or not 	GG.TechTree[team][TechName] then return 0
	else
		return GG.TechTree[team][TechName] 
	end
	
end

function createTechTree(teams)
	for i=1, #teams do
		--get side
		 _,_,_,ai,side = Spring.GetTeamInfo(teams[i])
		--erect new tech tree
		getSideNewTechTree(teams[i],side)	
	end
end

