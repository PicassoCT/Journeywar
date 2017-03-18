local unitName = "callygator"

local unitDef = {
	name = "Allygator",
	Description = "swallows small Units alive with a Portal",
	objectName = "cAllygator.s3o",
	script = "cAllygatorScript.lua",
	buildPic = "conair.dds",
	--floater = true,
	--cost
	buildCostMetal = 760,
	buildCostEnergy = 530,
	buildTime = 6,
	--Health
	maxDamage = 4550,
	idleAutoHeal = 0,
	--Movement
	Acceleration = 0.5,
	BrakeRate = 1,
	FootprintX = 3,
	FootprintZ = 3,
	TEDClass = [[VTOL]],
	steeringmode = [[1]],
	maneuverleashlength = 1380,
	turnRadius		 	= 80,
	dontLand		 	= false,
	MaxVelocity = 2.1,
	MaxWaterDepth = 50,
	MovementClass = "Default2x2",
	TurnRate = 150,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	crashDrag = 0.02,
	canCrash=true,
	collisionVolumeScales		= [[23 30 62]],
	collisionVolumeOffsets	= [[-5 -8 3]],
	collisionVolumeTest	 = 1,
	collisionVolumeType	 = [[box]],
	
	NoWeapon=false,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	
	
	Builder = false,
	--canHover=true,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = false,
	LeaveTracks = false, 
	cruiseAlt=85,
	CanFly = true,
	ActivateWhenBuilt=1,
	maxBank=0.4,
	myGravity =0.5,
	mass = 1225,
	canSubmerge = true,
	useSmoothMesh =true,
	collide = true,
	
	smoothAnim = true,
	transportByEnemy = false,
	transportCapacity = 5,
	transportSize = 30000,
	
	
	
	Category = [[AIR]],
	
	--Weapons and related
	
	weapons = {
		[1]={name = "callygatormarker",
			onlyTargetCategory = [[ LAND ]],
		},
	},
	
	customParams = {},
	
	sfxtypes = {
		explosiongenerators = {
			"custom:conairexaust",
			
			
			
			
		},
		
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })