local unitName = "chedgehog"

local unitDef = {
	name = "Hedgehog Experimental",
	Description = "massive Landdestroyer firing miniature Universes",
	objectName = "chedgehog.s3o",
	script = "cHedgeHog.lua",
	buildPic = "crestrictor.dds",
	--cost
	buildCostMetal = 380,
	buildCostEnergy = 120,
	buildTime = 9,
	--Health
	maxDamage = 1250,
	idleAutoHeal = 1,
	--Movement
	Acceleration = 0.1,
	BrakeRate = 0.3,
	FootprintX = 9,
	FootprintZ = 9,
	MaxSlope = 10,
	MaxVelocity = 0.31415,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 90,
	mass=42000,
	sightDistance = 100,
	nanocolor=[[0 0.9 0.9]],
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = true, 
	turnInPlace =false,
	onOffable=true,
	Category = [[LAND]],
	
	trackType ="cRes",
	trackStrength=12,
	trackWidth =80,
	
	
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", 
			"custom:chedgehogfired",
		},
	},
	
	
	weapons = {
		[1]={name = "cuniversegun",
			onlyTargetCategory = [[LAND]],
		},
		
	},
}

return lowerkeys({ [unitName] = unitDef })