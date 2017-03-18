local unitName = "jghostdancer"

local unitDef = {
	name = "Ghost Dancer",
	Description = "backtracks to alternative Timelines on Damage",
	objectName = "ghostdancer.s3o",
	script = "jghostdancer.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 280,
	buildCostEnergy = 620,
	buildTime = 9,
	--Health
	maxDamage = 850,
	idleAutoHeal = 12,
	--Movement
	Acceleration = 0.4,
	BrakeRate = 0.3,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 20,
	MaxVelocity = 5.2,
	MaxWaterDepth = 5,
	MovementClass = "jinfantry",
	TurnRate = 900,
	mass=1250,
	sightDistance = 900,
	nanocolor=[[0.2 0.9 0.5]],
	turnInPlace=true, 
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	CanStop = true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	onOffable=true,
	Category = [[LAND]],
	-- leaveTracks =true,
	-- trackType ="cRes",
	
	--explodeAs = "330RLexplode",
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:dirt", --Thumper
			"custom:jghoststripe", --Thumper
			--
			--Bulletof The Cannon
		},
	},
	
	
	weapons = {
		[1]={name = "jGDCloseCombat",
			onlyTargetCategory = [[LAND TRAITOR]],
		},
		[2]={name = "jGDJump",
			onlyTargetCategory = [[LAND]],
		},
	},
}

return lowerkeys({ [unitName] = unitDef })