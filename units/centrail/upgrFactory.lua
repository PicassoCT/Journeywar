local unitName = "upgradefactory"

local unitDef = {
name = "Upgrade Factory",
Description = "transform the Factory into a Nanoforge",
objectName = "emptyObjectIsEmpty.s3o",
script = "not_implemented_yet.lua",
buildPic = "placeholder.png",
--floater = true,
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime =1,
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
	explodeAs="citadelldrone",
	selfDestructAs="cArtDM",




 
 
 

   

Category = [[NONTARGET]],



  
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	  
	   
	   
	   
						  },
	
			},

}

return lowerkeys({ [unitName] = unitDef })