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
 
 explodeAs="defaultweapon",
	selfDestructAs="defaultweapon", 
 
  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:AR2Impact",
	   "custom:AR2Muzzle",
	   "custom:AR2Projectile",
	   "custom:bloodspray"
	   
	   
	   
	   
						  },
	
			},

 
 
Category = [[LAND]],

weapons = {
[1]={name  = "cwallbuildw",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},

[2]={name  = "AR2",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},

[3]={name  = "cwallbuildw",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},

[4]={name  = "AR2",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},

[5]={name  = "AR2",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},
[6]={name  = "AR2",
	onlyTargetCategory = [[ LAND AIR]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},
[7]={name  = "citadelldrone",
	onlyTargetCategory = [[ LAND]],
	mainDir=[[0 0 1]],--nerfed
	maxAngleDif        = 120,--nerfed
	},

	
	},


}

return lowerkeys({ [unitName] = unitDef })