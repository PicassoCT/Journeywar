local unitName = "cHopper"

local unitDef = {
  name               = "Hopper Mine Field",
  objectName         = "cHopperMinefield.s3o",
  script ="cHopper.lua",
  buildPic = "mines.dds",
  	RadarDistance = 25,
	SightDistance = 200,
  
	buildCostMetal = 180,
	buildCostEnergy = 150,
	buildTime = 24,
	
	maxDamage = 900,
	idleAutoHeal = 0,
	blocking =false,
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",	
------------------------------
	canPatrol = false,

ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,	

nanocolor=[[0 0.9 0.9]],


Reclaimable = true,
	


-- Pathfinding and related

	MaxSlope = 500,	
	

-- Building	
	Builder = false,



--custom UnitDefParameter

  FootprintX = 1,
FootprintZ = 1,
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:dirt",
	
	   
						  },
	
				},



weapons = {
[1]={name  = "cHopper",
	onlyTargetCategory = [[ LAND]],
	},

	
	
	},


}

return lowerkeys({ [unitName] = unitDef })