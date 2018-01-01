local unitName = "jmeconverter"
local unitDef = {
name = "Greenhouse Accelerator",
Description = "converts Light to Matter. <Matter Energy Conversion>",


objectName = "jmeconverter.s3o",
script = "jmeconverterscript.lua",
buildPic = "placeholderj.png",

--cost
buildCostMetal = 200,
buildCostEnergy = 50,
buildTime = 12,
CanReclaim=false,

MovementClass = "Default2x2",
onoffable=true,
upright=true,
acitvateonstart=true,
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

    collisionVolumeOffsets    =  "0 0 0",
    collisionVolumeScales     =  "35 60 90",
	collisionVolumeTest       =  1,
	collisionVolumeType       =  "box",

reclaimable=false,
Builder = true,
CanAttack = true,
CanGuard= true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false,

corpse             = "bgcorpse",
-- Building	
MaxVelocity = 1.5,
	ActivateWhenBuilt=1,


 	usebuildinggrounddecal = false,


Category = [[LAND BUILDING]],

EnergyStorage = 250,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 5, 
	MetalMake = 0,	
  acceleration           = 0.3,

nanocolor=[[1 0.2 0.05]],

  
  mass                   = 9990,
  
  maxSlope               = 255,
  
  
  noAutoFire             = false,

  smoothAnim             = true,
 -- TEDClass               = [[METAL]],
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             
			    "custom:jbuildingexaust"				
				},

			},

}return lowerkeys({ [unitName] = unitDef })