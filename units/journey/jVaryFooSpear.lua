local unitName = "jvaryfoospear"
local unitDef = {
	name = "Ahab",
	Description = "From the bottom of hell i stab at thee",
	objectName = "jvaryspear.s3o",
	script = "varyfoospear_script.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 350,
	buildCostEnergy = 150,
	buildTime = 15,
	--Health
	maxDamage = 150,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 3,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 15,
	MaxVelocity = 1.4,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 450,
	mass=1050,
	
	 LeaveTracks = true, 
	trackType ="jBug",
	 trackStrength=1,
	trackWidth =32,
	trackOffset =0,
	
	sightDistance = 500,
	upright=true,
	Builder = false,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,

	
	
	weapons = {
		[1]={name = "jvaryspear",
			onlyTargetCategory = [[ LAND ]],
		},
		
	},
	
	Category = [[LAND]],
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:bloodspray",
			
		},
		
	},
	
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })