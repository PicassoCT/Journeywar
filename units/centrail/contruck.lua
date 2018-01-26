local unitName = "contruck"
local unitDef = {
name = "Construction Truck",
Description = "builds buildings using up its Hitpoints. <Construction Unit>",
objectName = "contruck.s3o",
script = "conTruck.lua",
buildPic = "contruck.dds",
--cost
buildCostMetal = 250,
buildCostEnergy = 800,
buildTime = 34,
--Health
maxDamage = 500,
idleAutoHeal = 0,
--Movement
Acceleration = 0.10,

BrakeRate = 0.10,
FootprintX = 3,
FootprintZ = 3,
MaxSlope = 5,
MaxVelocity = 4.2,
MaxWaterDepth = 10,
MovementClass = "allterrain",
reclaimSpeed=3,
TurnRate = 224,--6 42 -- 12 84  --18 126  --24 168
mass=9000,
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
turnInPlace=true, 
Builder = true,
CanAttack = false,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,

	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 

upright=false,

Category = [[LAND]],
  leaveTracks =true,
  trackType ="ctrain",
ShowNanoSpray = false,
CanBeAssisted = true,
CanReclaim=false,	
workerTime = 0.6,
buildDistance = 50,
terraformSpeed = 0.2,

	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",     
				   "custom:bloodspray",
				   "custom:weldArc"				   
									},
				},
  
}

return lowerkeys({ [unitName] = unitDef })