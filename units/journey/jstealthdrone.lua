local unitName = "jstealthdrone"

local unitDef = {
	name = "Gasgiant",
	Description = "stealthy Construction Exobiotic, using lifeforce to construct.<Construction>",
	objectName = "condrone.s3o",
	script = "jcondronescript.lua",
	buildPic = "conair.png",
	--floater = true,
	--cost
	buildCostMetal = 260,
	buildCostEnergy = 130,
	buildTime = 6,
	--Health
	maxDamage = 150,
	idleAutoHeal = 0,
	--Movement
	Acceleration = 0.5,
	BrakeRate = 1,
	FootprintX = 3,
	FootprintZ = 3,
	TEDClass            = [[VTOL]],
	steeringmode        = [[1]],
	maneuverleashlength = 1380,
	stealth=true,
	 cloakCost = 0.0,  
	 cloakCostMoving =0.5,
	  initCloaked=true,
	turnRadius		  	= 8,
	dontLand		 	= false,
	MaxVelocity = 2.5,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 150,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 500,
	  selfDestructAs ="defaultweapon",
	  explodeAs = "defaultweapon",





	Builder = true,
	--canHover=true,
	CanAttack = false,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop  = false,
	LeaveTracks = false, 
	cruiseAlt=165,
	CanFly   = true,
	ActivateWhenBuilt=1,
	maxBank=0.4,
	myGravity =0.5,
	mass                = 1225,
	canSubmerge         = false,
	useSmoothMesh =false,
	collide             = true,
	crashDrag =0.1,



	Category = [[AIR]],


	ShowNanoSpray = false,
	CanBeAssisted = true,
	CanReclaim=false,	
	workerTime = 0.4,
	buildDistance = 110,
	terraformSpeed = 0.2,

	buildoptions = 
		{

		},
	  customParams = {},
	 sfxtypes = {
		explosiongenerators = {
			--"custom:conDroneLightShadow",
			--"custom:conDroneMedShadow",
			--"custom:condronecloud",
			--"custom:conDroneShadow",
		   
		   
							  },
		
				},


}

return lowerkeys({ [unitName] = unitDef })