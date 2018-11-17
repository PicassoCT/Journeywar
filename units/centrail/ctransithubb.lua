local unitName = "ctransithubb"

local unitDef = {
	name = "Transit Hub Exit:",
	Description = "Transports Hubbuildings Counterpart <Teleportation Building>",
	objectName = "ctransitnode.s3o",
	script = "transitnodeExit.lua",
	buildPic = "ctransithubb.png",
	--cost
	buildCostMetal = 950,
	buildCostEnergy = 750,
	buildTime = 35,
	--Health
	maxDamage = 3950,
	mass=1024,
	idleAutoHeal = 25,
	idletime=3000,
	--Movement
	FootprintX = 12,
	FootprintZ = 12,
	MaxSlope = 50,
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
	blocking=false,
	sightDistance = 600,
	nanocolor=[[0 0.9 0.9]],
	levelGround = false,
	NoWeapon=true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	CanAttack = true,
	CanGuard = true,
	category = [[LAND BUILDING]],
	mass = 49999,

	CanMove = false,
	CanPatrol = false,
	CanStop = true,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			
		},
		
	},
	
	
	
	
	Category=[[LAND BUILDING]],	
	
	
}

return lowerkeys({ [unitName] = unitDef })