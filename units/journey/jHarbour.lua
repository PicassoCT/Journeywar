local unitName = "jharbour"
local unitDef = {
name = "Harbour Cliffcolony",
Description = "a harbour is always where the water is.",
TEDClass = "PLANT",

objectName = "jharbour.s3o",
script = "jharbourscript.lua",
buildPic = "placeholderj.png",

--cost
buildCostMetal = 200,
buildCostEnergy = 50,
buildTime = 12,
CanReclaim=false,
buildDistance = 200,
onoffable=true,
upright=true,
acitvateonstart=false,
--Health
maxDamage = 1200,
idleAutoHeal = 3,
--Movement
MovementClass = "Default2x2",
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
--MaxVelocity = 0.5,
MaxWaterDepth =0,
TurnRate = 200,
isMetalExtractor = false,
sightDistance = 300,

reclaimable=false,
Builder = true,
CanAttack = true,
CanGuard= true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false,

	YardMap ="o",
corpse             = "bgcorpse",
-- Building	

	ShowNanoSpray = true,
	CanBeAssisted = true,	
		workerTime = 0.54,
	buildoptions = 
	{
	"jfishswarm","jgalatea"
	},


 	usebuildinggrounddecal = false,


Category = [[LAND BUILDING WATER]],

EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
  acceleration           = 0,

nanocolor=[[1 0.2 0.05]],

  levelGround            = false,
  mass                   = 9990,
  
  maxSlope               = 255,
  
  
  noAutoFire             = false,

  smoothAnim             = true,
 -- TEDClass               = [[METAL]],
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             
				   "custom:bloodspray",
				    "custom:greenlight",
				    "custom:fruitwater"				
				},

			},

}return lowerkeys({ [unitName] = unitDef })