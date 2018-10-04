local unitName = "paxcentrail"

local unitDef = {
	name = "Pax Centrail",
	Description = "Chaingang forced to fight by their families held hostage.<Ground Air Assault Unit>",
	objectName = "cPaxCentrail.s3o",
	script = "cPaxCentrailscript.lua",
	buildPic = "cpaxcentrail.png",
	moveState =2,
	 fireState=2,
	--cost
	buildCostMetal = 10500,
	buildCostEnergy = 20000,
	buildTime = 6,
	--Health
	maxDamage = 12000,
	idleAutoHeal = 3,
	--Movement
	mass=52000,
	upright=true,
	Acceleration = 0.1,
	BrakeRate = 2,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 62,
	MaxVelocity = 2.514,
	MaxWaterDepth = 90,
	MovementClass = "Default2x2",
	TurnRate = 250,
	nanocolor=[[0.7 0 0.1]],
	sightDistance = 550,
	activateWhenBuilt=false,
	maxWaterDepth = 60,
	onoffable=true,
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	strafeToAttack=true,
	shownanoframe= false,
	 corpse             = "bgcorpse",
	 
	 explodeAs = [[NOWEAPON]],
		selfDestructAs= [[NOWEAPON]], 
	 
	  customParams = {},
	 sfxtypes = {
		explosiongenerators = {
		  "custom:cbonkerplasma",
							  },		
				},
	 
	Category = [[LAND]],
	
	weapons = {
	[1]={name  = "cexplochaingun",
		onlyTargetCategory = [[LAND]],

		},

	[2]={name  = "cexpgun",
		onlyTargetCategory = [[LAND AIR]],
		
		
		},

	[3]={name  = "cexplochaingun",
		onlyTargetCategory = [[LAND]],
		

		},

	[4]={name  = "cexpgun",
		onlyTargetCategory = [[LAND AIR]],

		},

	[5]={name  = "crazorgrenade",
		onlyTargetCategory = [[LAND]],

		},
	[6]={name  = "crazorgrenade",
		onlyTargetCategory = [[LAND]],

		},
	[7]={name  = "citadelldrone",
		onlyTargetCategory = [[LAND]],

		},


		
		},
}

return lowerkeys({ [unitName] = unitDef })