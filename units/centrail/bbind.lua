local unitName = "bbind"

local unitDef = {

  name               = "Idustrial Complex",
  description = "recycles Remains. Returns the other half, doubled upon Destruction by the enemie. <Scrap Recycling Building>",
  objectName         = "bbind.s3o",
  script = "bbind.lua",
  buildPic = "industry.dds",
	EnergyUse = 5,
	MetalUse = 5,
	
	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = false,

nanocolor=[[0 0.9 0.9]],

--cost
buildCostMetal = 900,
buildCostEnergy = 1200,
buildTime = 80,
--Health
maxDamage = 650,
idleAutoHeal = 3,
--Movement

FootprintX = 13,
FootprintZ = 13,
MaxSlope = 90,

MaxWaterDepth = 0,
MovementClass = "Default2x2",
explodeAs="cflamethrower",
selfDestructAs="cflamethrower", 


sightDistance = 700,

EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	


CanAttack = false,
CanGuard = false,
CanAssist=false;
CanMove = false,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 

Builder = true,
ShowNanoSpray = true,
CanBeAssisted = true,
CanReclaim=true,	
workerTime = 1.00,
buildDistance = 650,
terraformSpeed = 50,
nanocolor=[[0 0 0]], --
-- Pathfinding and related
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
				   "custom:blackerthenSmoke",	--1024
				   "custom:flames",				--1025
				   "custom:glowsmoke",  	    --1026
				   "custom:AR2Impact",	--1027
				   "custom:vortflames",--28
				   "custom:bloodslay",--29
				   "custom:lowrisesparkfire",--30
				   "custom:scrapallover",--31
				   "custom:fireball",--32
				
						  },
	
			},

				
Category=[[LAND BUILDING]],	

	
}

return lowerkeys({ [unitName] = unitDef })