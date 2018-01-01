local unitName = "art"

local unitDef = {
name = "Dark Matter Artillery",
Description = "shells the (Head)crab out of the enemy <Long Range Artillery>",
objectName = "art.s3o",
script = "artscript.lua",
buildPic = "cart.dds",
--cost
moveState =0,
buildCostMetal = 810,
buildCostEnergy = 460,
buildTime = 14,
--Health
mass=4000,
maxDamage = 380,
idleAutoHeal = 0,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 4,
FootprintZ = 4,
MaxSlope = 10,
MaxVelocity = 2.1,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 400,
onOffable = true,
ActivateWhenBuilt=1,
nanocolor=[[0 0.9 0.9]],
sightDistance = 500,

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 

Category = [[LAND]],


	explodeAs="crabshell",
	selfDestructAs="crabshell", 

 customParams = {},
 sfxtypes = {
  explosiongenerators = {
    "custom:cartdarkmat_STARFX",
    "custom:cartdarkmat_STARIMPACTFX",

  },
},


weapons = {
[1]={name  = "crabshell",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "cartdarkmat",
	onlyTargetCategory = [[LAND]],
	},

},
}

return lowerkeys({ [unitName] = unitDef })