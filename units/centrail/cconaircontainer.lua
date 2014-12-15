local unitName = "cconaircontainer"

local unitDef = {
name = "Container",
Description = "drop near Farcaster for Reward",
objectName = "cConTainer.s3o",
script = "cconaircontainer_script.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 6666,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=18020,
 transportByEnemy    = true,

Acceleration = 0.0000001,
BrakeRate = 0.0001,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 90,
MaxVelocity = 0.000001,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 1,

sightDistance = 80,

reclaimable=true,
Builder = false,
CanAttack = true,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false,
useSmoothMesh = false,


 

 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {

						  },
	
			},

 
 
Category = [[NOTARGET]],



}

return lowerkeys({ [unitName] = unitDef })