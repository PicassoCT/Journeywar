local unitName = "jtree3dummy"

local unitDef = {
name = "Tree ",
Description = "Regenerates after Destruction. Stores Energy.",
objectName = "jETree3.s3o",
script = "jTree3.lua",
decoyFor ="jtree3",
buildPic = "jtree.png",
--cost
buildCostMetal = 1,
buildCostEnergy = 1,
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
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



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
Category = [[LAND BUILDING]],

EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
  acceleration           = 0,


  levelGround            = false,
  mass                   = 199,
  
  maxSlope               = 255,
    activateWhenBuilt      = true,
  noAutoFire             = false,
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",
				   "custom:fireSparks", --1025
				   "custom:blackerThenSmoke",
				   "custom:flames", --1027
				   "custom:leaves", --1028
				   --
				    --Bulletof The Cannon
				},
  }
  
  ------------------------




}

return lowerkeys({ [unitName] = unitDef })