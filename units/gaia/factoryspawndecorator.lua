local unitName = "factoryspawndecorator"

local unitDef = {
name = "Anti Matter Projector",
Description = "Dissolving the Matters at hand",
objectName = "emptyobjectisempty.s3o",
script = "factoryspawndecorator.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 0,
buildCostEnergy = 0,
buildTime = 1,
--Health
maxDamage = 1,
mass=1024,
idleAutoHeal =1,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 3,
FootprintZ = 3,
MaxSlope = 60,
MaxVelocity = 4.5,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 900,

sightDistance = 500,
nanocolor=[[0 0.9 0.9]],


CanMove = true,
CanPatrol = true,
CanStop = true,



	  customParams = {},
 sfxtypes = {
    explosiongenerators = {

	
	   

	   
						  },
	
				},
				
		
	
	
Category = [[LAND]],

	

}

return lowerkeys({ [unitName] = unitDef })