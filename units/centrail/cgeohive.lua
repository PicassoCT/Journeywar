local unitName = "geohive"

local unitDef = {
  name               = "Underground City",
  Description = "rebuilds civilisation upon Destruction <Spawns Buildings> ",
  objectName         = "geohive.s3o",
  buildPic = "cgeohive .png",
  script="cgeohive.lua",
   MaxDamage = 1500,
   MaxDamage = 1500,
	
	
	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = false,
	--cost
	buildCostMetal = 200,
	buildCostEnergy = 150,
	buildTime =12,
	--economy	
	EnergyStorage = 0,
	EnergyUse = 5,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	nanocolor=[[0 0.9 0.9]],
	onoffable=true,
	ActivateWhenBuilt=0,

	explodeAs="cartdarkmat",
	selfDestructAs= [[NOWEAPON]],

-- Internal settings	

-- Unit limitations and properties

	
	

-- Pathfinding and related
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 10,	
  
  yardmap="ooo ogo ooo",
  }

return lowerkeys({ [unitName] = unitDef })