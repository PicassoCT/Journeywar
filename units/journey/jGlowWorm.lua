local unitName = "jglowworms"

local unitDef = {
	name = "Fireflys",
	Description = "dangerous near immortal Insectoids",
	objectName = "jGlowSwamp.s3o",
	script = "jGlowWormScript.lua",
	buildPic = "jglowworm.png",
	--cost
	buildCostMetal = 55,
	buildCostEnergy = 100,
	buildTime = 3,
	--Health
	maxDamage = 400,
	idleAutoHeal = 5,
	--Movement
	onOffable = true,
	ActivateWhenBuilt=false,
	
	upright=false,
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
	
	cancloak=true,
	cloakCost=2.7,
	
	mass=600,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	
	upright=false,
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	
	Category = [[LAND]],
	
	
	weapons = {
		[1]={name = "jglowproj",
			onlyTargetCategory = [[LAND]],
		}
	},
	
	
	
	
	strafeToAttack=true,
	
	
}
return lowerkeys({ [unitName] = unitDef })