local unitName = "cwallbuilder"
local unitDef = {
	name = "Wallbuilder",
	Description = "builds and charges mobile Wall Units",
	objectName = "cWallBuilder.s3o",
	script = "cWallBuilder.lua",
	buildPic = "placeholder.png",
	--cost
	buildCostMetal = 1100,
	buildCostEnergy = 560,
	buildTime = 46,
	--Health
	maxDamage = 3500,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 0.25,
	BrakeRate = 0.3,
	FootprintX = 5,
	FootprintZ = 5,
	MaxSlope = 4,
	MaxVelocity = 0.25,
	MaxWaterDepth = 7,
	MovementClass = "Default2x2",
	TurnRate = 25,
	
	radardistance=150,
	sightDistance = 700,
	mass=3000,
	EnergyStorage = 200,
	EnergyUse = 35,
	MetalStorage = 0,
	EnergyMake = 13, 
	MakesMetal = 0, 
	MetalMake = 0,	
	
	
	CanBeAssisted = true,	
	
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = true,
	trackType ="wallbuild",
	trackStrength=12,
	trackWidth =96,
	
	onoffable=true, --used for turning the electricity on/off
	
	Builder = true,
	ShowNanoSpray = true,
	
	
	nanocolor=[[0.5 0.9 0.5]], --
	canRestore =true,
	CanReclaim=false,	
	workerTime = 0.1,
	buildDistance = 155,
	
	SelfDestructAs="electric_explosion",
	buildoptions = 
	{
		"efence","bonker","crailgun","geohive","chopper","combinedfeature","cdefusermine"
	},
	
	NoWeapon=false,
	explodeAs = "factory_explosion",
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factory_explosion",
			"custom:dirt",
			"custom:electric_explosion",
			"custom:sparkcloud",
			"custom:cwallbuildlight",--28
			"custom:cefencesplash"--29
		},
		
	},
	
	category=[[LAND]],
	
	weapons = {
		[1]={name = "cwallbuildw",
			onlyTargetCategory = [[LAND]],
		},
		[2]={name = "cwallbuildw",
			onlyTargetCategory = [[LAND]],
		},
		[3]={name = "cwallbuildw",
			onlyTargetCategory = [[LAND]],
		},
		[4]={name = "cwallbuildw",
			onlyTargetCategory = [[LAND]],
		},
	},
	
	
}
return lowerkeys({ [unitName] = unitDef })