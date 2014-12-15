local unitName = "jscrapheap_tree"

local unitDef = {
name = "Treestump",
Description = " slowly rotting away",
objectName = "jscrapheap.s3o",
script = "jscrapheap_script.lua",
buildPic = "jplaceholder.png",
buildCostMetal = 200,
buildCostEnergy = 50,
buildTime =1,
--Health
maxDamage = 1200,
idleAutoHeal = 3,
--Movement

FootprintX = 3,
FootprintZ = 3,

--MaxVelocity = 0.5,
MaxWaterDepth =20,
--MovementClass = "Default2x2",--

isMetalExtractor = false,
sightDistance = 0,

reclaimable=true,
Builder = false,
CanAttack = false,

CanMove = false,
CanPatrol = false,
CanStop = false,
LeaveTracks = false,

-- Building	

 	usebuildinggrounddecal = false,

Category = [[LAND BUILDING]],

  acceleration           = 0,
  canguard=true,
  activateWhenBuilt      = false,
  canbetransported=true,
  -- bmcode                 = [[0]],
	
	--


  --extractsMetal          = 0.005,
  floater                = true,


nanocolor=[[1 0.2 0.05]],
  levelGround            = false,
  mass                   = 99,
  
  maxSlope               = 145,
  
  


  smoothAnim             = true,
 -- TEDClass               = [[METAL]],
  
   customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:dirt",             --Thumper
				  -- "custom:smokeScreen",
				   --
				    --Bulletof The Cannon
				},

},

}

return lowerkeys({ [unitName] = unitDef })