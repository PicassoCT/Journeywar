local unitName = "conair"

local unitDef = {
name = "conair",
Description = "Construction Aircraft",
objectName = "conair.s3o",
script = "conairscript.lua",
buildPic = "conair.dds",
--floater = true,
--cost
buildCostMetal = 260,
buildCostEnergy = 130,
buildTime = 6,
--Health
maxDamage = 150,
idleAutoHeal = 0,
--Movement
Acceleration = 0.5,
BrakeRate = 1,
FootprintX = 3,
FootprintZ = 3,
TEDClass            = [[VTOL]],
steeringmode        = [[1]],
maneuverleashlength = 1380,
turnRadius		  	= 8,
dontLand		 	= false,
MaxVelocity = 2.5,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 150,
nanocolor=[[0 0.9 0.9]],
sightDistance = 500,

 collisionVolumeScales		= [[23 30 62]],
 collisionVolumeOffsets	= [[-5 -8 3]],
 collisionVolumeTest	    = 1,
 collisionVolumeType	    = [[box]],

  NoWeapon=true,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",




Builder = true,
--canHover=true,
CanAttack = false,
CanGuard = true,
CanMove = true,
CanPatrol = true,
Canstop  = false,
LeaveTracks = false, 
cruiseAlt=165,
CanFly   = true,
ActivateWhenBuilt=1,
maxBank=0.4,
myGravity =0.5,
mass                = 1225,
canSubmerge         = false,
useSmoothMesh =false,
collide             = true,
crashDrag =0.1,



Category = [[AIR]],


ShowNanoSpray = false,
CanBeAssisted = true,
CanReclaim=true,	
workerTime = 0.4,
buildDistance = 110,
terraformSpeed = 0.2,

buildoptions = 
	{
	"bg",	
	},
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:conairexaust",
	 
	   
	   
	   
						  },
	
			},


}

return lowerkeys({ [unitName] = unitDef })