local unitName = "genupgrade"

local unitDef = {
name = "Upgrade Generator",
Description = "adds additional Build Power",
objectName = "emptyObjectIsEmpty.s3o",
script = "not_implemented_yet.lua",
buildPic = "upgradeGen.dds",
--floater = true,
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime =9000,
--Health
maxDamage = 1200,
idleAutoHeal = 0,
--Movement

FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
--MaxVelocity = 0.5,
MaxWaterDepth =0,
--MovementClass = "Default2x2",--


sightDistance = 300,
	explodeAs="zombieweapon",
	selfDestructAs="zombieweapon",




 
 
 

   

Category = [[NONTARGET]],



  
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	  
	   
	   
	   
						  },
	
			},

}

return lowerkeys({ [unitName] = unitDef })