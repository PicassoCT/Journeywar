local unitName = "jeliah"

local unitDef = {
name = "eliah",
Description = "Infantry in BioMechSuit",
objectName = "jeliah.s3o",
script = "jEliahScript.lua",
buildPic = "jeliah.png",
--cost
buildCostMetal = 110,
buildCostEnergy = 350,
buildTime = 9,
--Health
maxDamage = 320,
idleAutoHeal = 3,
--Movement
mass=220,
Acceleration = 0.3,
BrakeRate = 0.3,
FootprintX = 1,
FootprintZ = 1,
MaxSlope =72,
MaxVelocity = 1.3,
MaxWaterDepth = 20,
MovementClass = "Default2x2",
TurnRate = 1000,
upRight=true,
sightDistance = 630,

Builder = false,
CanAttack = true,
CanGuard = true,
CanMove = true,
CanPatrol = true,
CanStop = true,
LeaveTracks = false, 
nanocolor=[[0.2 0.9 0.5]],
Category = [[LAND]],
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


weapons = {
[1]={name  = "jeliahbeam",
	onlyTargetCategory = [[ LAND ]],
	
	},
[2]={name  = "jeliahbeam",
	onlyTargetCategory = [[ LAND]],
	},
[3]={name  = "jeliahbeamslave",
	onlyTargetCategory = [[ LAND ]],
	
	},
[4]={name  = "jeliahbeamslave",
	onlyTargetCategory = [[ LAND]],
	
	},

[5]={name  = "jeliahbeamslave",
	onlyTargetCategory = [[ LAND ]],
	
	},
[6]={name  = "jeliahbeamslave",
	onlyTargetCategory = [[ LAND]],
	
	},	
[7]={name  = "jeliahshield",
	onlyTargetCategory = [[LAND AIR]],
	},	
		},
		

}

return lowerkeys({ [unitName] = unitDef })