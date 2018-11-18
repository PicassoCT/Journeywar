local unitName = "cfclvl1"

local unitDef = {
	name = "Farcaster",
	Description = "orders first Level Units from a higher Dimension <Ground Unit Factory>",
	
	
	buildPic = "cfclvl1.png",
	objectName = "fclvlone.s3o",
	script = "fclvlone.lua",
	
	onoffable = false,
	activateWhenBuilt=false,
	
	Upright = 1,	
	levelground = 1,
	
	nanocolor=[[0 0.9 0.9]],
	
	--cost
	buildCostMetal = 900,
	buildCostEnergy = 250,
	buildTime = 36,
	--Health
	maxDamage = 1025,
	idleAutoHeal = 0,
	--Movement
	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat",
	FootprintX = 5,
	FootprintZ = 8,
	MaxSlope = 50,
	
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	
	
	radardistance=150,
	sightDistance = 300,
	
	
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	corpse = "bgcorpse",
	
	CanPatrol = true,
	
	ShowNanoSpray = false,
	
	CanReclaim=false,
	canmove=true,	
	canBeAssisted =false,
	Reclaimable = true,
	buildDistance = 200,
	terraformSpeed = 50,
	
	-- Pathfinding and related
	FootprintX = 5,
	FootprintZ = 5,

	YardMap ="ooooo occco occco occco occco",
	
	-- Building	
	Builder = true,
	
	
	
	workerTime = 0.54,
	buildoptions = 
	{
		"genupgrade","upgradefactory","cgamagardener",
		"cspc","cit","css",
		"campro", "crestrictor","csniper",
		"advisor"
	},
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factorywarp", --1024
		},
	},
	
	
	Category = [[LAND BUILDING]],
}








return lowerkeys({ [unitName] = unitDef })