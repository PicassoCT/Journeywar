local unitName = "gcrawlerfeeder"

local unitDef = {
name = "gCrawler",
Description = "Sand ",
objectName = "gCrawlerFeeder.s3o",
script = "gCrawlerFeederScript.lua",
buildPic = "crestrictor.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 62250,
idleAutoHeal = 1,
--Movement
Acceleration = 0.04,
BrakeRate = 0.03,
FootprintX = 15,
FootprintZ = 15,
collisionVolumeType="box",
collisionVolumeScales = [[20 20 40]],

pushResistant=true,
MaxSlope = 15,
MaxVelocity = 0.15,
MaxWaterDepth = 14,
MovementClass = "truck",
TurnRate = 12,
mass=66500,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
turnInPlace=true, 
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
				   "custom:dirt",             
				   "custom:missile_explosion",
					"custom:sandflow"				  
				  
				},
				},
  

weapons = {

},
}

return lowerkeys({ [unitName] = unitDef })