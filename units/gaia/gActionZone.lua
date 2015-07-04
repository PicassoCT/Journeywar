local unitName = "actionzone"
local unitDef = {
name = "Action",
Description = "Stores the Orders to be Executed",
objectName = "gZoneMarker.s3o",
script = "gZoneScript.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
upRight=true,
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 6660000,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=180020,
blocking=false,
pushResistant=true,
Acceleration = 0.0000001,
BrakeRate = 0.0001,
FootprintX = 12,
FootprintZ = 12,
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
  


MaxSlope = 90,
MaxVelocity = 0.000001,
MaxWaterDepth = 15,
MovementClass = "Default2x2",
TurnRate = 1,

sightDistance = 0,

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
				   "custom:triggerzone",	   		    
				   "custom:actionzone",	   		    
				   "custom:reservoirzone",	   		    
				   
						  },
	
			},

 
 
Category = [[NOTARGET]],




}

return lowerkeys({ [unitName] = unitDef })