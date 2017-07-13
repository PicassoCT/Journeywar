local unitName = "jhivemind"

local unitDef = {
	name = "Hivemind",
	Description = " allows for the rewinding into another branch of history",
	objectName = "placeholder.s3o",
	script = "jHiveMindScript.lua",
	buildPic = "jdragongrass.png",
	--cost
	buildCostMetal = 950,
	buildCostEnergy = 750,
	buildTime = 35,
	--Health
	maxDamage = 4200,
	mass=1024,
	idleAutoHeal = 25,
	idletime=3000,
	--Movement
	maxwaterdepth=5,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 10,	
	sightDistance = 600,
	nanocolor=[[0 0.9 0.9]],
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	CanAttack = true,
	CanGuard = true,
	
	
	CanMove = false,
	CanPatrol = false,
	CanStop = true,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:orangespores",
		},
		
	},
	
	
	
	
	Category=[[LAND BUILDING]],	
	
	weapons = {
		[1]={name = "jfungiforrestmarker",
			onlyTargetCategory = [[ LAND AIR]],
		},
		
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })