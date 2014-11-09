local unitName = "gconditionracist"

local unitDef = {
name = "",
Description = "",
objectName = "emptyObjectIsEmpty.s3o",

script = "placeholder.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxwaterdepht=10,
maxDamage = 66666,
idleAutoHeal = 15,
autoheal=100,
--Movement
mass=66000,
MaxSlope = 15,
Acceleration = 29.0,
BrakeRate = 90.0,
FootprintX = 1,
FootprintZ = 1,
MaxVelocity = 75,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 900,
turnInPlace=true, 
sightDistance = 8000,

reclaimable=false,
Builder = false,
CanAttack = true,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false,
useSmoothMesh = false,

 corpse             = "lavafeature",
 

 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	 
	   
						  },
	
			},

 
 
Category = [[NOTARGET]],




}

return lowerkeys({ [unitName] = unitDef })