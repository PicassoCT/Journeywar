local unitName = "gpillar"

local unitDef = {
name = "Pillar",
Description = "What grows tall can fall on small once and for all",
objectName = "gpillar.s3o",
script = "gPillarScript.lua",
buildPic = "placeholder.png",
--cost
buildCostMetal = 200,
buildCostEnergy = 50,
buildTime =1,
--Health
maxDamage = 666000,
idleAutoHeal = 0,
--Movement

FootprintX = 4,
FootprintZ = 4,
	levelground = 1,
--MaxVelocity = 0.5,
MaxWaterDepth =20,
--MovementClass = "Default2x2",--
TurnRate = 200,
isMetalExtractor = true,
sightDistance = 300,

reclaimable=false,


	YardMap ="yyyy yyyy yyyy yyyy",

-- Building	
	ShowNanoSpray = false,
	CanBeAssisted = true,	
	workerTime = 1,





    
   

Category = [[LAND]],

EnergyStorage = 0,
	EnergyUse = 75,
	MetalStorage = 0,
	EnergyMake = 0, 
	MakesMetal = 16, 
	MetalMake = 0,	
 
  levelGround            = false,
  mass                   = 99000,
  
  
  noAutoFire             = false,

  


 -- TEDClass               = [[METAL]],
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
	
				   "custom:LightUponSmoke",
				 
				   --
				    --Bulletof The Cannon
				},

},




}

return lowerkeys({ [unitName] = unitDef })