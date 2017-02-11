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
	
	maxDamage = 19900,
	idleAutoHeal = 12,
	onOffAble=true,
	ActivateWhenBuilt=1,
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
		[1]={name = "cgaterailgun",
			onlyTargetCategory = [[ LAND]],
			},
		[2]={name = "ccatapult",
			onlyTargetCategory = [[ LAND]],
			},		
		
		[3]={name = "ccatapult",
			onlyTargetCategory = [[ LAND]],
		},
		[4]={name = "cimpulstower",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[5]={name = "cimpulstower",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[6]={name = "cimpulstower",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[7]={name = "cimpulstower",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[8]={name = "ceater",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[9]={name = "ceater",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[10]={name = "ceater",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[11]={name = "ceater",
			onlyTargetCategory = [[ LAND AIR]],
		},
		
		
	},
	Category = [[LAND]],
	
}
return lowerkeys({ [unitName] = unitDef })