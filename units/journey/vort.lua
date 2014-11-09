local unitName = "vort"

local unitDef = {
name = "Vortigaunt",
Description = "Teleportin Alienwarrior",
objectName = "vort.s3o",
script = "jVortigaunt.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 450,
buildTime = 6,
--Health
maxDamage = 620,
idleAutoHeal = 3,
--Movement
Acceleration = 0.3,
BrakeRate = 0.5,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 60,
MaxVelocity = 1.2,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 950,
corpse="jbiocorpse",
sightDistance = 600,
selfDestructAs="defaultweapon",
explodeas="defaultweapon",
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 

Category = [[LAND]],

weapons = {
[1]={name  = "vortweapon",
	onlyTargetCategory = [[LAND]],
	},
},


  customParams = {},
 sfxtypes = {
    explosiongenerators = {
     "custom:vortport"
    },
  }

}

return lowerkeys({ [unitName] = unitDef })