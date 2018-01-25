local unitName = "jspacebornembryo"

local unitDef = {
	name = "Spaceborn Emybro",
	Description = "Behemoth Birth ",
	objectName = "jSpaceBornEmbryo.s3o",
	script = "jEmbryoScript.lua",
	buildPic = "placeholderj.png",
	levelGround =false,
	--cost
	buildCostMetal = 15,
	buildCostEnergy = 1,
	buildTime = 1,
	--Health
	maxDamage = 100,
	idleAutoHeal = 0,
	autoheal=0,
	--Movement
	mass=180020,
	upRight=true,
	Acceleration = 0.0000001,
	BrakeRate = 0.0001,
	FootprintX = 0,
	FootprintZ = 0,
	MaxSlope = 90,
	yardmap="yyoyyyoooyoooooyoooyyyoyy",
	MaxWaterDepth = 15,
	MovementClass = "Default2x2",
	TurnRate = 1,
	pushResistant=true,
	sightDistance = 80,
	
	reclaimable=true,
	Builder = false,
	CanAttack = true,
	CanGuard = false,
	CanMove = false,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = false,
	useSmoothMesh = false,
	
	corpse = "lavafeature",
	
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factory_explosion",
			"custom:flames",
			"custom:glowsmoke",
			"custom:blackerthensmoke",
			"custom:LightUponSmoke", 
		},
		
	},
	
	
	
	Category = [[LAND]],
	
	
	
	
} return lowerkeys({ [unitName] = unitDef })