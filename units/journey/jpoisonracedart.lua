local unitName = "jpoisonracedart"

local unitDef = {
	name = "Poisonous Race Dart",
	Description = "Poisonous Dart",
	objectName = "jPoisonRacedart.s3o",
	script = "jracedartscript.lua",
	buildPic = "jplaceholder.png",
	--cost
	buildCostMetal = 550,
	buildCostEnergy = 250,
	buildTime = 5,
	--Health
	maxDamage = 1600,
	mass=1024,
	idleAutoHeal =0,
	--Movement
	Acceleration = 4.5,
	BrakeRate = 0.0000000000000000003,
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 60,
	MaxVelocity = 4.5,
	MaxWaterDepth = 100,
	MovementClass = "Default2x2",
	TurnRate = 1100,
	
	sightDistance = 500,
	nanocolor=[[0 0.9 0.9]],
	selfDestructCountdown =0,
	hideDamage =true,
	
	CanAttack = true,
	CanGuard = true,
	
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	
	explodeAs="cantimatter",
	selfDestructAs="cantimatter", 
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:poisonteal",	 
		},	
	},
	
	Category = [[LAND]],
	
	weapons = {	
			[1]={name = "jpoisondartw",
			onlyTargetCategory = [[LAND]]
			},
	},
}

return lowerkeys({ [unitName] = unitDef })