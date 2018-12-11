local unitName = "jresistanceoutpost"

local unitDef = {
name = "Resistance Outpost",
Description = "invisible to the enemy. Depends on the Enemy Building its attached to.<Stealth Factory>",

objectName = "jResistanceOut.s3o",
script = "jResistanceOutpost.lua",
buildPic = "jresistanceoutpost.png",
--cost
TEDClass = "PLANT",

	RadarDistance = 200,
	SightDistance = 600,	
	Upright = 1,	
	levelground = 1,

nanocolor=[[0 0.9 0.9]],

--cost
buildCostMetal = 900,
buildCostEnergy = 250,
buildTime = 36,
--Health
maxDamage = 4025,
idleAutoHeal = 500,
autoheal=1200,
stealth =true,
radarDistanceJam=2.0,
--Movement
cancloak=true,
cloakCost=0.0,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



MaxSlope = 20,

MaxWaterDepth = 0,
MovementClass = "Default2x2",






	

		EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	


CanPatrol = true,

ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,	
Reclaimable = false,

CanBeAssisted = false,	

buildDistance = 200,
terraformSpeed = 50,

-- Pathfinding and related
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 10,	
	YardMap ="oco ccc oco",

-- Building	
	Builder = true,
   
	
	
	workerTime = 0.54,
	buildoptions = 
	{
	"jresistancewarrior",
	},
	
	
Category = [[LAND BUILDING]],
}

return lowerkeys({ [unitName] = unitDef })