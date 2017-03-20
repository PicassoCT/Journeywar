local unitName = "jmotherofmercy"

local unitDef = {
	name = "Mother of Mercy",
	Description = "Shepards asteroid gardens",
	objectName = "jMotherOfMercy.s3o",
	script = "jMotherOfMercyScript.lua",
	buildPic = "jmotherofmercy.png",
	
	
	--cost
	buildCostMetal = 260,
	buildCostEnergy = 130,
	buildTime = 6,
	--Health
	maxDamage = 1900,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 0.5,
	fireState=1,
	BrakeRate = 1,
	FootprintX = 3,
	FootprintZ = 3,
	TEDClass = [[VTOL]],
	steeringmode = [[1]],
	maneuverleashlength = 1380,
	turnRadius		 	= 8,
	dontLand		 	= false,
	MaxVelocity = 2.5,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 350,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	CanFly = true,
	showNanoFrame=false,
	
	
	Builder = false,
	--canHover=true,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = false,
	onOffable = true,
	LeaveTracks = false, 
	cruiseAlt=265,
	
	ActivateWhenBuilt=0,
	maxBank=0.4,
	myGravity =0.5,
	mass = 1225,
	useSmoothMesh =true,
	canSubmerge = true,
	collide = true,
	crashDrag =0.035,
	
	
	customParams = {},
	sfxtypes = {				
		explosiongenerators = {				 
			"custom:dirt",
			"custom:bloodspray",				
			"custom:jmomexaust"				
		},
	},
	
	weapons = {
		[1]={name = "jmomtractor",
			onlyTargetCategory = [[LAND]],
		},
		
		
		
	},
	
	Category = [[AIR]],
	
}

return lowerkeys({ [unitName] = unitDef })