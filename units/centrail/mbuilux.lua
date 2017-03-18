local unitName = "mbuilux"

local unitDef = {
maxdamage=1200,
  name               = "Expanded Luxery Appartments",
  objectName         = "mbuilux.s3o",
  description = "allocates more Materialbudget to the Fullcitizens.",
  script = "mbuiluxscript.lua",
  buildPic = "builux.dds",
	buildCostMetal =  2400,
	buildCostEnergy = 1800,
	buildTime =40,

  EnergyStorage = 800,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 150, 
	MetalUse = 3,
	MakesMetal = 0, 
	MetalMake = 0,	
	activateWhenBuilt= true,
	 explodeAs = [[NOWEAPON]],
	 selfDestructAs = [[NOWEAPON]],
	onoffable= true,
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	 corpse             = "bgcorpse",
	 
	 
nanocolor=[[0 0.9 0.9]],

Category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })