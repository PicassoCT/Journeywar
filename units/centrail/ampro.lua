local unitName = "campro"

local unitDef = {
name = "Anti Matter Projector",
Description = "Dissolving the Matters at hand",
objectName = "ampro.s3o",
script = "campro.lua",
buildPic = "campro.png",
--cost
buildCostMetal = 550,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 3950,
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


CanAttack = true,
CanGuard = true,

CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 
  trackType ="BIGFoot",
	explodeAs="cantimatter",
	selfDestructAs="cantimatter", 

	  customParams = {},
 sfxtypes = {
    explosiongenerators = {

	
	   "custom:antimatter",
	   "custom:cviolentvehicledeath",

	   
						  },
	
				},
				
		
	
	
Category = [[LAND]],

weapons = {
[1]={name  = "cantimatter",
	onlyTargetCategory = [[LAND]],
	},

	
},
}

return lowerkeys({ [unitName] = unitDef })