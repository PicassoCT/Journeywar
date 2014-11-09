local unitName = "crazordrone"

local unitDef = {
name = "Razor Drone",
Description = "Cuts Enemys",
objectName = "crazorDrone.s3o",
script = "cRazorScript.lua",
buildPic = "placeholder.png",
moveState =2,
 fireState=2,
--cost
buildCostMetal = 105,
buildCostEnergy = 200,
buildTime = 6,
--Health
maxDamage = 240,
idleAutoHeal = 3,
--Movement
mass=120,
upright=true,
Acceleration = 8,
BrakeRate = 2,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 62,
MaxVelocity = 2.8,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 850,
nanocolor=[[0.7 0 0.1]],
sightDistance = 550,
	explodeAs="citadelldrone",
	selfDestructAs="citadelldrone", 

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
strafeToAttack=true,
shownanoframe=0,
 --corpse             = "bgcorpse",
 
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:bloodspray",
	   
	   
	   
	   
						  },
	
			},

 
 
Category = [[LAND]],

weapons = {
[1]={name  = "razordrone",
	onlyTargetCategory = [[ LAND]],
	
	},
},


}

return lowerkeys({ [unitName] = unitDef })