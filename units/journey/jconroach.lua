local unitName = "jconroach"
local unitDef = {
	name = "Conroach",
	Description = " Construction Exobiotic, using lifeforce to construct. <Construction Unit>",
	objectName = "conRoach.s3o",
	script = "jconroach.lua",
	buildPic = "jconroach.png",
	--cost
	buildCostMetal = 150,
	buildCostEnergy = 200,
	buildTime = 9,
	--Health
	maxDamage = 600,
	idleAutoHeal = 0,
	reclaimSpeed=3,
	--Movement
	MaxVelocity=0.3,
	Acceleration = 0.1,
	BrakeRate = 0.05,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 35,
	MaxVelocity = 7.2,
	MaxWaterDepth = 620,
	MovementClass = "Default2x2",
	TurnRate = 320,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
		selfDestructCountdown =1,
	
	sightDistance = 300,
	CanBeAssisted = true,
	CanReclaim=false,	
	workerTime = 0.2,
	buildDistance = 50,
	terraformSpeed = 350,
	Builder = true,
	corpse="exconroach",
	CanGuard = true,
	CanMove = true,
	canassist=true,
	CanStop = true,
	LeaveTracks = false, 
	nanocolor=[[0.2 0.9 0.5]],
	Category = [[LAND]],
	
	 LeaveTracks = true, 
	trackType ="jBug",
	 trackStrength=4,
	trackWidth =32,
	trackOffset =0,
	
	sfxtypes = {
		explosiongenerators = {
		"custom:jconroach_heal",
	
		
		
							},
		
				},
	
}

return lowerkeys({ [unitName] = unitDef })