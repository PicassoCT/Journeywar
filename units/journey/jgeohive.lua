local unitName = "jgeohive"

local unitDef = {
name = "Drone Hive",
Description = "Spawns Creepers who autoattack",

objectName = "jgeohive.s3o",
script = "jgeohive.lua",
buildPic = "jgeohive.png",


	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = 1,



--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 5,
--Health
maxDamage = 150,
idleAutoHeal = 0,
--Movement

FootprintX = 5,
FootprintZ = 5,
MaxSlope = 20,
YardMap ="yyyyy yyyyy yyyyy yyyyy yyyyy",
MaxWaterDepth = 20,
MovementClass = "Default2x2",

  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


radardistance=150,
sightDistance = 700,

EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 0,	


CanAttack = false,
CanGuard = false,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 

Builder = true,
ShowNanoSpray = true,
CanBeAssisted = true,
CanReclaim=true,	
workerTime = 1.00,
buildDistance = 200,
terraformSpeed = 50,

-- Pathfinding and related
	FootprintX = 5,
	FootprintZ = 5,
	MaxSlope = 10,	
  

-- Building	
	Builder = true,
    Reclaimable = false,
	ShowNanoSpray = true,
	CanBeAssisted = true,	
	workerTime = 1,
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
     "custom:factory_explosion",
	 "custom:dirt",
	
	  
    },
	},

Category = [[LAND BUILDING]],
}

return lowerkeys({ [unitName] = unitDef })