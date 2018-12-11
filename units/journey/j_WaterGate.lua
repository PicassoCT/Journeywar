local unitName = "jwatergate"
local unitDef = {
name = "Watergate",
Description = "floods the World via a Waterworldwormhole <Terraforming Unit>",
objectName = "jWaterGate.s3o",
script = "j_WaterGate.lua",
buildPic = "jwatergate.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 12,
buildTime = 5,
--Health
maxDamage = 2500,
idleAutoHeal = 5,
--Movement
Acceleration = 0.25,
BrakeRate = 0.3,
FootprintX = 8,
FootprintZ = 8,
MaxSlope = 20,
MaxVelocity = 3.0,
MaxWaterDepth = 999999,
MovementClass = "Default2x2",
TurnRate = 0,

radardistance=150,
sightDistance = 700,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


nanocolor=[[0.8 1 0.1]], --
Category = [[LAND BUILDING]],
EnergyStorage = 200,
	EnergyUse = 5,
	EnergyMake =25,
	MetalStorage = 0,
	
	MakesMetal = 0, 
	MetalMake = 0,	
	floater =true,
	--minWaterDepth =10,
	--waterline =5,

CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = true,
CanStop = true,
--LeaveTracks = false, 
onoffable=true,
activateWhenBuilt=true,


   customParams = {},
 sfxtypes = {
				explosiongenerators = {
		
				   "custom:watergatesfx",
				   "custom:waterwaves",
			
				},

},

}
return lowerkeys({ [unitName] = unitDef })