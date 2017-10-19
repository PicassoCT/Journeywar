local unitName = "coperatrans"
local unitDef = {
	--Internal settings
	BuildPic = "filename.bmp",
	ObjectName = "operatrans.s3o",
	name = "Operatransport",
	Description= "transports Units, carrys Waterbombs",
	Side = "CentrAIl",
	script = "operatransscript.lua",
	
	--cost
	buildCostMetal = 1200,
	buildCostEnergy = 900,
	BuildTime = 82,
	--Health
	maxDamage =1950,
	idleAutoHeal = 0,
	--Movement
	Acceleration = 0.5,
	BrakeRate = 0.4,
	FootprintX = 4,
	FootprintZ = 4,
	TEDClass = [[VTOL]],
	steeringmode = [[1]],
	maneuverleashlength = 1380,
	turnRadius		 	= 8,
	dontLand		 	= false,
	MaxVelocity = 2.5,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	crashDrag = 0.02,
	canCrash=true,
	TurnRate = 250,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	bankingAllowed = true,
	hoverAttack =true,
	verticalSpeed=1.0,
	factoryHeadingTakeoff = true,
	Builder = false,
	canHover=true,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = true,--alt
	upright = true,
	airHoverFactor = 0.1,
	cruiseAlt=65,--165,
	CanFly = true,
	CanLand = false,
	canSubmerge = false,

	--maxBank=0.4,
	myGravity =0.5,
	mass = 1225,
	canSubmerge = false,
	
	collide = true,
	
	transportUnloadMethod = 0,
	transportByEnemy = false,
	transportCapacity = 5,
	transportSize = 30000,
	
	--Ressourcing
	EnergyStorage = 800,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 150, 
	MetalUse = 3,
	MakesMetal = 0, 
	MetalMake = 0,	 
	
	Category = [[LAND AIR]],
	
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 
	ShowNanoSpray = false,
	CanBeAssisted = false,
	CanReclaim=false,	
	
	customParams = {},
	
	--Hitbox
	collisionVolumeOffsets = "0 0 0",
	collisionVolumeScales = "35 60 90",
	collisionVolumeTest = 1,
	collisionVolumeType = "box",
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factory_explosion",	 
		},	
	},
	--Weapons and related
	
	weapons = {
		[1]={name = "cOperaCannon",
			onlyTargetCategory = [[ LAND ]],
		},
		[2]={name = "cOperaCannon",
			onlyTargetCategory = [[ LAND ]],
		},
		[3]={name = "cwaterbombs",
			onlyTargetCategory = [[ WATER]],
		},	
		[4]={name = "cwaterbombs",
			onlyTargetCategory = [[ WATER]],
		},	
		
	},
}
return lowerkeys({ [unitName] = unitDef })