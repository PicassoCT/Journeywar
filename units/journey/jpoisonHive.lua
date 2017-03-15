local unitName = "jpoisonhive"
local unitDef = {
	name = "Poison Dart Hive :",
	Description = "Spawns Poisonous Spiders",
	objectName = "jPoisonDartTower.s3o",
	script = "jPoisonHivescript.lua",
	buildPic = "jpoisonhive.png",
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
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })