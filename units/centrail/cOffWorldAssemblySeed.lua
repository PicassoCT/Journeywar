local unitName = "coffworldassemblyseed"

local unitDef = {
name = "Constructionseed",
Description = "errects a Offworld-Assembly building <Upgrade in Progress Building>",
objectName = "cOffWorldAssemblySeed.s3o",
script = "coffworldassemblyseed.lua",
buildPic = "nanoupgrade.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 1250,
idleAutoHeal = 1,
--Movement
Acceleration = 0.05,
BrakeRate = 0.3,
FootprintX = 2,
FootprintZ = 2,
MaxSlope = 20,
MaxVelocity = 0.8,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 100,
mass=6500,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
turnInPlace=true, 
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 
onOffable=true,
activateWhenBuilt =false,
Category = [[LAND]],
  selfDestructAs= [[NOWEAPON]],
  explodeAs = "defaultweapon",
  trackType ="cRes",
  trackStrength=12,

  
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             
				   "custom:missile_explosion",     
				},
				},
  


}

return lowerkeys({ [unitName] = unitDef })