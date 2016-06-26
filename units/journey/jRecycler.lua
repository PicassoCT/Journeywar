local unitName = "jrecycler"

local unitDef = {
	name = "Recycler",
	Description = "Shepards asteroid gardens",
	objectName = "jRecycler.s3o",
	script = "jrecyclerscript.lua",
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
	dontLand		 	= true,
	MaxVelocity = 2.5,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 150,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	CanFly = true,
	
	CanReclaim=true,
	reclaimSpeed=22,
	buildDistance = 2048,
	Builder = false,
	--canHover=true,
	CanAttack = false,
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
	
	
	
	Category = [[AIR]],
	
	
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })