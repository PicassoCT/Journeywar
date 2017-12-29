local unitName = "ctransithub"

local unitDef = {
	name = "Transit Hub :",
	Description = "Transports Unit to its counterpart",
	objectName = "ctransitnode.s3o",
	script = "transitnode.lua",
	buildPic = "Transithub.dds",
	--cost
	buildCostMetal = 950,
	buildCostEnergy = 750,
	buildTime = 35,
	--Health
	maxDamage = 1450,

	idleAutoHeal = 25,
	idletime=3000,
	--Movement
	FootprintX = 18,
	FootprintZ = 18,
	MaxSlope = 50,
	--MaxVelocity = 0.5,
	MaxWaterDepth =0,
	blocking=false,
	sightDistance = 600,
	nanocolor=[[0 0.9 0.9]],

	terraformSpeed = 350,
	CanAttack = false,
	CanGuard = true,
	Builder = true,
	
	NoWeapon=true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	levelGround = false,
	mass = 49999,
	ShowNanoSpray = false,
	CanBeAssisted = true,	
	workerTime = 0.0001,
	buildDistance = 42200,
	buildoptions = 
	{
		"ctransithubb"
	},
	

	CanMove = false,
	CanPatrol = false,
	CanStop = true,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			
		},
		
	},
	
	
	
	
	Category=[[LAND BUILDING]],	
	
	
}

return lowerkeys({ [unitName] = unitDef })