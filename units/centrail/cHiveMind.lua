local unitName = "chivemind"

local unitDef = {
	name = "Hivemind",
	Description = " sacrifices individuals for strategic thought speed <Buff Building>",
	objectName = "cHiveMind.s3o",
	script = "cHiveMindScript.lua",
	buildPic = "chivemind.png",
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
	MaxSlope = 50,	
	sightDistance = 600,
	nanocolor=[[0 0.9 0.9]],
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	onoffable=true,
	ActivateWhenBuilt= false,
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
	

	
	
}

return lowerkeys({ [unitName] = unitDef })