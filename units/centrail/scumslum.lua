local unitName = "scumslum"

local unitDef = {
  name               = "Scumslum",
  Description = " adds Securitybudget to keep the new citizens in line <Security Production>",
  objectName         = "scumslum.s3o",
  	buildPic = "scumslum.dds",
  script= "cscumslum.lua",
	buildCostMetal = 180,
	buildCostEnergy = 90,
	buildTime = 70,
	MaxSlope = 5,
	
	maxdamage = 900,
	idleAutoHeal = 3,
	FootprintX = 8,
	FootprintZ = 6,


	MaxWaterDepth = 5,
	category=[[LAND]],
	nanocolor=[[0 0.9 0.9]],
	radardistance=0,
	sightDistance = 500,

	EnergyStorage = 50,
	EnergyUse = 5,
	MetalStorage = 0,
	EnergyMake = 48, 
	MakesMetal = 0, 
	MetalMake = 0,	
	
	explodeAs = "defaultweapon",
	selfDestructAs= [[NOWEAPON]],
	weapons = {
[1]={name  = "NOWEAPON",
	},
},

	
	
	
	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
      "custom:factory_explosion",
    },
  }
}

return lowerkeys({ [unitName] = unitDef })