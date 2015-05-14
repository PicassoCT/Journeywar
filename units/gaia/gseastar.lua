local unitName = "gseastar"

local unitDef = {
name = "Seastar",
Description = "once a year they come ashore",
objectName = "g_seastar.s3o",
script = "gseastarscript.lua",
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

pushResistant=true,
MaxSlope = 75,
MaxVelocity = 0.4,
MaxWaterDepth = 950,
MovementClass = "Default2x2",
TurnRate = 20,
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
selfDestructAs="defaultweapon",

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