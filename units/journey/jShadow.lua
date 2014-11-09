local unitName = "jshadow"

local unitDef = {
name = "shadow",
Description = "Your worst Nightmare",
objectName = "jShadow.s3o",
script = "jshadow.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime = 1,
--Health
maxDamage = 6666,
idleAutoHeal = 12,
--Movement
Acceleration = 1.7,
BrakeRate = 0.3,
FootprintX = 2,
FootprintZ = 2,
MaxSlope = 15,
MaxVelocity = 1.4,
MaxWaterDepth = 200,
MovementClass = "Default2x2",
TurnRate = 350,
mass=500,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



sightDistance = 600,
upright=false,
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 

Category = [[LAND]],

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	  "custom:gdShadows",

	
						  },
	
				},
				

}

return lowerkeys({ [unitName] = unitDef })




