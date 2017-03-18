local unitName = "jpeeble"

local unitDef = {
name = "Rock",
Description = "very newtonion views ",
objectName = "jpeeble.s3o",
script = "jpeeble.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 110,
buildCostEnergy = 350,
buildTime = 9,
--Health
maxDamage = 320,
idleAutoHeal = 3,
--Movement
mass=220,
Acceleration = 1.4,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope =72,
MaxVelocity = 2.9,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 1000,
upRight=true,
sightDistance = 630,
corpse="jbiocorpse",
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
nanocolor=[[0.2 0.9 0.5]],
Category = [[AIR]],

  customParams = {},
 sfxtypes = {
    explosiongenerators = {	
	 	   "custom:directionaldirt",
	 	   "custom:risingdirt",
	   
	   
						  },
	
			},


}

return lowerkeys({ [unitName] = unitDef })