local unitName = "choblock"

local unitDef = {
maxdamage=150,
  name               = "Hostage Block",
  description = "Allows to put pressure on prisoners in PaxCentrails ",
  objectName         = "buihoblock.s3o",
  script="placeholder.lua",
  buildPic = "hoblock.dds",
  	SightDistance = 800,
	FootprintX = 3,
	FootprintZ = 3,
	buildtime=50,
  EnergyStorage = 0,
	EnergyUse = 20,
	MetalUse=10,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 5, 
	MetalMake = 0,	
nanocolor=[[0 0.9 0.9]],

	explodeAs="citadelldrone",
	selfDestructAs="cArtDM", 
}

return lowerkeys({ [unitName] = unitDef })