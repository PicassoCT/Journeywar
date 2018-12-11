local unitName = "jspore"

local unitDef = {
name = "Fungispore",
Description = "will infect any Unit nearby of the same type",
objectName = "jInfMuShroom.s3o",
script = "spore.lua",
buildPic = "jspore.png",
--cost
buildCostMetal = 600,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 380,
idleAutoHeal = 0,
--Movement
Acceleration = 0,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
MaxVelocity = 0,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 0,
nanocolor=[[0 0.9 0.9]],

 --collisionVolumeTest = 1;
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",




sightDistance = 20,

Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false, 

isFirePlatform=false,
holdSteady =true,
releaseHeld =false,
transportCapacity   = 1,
transportSize       = 90000,
  
  


	  sfxtypes            = {	
	    explosiongenerators = {
				"custom:orangespores",
		
		},	
		},
Category = [[NONTARGET]],

}

return lowerkeys({ [unitName] = unitDef })