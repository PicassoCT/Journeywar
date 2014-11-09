local unitName = "sentrynell"

local unitDef = {
name = "Sentrynell",
Description = "Heavy Anti Air Defense Unit, able do deploy Sentrys",
objectName = "sentrynell.s3o",
script = "sentrynellscript.lua",
buildPic = "sentrynell.dds",
--cost
buildCostMetal = 750,
buildCostEnergy = 350,
buildTime = 25,
--Health
maxDamage = 650,
idleAutoHeal = 0,
--Movement
Acceleration = 0.25,
BrakeRate = 0.3,
FootprintX = 5,
FootprintZ = 5,
MaxSlope = 5,
MaxVelocity =0.5,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 100,
selfDestructAs="defaultweapon",
explodeAs="defaultweapon",
sightDistance = 800,


CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 
mass=500,

ShowNanoSpray = true,
nanoColor = [[0  0.9  0.9]],
onoffable     = true,
activateWhenBuilt= false,
CanBeAssisted = false,
CanReclaim=false,
Builder=false,	
workerTime = 100,
buildDistance = 400,
terraformSpeed = 9001,

Category = [[LAND]],

weapons = {
[1]={name  = "SentryNellAA",
	onlyTargetCategory = [[AIR]],
	},	
},


		   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:ssuckin", --1024
				   "custom:sentrynellfire", --1025
				
				  
										},
				},
	

}

return lowerkeys({ [unitName] = unitDef })