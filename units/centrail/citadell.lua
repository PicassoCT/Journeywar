local unitName = "citadell"
local unitDef = {
name = "Spearspire",
Description = "CentrAIl Building, stores ConPlans, creates Units",
objectName = "citadell.s3o",
script = "citadellscript.lua",
buildPic = "citadell.dds",
--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 15,
--Health
maxDamage = 2500,
idleAutoHeal = 5,
--Movement
Acceleration = 0.25,
BrakeRate = 0.3,
FootprintX = 8,
FootprintZ = 8,
MaxSlope = 20,
MaxVelocity = 3.0,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 500,
--  explodeAs = "csuborbitalstrike",
radardistance=150,
sightDistance = 700,

	collisionVolumeScales		= [[48 884 28]],
	collisionVolumeOffsets	= [[0 -8 3]],
	collisionVolumeTest	    = 1,
	collisionVolumeType	    = [[box]],

EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 5,	
selfDExplosion = "electric_explosion",
NoWeapon=false,
CanAttack = true,
CanGuard = false,
reclaimSpeed=1,
CanMove = false,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
onoffable=true,
ActivateWhenBuilt=0,
Builder = true,
ShowNanoSpray = true,
CanBeAssisted = true,

nanocolor=[[0 0 0]], --
CanReclaim=true,	
workerTime = 0.002,
buildDistance = 1200,
terraformSpeed = 350,

	explodeAs="cArtDM",
	selfDestructAs="cArtDM", 


buildoptions = 
	{
	"scumslum","mdigg","cwaterextractor",
	"campole","mestorage","builux",
	"bbind","ctransithub","coverworldgate",
	"condepot","fclvlone","cairbase",
	"cdistrictnone","buibaicity2","buibaicity1",
	"crailgun","sentry","bonker", "cdefusermine",
	"chopper","comendbonker","geohive",
	},
	
sounds = {
   ["underattack"] =
   {
   [1]={name  = "citadell/citadellAlarm",
	["id"] = 140,   			
    ["volume"] = 5,
	},
	}
		},
		
explodeAs = "custom:factory_explosion",

 customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:factory_explosion",
	   "custom:dirt",
	   "custom:electric_explosion",
	   "custom:sparkcloud",
	   "custom:citadellfire",
	   "custom:citadellcloud",
	   "custom:portalstorm",
	   "custom:portalground",
	   "custom:darkCloud",
	   "custom:flames",	  --1033		
	   "custom:ashflakes",--1034
	   "custom:redSparks",--1035
	   
						  },
	
				},


weapons = {
[1]={name  = "citadelldrone",
	onlyTargetCategory = [[LAND AIR]],
	},
[2]={name  = "ccitadelltur",
	onlyTargetCategory = [[LAND AIR]],
	},
[3]={name  = "ccitadelltur",
	onlyTargetCategory = [[LAND AIR]],
	},
[4]={name  = "ccitadelltur",
	onlyTargetCategory = [[LAND AIR]],
	},
[5]={name  = "ccitadelltur",
	onlyTargetCategory = [[LAND AIR]],
	},
[6]={name  = "ccitadellshield",
	onlyTargetCategory = [[LAND AIR]],
	},	
		},

category=[[LAND BUILDING]],		
}
return lowerkeys({ [unitName] = unitDef })