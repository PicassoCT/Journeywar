local unitName = "cadvisor"

local unitDef = {
	name = "Advisor",
	Description = "extracts Information from captured Enemys using PSI <Long Range Radar Unit/ Anti Air>",
	objectName = "advisor.s3o",
	script = "cAdvisor.lua",
	buildPic = "cadvisor.png",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 450,
	buildTime = 6,
	--Health
	maxDamage = 620,
	idleAutoHeal = 3,
	--Movement
	Acceleration = 0.2,
	BrakeRate = 0.5,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 60,
	MaxVelocity = 3.2,
	MaxWaterDepth = 20,
	MovementClass = "Default2x2",
	TurnRate = 950,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 200,
	losEmitHeight = 40,
	radarEmitHeight= 20,
	radarDistance  =200,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	Builder = false,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = false, 
	onoffable=true,
	activateWhenBuilt=false,
	transportByEnemy = false,
	transportCapacity = 1,
	transportSize = 3,
	Category = [[AIR LAND]],
	
	weapons = {
		[1]={name = "advisorPsiRay",
			onlyTargetCategory = [[LAND TRAITOR]],
		},
		[2]={name = "cadvisoraa",
			onlyTargetCategory = [[AIR]],
		},
		[3]={name = "advisor_shield"
		}
	},
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:advisorpsi",--28
			"custom:bluebloodspray",--29
		},
		
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })