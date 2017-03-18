local unitName = "jviciouscycler"

local unitDef = {
name = "Vicious Recycler",
Description = "Disolves everything with biological Nanotics",
objectName = "placeholder.s3o",
script = "jViciousCycler.lua",
buildPic = "placeholderj.png",
--floater = true,
--cost
buildCostMetal = 260,
buildCostEnergy = 130,
buildTime = 6,
--Health
maxDamage = 650,
idleAutoHeal = 0,
--Movement
Acceleration = 0.05,
BrakeRate = 0.05,
FootprintX = 3,
FootprintZ = 3,
TEDClass            = [[VTOL]],
steeringmode        = [[1]],
maneuverleashlength = 1380,
turnRadius		  	= 8,
dontLand		 	= true,
MaxVelocity = 1.5,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 150,
nanocolor=[[0 0.9 0.9]],
sightDistance = 1000,




Builder = true,
--canHover=true,
CanAttack = false,
CanGuard = true,
CanMove = true,
CanPatrol = true,
Canstop  = true,
LeaveTracks = false, 
cruiseAlt=256,
CanFly   = true,
ActivateWhenBuilt=1,
maxBank=0.4,
myGravity =0.1,
mass                = 8000,
canSubmerge         = false,
useSmoothMesh =true,
collide             = true,
crashDrag =0.9,



Category = [[AIR]],


ShowNanoSpray = true,
CanBeAssisted = false,
CanReclaim=true,	
workerTime = 0.15,
buildDistance = 1100,
terraformSpeed = 0.0000000002,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	 
	   
	   
	   
						  },
	
			},


}

return lowerkeys({ [unitName] = unitDef })