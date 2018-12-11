local unitName = "jswiftspear"

local unitDef = {
	name = "Swiftspear",
	Description = "rapes enemy units, impregnates them with little swiftspears <Sabotage/Assault>",
	objectName = "swiftspear.s3o",
	script = "swiftspear.lua",
	buildPic = "jswiftspear.png",
	--cost
	buildCostMetal = 100,
	buildCostEnergy = 0,
	buildTime = 5,
	--Health
	maxDamage = 1250,
	idleAutoHeal = 3,
	--Movement
	Acceleration = 3,
	BrakeRate = 0.3,
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 15,
	MaxVelocity = 2,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 350,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


	sightDistance = 500,

	Builder = false,
	CanAttack = true,
	CanRepair=false,
	CanAssist=false,
	canReclaim=false,
	CanGuard = true,
	CanMove = true,
	CanPatrol = false,
	CanStop = true,
	LeaveTracks = false, 
	cantBeTransported =true,
	isFirePlatform =false,
	transportByEnemy    = false,
	transportCapacity   = 256,
	transportSize       = 9700,
	loadingRadius =340,
	transportUnloadMethod =1,

	
nanocolor=[[0.7 0 0.1]],


   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             --Thumper
				   "custom:bloodspray",	
				   "custom:spermspray",	
				 
				},

},


Category = [[LAND]],

weapons = {
[1]={name  = "swiftProjectile",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "jswiftrapemark",
	onlyTargetCategory = [[LAND]],
	},	
[3]={name  = "jfacehugger",
	onlyTargetCategory = [[LAND]],
	},	
},
}

return lowerkeys({ [unitName] = unitDef })