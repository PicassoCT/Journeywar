local unitName = "strider"

local unitDef = {
	name = "Strider",
	Description = "heavy Synth Tripod <Tank Unit>",
	objectName = "strider.s3o",
	script = "striderscript.lua",
	buildPic = "strider.png",
	--cost
	buildCostMetal = 2500,
	buildCostEnergy = 1200,
	buildTime = 120,
	--Health
	maxDamage = 10500,
	idleAutoHeal = 2,
	--Movement
	Acceleration = 0.25,
	BrakeRate = 0.3,
	FootprintX = 5,
	FootprintZ = 5,
	MaxSlope = 80,
	MaxVelocity = 1.4,
	MaxWaterDepth = 65,
	MovementClass = "allterrain",
	TurnRate = 250,
	hideDamage = true,
	sightDistance = 1100,
	usePieceCollisionVolumes = true,
	strafeToAttack = true,
	blocking = false,
	upright=true,
	onoffable=true,
	activateWhenBuilt =false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = true, 
	
	Builder = false,
	ShowNanoSpray = true,
	CanBeAssisted = false,
	CanReclaim=false,	
	showNanoFrame = false,
	
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
	
	
	Category = [[LAND]],
	
	weapons = {
		[1]={name = "stridergun",
			onlyTargetCategory = [[LAND]],
			mainDir=[[0 0 1]],--nerfed
			maxAngleDif = 90,--nerfed
		},
		[2]={name = "warpcannon",
			onlyTargetCategory = [[LAND]],
			mainDir=[[0 0 1]],--nerfed
			maxAngleDif = 120,--nerfed
		},
	},
}

return lowerkeys({ [unitName] = unitDef })