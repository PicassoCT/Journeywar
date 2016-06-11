local unitName = "mbeanstalk"

local unitDef = {
	name = "Mobile Beanstalk",
	Description = " use Ability to resettle",
	objectName = "beanstalk.s3o",
	script = "mbeanstalkscript.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 12,
	buildTime = 5,
	--Health
	maxDamage = 2500,
	idleAutoHeal = 5,
	--Movement
	Acceleration = 0.25,
	BrakeRate = 0.3,
	FootprintX = 5,
	FootprintZ = 5,
	MaxSlope = 20,
	MaxVelocity = 0.5,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	TurnRate = 50,
	onOffAble=true,
	upRight=true,
	radardistance=750,
	sightDistance = 700,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 5,	
	
	
	CanAttack = false,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	nanocolor=[[0.2 0.9 0.5]],
	Builder = false,
	ShowNanoSpray = false,
	CanBeAssisted = false,
	CanReclaim=false,	
	
	Category = [[LAND BUILDING]],
	
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factory_explosion",
			"custom:flames",
			"custom:glowsmoke",
			"custom:glowsmoke",
			"custom:dirt",
			"custom:blackerThenSmoke",
			"custom:greenSparks",--1030
			"custom:leaves", --1031 
			"custom:beanstalkgrowth", --1032 
		},
	}
	
	
}

return lowerkeys({ [unitName] = unitDef })