local unitName = "gjmeatballs"

local unitDef = {
name = "MeatBalls",
Description = "dropping balls",
objectName = "gjMeatBalls.s3o",
script = "jMeatBallScript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 200,
buildCostEnergy = 50,
buildTime =1,
--Health
maxDamage = 666,
idleAutoHeal = 0,
--Movement

FootprintX = 5,
FootprintZ = 5,

--MaxVelocity = 0.5,
MaxWaterDepth =400,
--MovementClass = "Default2x2",--


sightDistance = 50,
cantBeTransported=false,

transportByEnemy =true,
reclaimable=true,
Builder = true,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,



-- Building	
	





    
   

Category = [[NOTARGET]],

EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
  acceleration           = 0,
  

   -- bmcode                 = [[0]],
	
	--


  --extractsMetal          = 0.005,
  --floater                = false,



  levelGround            = false,
  mass                   = 9900,
  



  


 -- TEDClass               = [[METAL]],
  
    
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				  "custom:dirt",
	   		       "custom:bloodspray",
	   		       "custom:greenbloodspray",
				  
				   --
				    --Bulletof The Cannon
				},

},


}
return lowerkeys({ [unitName] = unitDef })