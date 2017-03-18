local unitName = "jtree2"

local unitDef = {
	name = "Future Tree",
	Description = " Grows into a Dream Tree with Radiation",
	objectName = "jEtree2.s3o",
	script = "jTree2.lua",
	buildPic = "jtreeRad.png",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 50,
	buildTime =1,
	--Health
	maxDamage = 400,
	idleAutoHeal = 1,
	--Movement
	showNanoFrame=false,
	FootprintX = 2,
	FootprintZ = 2,
	
	--MaxVelocity = 0.5,
	MaxWaterDepth =15,
	--MovementClass = "Default2x2",--
	
	
	sightDistance = 25,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	reclaimable=true,
	CanAttack = false,
	CanGuard = false,
	CanMove = false,
	CanPatrol = false,
	CanStop = false,
	TurnRate = 200,
	LeaveTracks = false,
	-- Building	
	Category = [[LAND BUILDING]],
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 5, 
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
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt",
			"custom:fireSparks", --1025
			"custom:blackerThenSmoke",
			"custom:flames", --1027
			"custom:leaves", --1028
			--
			--Bulletof The Cannon
		},
	}
	
	------------------------
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })