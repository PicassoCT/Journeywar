local unitName = "advisor"

local unitDef = {
name = "Advisor Stalker",
Description = "Psionic Information Unit: Extracts Infos from captured Units",
objectName = "advisor.s3o",
script = "cAdvisor.lua",
buildPic = "advstalker.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 450,
buildTime = 6,
--Health
maxDamage = 620,
idleAutoHeal = 3,
--Movement
Acceleration = 0.3,
BrakeRate = 0.5,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 60,
MaxVelocity = 1.2,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 950,
nanocolor=[[0 0.9 0.9]],
sightDistance = 600,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 
onoffable=true,
	activateWhenBuilt=false,
 transportByEnemy    = false,
  transportCapacity   = 1,
  transportSize       = 3,
Category = [[LAND]],

weapons = {
[1]={name  = "advisorPsiRay",
	onlyTargetCategory = [[LAND TRAITOR]],
	},
},

 customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:advisorpsi",--28
						  },
	
				},


}

return lowerkeys({ [unitName] = unitDef })