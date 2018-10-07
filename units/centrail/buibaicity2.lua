local unitName = "smconverter"

local unitDef = {
	name = "Full Citizen Arcology",
	objectName = "buibaicity2.s3o",
	description=" Converts Material to Security.  Generates Propaganda if set on fire by enemy < Security Material Converter Building>",
	script ="cbuibaiCityArco.lua",
	buildPic = "carcology.dds",
	maxdamage=1400,
	EnergyUse = 175,
	MetalStorage = 0,
	EnergyMake = 0, 
	MetalMake = 1.25,

	
	buildTime = 182,
	FootprintX = 9,
	FootprintZ = 9,
	MaxSlope = 50,
	idleAutoHeal = 0,
	nanocolor=[[0 0.9 0.9]],
	
	explodeAs="citadelldrone",
	selfDestructAs="citadelldrone", 
	
	corpse = "cInfantryCorpse",
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:factory_explosion",
			"custom:flames",
			"custom:glowsmoke",
			"custom:blackerThenSmoke",
			"custom:LightUponSmoke",
			
			
		},
	},
	
	category=[[BUILDING]],
}

return lowerkeys({ [unitName] = unitDef })
