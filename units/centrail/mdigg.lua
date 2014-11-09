local unitName = "mdigg"

local unitDef = {
name = "Metalldiggester",
Description = "Harvests Metall, can be used for stripmining and artillery",
objectName = "mdigg.s3o",
script = "mdigscript.lua",
buildPic = "mdiggMex.dds",
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
FootprintX = 4,
FootprintZ = 4,
MaxSlope = 5,
MaxVelocity = 0.5,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 200,
isMetalExtractor = false,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
onoffable=true,
activateWhenBuilt =false,
Builder = false,
CanAttack = false,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = true, 
trackType ="mdigg",
  trackStrength=192,
  trackWidth =66,
Category = [[LAND]],

NoWeapon=true,
explodeAs="defaultweapon",
selfDestructAs="defaultweapon",
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
				   "custom:fireSparks",
				   "custom:smokeScreen",
				   --
				    --Bulletof The Cannon
				},

},



}

return lowerkeys({ [unitName] = unitDef })