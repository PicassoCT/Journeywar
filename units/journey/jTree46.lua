local unitName = "jtree46"

local unitDef = {
name = "Accid Tree ",
Description = " a Matter  Depot in Times of Crisis.",
objectName = "jLtree6.s3o",
script = "jLtreescript.lua",
buildPic = "jtree.png",
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
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


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
   
		usebuildinggrounddecal = true,

		buildinggrounddecaldecayspeed = 0.00002,
		buildinggrounddecalsizex = 6,
		buildinggrounddecalsizey = 6,
		buildinggrounddecaltype = "jLTreeRoot4.png",
   
 sfxtypes = {
				explosiongenerators = {
	
				   --
				    --Bulletof The Cannon
				},
  }
  
  ------------------------




}

return lowerkeys({ [unitName] = unitDef })