local unitName = "mdigg"

local unitDef = {
	name = "Metalldiggester",
	Description = "mobile to drive towards Matter Ressource Locations <Matter Production Unit>",
	objectName = "mdigg.s3o",
	script = "mdigscript.lua",
	buildPic = "mdigg.png",
	--cost
	
	buildCostMetal = 850,
	buildCostEnergy = 340,
	buildTime = 50,
	--Health
	maxDamage = 2300,
	idleAutoHeal = 3,
	--Movement
	Acceleration = 0.4,
	BrakeRate = 0.3,
	FootprintX = 4,
	FootprintZ = 4,
	MaxSlope = 5,
	MaxVelocity = 0.5,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	TurnRate = 100,
	isMetalExtractor = false,
	sightDistance = 500,
	nanocolor=[[0 0.9 0.9]],
	onoffable=true,
	activateWhenBuilt =false,
	Builder = false,
	CanAttack = false,
	CanGuard = false,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = true, 
	trackType ="mdigg",
	trackStrength=192,
	trackWidth =66,
	trackOffset =52,
	Category = [[LAND]],
	
	NoWeapon=true,
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]],
	EnergyStorage = 0,
	EnergyUse = 15,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 1, 
	MetalMake = 0,	
	customParams = {ability_description="Start\n Mining"},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", --Thumper
			"custom:fireSparks",
			"custom:smokeScreen",
			--
			--Bulletof The Cannon
		},
		
	},
	
	
	
}

return lowerkeys({ [unitName] = unitDef })