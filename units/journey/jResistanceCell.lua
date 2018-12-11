local unitName = "jresistancecell"

local unitDef = {
name = "Resistance Cell",
Description = "Can transform into a resistance outpost near a enemy civil building <Sabotage>",
objectName = "jResistanceCell.s3o",
script = "jresistancecell.lua",
buildPic = "jresistancecell.png",
--cost
buildCostMetal = 850,
buildCostEnergy = 340,
buildTime = 50,
--Health
maxDamage = 2300,
idleAutoHeal = 3,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 5,
MaxVelocity = 0.5,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 200,
isMetalExtractor = false,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
onoffable=true,
activateWhenBuilt =true,
Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false, 
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


Category = [[LAND]],

EnergyStorage = 0,
	EnergyUse = 15,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 25, 
	MetalMake = 0,	
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             --Thumper
				   "custom:smokeScreen",
				   --
				    --Bulletof The Cannon
				},

},



}

return lowerkeys({ [unitName] = unitDef })