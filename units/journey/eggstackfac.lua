local unitName = "eggstackfac"

local unitDef = {
name = "Eggstack",
Description = "Produces a limited amount of eggs",
objectName = "jeggstack.s3o",
script = "jstationaryEggstack.lua",
buildPic = "eggstack.png",
buildCostMetal = 200,
buildCostEnergy = 50,
buildTime =1,
--Health
maxDamage = 1200,
idleAutoHeal = 3,
--Movement

FootprintX = 6,
FootprintZ = 6,
MaxSlope = 5,
--MaxVelocity = 0.5,
MaxWaterDepth =0,
--MovementClass = "Default2x2",--
TurnRate = 200,
isMetalExtractor = false,
sightDistance = 300,

reclaimable=true,
Builder = true,
CanAttack = false,

CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false,

	YardMap ="cccccc cccccc cccccc cccccc cccccc cccccc",

-- Building	

	ShowNanoSpray = true,
	CanBeAssisted = true,	
	workerTime = 1,
	buildoptions = 
	{
	"jstealthdrone","jconroach","conbigfoot",
	},


 	usebuildinggrounddecal = false,

		




    
   

Category = [[LAND BUILDING]],

EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
  acceleration           = 0,
  canguard=true,
  activateWhenBuilt      = false,
   -- bmcode                 = [[0]],
	
	--


  --extractsMetal          = 0.005,
  --floater                = false,


nanocolor=[[1 0.2 0.05]],
  levelGround            = false,
  mass                   = 99,
  
  maxSlope               = 255,
  
  
  noAutoFire             = false,
  
  onoffable              = true,
  


  smoothAnim             = true,
 -- TEDClass               = [[METAL]],
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             --Thumper
				   "custom:bloodspray",
				  -- "custom:smokeScreen",
				   --
				    --Bulletof The Cannon
				},

},

}

return lowerkeys({ [unitName] = unitDef })