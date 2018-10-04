local unitName = "jhunter"

local unitDef = {
	name = "Sungods Shepard",
	Description = "Small Tripod <Assault>",
	objectName = "jHunter.s3o",
	script = "jhunterscript.lua",
	buildPic = "jhunter.png",

	--cost
	buildCostMetal = 2500,
	buildCostEnergy = 1200,
	buildTime = 50,
	--Health
	maxDamage = 3200,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 0.25,
	BrakeRate = 0.3,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 90,
	MaxVelocity = 1.8,
	MaxWaterDepth = 65,
	MovementClass = "Default2x2",
	TurnRate = 1250,

	sightDistance = 900,
	upright=false,
	onoffable=true,
	activateWhenBuilt =false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = true, 

	Builder = false,
	ShowNanoSpray = true,
	CanBeAssisted = false,
	CanReclaim=false,	

		explodeAs = [[NOWEAPON]],
		selfDestructAs= [[NOWEAPON]], 
	 
	 
	Category = [[LAND]],

	weapons = {
	[1]={name  = "jdartgun",
		onlyTargetCategory = [[LAND]],
		mainDir=[[0 0 1]],--nerfed
		maxAngleDif        = 90,--nerfed
		},
},
}

return lowerkeys({ [unitName] = unitDef })