local unitName = "jgalatea"

local unitDef = {
name = "Galatea Manowar",
Description = "Beware of the galatea eggs",
objectName = "jgalatea.s3o",
script = "jgalatescript.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 666,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=180020,
upRight=true,
blocking=false,
pushResistant=true,
Acceleration = 0.001,
BrakeRate = 0.01,
FootprintX = 1,
FootprintZ = 1,


MaxSlope = 90,
MaxVelocity = 0.3,
MaxWaterDepth = 55,
MovementClass = "Default2x2",
TurnRate = 900,

sightDistance = 420,

reclaimable=false,
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false,
useSmoothMesh = false,
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
						  },
	
			},
 
Category = [[LAND WATER]],

}

return lowerkeys({ [unitName] = unitDef })