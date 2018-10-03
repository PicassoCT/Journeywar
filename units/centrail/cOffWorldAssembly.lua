local unitName = "coffworldassembly"

local unitDef = {
	name = "OffWorld Assembly",
	Description = "assembles forbidden Technology Units for the centrail confederacy <Heavy Synth Construction Factory>",
	TEDClass = "PLANT",
	
	
	
	objectName = "coffworldAssembly.s3o",
	script = "cOffWorldAssemblyscript.lua",
	buildPic = "cfc2.dds",
	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat",
	
	corpse = "bgcorpse",
	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = 1,
	
	nanocolor=[[0.9 0.2 0]],
	
	--cost
	buildCostMetal = 2600,
	buildCostEnergy = 1300,
	buildTime = 27,
	--Health
	maxDamage = 850,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 25,
	FootprintZ = 25,
	MaxSlope = 20,
	
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	
	corpse = "bgcorpse",
	radardistance=150,
	sightDistance = 700,
	
	EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 0,	
	
	
	CanAttack = false,
	CanGuard = true,
	CanMove = false,
	CanPatrol = true,
	CanStop = false,
	LeaveTracks = false, 
	
	Builder = true,
	ShowNanoSpray = true,
	CanBeAssisted = true,
	CanReclaim=true,	
	workerTime = 0.64,
	buildDistance = 200,
	terraformSpeed = 50,
	
	-- Pathfinding and related
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	YardMap ="ooyyoo".. 
			 "oyyyyo".. 
			 "yyyyyy"..
			 "yyyyyy"..
			 "oyyyyo".. 
			 "ooyyoo",
	
	-- Building	
	Builder = true,
	Reclaimable = false,
	
	workerTime = 1,
	buildoptions = 
	{		
		"strider","ccrabsynth", "chunter",
		"cauterizer","paxcentrail","cgatefort",
		"cnanorecon",
	},
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			
			"custom:factorywarp", --1024
			"custom:factorysfx", --1024
			--
			
		},
	},
	
	Category = [[LAND BUILDING]],
}
return lowerkeys({ [unitName] = unitDef })