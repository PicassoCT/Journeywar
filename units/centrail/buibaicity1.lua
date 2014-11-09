local unitName = "buibaicity1"

local unitDef = {
  name               = "Baitbuilding: Skyskrapers",
  objectName         = "buibaicity.s3o",
  description=" Returns once attacked your Investment + Bonu donated by everyone in the enemy team,except last attacker",
  script ="cBuiBaiSky.lua",
  buildPic = "cskyscrape.dds",

  maxdamage=1400,
  idleAutoHeal=5,
  	--EnergyUse = 15,
	--MetalUse = 15,
	
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 20,
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