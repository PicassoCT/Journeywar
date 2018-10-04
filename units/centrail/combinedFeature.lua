local unitName = "cwatchpost"

local unitDef = {
	name = "Overwatch Outpost",
	Description = " sterlizes the nearby Exobiotic fauna <Area Debuff Building>",
	objectName = "cCombineOutPost.s3o",
	script = "combinedFeatureScript.lua",
	buildPic = "cwatchpost.png",
	--cost
	buildCostMetal = 600,
	buildCostEnergy = 250,
	buildTime = 5,
	--Health
	maxDamage = 2800,
	idleAutoHeal = 1,
	--Movement
	--Acceleration = 0.1,
	--BrakeRate = 0.3,
	FootprintX = 8,
	FootprintZ = 8,
	--MaxSlope = 5,
	--MaxVelocity = 2.5,
	MaxWaterDepth = 20,
	--MovementClass = "Default2x2",
	--TurnRate = 900,
	nanocolor=[[0 0.9 0.9]],

	--collisionVolumeTest = 1;
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 
	
	
	
	sightDistance = 650,
	
	Builder = false,
	CanAttack = true,
	--CanGuard = true,
	CanMove = false,
	--CanPatrol = true,
	CanStop = true,
	--LeaveTracks = true, 
		
	sfxtypes = {	
		explosiongenerators = {
			"custom:smallblueburn",
			"custom:bloodspray",
			"custom:dirt",
			"custom:greenlight",
			"custom:sniperlazzor"
		},	
	},
	Category = [[LAND BUILDING]],
	
weapons = {
	[1]={name  = "sniperweapon",
		onlyTargetCategory = [[LAND BUILDING]],
		}
	},
}

return lowerkeys({ [unitName] = unitDef })