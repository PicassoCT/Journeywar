local unitName = "cdefusermine"

local unitDef = {
	name = "Defusedart Deployer",
	Description = "launches free Dartdefusors <Anti Projectile Defense>",

	objectName = "cdefusormine.s3o",
	script = "cdefusermine_script.lua",
	buildPic = "cdefusermine.png",


	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = 0,



	--cost
	buildCostMetal = 100,
	buildCostEnergy = 12,
	buildTime = 5,
	--Health
	maxDamage = 150,
	idleAutoHeal = 0,
	--Movement
	  selfDestructAs ="defaultweapon",
	  explodeAs = "defaultweapon",

	radarEmitHeight =250,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 20,

	MaxWaterDepth = 90,
	MovementClass = "Default2x2",


	radardistance=1024,
	sightDistance = 350,

	EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	nanocolor=[[1 0.2 0.05]],

	CanAttack = false,
	CanGuard = false,
	CanMove = false,
	CanPatrol = false,
	CanStop = false,
	LeaveTracks = false, 

	Builder = false,
	ShowNanoSpray = false,
	CanBeAssisted = false,
	CanReclaim=false,	
	workerTime = 1.00,
	buildDistance = 200,
	terraformSpeed = 50,

	-- Pathfinding and related

	-- Weapon

	weapons = {


		[1]={name  = "cdefusorminegun",
		onlyTargetCategory = [[DART]],
		},
		},	


	  customParams = {},
	 sfxtypes = {
		explosiongenerators = {},
		},

	Category = [[LAND]],
}

return lowerkeys({ [unitName] = unitDef })