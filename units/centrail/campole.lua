local unitName = "campole"

local unitDef = {
	maxdamage=150,
	name = "Propagandapole",
	description = "Converts Material to Securitybudget < Material Security Converter Building>",
	objectName = "campole.s3o",
	buildPic = "campole.png",
	script="campole.lua",
	SightDistance = 800,
	FootprintX = 3,
	FootprintZ = 3,
	MaxSlope = 50,
	buildtime=50,
	EnergyStorage = 0,
	
	MetalUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 

	MetalMake = 0,	
	nanocolor=[[0 0.9 0.9]],
	explodeAs="citadelldrone",
	selfDestructAs="citadelldrone", 
	Category=[[LAND BUILDING]],	
}

return lowerkeys({ [unitName] = unitDef })