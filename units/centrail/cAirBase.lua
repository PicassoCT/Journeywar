local unitName = "cairbase"

local unitDef = {
name = "Airbase",
Description = "builds and repairs Aircrafts",
TEDClass = "PLANT",



objectName = "cAirBase.s3o",
script = "cAirBaseScript.lua",
buildPic = "cairbase.dds",


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


radardistance=150,
sightDistance = 700,
isAirbase =true,
EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 0, 
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
workerTime = 0.4,
buildDistance = 200,
terraformSpeed = 50,

explodeAs="citadelldrone",
selfDestructAs="citadelldrone", 

-- Pathfinding and related
	FootprintX = 8,
	FootprintZ = 8,
	MaxSlope = 10,	
	YardMap ="oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

-- Building	
	Builder = true,
    Reclaimable = false,
	ShowNanoSpray = true,
	canBeAssisted =false,

	buildoptions = 
	{
	"chunterchopper","csuborbital","conair","cgunship"
	},
	
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				
				   "custom:weldArc",
				  
									},
				},
	
	
Category=[[LAND BUILDING]],	
}
return lowerkeys({ [unitName] = unitDef })