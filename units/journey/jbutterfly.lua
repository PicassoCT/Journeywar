local unitName = "jbutterfly"

local unitDef = {
name = "butterfly",
Description = "Unit respawns a Eliah",
objectName = "jbutterfly.s3o",
script = "jbutterfly.lua",
buildPic = "placeholderj.png",


--cost
buildCostMetal = 260,
buildCostEnergy = 130,
buildTime = 6,
--Health
maxDamage = 150,
idleAutoHeal = 0,
--Movement
Acceleration = 0.05,
BrakeRate = 1,
FootprintX = 1,
FootprintZ = 1,
TEDClass            = [[VTOL]],
steeringmode        = [[1]],
maneuverleashlength = 1380,
turnRadius		  	= 8,

MaxVelocity = 0.5,
MaxWaterDepth = 0,
--MovementClass = "Default2x2",
TurnRate = 150,
nanocolor=[[0 0.9 0.9]],
sightDistance = 500,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",




--canHover=true,
CanAttack = false,
CanGuard = false,
CanMove = true,
CanPatrol = true,
Canstop  = false,
LeaveTracks = false, 
cruiseAlt=165,
CanFly   = true,
ActivateWhenBuilt=0,
maxBank=0.4,
myGravity =0.5,
mass                = 125,
canSubmerge         = false,
useSmoothMesh =true,
collide             = true,
crashDrag =0.1,



Category = [[AIR]],






}

return lowerkeys({ [unitName] = unitDef })