local unitName = "jwatchbird"

local unitDef = {
	name = "Birds",
	Description = "observing enemy movements. Regenerate in Water. <Air Scout>",
	objectName = "jwatchbird.s3o",
	script = "jwatchbirdscript.lua",
	--script = "pieceMaker.lua",
	buildPic = "jwatchbird.png",
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

	BrakeRate = 1,
	FootprintX = 3,
	FootprintZ = 3,
	TEDClass = [[VTOL]],
	steeringmode = [[1]],
	maneuverleashlength = 1380,
	turnRadius		 	= 8,
	dontLand		 	= false,
	MaxVelocity = 2.5,
	MaxWaterDepth = 30,
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
	Canstop = true,
	
	LeaveTracks = false, 
	cruiseAlt=265,
	
	maxBank=0.4,
	myGravity =0.5,
	mass = 1225,
	canSubmerge = false,
	useSmoothMesh 		= false,
	collide = true,
	crashDrag =0.035,
	
	Category = [[AIR]],
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:flyingfeather",
			"custom:bloodspray",		
			"custom:dirt",		
			
			
		},
		
	},
	
	
	weapons = {
		[1]={name = "jbeanstalkphoenix",
			onlyTargetCategory = [[LAND]],
		},	
		
	},	
	
}

return lowerkeys({ [unitName] = unitDef })