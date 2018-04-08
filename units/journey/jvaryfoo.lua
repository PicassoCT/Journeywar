local unitName = "jvaryfoo"
local unitDef = {
	name = "Varyfoo",
	Description = " hungry, always so hungry, nibblin at the hoops <Assault>",
	objectName = "varyFoo.s3o",
	script = "varyfooscript.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 350,
	buildCostEnergy = 150,
	buildTime = 15,
	--Health
	maxDamage = 950,
	idleAutoHeal = 12,
	--Movement
	Acceleration = 3,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 15,
	MaxVelocity = 1.4,
	MaxWaterDepth = 2000,
	MovementClass = "jinfantry",
	TurnRate = 450,
	mass=900,
	
	
	sightDistance = 500,
	upright=false,
	Builder = false,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,

	 LeaveTracks = true, 
	trackType ="jBug",
	 trackStrength=4,
	trackWidth =32,
	trackOffset =0,
	
	weapons = {
		[1]={name = "jvaryfoomark",
			onlyTargetCategory = [[ LAND ]],
		},
		[2]={name = "jvaryjump",
			onlyTargetCategory = [[LAND]],
		},
	},
	
	Category = [[LAND]],
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:bloodspray",
			"custom:jvaryfoohit",
			"custom:jvaryfoohit2"
			
		},
		
	},
	
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })