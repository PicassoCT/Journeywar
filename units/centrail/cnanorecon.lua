local unitName = "cnanorecon"

local unitDef = {
	name = "Swarming Nano Bots",
	Description = "harvest Ressources to call a new Citadell through a Portal <Sabotage Harass Reconquisita Unit>",
	objectName = "cNanoRecon.s3o",
	script = "cNanoReconScript.lua",
	buildPic = "cbg.png",
	moveState =3,
	fireState=2,
	--cost
	buildCostMetal = 105,
	buildCostEnergy = 200,
	buildTime = 120,
	--Health
	maxDamage = 240,
	idleAutoHeal = 3,
	--Movement
	mass=120,
	upright=true,
	Acceleration = 8,
	BrakeRate = 2,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 62,
	MaxVelocity = 2.8,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	TurnRate = 850,
	nanocolor=[[0.7 0 0.1]],
	sightDistance = 550,
	onoffable=true,
	ActivateWhenBuilt=0,
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	strafeToAttack=true,
	shownanoframe=0,
	corpse = "bgcorpse",
	
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:AR2Impact",
			"custom:AR2Muzzle",
			"custom:AR2Projectile",
			"custom:bloodspray"
		},
		
	},
	
	
	
	Category = [[LAND]],
	
	weapons = {
		[1]={name = "ceater",
			onlyTargetCategory = [[ LAND AIR]],
		},
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })