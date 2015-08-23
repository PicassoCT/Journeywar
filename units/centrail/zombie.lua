local unitName = "zombie"

local unitDef = {
name = "zombie",
Description = "Zombie",
objectName = "zombie.s3o",
script = "zombiescript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 350,
buildCostEnergy = 150,
buildTime = 15,
--Health
maxDamage = 1350,
idleAutoHeal = 12,
--Movement
Acceleration = 3,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 15,
MaxVelocity = 0.4,
MaxWaterDepth = 2000,
MovementClass = "Default2x2",
TurnRate = 150,
mass=700,
 corpse             = "",
	explodeAs="zombieweapon",
	selfDestructAs="crabshell", 
sightDistance = 500,
upright=true,
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 

Category = [[LAND]],

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:bloodspray",
	
						  },
	
				},
				
weapons = {
[1]={name  = "zombieweapon",
	onlyTargetCategory = [[LAND]],
	},
},
}

return lowerkeys({ [unitName] = unitDef })




