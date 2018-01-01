local unitName = "buibaicity2"

local unitDef = {
  name               = "Arcology",
  objectName         = "buibaicity2.s3o",
  description="repays invested Insurrance Money if set on fire by a enemy <Econ Trap Building>",
  script ="cbuibaiCityArco.lua",
  buildPic = "carcology.dds",
  maxdamage=1400,
  	--EnergyUse = 15,
	--MetalUse = 15,
	buildTime = 182,
	FootprintX = 9,
	FootprintZ = 9,
	MaxSlope = 50,
	idleAutoHeal = 0,
  nanocolor=[[0 0.9 0.9]],
  
 explodeAs="citadelldrone",
selfDestructAs="citadelldrone", 
  
   corpse             = "cInfantryCorpse",
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