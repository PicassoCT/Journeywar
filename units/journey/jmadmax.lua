local unitName = "jmadmax"
local unitDef = {
name = "Rebells",
Description = " bad to the bone",
objectName = "varyFoo.s3o",
script = "jmadmaxscript.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 350,
buildCostEnergy = 150,
buildTime = 15,
--Health
maxDamage = 50,
idleAutoHeal = 2,
--Movement
Acceleration = 3,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 15,
MaxVelocity = 1.4,
MaxWaterDepth = 2000,
MovementClass = "Default2x2",
TurnRate = 450,
mass=10,


sightDistance = 500,
upright=true,
Builder = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 

   
    weapons = {
        [1]={name  = "jvaryfoomark",
	onlyTargetCategory = [[ LAND ]],
	},
	
},

Category = [[LAND]],
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
			"custom:bloodspray",
						  },
	
				},



				
		
}

return lowerkeys({ [unitName] = unitDef })




