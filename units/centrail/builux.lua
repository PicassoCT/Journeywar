local unitName = "builux"

local unitDef = {
maxdamage=650,
  name               = "Luxery Appartments",
  description = ":Allowing you to diverts some Material from the orgybudget into your pockets.",
  objectName         = "builux.s3o",
  	buildPic = "builux.dds",
    script = "builuxscript.lua",
	EnergyStorage = 200,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 75, 
	MetalUse = 1,
	MakesMetal = 0, 
	MetalMake = 0,	
	onoffable = true,
	 corpse             = "bgcorpse",
	buildCostMetal =  1200,
	buildCostEnergy = 900,
	buildTime =82,
	explodeAs="cArtDM",
	selfDestructAs="defaultweapon",
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	activateWhenBuilt=true,
	shownanoframe=1,
	--TransportByEnemy=1;   
	--immunetoparalyzer=1;
	--CantBeTransported=0;
	nanocolor=[[0 0.9 0.9]],
	
}

return lowerkeys({ [unitName] = unitDef })