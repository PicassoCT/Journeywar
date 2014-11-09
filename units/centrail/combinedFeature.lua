local unitName = "combinedfeature"

local unitDef = {
name = "Combine Watchpost",
Description = "Outpost - sterlizing the nearby fauna",
objectName = "cCombineOutPost.s3o",
script = "combinedFeatureScript.lua",
buildPic = "csniper.dds",
--cost
buildCostMetal = 600,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 2800,
idleAutoHeal = 1,
--Movement
--Acceleration = 0.1,
--BrakeRate = 0.3,
FootprintX = 8,
FootprintZ = 8,
--MaxSlope = 5,
--MaxVelocity = 2.5,
MaxWaterDepth = 20,
--MovementClass = "Default2x2",
--TurnRate = 900,
nanocolor=[[0 0.9 0.9]],
collisionvolumetype  = "box",
collisionvolumescales = "30 65 30",
collisionvolumeoffsets = "0 0 0",
 --collisionVolumeTest = 1;
	explodeAs="citadelldrone",
	selfDestructAs="cArtDM", 



sightDistance = 650,

Builder = false,
CanAttack = true,
--CanGuard = true,
CanMove = false,
--CanPatrol = true,
CanStop = true,
--LeaveTracks = true, 

--isFirePlatform=true,
--holdSteady =true,
--releaseHeld =true,
--transportCapacity   = 1,
--transportSize       = 90000,
  
  
--trackType ="BIGFoot",
--  trackStrength=4,

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
[1]={name  = "sniper",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "sniperslavemelee",
	onlyTargetCategory = [[LAND]],
	slaveTo=1,
	},	
},
}

return lowerkeys({ [unitName] = unitDef })