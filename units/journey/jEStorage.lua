local unitName = "jestorage"
local unitDef = {
name = "Light Storage",
Description = " stores Energy",
objectName = "jEstorage.s3o",
script = "jestoragescript.lua",
buildPic = "jmestorage.png",
--cost

buildCostMetal = 3000,
buildCostEnergy = 9000,
buildTime = 240,
--Health
maxDamage = 1200,
idleAutoHeal = 0,

--Movement
MaxVelocity=0.07,
Acceleration = 0.01,
BrakeRate = 0.05,
FootprintX = 6,
FootprintZ = 6,
MaxSlope = 20,
MaxWaterDepth = 10,
MovementClass = "Default2x2",
TurnRate = 200,

sightDistance = 600,
CanBeAssisted = true,
CanReclaim=false,	
workerTime = 0.2,
buildDistance = 5000,
terraformSpeed = 50,

  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",

EnergyStorage = 1200,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 5, 
	MakesMetal = 0, 
	MetalMake = 0,	

CanGuard = true,
CanMove = true,
canassist=true,
CanStop = true,
LeaveTracks = false, 
nanocolor=[[0.2 0.9 0.5]],
Category = [[LAND]],


}

return lowerkeys({ [unitName] = unitDef })