local unitName = "jnativevil"

local unitDef = {
maxdamage=950,
  name               = "Natives",
  description = "too reap what they sow",
  objectName         = "jNativeVillage.s3o",
    buildPic = "jnativevillage.png",
  script="jnativevilscript.lua",
  	SightDistance = 800,
	FootprintX = 3,
	FootprintZ = 3,
	buildtime=50,
  EnergyStorage = 0,
	EnergyUse = 15,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 2, 
	MetalMake = 0,	
nanocolor=[[0 0.9 0.9]],
explodeAs="citadelldrone",
selfDestructAs="citadelldrone", 
Category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })