local unitName = "citadell"
local unitDef = {
	name = "Spearspire",
	Description = "Center of Operations, plans and coordinates",
	objectName = "citadell.s3o",
	script = "citadellscript.lua",
	buildPic = "citadell.dds",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 12,
	buildTime = 15,
	--Health
	maxDamage = 2500,
	idleAutoHeal = 5,
	--Movement
	FootprintX = 8,
	FootprintZ = 8,
	MaxSlope = 20,
	MaxWaterDepth = 20,
	TurnRate = 500,
	-- explodeAs = "csuborbitalstrike",
	radardistance=150,
	sightDistance = 700,
	
	collisionVolumeScales		= [[48 468 28]],
	collisionVolumeOffsets	= [[0 -8 3]],
	collisionVolumeTest	 = 1,
	collisionVolumeType	 = [[box]],
	
	EnergyStorage = 200,
	EnergyUse = 0,
	MetalStorage = 200,
	EnergyMake = 0, 
	MakesMetal = 5, 
	MetalMake = 5,	
	selfDExplosion = "electric_explosion",
	NoWeapon=false,
	CanAttack = true,
	CanGuard = false,
	reclaimSpeed=1,
	CanMove = false,
	CanPatrol = true,
	CanStop = true,
	LeaveTracks = false, 
	onoffable=true,
	ActivateWhenBuilt=0,
	Builder = true,
	ShowNanoSpray = true,
	CanBeAssisted = true,
	
	nanocolor=[[0 0 0]], --
	CanReclaim=true,	
	workerTime = 0.005,
	buildDistance = 1200,
	terraformSpeed = 350,
	
	explodeAs="cartdarkmat",
	selfDestructAs="cartdarkmat", 
	
	
	buildoptions = 
	{
		"scumslum","mdigg","cwaterextractor",
		"campole","mestorage","citconair",
		"builux","bbind","coverworldgate",
		"condepot","fclvlone","cairbase",
		"cdistrictnone","buibaicity2","buibaicity1",
		"crailgun","sentry","bonker",
		"cdefusermine",	"chopper","efence",
		"comendbonker","ctransithub"
	},
	
	sounds = {
		["underattack"] =
		{
			[1]={name = "citadell/citadellAlarm",
				["id"] = 140, 			
				["volume"] = 5,
			},
		}
	},
	
	explodeAs = "custom:factory_explosion",
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factory_explosion",
			"custom:dirt",
			"custom:electric_explosion",
			"custom:sparkcloud",
			"custom:citadellfire",
			"custom:citadellcloud",
			"custom:portalstorm",
			"custom:portalground",
			"custom:darkCloud",
			"custom:flames",	 --1033		
			"custom:ashflakes",--1034
			"custom:redSparks",--1035
			"custom:citacloudcore",--1036
			"custom:portalenter",--1037
			"custom:citlightpillar",--1038
			"custom:clightball",--1039
			
		},
		
	},
	
	
	weapons = {
		[1]={name = "citadelldrone",
			onlyTargetCategory = [[LAND AIR]],
		},
		[2]={name = "ccitadelltur",
			onlyTargetCategory = [[LAND AIR]],
		},
		[3]={name = "ccitadelltur",
			onlyTargetCategory = [[LAND AIR]],
		},
		[4]={name = "ccitadelltur",
			onlyTargetCategory = [[LAND AIR]],
		},
		[5]={name = "ccitadelltur",
			onlyTargetCategory = [[LAND AIR]],
		},
		[6]={name = "ccitadellshield",
			onlyTargetCategory = [[LAND AIR]],
		},	
	},
	
	category=[[LAND BUILDING]],		
}
return lowerkeys({ [unitName] = unitDef })