local unitName = "contrain"

local unitDef = {
name = "Construction Train",
Description = "supports construction & heals units, using up health.",
objectName = "conTrain.s3o",
script = "cConTrain.lua",
buildPic = "ccontrain.dds",
--cost
buildCostMetal = 900,
buildCostEnergy = 800,
buildTime = 34,
--Health
maxDamage = 1250,
idleAutoHeal = 0,
--Movement
Acceleration = 0.10,

BrakeRate = 0.10,
FootprintX = 5,
FootprintZ = 5,
MaxSlope = 20,
MaxVelocity = 7.2,
MaxWaterDepth = 30,
MovementClass = "Train",
TurnRate = 24,--6 42 -- 12 84  --18 126  --24 168
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
	selfDestructAs="cArtDM", 

upright=true,
 transportCapacity   = 3,
  transportSize       = 3000,
  
  
Category = [[LAND]],
  leaveTracks =true,
  trackType ="cTrain",
ShowNanoSpray = false,
CanBeAssisted = true,
CanReclaim=false,	
workerTime = 0.6,
buildDistance = 110,
terraformSpeed = 0.2,

	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",     
				   "custom:bloodspray",
				      "custom:healtrain",
				     --electric Sparc
				     --electric Sparc
				   
				},
				},
  


}

return lowerkeys({ [unitName] = unitDef })