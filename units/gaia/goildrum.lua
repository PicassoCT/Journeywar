local unitName = "goildrum"
local unitDef = {
	name = "Oildrums",
	Description = "",
	objectName = "oildrum.s3o",
	script = "goildrumscript.lua",
	buildPic = "placeholder.png",

	
	RadarDistance = 0,
	SightDistance = 0,	
	Upright = 1,	
	levelground = 0,
	
	
	
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 12,
	buildTime = 5,
	--Health
	maxDamage = 50,
	idleAutoHeal = 0,
	--Movement
	
	
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	radardistance=150,
	sightDistance = 700,
	
	EnergyStorage = 200,
	EnergyUse = 15,
	MetalStorage = 200,
	EnergyMake = 75, 
	MakesMetal = 5, 
	MetalMake = 0,	
	
	
	CanAttack = false,
	CanGuard = false,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	

	

	
	-- Pathfinding and related
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 10,	
	
	
	-- Building	

	Reclaimable = true,



	customParams = {},
	sfxtypes = {
		explosiongenerators = {
	
	   "custom:cssdeathflames",
	   "custom:fireball",
	   "custom:firefive",		--1026
	   "custom:cssfirejet"		--1027
	   
			
		},
	},
	
	Category = [[LAND BUILDING]],
}

return lowerkeys({ [unitName] = unitDef })