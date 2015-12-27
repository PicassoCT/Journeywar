local unitName = "gworldengine"

local unitDef = {
name = "Autonomous Terraforming Unit",
Description = "Civilian Car, Drunk Driver",
objectName = "gworldEngine.s3o",
script = "gworldEngineScript.lua",
buildPic = "crestrictor.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 12500,
idleAutoHeal = 1,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 8	,
FootprintZ = 8,


pushResistant=false,
MaxSlope = 15,
MaxVelocity = 3.2,
MaxWaterDepth = 14,
MovementClass = "Default2x2",
TurnRate = 1200,
mass=2500,
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