local unitName = "cheadlauncher"
local unitDef = {
name = "Headlauncher",
Description = "provokes enemies into Melees. Withstands 3 enemies <Ground Harass Tank>",
objectName = "hl.s3o",
script = "cHeadLaunchScript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 1100,
buildCostEnergy = 560,
buildTime = 46,
--Health
maxDamage = 3500,
idleAutoHeal = 2,
--Movement
Acceleration = 0.25,
BrakeRate = 0.3,
FootprintX = 3,
FootprintZ = 3,
MaxSlope = 4,
MaxVelocity = 1.5,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 100,
nanocolor=[[0 0.9 0.9]],
radardistance=150,
sightDistance = 700,

	

CanBeAssisted = false,	

CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,


	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat", 



CanBeAssisted = false,

nanocolor=[[0.5 0.9 0.5]], --
CanReclaim=false,	


	 customParams = {},
 sfxtypes = {
    explosiongenerators = {

	   "custom:electric_explosion",
	   "custom:sparkcloud",
	   "custom:cwallbuildlight",--28
						  },
	
				},


weapons = {
[1]={name  = "headlaunch",
	onlyTargetCategory = [[LAND]],
	},
		},

		Category = [[LAND]],
}
return lowerkeys({ [unitName] = unitDef })