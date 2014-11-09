local unitName = "gnewsdrone"

local unitDef = {
name = "News Drone",
Description = "INTERDIM NEWS reporting Live",
objectName = "gNewsDrone.s3o",
script = "gNewsDroneScript.lua",
buildPic = "placeholder.png",
--floater = true,
--cost
buildCostMetal = 2260,
buildCostEnergy = 4130,
buildTime = 190,
--Health
maxDamage = 280,
idleAutoHeal = 1,
--Movement
Acceleration = 0.5,
 fireState=1,
BrakeRate = 1,
FootprintX = 3,
FootprintZ = 3,
TEDClass            = [[VTOL]],
steeringmode        = [[1]],
maneuverleashlength = 1380,
turnRadius		  	= 8,
dontLand		 	= true,
MaxVelocity = 2.5,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 150,
nanocolor=[[0 0.9 0.9]],
sightDistance = 500,
CanFly   = true,



Builder = true,
--canHover=true,
CanAttack = false,
CanGuard = true,
CanMove = true,
CanPatrol = true,
Canstop  = false,
onOffable = true,
LeaveTracks = false, 
cruiseAlt=265,

ActivateWhenBuilt=0,
maxBank=0.4,
myGravity =0.5,
mass                = 1225,
canSubmerge         = false,
useSmoothMesh =false,
collide             = true,
crashDrag =0.035,



Category = [[AIR]],

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:conairexaust",
	 
	   
	   
	   
						  },
	
			},

			


}

return lowerkeys({ [unitName] = unitDef })