local unitName = "bg"

local unitDef = {
name = "Black Guard",
Description = "Combine Soldier",
objectName = "bg.s3o",
script = "bgscript.lua",
buildPic = "cbg.png",
moveState =3,
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

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
strafeToAttack=true,
shownanoframe=0,
 corpse             = "bgcorpse",
 
	explodeAs="defaultweapon",
	selfDestructAs="defaultweapon", 
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:AR2Impact",
	   "custom:AR2Muzzle",
	   "custom:AR2Projectile",
	   "custom:bloodspray"
						  },
	
			},

 
 
Category = [[LAND]],

weapons = {
[1]={name  = "AR2",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	
	},
},


}

return lowerkeys({ [unitName] = unitDef })