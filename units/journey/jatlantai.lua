local unitName = "jatlantai"

local unitDef = {
	name = "lan'Tai ",
	Description = "drawing energy from Attacked Units Team",
	objectName = "jEthief.s3o",
	script = "jethiefscript.lua",
	--script = "pieceMaker.lua",
	buildPic = "placeholderj.png",
	--floater = true,
	--cost
	buildCostMetal = 2260,
	buildCostEnergy = 4130,
	buildTime = 190,
	--Health
	maxDamage = 880,
	idleAutoHeal = 1,
	--Movement
	Acceleration = 0.5,
	fireState=1,
	BrakeRate = 1,
	FootprintX = 3,
	FootprintZ = 3,
	TEDClass = [[VTOL]],
	canSubmerge = false,
	floater = true,
	waterline = 3,
	
	airStrafe =false,
	hoverAttack = true,
	factoryHeadingTakeoff  = false,
	strafeToAttack=true, 	
	steeringmode = [[1]],
	maneuverleashlength = 1380,
	turnRadius		 	= 8,
	dontLand		 	= false,
	MaxVelocity = 4.5,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 150,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	CanFly = true,
	
	--canHover=true,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = false,
	onOffable = true,
	LeaveTracks = false, 
	cruiseAlt=128,
	
	ActivateWhenBuilt=0,
	maxBank=0.4,
	myGravity =0.5,
	mass = 1225,
	canSubmerge = false,
	useSmoothMesh 		= true,
	collide = true,
	crashDrag =0.035,
	
	Category = [[AIR]],
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:flyingfeather",
			"custom:bloodspray",
			
			
			
			
		},
		
	},
	
	
	weapons = {
		[1]={name = "jethiefweapon",
			onlyTargetCategory = [[LAND]],
		},
		
	},	
	
}

return lowerkeys({ [unitName] = unitDef })