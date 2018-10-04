local unitName = "gasteroids"

local unitDef = {
	name = "asteroids",
	Description = "",
	objectName = "Asteroid.s3o",
	script = "asteroidsscript.lua",
	buildPic = "placeholder.png",
	--cost
	buildCostMetal = 350,
	buildCostEnergy = 150,
	buildTime = 15,
	--Health
	maxDamage = 350,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 3,
	BrakeRate = 1,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 15,
	MaxVelocity = 2.4,
	MaxWaterDepth = 2000,
	MovementClass = "Default2x2",
	TurnRate = 450,
	mass=500,
	
	
	sightDistance = 500,
	upright=false,
	Builder = false,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = false, 
	
	Category = [[LAND]],
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:bloodspray",
			
		},
		weapons = {
			[1]={name = "zombiehorseclosecombat",
				onlyTargetCategory = [[LAND]],
			},
		},	
	},
	
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })