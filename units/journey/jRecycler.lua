local unitName = "jrecycler"

local unitDef = {
	name = "Cycleship",
	Description = "recycles enemy Units and remains from afar",
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

	
	CanReclaim=true,
	CanRepair=false,
	reclaimSpeed=22,
	buildDistance = 3000,
	ShowNanoSpray = true,
	workerTime = 0.005,
	Builder = true,
	--canHover=true,
	CanAttack = false,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = false,
	showNanoFrame=false,
	onOffable = true,
	LeaveTracks = false, 
	cruiseAlt=265,
	canassist=false,
	canRestore=false,
	
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