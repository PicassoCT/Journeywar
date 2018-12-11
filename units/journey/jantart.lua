local unitName = "jantart"

local unitDef = {
	name = "Anthill Artillery",
	Description = " fires Accid Ants Weddings at the Enemy <Long Range Artillery>",
	objectName = "jantart.s3o",
	script = "jantart.lua",
	buildPic = "jantart.png",
	--cost
	moveState =0,
	buildCostMetal = 810,
	buildCostEnergy = 460,
	buildTime = 14,
	--Health
	mass=4000,
	maxDamage = 680,
	idleAutoHeal = 0,
	--Movement
	Acceleration = 0.3,
	BrakeRate = 0.3,
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 60,
	MaxVelocity = 2.1,
	MaxWaterDepth = 50,
	floater=true,
	MovementClass = "HOVER2x2",
	
	TurnRate = 400,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	highTrajectory = 1,
	
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	upright = false,
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = true, 
	trackType ="antihill",
	trackStrength=0.6,
	trackWidth =64,
	trackOffset =22,
	Category = [[LAND]],
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:jantseverywhere",
			"custom:jlessants",
		},
	},
	
	
	weapons = {
		[1]={name = "jacidants",
			onlyTargetCategory = [[LAND]],
		},
		[2]={name = "jinfectants",
			onlyTargetCategory = [[LAND]],
		},
		
		
	},
}

return lowerkeys({ [unitName] = unitDef })