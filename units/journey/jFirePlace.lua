local unitName = "jFirePlace"

local unitDef = {
name = "Fire Place",
Description = "making a walkingStone Sandwich",
objectName = "gFirePlace.s3o",
script = "gFirePlace.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 10,
buildCostEnergy = 5,
buildTime =1,
--Health
maxDamage = 16,
idleAutoHeal = 0,
--Movement

FootprintX = 1,
FootprintZ = 1,

--MaxVelocity = 0.5,
MaxWaterDepth =0,
--MovementClass = "Default2x2",--


sightDistance = 3,

reclaimable=true,
Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,



-- Building	
	





    
   

Category = [[LAND]],

EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
  acceleration           = 0,
  

   -- bmcode                 = [[0]],
	
	--


  --extractsMetal          = 0.005,
  --floater                = false,



  levelGround            = false,
  mass                   = 100,
  



  


 -- TEDClass               = [[METAL]],
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
					
	   		       "custom:vortflames",
				  
				  
				   --
				    --Bulletof The Cannon
				},

},


}
return lowerkeys({ [unitName] = unitDef })