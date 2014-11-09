local unitName = "gLava"

local unitDef = {
name = "Lava(Gaia)",
Description = "Lavastream",
objectName = "gLavaUnit.s3o",
script = "gLavaUnit.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 666,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=180020,

Acceleration = 0.00001,
BrakeRate = 0.0001,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 90,
MaxVelocity = 0.000001,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 22,

sightDistance = 80,

reclaimable=true,
Builder = false,
CanAttack = true,
CanGuard = false,
CanMove = true,
CanPatrol = false,
CanStop = true,
LeaveTracks = false,
useSmoothMesh = false,

 corpse             = "lavafeature",
 

 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:fireSparks",
	   "custom:volcanoflames",
	   "custom:volcanolightsmall",--1026
	   
						  },
	
			},

 
 
Category = [[NOTARGET]],
--[[
EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
  acceleration           = 0,

  activateWhenBuilt      = true,
 ]] 
weapons = {
[1]={name  = "gLavaWeapon",
	onlyTargetCategory = [[LAND]],
	},
},



}

return lowerkeys({ [unitName] = unitDef })