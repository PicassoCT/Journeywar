local unitName = "cRewarder"

local unitDef = {
  name               = "cRewarder",
  objectName         = "placeholder.s3o",
  description="",
  script ="cRewarder.lua",
  maxdamage=0,
  idleAutoHeal=5,
  levelGround =false,
  	--EnergyUse = 15,
	--MetalUse = 15,
	
	FootprintX = 1,
	FootprintZ = 1,
	MaxSlope = 20,
   NoWeapon=true,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",

  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {

				  
				   
				},
				},
  
  
}

return lowerkeys({ [unitName] = unitDef })