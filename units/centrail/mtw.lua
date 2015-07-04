local unitName = "mtw"

local unitDef = {
name = "MannedTransportVehicle",
Description = "Deploys CombinedFeatures. Currently holds: 0 0 0 0 0 0. Currently builds:",
objectName = "mtw.s3o",
script = "mtw.lua",
buildPic = "cmtw.png",
--cost
buildCostMetal = 550,
buildCostEnergy = 250,
buildTime = 5,
--Health
maxDamage = 950,
mass=1024,
idleAutoHeal =1,
--Movement
Acceleration = 0.12,
BrakeRate = 0.3,
FootprintX = 3,
FootprintZ = 3,
MaxSlope = 60,
MaxVelocity = 2.2,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 270,
turnInPlace =false,
selfDestructAs= [[NOWEAPON]],
sightDistance = 500,
nanocolor=[[0 0.9 0.9]],
Builder = true,
ShowNanoSpray = false,
CanBeAssisted = false,
CanAssist=false,
CanReclaim=false,
workerTime = 0.3,
buildDistance = 180,
CanAttack = true,
CanGuard = true,
CanRepair=false,
CanRestore=false,
onOffable=true,
ActivateWhenBuilt=true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = true, 
  trackType ="BIGFoot",


	  customParams = {},
 sfxtypes = {
    explosiongenerators = {

	
	   "custom:portalstorm",
	   "custom:mtwmuzzle",
	   
						  },
	
				},
				
		
	
	
Category = [[LAND]],

weapons = {
[1]={name  = "MachineGun",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "bgMtwTele",
	onlyTargetCategory = [[LAND]],
	},	
[3]={name  = "cmtwgrenade",
	onlyTargetCategory = [[LAND]],

	},	
	
},
}

return lowerkeys({ [unitName] = unitDef })