local unitName = "condepot"

local unitDef = {
Category=[[LAND BUILDING]],		

--TEDClass = "PLANT",
	script = "condepotscript.lua",
	buildPic = "condepot.dds",
  name               = "Construction Unit Depot ",
  objectName         = "condepot.s3o",
  	Description = "  builds Construction Units. Set to support the citadell. <Construction Unit Factory>",
	MaxDamage = 1500,
	category =[[LAND BUILDING]],
	corpse             = "cInfantryCorpse",
	RadarDistance = 10,
	SightDistance = 400,	
	Upright = 1,	
	levelground = 1,
  --cost
	buildCostMetal = 620,
	buildCostEnergy = 300,
	buildTime =42,
		--economy	
	EnergyStorage = 0,
	EnergyUse = 55,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 




-- Internal settings	

-- Unit limitations and properties

	
	

-- Pathfinding and related
	FootprintX = 11,
	FootprintZ = 8,
	MaxSlope = 50,	
	YardMap ="ooocccccooo occccccccco occccccccco ccccccccccc  ccccccccccc occccccccco occccccccco ooocccccooo",

--------------------------------------	

ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,	
Reclaimable = true,

CanBeAssisted = false,	
workerTime = 1.00,
buildDistance = 200,
terraformSpeed = 50,

nanocolor=[[0 0.9 0.9]],

	
-- Building	
	Builder = true,
	CanReclaim=false,
    Reclaimable = false,
	ShowNanoSpray = false,
	CanBeAssisted = false,	
	workerTime = 0.5,
	onoffable     = true,
	ActivateWhenBuilt=1,
	
	buildoptions = 
	{
	"conair","contrain","contruck",
	},
}

return lowerkeys({ [unitName] = unitDef })