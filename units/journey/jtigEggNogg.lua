local unitName = "jtigeggnogg"

local unitDef = {
name = "Tiglilegg",
Description = "Grows into a Tigerlily",

objectName = "tigEggNogg.s3o",
script = "tiglilegg.lua",
buildPic = "tiglil.png",


	RadarDistance = 0,
	SightDistance = 400,	
	Upright = 1,	
	levelground = 0,



--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 5,
--Health
maxDamage = 150,
idleAutoHeal = 0,
--Movement

FootprintX = 1,
FootprintZ = 1,
MaxSlope = 20,

MaxWaterDepth = 90,
MovementClass = "Default2x2",
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



radardistance=150,
sightDistance = 700,

EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 0,	


CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false, 

Builder = false,
ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,	
workerTime = 1.00,
buildDistance = 200,
terraformSpeed = 50,

-- Pathfinding and related
nanocolor=[[1 0.2 0.05]],
-- Building	

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
     "custom:fruitwater",

	
	  
    },
	},

Category = [[LAND]],
}

return lowerkeys({ [unitName] = unitDef })