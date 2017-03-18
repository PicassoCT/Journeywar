local unitName = "csuborbexplo"

local unitDef = {
	name = "Ground Zero",
	Description = "If you read this.. everyone around you is doomed",
	objectName = "cSubOrbImpactor.s3o",
	script = "csuborbexplo.lua",
	buildPic = "placeholder.png",
	--floater = true,
	--cost
	buildCostMetal = 0,
	buildCostEnergy = 0,
	buildTime =1,
	--Health
	maxDamage = 1200,
	idleAutoHeal = 0,
	--Movement
	
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 5,
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
	--MovementClass = "Default2x2",--
	
	
	sightDistance = 300,
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat",
	
	
	
	
	
	
	
	
	
	
	Category = [[AIR]],
	
	
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:cnukering",
			"custom:spherespawn",
			"custom:flames",--1026
			"custom:fireSparks",--1027
			"custom:unitonfire",--1028
			"custom:nukular",--1029
			"custom:glowsmoke",--1030
			"custom:volcanolightsmall",--1031
			"custom:csuborbscrap",--1032
			
			
			
			
		},
		
	},
	
}

return lowerkeys({ [unitName] = unitDef })