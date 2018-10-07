local unitName = "buibaicity1"

local unitDef = {
  name               = "Skyscrapers",
  objectName         = "buibaicity.s3o",
  description=" returns invested Money on Attack. Diverts Money from all but second-last Attacker. Upgrades Luxus Appartments nearby.<Economy Trap Building>",
  script ="cBuiBaiSky.lua",
  buildPic = "cskyscrape.dds",

  maxdamage=1400,
  idleAutoHeal=5,
  	--EnergyUse = 15,
	--MetalUse = 15,
	
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 50,
	buildtime=240,
	
	explodeAs="citadelldrone",
	selfDestructAs="citadelldrone", 	
	
   corpse             = "cInfantryCorpse",
    nanocolor=[[0 0.9 0.9]],
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
  
category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })
