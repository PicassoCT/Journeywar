local unitName = "jdrilltree"

local unitDef = {
	name = "Drill Tree ",
	Description = "produces Matter. Slag is radioactive.",
	objectName = "jDrillTree.s3o",
	script = "jDrillTree.lua",
	buildPic = "DrillTree.png",
	--cost
	buildCostMetal = 200,
	buildCostEnergy = 50,
	buildTime =1,
	--Health
	maxDamage = 1200,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 5,
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
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
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	YardMap ="yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy",
	
	-- Building	
	ShowNanoSpray = false,
	CanBeAssisted = true,	
	workerTime = 1,
	buildoptions = 
	{
	},
	
	
	usebuildinggrounddecal = true,
	
	buildinggrounddecaldecayspeed = 0.00002,
	buildinggrounddecalsizex = 26,
	buildinggrounddecalsizey = 26,
	buildinggrounddecaltype = "jDrillDecal.dds",
	
	
	usebuildinggrounddecal = true,
	
	
	
	
	
	
	Category = [[LAND BUILDING]],
	
	EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
	acceleration = 0,
	
	activateWhenBuilt = true,
	-- bmcode = [[0]],
	
	--
	
	
	--extractsMetal = 0.005,
	--floater = false,
	
	
	
	levelGround = true,
	mass = 99,
	
	maxSlope = 255,
	
	
	noAutoFire = false,
	
	onoffable = true,
	
	
	
	smoothAnim = true,
	-- TEDClass = [[METAL]],
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", --1024
			"custom:jdrillradiation",--1025
			"custom:directionaldirt",
			--
			--Bulletof The Cannon
		},
		
	},
	
}

return lowerkeys({ [unitName] = unitDef })