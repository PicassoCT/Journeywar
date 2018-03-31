local unitName = "jbutterfly"

local unitDef = {
	name = "el 'Iah",
	Description = " respawns the Eliah after enough time has passed <Assault>",
	objectName = "jbutterfly.s3o",
	script = "jbutterfly.lua",
	buildPic = "placeholderj.png",
	
	
	
	buildCostMetal = 260,
	buildCostEnergy = 130,
	buildTime = 6,
	--Health
	maxDamage = 350,
	idleAutoHeal = 10,
	AutoHeal = 5,
	--Movement
	Acceleration = 0.1,
	BrakeRate = 1,
	FootprintX = 1,
	FootprintZ = 1,
	TEDClass = [[VTOL]],
	steeringmode = [[1]],
	maneuverleashlength = 1380,

	turnRadius		 	= 8,
	dontLand		 	= true,
	MaxVelocity = 3.141,
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
	Canstop = false,
	LeaveTracks = false, 
	CanLand= false,

	CanFly = true,
	ActivateWhenBuilt=1,
	maxBank=0.4,
	myGravity =0.5,
	mass = 1225,
	canSubmerge = false,
	useSmoothMesh =false,
	collide = true,
	crashDrag =0.1,
	airHoverFactor = 15,
	cruiseAlt = 25,
	Category = [[AIR LAND]],
}

return lowerkeys({ [unitName] = unitDef })