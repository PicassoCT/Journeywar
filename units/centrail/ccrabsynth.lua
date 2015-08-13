local unitName = "ccrabsynth"

local unitDef = {
name = "Crab Synth",
Description = "Combined Crab Synth",
objectName = "placeholder.s3o",
script = "cCrabSynthScript.lua",
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
onoffable=true,
ActivateWhenBuilt=0,
--Movement
mass=120,
upright=true,
Acceleration = 8,
BrakeRate = 2,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 62,
MaxVelocity = 	1.4,
MaxWaterDepth = 120,
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
strafeToAttack=false,
shownanoframe=0,

 
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:AR2Muzzle",
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