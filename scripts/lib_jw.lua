--===================================================================================================================
--Game specific functions
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

--===================================================================================================================
