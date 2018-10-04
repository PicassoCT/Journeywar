local unitName = "skinfantrydecoy"

local unitDef = {
	name = "Skinfantry",
	Description = "Infantry in Biosuits, using Shardgun and Birdrockets <Assault>",
	objectName = "skInfantry.s3o",
	script = "skInfantry.lua",
	buildPic = "skinfantry.png",
	decoyFor = "skinfantry",
	
	--cost
	buildCostMetal = 110,
	buildCostEnergy = 350,
	buildTime = 9,
	--Health
	maxDamage = 320,
	idleAutoHeal = 3,
	maxWaterdepth= 50,
	--Movement
	mass=720,
	Acceleration = 1.4,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope =72,
	MaxVelocity = 2.25,
	strafeToAttack =true,
	
	--cloaking
	canCloak =true,
	cloakCost= 0,
	cloakCostMoving =0,
	minCloakDistance =15,
	
	onoffable=true,
	
	MovementClass = "jinfantry",
	TurnRate = 1000,
	upRight=true,
	sightDistance = 630,
	corpse="jbiocorpse",
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	nanocolor=[[0.2 0.9 0.5]],
	Category = [[LAND]],
	
	
}

return lowerkeys({ [unitName] = unitDef })