local unitName = "cRailGun"

local unitDef = {
  name               = "Railgun",
  objectName         = "cRailGun.s3o",
  description= "powerfull, longrange base Defenses.<Long Range Defense Building>",
  script ="cRailGund.lua",
  buildPic = "crailgun.dds",
  	RadarDistance = 25,
	SightDistance = 200,
  
	buildCostMetal = 980,
	buildCostEnergy = 1250,
	buildTime = 54,
	
	maxDamage = 1900,
	idleAutoHeal = 1,
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
------------------------------
	canPatrol = false,
nanocolor=[[0 0.9 0.9]],
ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,	
	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat", 



Reclaimable = true,
	


-- Pathfinding and related

   FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 500,	
	

-- Building	
	Builder = false,



--custom UnitDefParameter

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:dirt",
	   "custom:railGunCeg",
	   "custom:cRailSparks",
	   "custom:snipercooloff",
	
	   
						  },
	
				},



weapons = {
[1]={name  = "cRailGun",
	onlyTargetCategory = [[ LAND]],
	},
	},
Category = [[LAND]],

}

return lowerkeys({ [unitName] = unitDef })