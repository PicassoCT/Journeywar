local unitName = "jnativevil"

local unitDef = {
maxdamage=950,
  name               = "Native Village",
  description = "convert Matter into Light <Energy Metal Conversion>",
  objectName         = "jNativeVillage.s3o",
    buildPic = "jnativevillage.png",
  script="jnativevilscript.lua",
  	SightDistance = 800,
	MaxWaterDepth =0,
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 35,	
	buildtime=50,
  EnergyStorage = 0,
	EnergyUse = 0,
	MetalUse = 5,
	MetalStorage = 0,
	EnergyMake = 12, 
	MakesMetal = 0, 
	MetalMake = 0,	
nanocolor=[[0 0.9 0.9]],
explodeAs="citadelldrone",
selfDestructAs="citadelldrone", 
Category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })