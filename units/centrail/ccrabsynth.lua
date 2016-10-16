local unitName = "ccrabsynth"

local unitDef = {
name = "Crab Synth",
Description = "Combined Crab Synth",
objectName = "ccrabsynth.s3o",
script = "cCrabSynthScript.lua",
buildPic = "cbg.png",
moveState =3,
 fireState=2,
--cost
buildCostMetal = 105,
buildCostEnergy = 200,
buildTime = 160,
--Health
maxDamage = 18000,
idleAutoHeal = 3,
onoffable=true,
ActivateWhenBuilt=0,
--Movement
mass=12000,
upright=true,
Acceleration = 0.15,
BrakeRate = 0.8,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 62,
MaxVelocity = 	0.42,
MaxWaterDepth = 120,
MovementClass = "Default2x2",
TurnRate = 50,
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
turnInPlace =true,
 
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
[1]={name  = "celetrochain",
	onlyTargetCategory = [[ LAND ]],	
	},
},


}

return lowerkeys({ [unitName] = unitDef })