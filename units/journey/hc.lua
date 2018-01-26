local unitName = "hc"

local unitDef = {
	name = "Headcrab",
	Description = "revives dead Units as Zombies",
	objectName = "hc.s3o",
	script = "hcscript.lua",
	buildPic = "hc.png",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 0,
	buildTime = 5,
	--Health
	maxDamage = 350,
	idleAutoHeal = 3,
	--Movement
	Acceleration = 3,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 15,
	MaxVelocity = 2,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 350,
	
	sightDistance = 500,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	blocking = false,

	Builder = true,
	CanAttack = true,
	CanRepair=false,
	CanAssist=false,
	canReclaim=false,
	CanGuard = true,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = false, 
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", --Thumper
			"custom:bloodspray",	
			
		},
		
	},
	
	
	Category = [[LAND]],
	
	weapons = {
		[1]={name = "hcProjectile",
			onlyTargetCategory = [[LAND]],
		},
	},
}

return lowerkeys({ [unitName] = unitDef })