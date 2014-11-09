local unitName = "jfiredancer"

local unitDef = {
name = "Firedancer",
Description = "those who created the Centrail, amending for there sins.",
objectName = "jfiredancer.s3o",
script = "jfiredancerscript.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 310,
buildCostEnergy = 350,
buildTime = 9,
--Health
maxDamage = 350,
idleAutoHeal = 3,
--Movement
mass=220,
Acceleration = 1.4,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope =72,
MaxVelocity = 1.5,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 1000,
upRight=true,
sightDistance = 630,
 corpse             = "cInfantryCorpse",
   selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


 
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
nanocolor=[[0.2 0.9 0.5]],
Category = [[LAND]],
  activateWhenBuilt      = false,
    onoffable              = true,
 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:firedancesparks",             --Thumper
				   "custom:bloodspray",
				   --
				    --Bulletof The Cannon
				},	
	},	
	
	
weapons = {
[1]={name  = "jfiredancerproj",
	onlyTargetCategory = [[AIR]],
	},

},


}

return lowerkeys({ [unitName] = unitDef })