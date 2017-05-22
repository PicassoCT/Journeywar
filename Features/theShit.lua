
local featureDef = {
	name = "shit",
	blocking = false,
	category = "LAND",
	damage = 3000,
	description = "important what comes out in the end",
	energy = 64,
	flammable = true,
	footprintX = 2,
	footprintZ = 2,
	upright = false,
	height = "6",
	hitdensity = "5",
	smokeTime =5,
	object = "theShit.s3o",
	reclaimable = true,
	resurrectable = false,
	nodrawundergray = false,
	autoreclaimable = true,
	
}
return lowerkeys({[featureDef.name] = featureDef})