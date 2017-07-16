local unitName = "gShit"

local unitDef = {
	name = "Shit",
	Description = "he was delicious and now smells vicious",
	objectName = "theShit.s3o",

	script = "transportable.lua",
	buildPic = "placeholder.png",
	--cost
	buildCostMetal = 200,
	buildCostEnergy = 50,
	buildTime =1,
	--Health
	maxDamage = 666,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 1,
	FootprintZ = 1,
	
	--MaxVelocity = 0.5,
	MaxWaterDepth =400,
	--MovementClass = "Default2x2",--
	
	cantBeTransported=false,
	
	transportByEnemy =true,
	sightDistance = 50,
	
	reclaimable=true,
	Builder = false,
	CanAttack = false,
	CanGuard = false,
	CanMove = false,
	CanPatrol = false,
	CanStop = false,
	

	Category = [[NOTARGET]],
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	acceleration = 0,
	
	
	levelGround = false,
	mass = 9900,
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:330rlexplode",
			"custom:flames",
			"custom:glowsmoke",
			"custom:vehsmokepillar",
			"custom:vehsmokepillar",
			"custom:vortflames",--1029
			"custom:volcanolightsmall",--1030
			"custom:cburningwreckage",--1031
			--
			--Bulletof The Cannon
		},
		
	},
	
	
}
return lowerkeys({ [unitName] = unitDef })