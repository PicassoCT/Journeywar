local unitName = "cbuilux"

local unitDef = {
maxdamage=650,
  name               = "Luxery Appartments",
  description = "diverts Materialbudgets for orgys into your pocket. < Matter Production Building>",
  objectName         = "builux.s3o",
  	buildPic = "cbuilux.png",
    script = "builuxscript.lua",
	EnergyStorage = 200,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MetalMake = 1,	
	MetalUse = 0,
	MakesMetal = 0, 
	collisionvolumetype = "box",
	collisionvolumescales = "110 100 110",
	collisionvolumeoffsets = "0 0 0",
	onoffable = true,
	 corpse             = "bgcorpse",
	buildCostMetal =  1200,
	buildCostEnergy = 900,
	buildTime =82,
	explodeAs="cartdarkmat",
	selfDestructAs= [[NOWEAPON]],
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	activateWhenBuilt=true,
	shownanoframe=1,
	--TransportByEnemy=1;   
	--immunetoparalyzer=1;
	--CantBeTransported=0;
	nanocolor=[[0 0.9 0.9]],
	Category=[[LAND BUILDING]],	

	
}

return lowerkeys({ [unitName] = unitDef })