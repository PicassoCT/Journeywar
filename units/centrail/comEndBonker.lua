local unitName = "comendbonker"

local unitDef = {
maxdamage=650,
  name               = "Underground Teleporter",
  description = "Spawns a Com Ender if you press Activate twice",
  objectName         = "comendbonker.s3o",
  	buildPic = "comEndBonker.dds",
    script = "comEndBonker.lua",
  EnergyStorage = 0,
	EnergyUse = 210,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
	onoffable = true,
	 corpse             = "bgcorpse",
	buildCostMetal =  1200,
	buildCostEnergy = 900,
	buildTime =82,
	levelground=false,
	
	explodeAs="cbonkerplasma",
	selfDestructAs="cartdarkmat",
	FootprintX = 6,
	FootprintZ = 6,
	MaxSlope = 10,	
	activateWhenBuilt=true,
	shownanoframe=1,
	--TransportByEnemy=1;   
	--immunetoparalyzer=1;
	--CantBeTransported=0;
	nanocolor=[[0 0.9 0.9]],
	  yardmap="oooooo oooooo oooooo oooooo oooooo oooooo",
	
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",     
				   "custom:weldArc"
				     --electric Sparc
				     --electric Sparc
				   
									},
				},
  


	
	
}

return lowerkeys({ [unitName] = unitDef })