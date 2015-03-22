local moveDefs =
{
	{
		name = "HOVER2x2",
		footprintY = 3,
		footprintX = 3,
		maxWaterDepth = 1000,
		maxSlope = 20,
		crushStrength = 0,
	},
	{
		name = "Default2x2",
		footprintX = 2,
		maxWaterDepth = 10,
		maxSlope = 20,
		crushStrength = 25,
	},
	{
		name = "Train",
		footprintX = 2,
		maxWaterDepth = 200,
		maxSlope = 88,
		crushStrength = 25,
	},
	{
		name = "truck",
		footprintX = 2,
		maxWaterDepth = 20,
		maxSlope = 55,
		crushStrength = 15,
	},
		{
		name = "jBeherith",
		footprintX = 3,
		footprintY = 3,
		maxWaterDepth = 50,
		maxSlope = 65,
		crushStrength = 600,
	},
	{
		name = "amphib",
		footprintX = 3,
		footprintY = 3,
		maxWaterDepth = 1990,
		maxSlope = 25,
		crushStrength = 0,
		Hover =1,
	},
	{
		name = "UBOAT3",
		footprintx = 3,
		footprintz = 3,
		minwaterdepth = 15,
		crushstrength = 150,
		subMarine = 1,
	},
	

	
}

return moveDefs
