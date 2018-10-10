local unitName = "gvolcano"

local unitDef = {
	name = "Volcan",
	Description = " He who diggs to deep... Dont stare.. run..",
	objectName = "volcano.s3o",
	script = "gVolcano.lua",
	buildPic = "placeholder.png",
	--cost
	buildCostMetal = 200,
	buildCostEnergy = 50,
	buildTime =1,
	--Health
	maxDamage = 666000,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 4,
	FootprintZ = 4,
	levelground = 1,
	--MaxVelocity = 0.5,
	MaxWaterDepth =20,
	--MovementClass = "Default2x2",--
	TurnRate = 200,
	isMetalExtractor = true,
	sightDistance = 300,
	
	reclaimable=true,
	Builder = true,
	CanAttack = false,
	CanGuard = false,
	CanMove = false,
	CanPatrol = false,
	CanStop = false,
	LeaveTracks = false,
	
	YardMap ="yyyy yyyy yyyy yyyy",
	
	-- Building	
	ShowNanoSpray = false,
	CanBeAssisted = true,	
	workerTime = 1,
	buildoptions = 
	{
		"glava"
	},
	
	
	usebuildinggrounddecal = true,
	
	buildinggrounddecaldecayspeed = 0.00002,
	buildinggrounddecalsizex = 26,
	buildinggrounddecalsizey = 26,
	buildinggrounddecaltype = "volcanodecal.dds",
	
	
	usebuildinggrounddecal = true,
	
	
	
	
	
	
	Category = [[LAND]],
	
	EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
	acceleration = 0,
	
	
	-- bmcode = [[0]],
	
	--
	
	
	--extractsMetal = 0.005,
	--floater = false,
	
	
	
	levelGround = false,
	mass = 99000,
	
	maxSlope = 255,
	
	
	noAutoFire = false,
	
	
	
	
	-- TEDClass = [[METAL]],
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", --1024
			"custom:fireSparks", --1025
			"custom:blackerthenSmoke",	--1026
			"custom:flames",				--1027
			"custom:LightUponSmoke",
			"custom:glowsmoke",
			"custom:ashflakes",--1030
			"custom:redSparks",--1031
			"custom:volcanolight",--1032
			"custom:spherespawn",--1032
			--
			--Bulletof The Cannon
		},
		
	},
	
	
	weapons = {
		[1]={name = "lavaBomb",
			onlyTargetCategory = [[LAND]],
		},
	},
	
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })