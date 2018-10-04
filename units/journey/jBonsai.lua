local unitName = "jbonsai"

local unitDef = {
	name = "Bonsai",
	Description = "secrets a Mountainwall, in Addition raising the water level <Defense Terraform Building>",
	objectName = "jBonsai.s3o",
	script = "jBonsaiScript.lua",
	buildPic = "jbonsai.png",
	--cost
	buildCostMetal = 240,
	buildCostEnergy = 10,
	buildTime =1,
	--Health
	maxDamage = 12000,
	idleAutoHeal = 1,
	--Movement
	
	FootprintX = 8,
	FootprintZ = 8,
	
	--MaxVelocity = 0.5,
	MaxWaterDepth =15,
	--MovementClass = "Default2x2",--
	
	
	sightDistance = 25,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	reclaimable=true,

	TurnRate = 200,

	-- Building	
	Category = [[LAND BUILDING]],
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 15, 
	MakesMetal = 0, 
	MetalMake = 0,	
	acceleration = 0,
	
	
	levelGround = false,
	mass = 199,
	
	maxSlope = 255,
	
	--tree deny ability
	activateWhenBuilt = false,
	onoffable = true,
	canSelfDestruct=false,
	
	noAutoFire = false,
	
	customParams = {},
	
	usebuildinggrounddecal = true,
	
	buildinggrounddecaldecayspeed = 0.00002,
	buildinggrounddecalsizex = 16,
	buildinggrounddecalsizey = 16,
	buildinggrounddecaltype = "jTreePlater2.png",
	
	sfxtypes = {
		explosiongenerators = {
			
			--
			--Bulletof The Cannon
		},
	}
	
	------------------------
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })