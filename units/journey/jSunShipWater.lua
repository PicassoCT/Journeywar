local unitName = "jsunshipwater"

local unitDef = {
	name = "Swimming Sunnship",
	name = "Swimming Sunnship",
	Description = "Waiting for the Sun to come up",
	objectName = "jSunShip.s3o",
	script = "jsunshipwaterScript.lua",
	buildPic = "placeholder.png",
	--cost
	buildCostEnergy = 600,
	buildCostMetal = 600,
	buildTime = 600,
	canAttack = true,
	canGuard = true,
	canMove = true,
	canPatrol = true,
	canstop = true,
	--Health
	
	idleAutoHeal = 3,
	--Movement
	mass=220,
	activateWhenBuilt = true,
	acceleration = 0.018,
	brakeRate = 0.225,
	collisionVolumeOffsets = [[0 0 0]],
	collisionVolumeScales = [[35 32 22]],
	collisionVolumeTest = 1,
	collisionVolumeType = [[box]],
	defaultmissiontype = [[Standby]],
	idleAutoHeal = 10,
	idleTime = 1800,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope =72,
	MaxVelocity = 4,
	
	
	sightDistance = 550,
	smoothAnim = true,
	sonarDistance = 450,
	steeringmode = true,
	TEDClass = [[WATER]],
	turninplace = 0,
	turnRate = 255,
	upright = true,
	waterline = 3,
	workerTime = 0,
	corpse = "cInfantryCorpse",
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	onoffable= true,
	ActivateWhenBuilt=false,
	maneuverleashlength = [[640]],
	
	maxDamage = 900,
	minWaterDepth = 1,
	movementClass = [[UBOAT3]],	
	nanocolor=[[0.2 0.9 0.5]],
	
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			
			"custom:bloodspray",
			
		},	
	},	
	
	Category = [[WATER]],	
	weapons = {
	}
	
	
}

return lowerkeys({ [unitName] = unitDef })