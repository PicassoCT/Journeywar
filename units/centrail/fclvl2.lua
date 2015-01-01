local unitName = "fclvl2"

local unitDef = {
name = "Worldgate",
Description = "orders Advcanced Units Offworld",
TEDClass = "PLANT",


onoffable=false,
objectName = "fclvl2.s3o",
script = "fclvl2.lua",
buildPic = "cfc2.dds",
	explodeAs="cArtDM",
	selfDestructAs="cArtDM",
canBeAssisted =false,
 corpse             = "bgcorpse",
	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = 1,

nanocolor=[[0 0.9 0.9]],

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

 corpse             = "bgcorpse",
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
CanReclaim=true,	
workerTime = 0.64,
buildDistance = 200,
terraformSpeed = 50,

-- Pathfinding and related
	FootprintX = 8,
	FootprintZ = 8,
	MaxSlope = 10,	
	YardMap ="oooooooo oyyyyyyo oyyyyyyo oyyyyyyo oyyyyyyo oyyyyyyo oyyyyyyo oyyyyyyo",

-- Building	
	Builder = true,
    Reclaimable = false,
	ShowNanoSpray = true,

	workerTime = 1,
	buildoptions = 
	{
	"genupgrade","coffworldassemblyseed","operatrans","art","sentrynell","cwallbuilder","cheadlauncher",
	},
	
	   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				
				   "custom:factorywarp", --1024
				   "custom:factorysfx", --1024
				   --
				   
				},
				},
	
Category = [[LAND]],
}








return lowerkeys({ [unitName] = unitDef })