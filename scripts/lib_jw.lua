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
FactoryTypes[UnitDefNames["eggstackfac"].id]=true
FactoryTypes[UnitDefNames["jmovingfac1"].id]=true
return FactoryTypes
end

--I want it all
FactoryTypes[UnitDefNames["jtrafactory"].id]=true
FactoryTypes[UnitDefNames["eggstackfac"].id]=true
FactoryTypes[UnitDefNames["jmovingfac1"].id]=true
FactoryTypes[UnitDefNames["fclvlone"].id]=true
FactoryTypes[UnitDefNames["fclvl2"].id]=true
FactoryTypes[UnitDefNames["condepot"].id]=true
return FactoryTypes

end

function getPyroProofTable(UnitDefNames)
FireProofTypes={}
FireProofTypes[UnitDefNames["css"].id]=true
FireProofTypes[UnitDefNames["jfireflower"].id]=true
FireProofTypes[UnitDefNames["citadell"].id]=true
FireProofTypes[UnitDefNames["beanstalk"].id]=true
return FireProofTypes
end

function getTreeTypeTable(UnitDefNames)
FactoryTypes={}
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
BattleTypes[UnitDefNames["operatrans"].id]=true
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

	 -- metalMake,   metalUse,  energyMake,   energyUse=Spring.GetUnitResources(unitID)
	
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

--===================================================================================================================
