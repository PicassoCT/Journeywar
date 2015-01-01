local unitName = "cdefusordart"

local unitDef = {
name = "Defuse Dart",
Description = "destroys Journey Race Darts close-up",
objectName = "cdefusordart.s3o",
script = "cdefusordart_script.lua",
buildPic = "cdefuserdart.png",
--cost
buildCostMetal = 550,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 3950,
mass=1024,
idleAutoHeal =1,
--Movement
Acceleration = 4.5,
BrakeRate = 0.00000000000000003,
FootprintX = 3,
FootprintZ = 3,
MaxSlope = 60,
MaxVelocity = 4.7,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 900,

sightDistance = 500,
nanocolor=[[0 0.9 0.9]],


CanAttack = true,
CanGuard = false,

CanMove = true,
CanPatrol = false,
CanStop = false,

  
	explodeAs="cantimatter",
	selfDestructAs="cantimatter", 

	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
		"custom:cdart",


	   
						  },
	
				},
				
		
	
	
Category = [[DART]],

weapons = {
[1]={name  = "cdefusordartgun",
	onlyTargetCategory = [[DART]],
	},

	
},
}

return lowerkeys({ [unitName] = unitDef })