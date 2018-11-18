local unitName = "csentry"
local unitDef = {
name = "Sentry",
Description = "close Combat Defense turret <Ground Defense>",
objectName = "sentry.s3o",
script = "sentryscript.lua",
buildPic = "csentry.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 25,
buildTime = 5,
--Health
maxDamage = 900,
idleAutoHeal = 3,
--Movement
Acceleration = 0,
BrakeRate = 0,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
MaxVelocity = 0,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 5,
mass=90,
nanocolor=[[0 0.9 0.9]],
sightDistance = 450,
selfDestructAs= [[NOWEAPON]],
Builder = false,
CanAttack = true,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 
levelGround =false,
Category = [[LAND]],

	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
 

weapons = {
[1]={name  = "sentrygun",
	onlyTargetCategory = [[LAND]],
	},
}
}
return lowerkeys({ [unitName] = unitDef })