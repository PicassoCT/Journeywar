local unitName = "paxcentrail"

local unitDef = {
name = "Pax Centrail",
Description = "Prisoners forced to fight by there familys",
objectName = "cPaxCentrail.s3o",
script = "cPaxCentrailscript.lua",
buildPic = "placeholder.png",
moveState =2,
 fireState=2,
--cost
buildCostMetal = 10500,
buildCostEnergy = 20000,
buildTime = 6,
--Health
maxDamage = 24000,
idleAutoHeal = 3,
--Movement
mass=12000,
upright=true,
Acceleration = 0.1,
BrakeRate = 2,
FootprintX = 1,
FootprintZ = 1,
MaxSlope = 62,
MaxVelocity = 0.314,
MaxWaterDepth = 90,
MovementClass = "Default2x2",
TurnRate = 50,
nanocolor=[[0.7 0 0.1]],
sightDistance = 550,
activateWhenBuilt=false,
onoffable=true,
Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
strafeToAttack=true,
shownanoframe=0,
 corpse             = "bgcorpse",
 
 explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	  "custom:cbonkerplasma",
	   
	   
	   
	   
						  },
	
			},

 
 
Category = [[LAND]],

weapons = {
[1]={name  = "cexplochaingun",
	onlyTargetCategory = [[ LAND ]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},

[2]={name  = "ccitadelltur",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},

[3]={name  = "cexplochaingun",
	onlyTargetCategory = [[ LAND ]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},

[4]={name  = "ccitadelltur",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},

[5]={name  = "crazorgrenade",
	onlyTargetCategory = [[ LAND ]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},
[6]={name  = "crazorgrenade",
	onlyTargetCategory = [[ LAND ]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},
[7]={name  = "citadelldrone",
	onlyTargetCategory = [[ LAND]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},

[8]={name  = "cbonkerfire",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},
[9]={name  = "cbonkerfire",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},
[10]={name  = "cexpgun",
	onlyTargetCategory = [[ LAND ]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},
[11]={name  = "cexpgun",
	onlyTargetCategory = [[ LAND ]],
	mainDir=[[0 0 1]], 
	maxAngleDif        = 120, 
	},

	
	},


}

return lowerkeys({ [unitName] = unitDef })