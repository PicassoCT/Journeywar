local unitName = "conTrainPillar"

local unitDef = {
	name = "conTrainPillar",
	Description = "They are everywhere, below the floor...",
	objectName = "conTrainPillar.s3o",
	script = "conTrainPillar.lua",
	buildPic = "placeholder.png",
	--cost
	maxdamage=800,
	EnergyStorage = 0,
	EnergyUse = 15,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 6, 
	MetalMake = 0,	
	upright=true,
	
	FootprintX = 1,
	FootprintZ = 1,
	
	levelGround =false,
	NoWeapon=true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	Category = [[LAND]],
	
}

return lowerkeys({ [unitName] = unitDef })