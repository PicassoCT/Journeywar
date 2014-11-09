local unitName = "fclvlone"

local unitDef = {
name = "fclvlone",
Description = "Orders Units from another Dimension",
TEDClass = "PLANT",


buildPic = "cfc1.dds",
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
	explodeAs="cArtDM",
	selfDestructAs="cArtDM",
FootprintX = 5,
FootprintZ = 8,
MaxSlope = 20,

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
 corpse             = "bgcorpse",

CanPatrol = true,

ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,
canmove=true,	
Reclaimable = true,
buildDistance = 200,
terraformSpeed = 50,

-- Pathfinding and related
	FootprintX = 5,
	FootprintZ = 5,
	MaxSlope = 10,	
	YardMap ="ooooo occco occco occco occco",

-- Building	
	Builder = true,
   
	
	
	workerTime = 0.54,
	buildoptions = 
	{
	"upgradefactory","mtw","campro","advisor","restrictor","cgamagardener","csniper"
	},
	
	   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				
				   "custom:factorywarp", --1024
				   --
				   
				},
				},
	
	
Category = [[LAND BUILDING]],
}








return lowerkeys({ [unitName] = unitDef })