local unitName = "skinfantry"

local unitDef = {
	name = "skInfantry",
	Description = "Infantry in BioMechSuit",
	objectName = "skInfantry.s3o",
	script = "skInfantry.lua",
	buildPic = "skinfantry.png",
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
	cloakCost=0.01,
	cloakCostMoving =999,
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
	
	weapons = {
		[1]={name = "birdrocket",
			onlyTargetCategory = [[ LAND AIR]],
		},
		[2]={name = "SIprojectiles",
			onlyTargetCategory = [[ LAND]],
		},
	},
}

return lowerkeys({ [unitName] = unitDef })