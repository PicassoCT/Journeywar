local unitName = "ghornblow"

local unitDef = {
name = "Lava(Gaia)",
Description = "Lavastream",
objectName = "Mission1Hornblow.s3o",
script = "Mission1Hornblow.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 6660000,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=180020,
upRight=true,
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

 corpse             = "lavafeature",
 

 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:fireSparks",
	   "custom:LightUponSmoke",
	    "custom:factory_explosion",
		"custom:csuborbscrap",
		  "custom:dirt",      
		  "custom:hornblowicon",      
						  },
	
			},

 
 
Category = [[NOTARGET]],




}

return lowerkeys({ [unitName] = unitDef })