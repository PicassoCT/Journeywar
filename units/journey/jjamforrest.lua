local unitName = "jjamforrest"

local unitDef = {
	name = "Rainforrest ",
	Description = "Jams Enemys Radar.",
	objectName = "jjam.s3o",
	script = "jjamscript.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 50,
	buildTime =1,
	--Health
	maxDamage = 400,
	idleAutoHeal = 1,
	--Movement
	
	FootprintX = 16,
	FootprintZ = 16,
	
	--MaxVelocity = 0.5,
	MaxWaterDepth =15,
	--MovementClass = "Default2x2",--
	
	
	sightDistance = 225,
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
	radarDistanceJam=950,
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
	activateWhenBuilt = true,
	noAutoFire = false,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:fog",
			"custom:leaves", --1028
			
			--
			--Bulletof The Cannon
		},
	}
	
	------------------------
	
	
	
	
}

return lowerkeys({ [unitName] = unitDef })