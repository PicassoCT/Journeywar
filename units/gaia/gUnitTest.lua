local unitName = "gunittest"

local unitDef = {
name = "UnitTest",
Description = "Mourning Wood",
objectName = "placeholder.s3o",
script = "gUnitScript.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 6660,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=8020,
upRight=false,
blocking=false,
pushResistant=true,
Acceleration = 0.0000001,
BrakeRate = 0.0001,
FootprintX = 8,
FootprintZ = 8,



MaxWaterDepth = 15,
MovementClass = "Default2x2",
TurnRate = 1,

sightDistance = 80,

reclaimable=false,
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