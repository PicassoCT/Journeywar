local unitName = "jsempresequoia"

local unitDef = {
name = "Sequoia ",
Description = "ground dominating Tree Ship",
objectName = "jsequoia.s3o",
script = "sequoiascript.lua",
buildPic = "placeholderj.png",
--cost
buildCostMetal = 10000,
buildCostEnergy = 5000,
buildTime =1,
--Health
maxDamage = 44000,
idleAutoHeal = 1,
--Movement

FootprintX = 5,
FootprintZ = 5,

MaxVelocity = 0.5,
MaxWaterDepth =15,
--MovementClass = "Default2x2",--

  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


sightDistance = 25,
onOffable = true,
ActivateWhenBuilt=false,
reclaimable=true,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = false,
TurnRate = 24,
LeaveTracks = false,
-- Building	

Category = [[AIR]],


cruiseAlt=165,
CanFly   = true,

maxBank=0.1,
myGravity =0.5,
mass                = 1225,
canSubmerge         = false,
useSmoothMesh =false,
crashDrag =0.1,
collide =true,
airHoverFactor =0,
dontLand		 	= true,
HoverAttack=1,
MovementClass = "Default2x2",
MaxWaterDepth=15,
-------------------------------

ActivateWhenBuilt=1;
BuildTime=51000;
Corpse="jbiocorpse",

RadarDistance=0,
SightDistance=800,









turnInPlace =true,

--------------------------------
Acceleration = 0.5,
maneuverleashlength = 1380,
--turnRadius		  	= 8,

weapons = {

[2]={name  = "jtreelazor",
	onlyTargetCategory = [[LAND]],
	},
[3]={name  = "jtreelazor",
	onlyTargetCategory = [[LAND]],
	},
[4]={name  = "jtreelazor",
	onlyTargetCategory = [[LAND]],
	},
[1]={name  = "jtreelazor",
	onlyTargetCategory = [[LAND]],
	},
[5]={name  = "greenseer",
	onlyTargetCategory = [[LAND]],
	},	
		},

  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",
				   "custom:leaves", --1025
				   "custom:sequoiawarp", --1026
				   --
				   
				},
  }
  
  ------------------------




}

return lowerkeys({ [unitName] = unitDef })