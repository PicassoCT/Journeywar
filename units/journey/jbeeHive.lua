local unitName = "jbeehive"

local unitDef = {
	name = "Hornethive",
	Description = " horryfing Hornets harassing hungry Honeythieves",
	objectName = "jhornethive.s3o",
	script = "jbeehive.lua",
	buildPic = "jbeehive.png",
	--cost
	buildCostMetal = 950,
	buildCostEnergy = 750,
	buildTime = 35,
	--Health
	maxDamage = 3950,
	mass=1024,
	idleAutoHeal = 25,
	idletime=3000,
	--Movement
	
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 10,	
	sightDistance = 600,
	nanocolor=[[0 0.9 0.9]],
	
	CanAttack = true,
	CanGuard = true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	
	CanMove = false,
	CanPatrol = false,
	CanStop = true,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			
		},
		
	},
	
	
	
	
	Category = [[LAND BUILDING]],
	
	weapons = {
		[1]={name = "jhornetBeehive",
			onlyTargetCategory = [[ LAND AIR]],
		},
		
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })