local unitName = "choblock"

local unitDef = {
maxdamage=150,
  name               = "Hostage Block",
  description = "holds the relatives of a Pax Centrail Prisoner Hostage <Unit Controll Building>",
  objectName         = "buihoblock.s3o",
  script="chostageblockscript.lua",
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
	canattack=true,
	explodeAs="citadelldrone",
	selfDestructAs="cartdarkmat", 
		
	weapons = {
		[1]={name = "ccitadelltur",
			onlyTargetCategory = [[LAND AIR]],
		},
		[2]={name = "ccitadelltur",
			onlyTargetCategory = [[LAND AIR]],
		}
		},
}

return lowerkeys({ [unitName] = unitDef })