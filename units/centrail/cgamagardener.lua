local unitName = "cgamagardener"

local unitDef = {
name = "GamaBurst Landscape Sterilization Unit",
Description = "Cooking the Weed",
objectName = "gama.s3o",
script = "cgamagardener.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 550,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 950,
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
onoffable=true,
activatewhenbuilt=false,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],

	explodeAs="citadelldrone",
	selfDestructAs="citadelldrone", 

CanAttack = false,
CanGuard = true,

CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 
  trackType ="BIGFoot",


	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:gamagarden",
	   "custom:gamagarden",
	

	   
						  },
	
				},
				
		
	
	
Category = [[LAND]],


	

}

return lowerkeys({ [unitName] = unitDef })