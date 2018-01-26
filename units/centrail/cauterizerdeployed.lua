local unitName = "cauterizerdeployed"

local unitDef = {
	name = "Cauterizer(deployed)",
	Description = "Combat Drone <Areal Denial Unit>",
	objectName = "cauterizer.s3o",
	script = "cauterizerdeployedscript.lua",
	buildPic = "placeholder.dds",
	
	--cost
	buildCostMetal = 1500,
	buildCostEnergy = 800,
	buildTime = 26,
	--Health
	maxDamage =1950,
	idleAutoHeal = 0,
	--Movement
	Acceleration = 1.9,
	BrakeRate = 1,
	FootprintX = 3,
	FootprintZ = 3,
	steeringmode = [[1]],
	maneuverleashlength = 1380,
	turnRadius		 	= 16,
	dontLand		 	= false,
	MaxVelocity = 8.5,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 250,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	
	airstrafe=true,
	factoryHeadingTakeoff =true,
	Builder = false,
	--canHover=true,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = true,--alt
	LeaveTracks = false, 
	
	cruiseAlt=175,
	CanFly = true,
	ActivateWhenBuilt=1,
	--maxBank=0.4,
	myGravity =0.5,
	mass = 6025,
	canSubmerge = false,
	useSmoothMesh =true,
	collide = true,
	--crashDrag =0.1,
	--airHoverFactor=0.1,
	airStrafe =true,
	hoverAttack = true,
	verticalSpeed= 5.0,
	factoryHeadingTakeoff =false,
	strafeToAttack=true,
	
	Category = [[AIR]],
	
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 
	ShowNanoSpray = false,
	CanBeAssisted = false,
	CanReclaim=false,	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:chopperdirt", --1024
			"custom:choppermuzzle",
			"custom:flyinggrass",
			"custom:blackerthensmoke",--1027
			"custom:330rlexplode",--1028	
			"custom:dronedrivemuzzle"
		},		
	},
		
	weapons = {
		[1]={name = "mtwMachineGun",
			MainDir = [[0 -1  0]],
			onlyTargetCategory = [[ LAND]],
			turret = false,
			
		},
		
		[2]={name = "suicidestarburst",
			onlyTargetCategory = [[ LAND]],
			MainDir = [[0 1 0]],
			MaxAngleDif = 50,			
		},		
	},	
}

return lowerkeys({ [unitName] = unitDef })