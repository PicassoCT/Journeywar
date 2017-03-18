local unitName = "jresistancewarrior"

local unitDef = {
name = "Resistance Warrior",
Description = "fighting the man, to be a man",
objectName = "jResistanceWarrior.s3o",
script = "jresistancewarrior.lua",
buildPic = "placeholderj.png",
moveState =2,
--cost
buildCostMetal = 55,
buildCostEnergy = 100,
buildTime = 3,
--Health
maxDamage = 200,
idleAutoHeal = 5,
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

cancloak=true,
cloakCost=2.7,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
strafeToAttack=true,
shownanoframe=0,
 corpse             = "cinfantrycorpse",
 
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:bloodspray",
	   
	   
	   
	   
						  },
	
			},

 
 
Category = [[LAND]],

weapons = {
[1]={name  = "jressubmg",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "jresrpg",
	onlyTargetCategory = [[LAND AIR]]
	},
},


}

return lowerkeys({ [unitName] = unitDef })