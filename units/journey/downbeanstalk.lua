local unitName = "dbeanstalk"

local unitDef = {
name = "beanstalk",
Description = "CentrAIl Building, stores ConPlans, creates Units",
objectName = "beanstalk.s3o",
script = "downedBeanstalk.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 5,
--Health
maxDamage = 2500,
idleAutoHeal = 5,
--Movement
Acceleration = 0.25,
BrakeRate = 0.3,
FootprintX = 5,
FootprintZ = 5,
MaxSlope = 20,
MaxVelocity = 3.0,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 500,
onOffAble=true,
  activateWhenBuilt      = false,
radardistance=750,
sightDistance = 700,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 5,	


CanAttack = true,
CanGuard = false,
CanMove = false,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
nanocolor=[[0.2 0.9 0.5]],
Builder = true,
ShowNanoSpray = true,
CanBeAssisted = true,
CanReclaim=true,	
workerTime = 0.005,
buildDistance = 12000,
terraformSpeed = 350,
buildoptions = 
	{"jsfactory1","jdrilltree","meggstack","jtree","jtree2","jtree3","jtree2dummy","jtreedummy","jgeohive","jwatergate","jfireflower","jbeehive","jfungiforrest"
	
	

	
	
	
	},

Category = [[LAND BUILDING]],

weapons = {
[1]={name  = "jbeanstalkphoenix",
	onlyTargetCategory = [[LAND AIR]],
	},
},

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
     "custom:factory_explosion",
	 "custom:flames",
	 "custom:glowsmoke",
	 "custom:glowsmoke",
	 "custom:dirt",
	 "custom:blackerThenSmoke",
	 "custom:greenSparks",--1030
	 "custom:leaves", --1031 
	 "custom:beanstalkgrowth", --1032 
    },
  }


}

return lowerkeys({ [unitName] = unitDef })