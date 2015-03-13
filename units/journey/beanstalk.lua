local unitName = "beanstalk"

local unitDef = {
name = "beanstalk",
Description = "CentrAIl Building, stores ConPlans, creates Units",
objectName = "beanstalk.s3o",
script = "beanstalkscript.lua",
buildPic = "beanstalk.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 5,
--Health
maxDamage = 4500,
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
	EnergyUse = 0,
	MetalStorage = 200,
	EnergyMake = 0, 
	MakesMetal = 5, 
	MetalMake = 5,	

	collisionVolumeScales		= [[48 1024 48]],
	collisionVolumeOffsets	= [[0 -8 3]],
	collisionVolumeTest	    = 1,
	collisionVolumeType	    = [[CylY]],

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
	{
	--factorys
	"jmovingfac1",
	"jviralfac",
	"jharbour",
	"jgeohive",
	"eggstackfac",
	--eco
	"jnativevil",
	"jdrilltree",
	"jmeconverter",
	"jtree",
	"jtreedummy",
	"jtree2",
	"jtree2dummy",
	"jtree3",
	"jtree3dummy",
	"jtreel",

	--defense
	"jjamforrest",
	"jwatergate",
	"jfireflower",
	"jdragongrass",
	"jbeehive",
	"jfungiforrest",
	"jrefugeetrap",
	
	--endgame
	"jabyss"
	
	},

Category = [[LAND BUILDING]],

weapons = {
[1]={name  = "jbeanstalkphoenix",
	onlyTargetCategory = [[LAND AIR]],
	},
[2]={name  = "jbeanstalkshield",
--	onlyTargetCategory = [[LAND AIR]],
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