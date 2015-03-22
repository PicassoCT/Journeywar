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
buildTime = 3,
--Health
maxDamage = 666,
idleAutoHeal = 0,
autoheal=0,
--Movement
mass=180020,
upRight=true,
blocking=false,
pushResistant=false,
Acceleration = 0.001,
BrakeRate = 0.01,
FootprintX = 1,
FootprintZ = 1,


MaxSlope = 90,
MaxVelocity = 0.3,
MaxWaterDepth = 9999,
MovementClass = "amphib",
TurnRate = 120,

sightDistance = 420,

reclaimable=true,
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false,
useSmoothMesh = false,
canhover=true,
turnInPlace=false,
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
						  },
	
			},
 
 weapons = {
[1]={name  = "jgluegun",
	onlyTargetCategory = [[LAND WATER]],
	},
},
 
 
Category = [[LAND WATER]],

}

return lowerkeys({ [unitName] = unitDef })