local unitName = "bonker"

local unitDef = {
name = "Bonker :",
Description = "Heavy Defense Outpost",
objectName = "bonker.s3o",
script = "bonker.lua",
buildPic = "cbonker.dds",

--cost
buildCostMetal = 950,
buildCostEnergy = 750,
buildTime = 35,
--Health
maxDamage = 3950,
mass=10024,
idleAutoHeal = 25,
idletime=3000,
--Movement

	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 10,	
sightDistance = 600,
nanocolor=[[0 0.9 0.9]],

CanAttack = true,
CanGuard = true,

explodeAs="citadelldrone",
selfDestructAs="citadelldrone", 

CanMove = false,
CanPatrol = false,
CanStop = true,

	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:bonkermuzzle",
	   "custom:cbonkerplasma",
	 --  "custom:electric_explosion",
						  },
	
				},
				
		
	
	
category=[[LAND BUILDING]],	

weapons = {
[1]={name  = "cbonkerfire",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "cbonkerfire",
	onlyTargetCategory = [[LAND]],
	},
[3]={name  = "bonkermaschinegun",
	onlyTargetCategory = [[AIR]],
	},		
	
},

}

return lowerkeys({ [unitName] = unitDef })