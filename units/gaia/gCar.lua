local unitName = "gcar"

local unitDef = {
name = "gcar",
Description = "Civilian Car, Drunk Driver",
objectName = "gCar.s3o",
script = "gCarScript.lua",
buildPic = "crestrictor.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 1250,
idleAutoHeal = 1,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 2,
FootprintZ = 2,
collisionVolumeType="box",
collisionVolumeScales = [[20 20 40]],

pushResistant=false,
MaxSlope = 15,
MaxVelocity = 3.2,
MaxWaterDepth = 14,
MovementClass = "Default2x2",
TurnRate = 1200,
mass=6500,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
turnInPlace=false, 
Builder = false,
CanAttack = false,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,



Category = [[LAND]],
selfDestructAs= [[NOWEAPON]],

  explodeAs = "330RLexplode",
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             --Thumper
				   "custom:missile_explosion",     --
				    --Bulletof The Cannon
				},
				},
  

weapons = {

},
}

return lowerkeys({ [unitName] = unitDef })