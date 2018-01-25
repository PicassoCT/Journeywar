local unitName = "jbeherith"

local unitDef = {
	name = "Beherith",
	Description = "giant Amphibious Behemoth able to transport Infantry <Tank Transport>",
	objectName = "beherith.s3o",
	script = "jbeherith.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 500,
	buildCostEnergy = 2500,
	buildTime = 70,
	hideDamage =true,
	--Health
	mass=60000,
	maxDamage = 66000,
	idleAutoHeal = 1,
	--Movement
	Acceleration = 0.15,
	BrakeRate = 0.01,
	FootprintX = 4,
	FootprintZ = 4,
	MaxSlope = 10,
	MaxVelocity = 2.4,
	MaxWaterDepth = 5000,
	MovementClass = "jBeherith",
	TurnRate = 20,
	onOffable = true,
	ActivateWhenBuilt=true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	transportByEnemy = false,
	transportCapacity = 5,
	transportSize = 7,
	
	nanocolor=[[0.7 0 0.1]],
	sightDistance = 500,
	
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	
	isFirePlatform =true,
	holdSteady =true,
	releaseHeld =true,
	transportUnloadMethod =2,
	loadingRadius =500, 
	Category = [[LAND]],
	
	 LeaveTracks = true, 
	trackType ="jBeherith",
	trackStrength=8,
	trackWidth =64,
	trackOffset =0,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", --Thumper
			"custom:bloodspray",
			"custom:waterspray",
			--sperm
			--Bulletof The Cannon
		},
		
	},
	
	
	weapons = {
		[1]={name = "beherithweapon",
			onlyTargetCategory = [[LAND]],
		},
		--impalor
		[2]={name = "beherithweapon",
			onlyTargetCategory = [[LAND]],
		},
		[3]={name = "beherithweapon",
			onlyTargetCategory = [[LAND]],
		},
		[4]={name = "beherithweapon",
			onlyTargetCategory = [[LAND]],
		},
		[5]={name = "beherithweapon",
			onlyTargetCategory = [[LAND]],
		},
		[6]={name = "jfootStomp",
			onlyTargetCategory = [[LAND]],
		},
		--throw
	},
	
}


return lowerkeys({ [unitName] = unitDef })