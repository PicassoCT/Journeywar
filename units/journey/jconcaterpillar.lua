local unitName = "jconcaterpillar"
local unitDef = {
	name = "Concaterpillar",
	Description = " Construction Exobiotic, using lifeforce to construct. <Heavy Construction Unit>",
	objectName = "conbigfoot.s3o",
	script = "conbigfoot.lua",
	buildPic = "placeholderj.png",
	--cost
	buildCostMetal = 300,
	buildCostEnergy = 900,
	buildTime = 24,
	--Health
	maxDamage = 1200,
	idleAutoHeal = 0,
	maxwaterdepth=80,
	canSubmerge=true,
	--Movement
	MaxVelocity=0.3,
	Acceleration = 0.1,
	BrakeRate = 0.05,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 20,
	MaxVelocity = 7.2,
	mass=2048,
	
	MovementClass = "Default2x2",
	TurnRate = 220,
	
	sightDistance = 300,
	CanBeAssisted = true,
	CanReclaim=true,	
	workerTime = 0.2,
	buildDistance = 50,
	terraformSpeed = 350,
	Builder = true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	collisionVolumeType	 = [[box]],
	
	collisionVolumeScales		= [[42 32 162]],
	collisionVolumeOffsets	= [[0 -8 -10]],
	collisionVolumeTest	 = 1,
	
	CanGuard = true,
	CanMove = true,
	canassist=true,
	CanStop = true,
	LeaveTracks = false, 
	nanocolor=[[0.2 0.9 0.5]],
	Category = [[LAND]],
	
	
}

return lowerkeys({ [unitName] = unitDef })