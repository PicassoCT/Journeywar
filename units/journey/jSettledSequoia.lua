local unitName = "jsettledsequoia"

local unitDef = {
name = "Sequoia ",
Description = " landed, regenerating Treeship <Energy>",
objectName = "jsequoia.s3o",
script = "sequoiarestingscript.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 100,
buildCostEnergy = 50,
buildTime =1,
--Health
maxDamage = 44000,
idleAutoHeal = 15,
--Movement

FootprintX = 2,
FootprintZ = 2,

--MaxVelocity = 0.5,
MaxWaterDepth =15,
--MovementClass = "Default2x2",--
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



sightDistance = 25,
onOffable = true,
ActivateWhenBuilt=false,
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
	EnergyMake = 15, 
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
				   "custom:leaves", --1028
				   --
				    --Bulletof The Cannon
				},
  }
  
  ------------------------




}

return lowerkeys({ [unitName] = unitDef })