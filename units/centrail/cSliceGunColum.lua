local unitName = "cmeatcolumn"

local unitDef = {
	name = "Meatcolumn",
	Description = "That got to hurt ",
	objectName = "cSlicerMeatColumn.s3o",
	script = "slicerImpact.lua",
	buildPic = "placeholder.png",
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
	loadingRadius =340,
	transportUnloadMethod =1,

	
nanocolor=[[0.7 0 0.1]],


   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             --Thumper
				   "custom:bloodspray",	
				
				 
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
},
}

return lowerkeys({ [unitName] = unitDef })