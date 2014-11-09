local unitName = "cawilduniverseappears"

local unitDef = {
name = "Universe",
Description = "Let there be light...",
objectName = "cAWildUniverseAppears.s3o",
script = "aWildUniverseAppears.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime =1,
--Health
maxDamage = 42666314,
idleAutoHeal = 0,
--Movement

FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
--MaxVelocity = 0.5,
MaxWaterDepth =0,
--MovementClass = "Default2x2",--
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
upright=true,
sightDistance = 300,

reclaimable=true,
Builder = true,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false,
levelground = 0,

-- Building	


   

Category = [[LAND]],



  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
			 "custom:blacksphereexpanding",	   		
			 "custom:cawilduniverseappearsgalaxys",	   		
			 "custom:sunfx",	   		
			 "custom:orgbigbang"  		
				  
				},

			},

}

return lowerkeys({ [unitName] = unitDef })