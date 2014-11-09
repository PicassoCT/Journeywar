local unitName = "restrictor"

local unitDef = {
name = "Restrictor",
Description = "Fast, Scout, capable of stunning buildings",
objectName = "res.s3o",
script = "cres.lua",
buildPic = "crestrictor.dds",
--cost
buildCostMetal = 380,
buildCostEnergy = 120,
buildTime = 9,
--Health
maxDamage = 1250,
idleAutoHeal = 1,
--Movement
Acceleration = 0.4,
BrakeRate = 0.3,
FootprintX = 2,
FootprintZ = 2,
MaxSlope = 20,
MaxVelocity = 5.2,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 900,
mass=650,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
turnInPlace=true, 
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 
onOffable=true,
Category = [[LAND]],
  selfDestructAs="defaultweapon",
  explodeAs = "defaultweapon",
  trackType ="cRes",
  trackStrength=12,

  
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             
				   "custom:missile_explosion",     
				},
				},
  

weapons = {
[1]={name  = "cRestricTorcannon",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "cRestricTorThumper",
	onlyTargetCategory = [[BUILDING]],
	},
},
}

return lowerkeys({ [unitName] = unitDef })