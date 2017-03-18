local unitName = "jVictory"

local unitDef = {
name = "Victory Statue",
Description = " Journeyman where victorious",
objectName = "jVictory.s3o",
script = "jVictoryScript.lua",
buildPic = "placeholderj.png",
--cost
	maxdamage=65000,
 EnergyStorage = 0,
	EnergyUse = 25,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 6, 
	MetalMake = 0,	

	
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


	
	

}

return lowerkeys({ [unitName] = unitDef })