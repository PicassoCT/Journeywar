local unitName = "jshroudshrike"
local unitDef = {
	name = "Shroudshrike",
	Description = "transfers Experience into a variable Direction. <Buff>",
	
	
	objectName = "jshroudshrike.s3o",
	script = "jshroudshrikescript.lua",
	buildPic = "jshroudshrike.png",
	
	--cost
	buildCostMetal = 200,
	buildCostEnergy = 50,
	buildTime = 12,
	CanReclaim=false,
	
	onoffable=true,
	upright=true,
	acitvateonstart=true,
	--Health
	maxDamage = 1200,
	idleAutoHeal = 3,
	--Movement
	MovementClass = "Default2x2",
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 5,
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
	TurnRate = 200,
	isMetalExtractor = false,
	sightDistance = 300,
	
	reclaimable=false,
	Builder = true,
	CanAttack = true,
	CanGuard= true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = true,
	trackType ="shroudshrike",
	trackStrength=6,
	trackWidth =32,
	trackOffset =0,
	
	Reclaimable = 0,
	
	
	corpse = "bgcorpse",
	-- Building	
	
	
	
	
	usebuildinggrounddecal = false,
	
	
	Category = [[LAND BUILDING]],
	
	EnergyStorage = 250,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 10, 
	MetalMake = 0,	
	acceleration = 2,
	
	ActivateWhenBuilt=0,
	MaxVelocity = 4.5,
	
	mass = 9990,
	
	maxSlope = 255,
	
	
	noAutoFire = false,
	
	smoothAnim = true,
	
	unitRestricted = 2,
	
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {

		},
		
	},
	
		weapons = {
		[1]={name = "jshroudtimerray",
			onlyTargetCategory = [[ LAND ]],			
		},		
		
	},
	
	
}return lowerkeys({ [unitName] = unitDef })