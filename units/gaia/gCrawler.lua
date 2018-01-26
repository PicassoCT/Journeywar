local unitName = "gCrawler"

local unitDef = {
name = "Gardeners of the Glassforrest",
Description = "Holy Congregation of horny singles. Taxexempted.",
objectName = "gCrawler.s3o",
script = "gCrawlerScript.lua",
buildPic = "crestrictor.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 62250,
idleAutoHeal = 1,
--Movement
Acceleration = 0.05,
BrakeRate = 0.03,
FootprintX = 15,
FootprintZ = 15,
collisionVolumeType="box",
collisionVolumeScales = [[15 15 30]],

pushResistant=true,
MaxSlope = 62,
MaxVelocity = 0.162,
MaxWaterDepth = 14,
MovementClass = "allterrain",
TurnRate = 24,
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
					 "custom:glowsmoke",
					"custom:blackerthensmoke",				  
					"custom:orangeray",				  
				  
				},
				},
  

weapons = {


},
}

return lowerkeys({ [unitName] = unitDef })