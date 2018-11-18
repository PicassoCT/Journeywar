local unitName = "cefence"

local unitDef = {
	name = "Efence",
	Description= " chargeable electric Defensefence <Defense Trap>",
	objectName = "efence.s3o",
	script ="cEfence.lua",
	buildPic = "cefence.png",
	RadarDistance = 0,
	SightDistance = 100,
	
	buildCostMetal = 180,
	buildCostEnergy = 250,
	buildTime = 34,
	
	maxDamage = 2800,
	idleAutoHeal = 1,
	nanocolor=[[0 0.9 0.9]],
	EnergyStorage = 50,
	EnergyUse = 5,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	------------------------------
	canPatrol = false,
	
	ShowNanoSpray = false,
	CanBeAssisted = false,
	CanReclaim=false,	
	onOffable = true,
	activateWhenBuilt=false,
	collisionVolumeTest = 1,
	collisionvolumetype = "box",
	collisionvolumescales = "140 45 15",
	collisionvolumeoffsets = "0 0 0",
	
	
	Reclaimable = true,
	
	

	isFactory = false,
	
	
	-- Pathfinding and related
	
	MaxSlope = 50,	
	YardMap ="oooccooo",
	
	-- Building	

	Reclaimable = true,
	
	--custom UnitDefParameter
	customparams = {
		boolischarged= "false",
	},
	FootprintX = 8,
	FootprintZ = 1,
	
	weapons = {
		[1]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		[2]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		[3]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		[4]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		[5]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		[6]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		[7]={name = "cWEFence1",
			onlyTargetCategory = [[ LAND]],
		},
		
		
		
	},
	category = [[LAND BUILDING]],

	sfxtypes = {
		explosiongenerators = {
			"custom:dirt",
			"custom:redlight",
			"custom:greenlight",
			
			
		},
	},
	
	
}

return lowerkeys({ [unitName] = unitDef })