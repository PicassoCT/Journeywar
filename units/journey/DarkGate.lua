local unitName = "jdarkgate"

local unitDef = {
name = "Darkgate ",
Description = "takes and gives Matter and Light from other Journeyworlds <Basic Positiv Negative Income>",
objectName = "jDarkGate.s3o",
script = "jDarkGateScript.lua",
buildPic = "jdarkgate.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 50,
buildTime =1,
--Health
maxDamage = 400,
idleAutoHeal = 1,
--Movement

FootprintX = 2,
FootprintZ = 2,

--MaxVelocity = 0.5,
MaxWaterDepth =15,
--MovementClass = "Default2x2",--


sightDistance = 25,

reclaimable=true,
CanAttack = false,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = false,
TurnRate = 200,
LeaveTracks = false,
-- Building	
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


Category = [[LAND BUILDING]],

EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
  acceleration           = 0,


  levelGround            = false,
  mass                   = 2900,
  
  maxSlope               = 255,
    activateWhenBuilt      = true,
  noAutoFire             = false,
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",
				   "custom:jdarkgateoutwards",
				   "custom:jdarkgateinwards",
				   "custom:darkgatesfx",
				   --outwardSFX
				   --inwardSFX
				   --blackhole
				   --whirlpool

				   --
				    --Bulletof The Cannon
				},
  }
  
  ------------------------




}

return lowerkeys({ [unitName] = unitDef })