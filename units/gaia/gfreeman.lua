local unitName = "gfreeman"

local unitDef = {
name = "Gordon",
Description = " mute Physicist, having a episode of the third kind.",
objectName = "gfreeman.s3o",
script = "gfreemanscript.lua",
buildPic = "crestrictor.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 9000,
idleAutoHeal = 1,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 2,
FootprintZ = 2,
collisionVolumeType="box",
collisionVolumeScales = [[20 20 40]],
MovementClass = "truck",
pushResistant=false,
MaxSlope = 5,
MaxVelocity = 3.2,
MaxWaterDepth = 35,
TurnRate = 1200,
mass=6500,
upright=true,
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
				   "custom:freemanzone",             --Thumper
		
				    --Bulletof The Cannon
				},
				},
  

weapons = {
[1]={name  = "jcrowbar",
	onlyTargetCategory = [[LAND]],
	},
},
}

return lowerkeys({ [unitName] = unitDef })