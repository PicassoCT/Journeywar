local unitName = "cfireplace"

local unitDef = {
	name = "Camp",
	Description = "Stay in the light <Healing Kit>",
	objectName = "cFirePlace.s3o",
	script = "cFirePlaceScript.lua",
	buildPic = "placeholder.png",
	--cost
	buildCostMetal = 10,
	buildCostEnergy = 5,
	buildTime =1,
	--Health
	maxDamage = 16,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 1,
	FootprintZ = 1,
	
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
	--MovementClass = "Default2x2",--
	
	
	sightDistance = 3,
	
	reclaimable=true,
	Builder = false,
	CanAttack = false,
	CanGuard = false,
	CanMove = false,
	CanPatrol = false,
	CanStop = false,
	
	
	Category = [[LAND]],
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	acceleration = 0,
	levelGround = false,
	mass = 100,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {		
			"custom:vortflames",		
		},
		
	},
	
	
}
return lowerkeys({ [unitName] = unitDef })