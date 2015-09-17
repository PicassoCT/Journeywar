local unitName = "cgatefort"
local unitDef = {
name = "Gatefotress",
Description = "Trainfortress travelling between Worlds",
objectName = "cGateFotress.s3o",
script = "cgatefotressscript.lua",
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
	explodeAs="cArtDM",
	selfDestructAs="cArtDM", 



Reclaimable = true,
	


-- Pathfinding and related
	MaxWaterDepth=70,
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
[1]={name  = "cgaterailgun",
	onlyTargetCategory = [[ LAND]],
[2]={name  = "catapult",
	},
	onlyTargetCategory = [[ LAND]],
	},
[3]={name  = "catapult",
	onlyTargetCategory = [[ LAND]],
	},
[4]={name  = "cimpulstower",
	onlyTargetCategory = [[ LAND AIR]],
	},
[5]={name  = "cimpulstower",
	onlyTargetCategory = [[ LAND AIR]],
	},
[6]={name  = "cimpulstower",
	onlyTargetCategory = [[ LAND AIR]],
	},
[7]={name  = "cimpulstower",
	onlyTargetCategory = [[ LAND AIR]],
	},


	},
Category = [[LAND]],

}
return lowerkeys({ [unitName] = unitDef })

