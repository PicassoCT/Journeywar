local unitName = "cWaterExtractor"
local unitDef = {
name = "Water Extractor",
Description = "Pumps Water Offworld",
objectName = "cWaterExtractor.s3o",
script = "c_WaterExtractor.lua",
buildPic = "cwater.dds",
--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 5,
--Health
maxDamage = 2500,
idleAutoHeal = 5,
--Movement
Acceleration = 0.25,
BrakeRate = 0.3,
FootprintX = 8,
FootprintZ = 8,
MaxSlope = 20,
MaxVelocity = 3.0,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 500,
nanocolor=[[0 0.9 0.9]],
radardistance=150,
sightDistance = 700,

EnergyStorage = 200,
	EnergyUse = 5,
	EnergyMake =25,
	MetalStorage = 0,
	
	MakesMetal = 0, 
	MetalMake = 0,	
	floater =true,
	minWaterDepth =10,
	waterline =5,
--[[
CanAttack = true,
CanGuard = false,
CanMove = false,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
onoffable=true,
activateWhenBuilt=true,
Builder = true,
ShowNanoSpray = true,
CanBeAssisted = true,

nanocolor="0 0 0", 
CanReclaim=true,	
workerTime = 0.002,
buildDistance = 1200,
terraformSpeed = 350,
SelfDestructAs="electric_explosion",
buildoptions = 
	{
	"builux","condepot","scumslum","campole",
	"efence","mestorage","buihoblock","geohive",
	"buibaislum","buibaicity","buibaicity2","mdigg","mbuilux",
	"fclvlone","fclvl2","bbind","cHopper",
	},
	
sounds = {
   ["underattack"] =
   {
   [1]={name  = "citadell/citadellAlarm",
	["id"] = 140,   			
    ["volume"] = 5,
	},
	}
		},
			]]	
explodeAs = "cartdarkmat",
	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:factory_explosion",
	   "custom:dirt",
	   "custom:electric_explosion",
	   "custom:sparkcloud",--1027
	   "custom:citadellfire",
	   "custom:citadellcloud",--1029
	   "custom:portalstorm",
	   "custom:portalground",
	   "custom:cwaterext",
	   
					  },
	
				},


Category=[[LAND BUILDING]],	


}
return lowerkeys({ [unitName] = unitDef })