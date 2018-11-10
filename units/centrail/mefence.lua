local unitName = "mefence"

local unitDef = {
	name = "Efence",
	Description= " moving Wall <Mobile Wall>",
	objectName = "mefence.s3o",
	script ="cmEfence.lua",
	buildPic = "efence.dds",
	RadarDistance = 0,
	SightDistance = 100,
	
	buildCostMetal = 180,
	buildCostEnergy = 250,
	buildTime = 34,
	
	maxDamage = 2800,
	idleAutoHeal = 1,
	nanocolor=[[0 0.9 0.9]],
	
	EnergyUse = 5,
	
	------------------------------
	
	--Movement
	Acceleration = 0.05,
	BrakeRate = 0.3,
	turnInPlace = false,
	MaxVelocity = 0.1,
	MaxWaterDepth = 7,
	MovementClass = "Default2x2",
	TurnRate = 15,
	radardistance=150,
	sightDistance = 700,
	mass=3000,
	
	
	canPatrol = true,
	canMove= true,
	CanBeAssisted = true,
	CanReclaim=false,	
	onOffable = true,
	activateWhenBuilt=false,
	
	collisionvolumetype = "box",
	collisionvolumescales = "140 45 15",
	collisionvolumeoffsets = "0 0 0",
	
	
	Reclaimable = true,
	
	
	
	
	-- Pathfinding and related
	
	MaxSlope = 50,	
	YardMap ="oooccooo",
	
	-- Building	
	
	
	--custom UnitDefParameter
	
	FootprintX = 8,
	FootprintZ = 1,
	
	category = [[LAND]],
	
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt",
			"custom:redlight",
			"custom:greenlight",
			
			
		},
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })