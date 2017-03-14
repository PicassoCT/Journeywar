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
	maxDamage = 3950,
	mass=1024,
	idleAutoHeal =1,
	--Movement
	Acceleration = 4.5,
	BrakeRate = 0.0000000000000000003,
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 60,
	MaxVelocity = 4.5,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	TurnRate = 900,
	
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
			"custom:jdart",	 
		},	
	},
	
	Category = [[LAND]],
	
	weapons = {	
	},
}

return lowerkeys({ [unitName] = unitDef })