local unitName = "jmeggstack"
local unitDef = {
	name = "Eggstack",
	Description = "grows construction Units from limitted amount of Eggs.",
	objectName = "jeggstack.s3o",
	script = "jmobileEggstackscript.lua",
	buildPic = "eggstack.png",
	buildCostMetal = 200,
	buildCostEnergy = 50,
	
	--Health
	maxDamage = 1200,
	idleAutoHeal = 3,
	--Movement
	buildTime = 50,
	--Health
	maxDamage = 2300,
	idleAutoHeal = 3,
	--Movement
	Acceleration = 0.4,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 5,
	MaxVelocity = 0.5,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	TurnRate = 200,
	isMetalExtractor = false,
	sightDistance = 500,
	nanocolor=[[0.2 0.9 0.5]],
	onoffable=true,
	activateWhenBuilt =false,
	Builder = false,
	CanAttack = false,
	CanGuard = false,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = true, 
	
	Category = [[LAND]],
	
	EnergyStorage = 0,
	EnergyUse = 15,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 25, 
	MetalMake = 0,	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", 
			"custom:bloodspray",
			"custom:greenlight",
			"custom:waterdrop",
			
			
			
		},
	},
	
	
	
}

return lowerkeys({ [unitName] = unitDef })