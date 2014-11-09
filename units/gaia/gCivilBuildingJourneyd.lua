local unitName = "gcivilbuildingjourneyed"

local unitDef = {
name = "civilbuilding",
Description = "Overgrown Officebuilding: Journeyman Un. Limited",
objectName = "cCivilBuilding2.s3o",
script = "cCivilBuilding.lua",
buildPic = "placeholder.png",
levelGround =false,
--cost
buildCostMetal = 15,
buildCostEnergy = 1,
buildTime = 1,
--Health
maxDamage = 6660,
idleAutoHeal = 15,
autoheal=10,
--Movement
mass=180020,
upRight=true,
Acceleration = 0.0000001,
BrakeRate = 0.0001,
FootprintX = 5,
FootprintZ = 5,
MaxSlope = 90,
yardmap="yyoyyyoooyoooooyoooyyyoyy",
MaxWaterDepth = 15,
MovementClass = "Default2x2",
TurnRate = 1,
pushResistant=true,
sightDistance = 80,

reclaimable=true,
Builder = false,
CanAttack = true,
CanGuard = false,
CanMove = false,
CanPatrol = false,
CanStop = true,
LeaveTracks = false,
useSmoothMesh = false,

 corpse             = "lavafeature",
 

 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
				   "custom:factory_explosion",
	   		       "custom:flames",
				   "custom:glowsmoke",
				   "custom:blackerthensmoke",
				   "custom:LightUponSmoke",  
						  },
	
			},

 
 
Category = [[LAND]],




}

return lowerkeys({ [unitName] = unitDef })