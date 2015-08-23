local unitName = "chunterchopper"

local unitDef = {
name = "Hunter Chopper",
Description = "Helicopter",
objectName = "chchopper.s3o",
script = "cHunterChopperScript.lua",
buildPic = "chunterchopper.dds",

--cost
buildCostMetal = 260,
buildCostEnergy = 130,
buildTime = 26,
--Health
maxDamage =1950,
idleAutoHeal = 0,
--Movement
Acceleration = 1.9,
BrakeRate = 1,
FootprintX = 3,
FootprintZ = 3,
TEDClass            = [[VTOL]],
steeringmode        = [[1]],
maneuverleashlength = 1380,
turnRadius		  	= 16,
dontLand		 	= false,
MaxVelocity = 8.5,
MaxWaterDepth = 0,
MovementClass = "Default2x2",
TurnRate = 250,
nanocolor=[[0 0.9 0.9]],
sightDistance = 500,

airstrafe=true,
factoryHeadingTakeoff =true,
Builder = false,
--canHover=true,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
Canstop  = true,--alt
LeaveTracks = false, 

cruiseAlt=175,
CanFly   = true,
ActivateWhenBuilt=1,
--maxBank=0.4,
myGravity =0.5,
mass                = 1900,
canSubmerge         = false,
useSmoothMesh =true,
collide             = true,
--crashDrag =0.1,
--airHoverFactor=0.1,
airStrafe =true,
hoverAttack  = true,
strafeToAttack=true,


Category = [[AIR]],

	explodeAs="citadelldrone",
	selfDestructAs="cArtDM", 
	ShowNanoSpray = false,
	CanBeAssisted = false,
	CanReclaim=false,	

  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:chopperdirt",
	   "custom:choppermuzzle",
	   "custom:flyinggrass",
	   "custom:blackerthensmoke",--1027
	   "custom:330rlexplode",--1028
	 
	   
	   
	   
						  },
	
			},
			
			
			weapons = {
[1]={name  = "cchoppermg",
	onlyTargetCategory = [[ LAND]],
	 MainDir            = [[0 0 1]],
      MaxAngleDif        = 90,

	},
[2]={name  = "cchoperrocket",
	onlyTargetCategory = [[AIR]],
	mainDir=[[0 0 1]],
	maxAngleDif        = 90,
	},
[3]={name  = "cchoppermines",
	onlyTargetCategory = [[ LAND]],
	},	
[4]={name  = "cwaterbombs",
	onlyTargetCategory = [[ WATER]],
	},	

	
	
	},


}

return lowerkeys({ [unitName] = unitDef })