local unitName = "campole"

local unitDef = {
maxdamage=150,
  name               = "Camera Pole",
  description = "Converts: Energy to Material(Securitybudget)",
  objectName         = "campole.s3o",
    buildPic = "campole.dds",
  script="campole.lua",
  	SightDistance = 800,
	FootprintX = 3,
	FootprintZ = 3,
	buildtime=50,
  EnergyStorage = 0,
	EnergyUse = 95,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 3, 
	MetalMake = 0,	
nanocolor=[[0 0.9 0.9]],
explodeAs="citadelldrone",
selfDestructAs="citadelldrone", 
Category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })