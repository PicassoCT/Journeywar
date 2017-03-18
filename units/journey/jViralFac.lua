local unitName = "jviralfac"
local unitDef = {
name = "Viralworm",
Description = "builds Commando-Units behind in the enemy lines",
objectName = "jViralFac.s3o",
script = "jViralFacScript.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 3000,
buildCostEnergy = 9000,
buildTime = 240,
--Health
maxDamage = 1200,
idleAutoHeal = 0,

--Movement
MaxVelocity=0.07,
Acceleration = 0.01,
BrakeRate = 0.05,
FootprintX = 6,
FootprintZ = 6,
MaxSlope = 20,
MaxWaterDepth = 10,
MovementClass = "Default2x2",
TurnRate = 20,

sightDistance = 600,
CanBeAssisted = true,
CanReclaim=false,	
workerTime = 0.2,
buildDistance = 5000,
terraformSpeed = 50,
Builder = true,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
  buildoptions = 
	{
	"jtigeggnogg",
	"jskineggnogg",
	"jsungodcattle",
	"hc",
	"jinfector",
	"jresistancecell"	
	},


 collisionVolumeScales		= [[50 50 420]],
 collisionVolumeOffsets	= [[4 5 0]],
 collisionVolumeTest	    = 1,
 collisionVolumeType	    = [[CylX]],
 
CanGuard = true,
CanMove = true,
canassist=true,
CanStop = true,
LeaveTracks = false, 
nanocolor=[[0.2 0.9 0.5]],
Category = [[LAND]],


}

return lowerkeys({ [unitName] = unitDef })