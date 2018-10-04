local unitName = "cDistrictNone"

local unitDef = {
  name               = "Shantytown",
  objectName         = "buibaislum.s3o",
  description="Returns invested Securitybudget upon destruction. Replicates itself. <Econ Trap Building>",
  script ="cDistrictNone.lua",
  maxdamage=1400,
  idleAutoHeal=5,
  	--EnergyUse = 15,
	--MetalUse = 15,
	levelground = 1,
	FootprintX = 11,
	FootprintZ = 11,
	MaxSlope = 20,
  category=[[LAND BUILDING]],
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:factory_explosion",
	   		       "custom:flames",
				   "custom:glowsmoke",
				   "custom:dirt",
				   
				  
				   
				},
				},
  
  
}

return lowerkeys({ [unitName] = unitDef })