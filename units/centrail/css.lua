local unitName = "css"

local unitDef = {
name = "Combine Super Soldier",
Description = "Combine Soldier",
objectName = "css.s3o",
script = "css.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 105,
buildCostEnergy = 200,
buildTime = 6,



--Health
maxDamage = 540,
idleAutoHeal = 3,
--Movement
mass=1200,
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

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 
strafeToAttack=true,
shownanoframe=0,
 corpse             = "bgcorpse",
 
 	explodeAs="cflamethrower",
	selfDestructAs="cflamethrower",
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {

	   "custom:cssdeathflames",
	   "custom:fireball",
	   "custom:firefive"		--1026
	   
	   
	   
						  },
	
			},

 
 
Category = [[LAND]],

weapons = {
[1]={name  = "cflamethrower",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "cflamethrower",
	onlyTargetCategory = [[LAND]],
	},
},


}

return lowerkeys({ [unitName] = unitDef })