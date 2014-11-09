local unitName = "mdiggMex"

local unitDef = {
name = "Metalldiggester (Stationary)",
Description = "Mines into the ground till it hits water",
objectName = "mdigg.s3o",
script = "mdiggMexscript.lua",
buildPic = "placeholder.png",
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

	NoWeapon=true,
	explodeAs="defaultweapon",
	selfDestructAs="defaultweapon",

	YardMap ="yyyyyy yyyyyy yyyyyy yyyyyy yyyyyy yyyyyy",

-- Building	
	ShowNanoSpray = false,
	CanBeAssisted = true,	
	workerTime = 1,
	buildoptions = 
	{
	"conair"
	},


 	usebuildinggrounddecal = true,

		buildinggrounddecaldecayspeed = 0.00002,
		buildinggrounddecalsizex = 26,
		buildinggrounddecalsizey = 26,
		buildinggrounddecaltype = "cdigdec.dds",


  	usebuildinggrounddecal = true,



    
   

Category=[[LAND BUILDING]],	

EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
  acceleration           = 0,
  
  activateWhenBuilt      = true,
   -- bmcode                 = [[0]],
	
	--


  --extractsMetal          = 0.005,
  --floater                = false,



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
				   "custom:fireSparks",
				   "custom:smokeScreen",
				   --
				    --Bulletof The Cannon
				},

},

}

return lowerkeys({ [unitName] = unitDef })