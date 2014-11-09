local unitName = "jrefugeetrap"

local unitDef = {
  name               = "Researchstation",
  description =" rebells rowdily once reached by Refugees running",
  objectName         = "jRefuggeTrap.s3o",
  script ="jrefugeetrapscript.lua",
  buildPic = "jplaceholder.png",
  	RadarDistance = 25,
	SightDistance = 200,
  
	buildCostMetal = 180,
	buildCostEnergy = 150,
	buildTime = 24,
	
	maxDamage = 900,
	idleAutoHeal = 0,
	
	EnergyStorage = 0,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 0, 
	MetalMake = 0,	
------------------------------
	canPatrol = false,

ShowNanoSpray = false,
CanBeAssisted = false,
CanReclaim=false,	

nanocolor=[[0 0.9 0.9]],


Reclaimable = true,
	


-- Pathfinding and related

	MaxSlope = 500,	
	

-- Building	
	Builder = false,



--custom UnitDefParameter

FootprintX = 1,
FootprintZ = 1,
 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:bubbles",             --1024
				   "custom:fireignite",             --1025
				   "custom:fireshockwave",             --1026
				   "custom:fireshine",             --1027
				   "custom:firedirt",             --1028
				   "custom:fireone",             --1029
				   "custom:firetwo",             --1030
				   "custom:firethree",             --1031
				   "custom:firefour",             --1032
				   "custom:centerfire",             --1033
				   "custom:suckfire",             --1034
				   "custom:highrisesparkfire",             --1035
				   --add zero-ks fire as background here
				   --
				    --Bulletof The Cannon
				},

},

Category = [[LAND BUILDING]],

weapons = {
[1]={name  = "jflowerfire",
	onlyTargetCategory = [[ LAND]],
	},

	
	
	},


}

return lowerkeys({ [unitName] = unitDef })