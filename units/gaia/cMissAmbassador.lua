local unitName = "cmissambassador"

local unitDef = {
name = "Koma Icnivad",
Description = "Take me to your Aliens",
objectName = "cMissAmbassador.s3o",
script = "cmissambassadorscript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 350,
buildCostEnergy = 150,
buildTime = 15,
--Health
maxDamage = 50,
idleAutoHeal = 2,
--Movement
Acceleration = 0.2,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 15,
MaxVelocity = 0.7,
MaxWaterDepth = 2000,
MovementClass = "Default2x2",
TurnRate = 450,
mass=1500,
	selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
  

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
	
		   "custom:ambassadoricon",
		   "custom:bloodspray",
	
						  },
	
				},



				
				 corpse             = "cInfantryCorpse",
}

return lowerkeys({ [unitName] = unitDef })




