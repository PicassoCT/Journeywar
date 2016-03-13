local unitName = "csniper"

local unitDef = {
name = "Sniper",
Description = "needs to deploy to fire - can drag harpooned bodys to base",
objectName = "csniper.s3o",
script = "csniper.lua",
buildPic = "csniper.dds",
--cost
buildCostMetal = 600,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 380,
idleAutoHeal = 0,
--Movement
Acceleration = 0.1,
BrakeRate = 0.3,
FootprintX = 2,
FootprintZ = 2,
MaxSlope = 5,
MaxVelocity = 2.5,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 900,
moveState =1,
nanocolor=[[0 0.9 0.9]],
collisionvolumetype  = "box",
collisionvolumescales = "30 65 30",
collisionvolumeoffsets = "0 0 0",
 --collisionVolumeTest = 1;
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 


sightDistance = 650,

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 

isFirePlatform=true,
holdSteady =true,
releaseHeld =true,
transportCapacity   = 1,
transportSize       = 90000,
  
  
trackType ="BIGFoot",
  trackStrength=4,

	  sfxtypes            = {	
	    explosiongenerators = {
		"custom:smallblueburn",
		"custom:bloodspray",
		"custom:dirt",
		"custom:greenlight",
		},	
		},
Category = [[LAND]],

weapons = {
[1]={name  = "sniperslavemelee",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "sniper",
	onlyTargetCategory = [[LAND]],
	slaveTo=1,
	},	
},
}

return lowerkeys({ [unitName] = unitDef })