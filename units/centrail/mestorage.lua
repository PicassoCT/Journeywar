local unitName = "mestorage"

local unitDef = {
  maxdamage=600,
  name               = "Depot",
  Description = "stores Material and Securitybudget <Material Storage Building>",
  objectName         = "mestorage.s3o",
  script= "mestoscript.lua",
   corpse             = "bgcorpse",
  EnergyStorage = 750,
  
  buildCostMetal = 250,
	buildCostEnergy = 250,
	buildTime = 15,
  
	EnergyUse = 5,
	MetalStorage = 750,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	FootprintX = 5,
	FootprintZ = 5,
	MaxSlope = 50,
	onoffable  = true,
	ActivateWhenBuilt=1,
  nanocolor=[[0 0.9 0.9]],
	
	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat", 
  Category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })