local unitName = "gcivillian"

local unitDef = {
name = "Civillian",
Description = "un(h?)armed civillian?",
objectName = "gCivVillian.s3o",
script = "gCiVillian.lua",
buildPic = "placeholder.png",
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
mass=550,


sightDistance = 500,
upright=true,
Builder = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 

Category = [[LAND]],
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
		   "custom:bloodspray",
	
						  },
	
				},



				
				 corpse             = "cInfantryCorpse",
}

return lowerkeys({ [unitName] = unitDef })




