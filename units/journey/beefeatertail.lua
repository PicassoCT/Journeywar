local unitName  =  "jbeefeatertail"
local unitDef  =  {
--Internal settings
    BuildPic = "filename.bmp",
    ObjectName = "jbeefeatertail.s3o",
    name = "Tail",
    Side = "Journeyman",
 
    script = "jbeefeatertail.lua",
   BuildTime = 82,
    Description = "...and it goes on and on and on.. but who scares.. ",
    MaxDamage = 240,
    RadarDistance = 0,
    SightDistance = 500,
    Upright = false,
	turnInPlace=false,
	--floater             = true,    
--Energy and metal related
    BuildCostEnergy = 400,
    BuildCostMetal = 1000,
    
--Pathfinding and related
	--holdSteady          = true,
    Acceleration = 0.05,
    BrakeRate = 0.1,
    FootprintX = 4,
    FootprintZ = 4,
    MaxSlope = 7,
    MaxVelocity = 3.5,
    MaxWaterDepth = 40,
    MovementClass = "Default2x2",
    TurnRate = 400,
    mass                = 3750,
	
nanocolor=[[0.3 0.5 0.6]],
  smoothAnim          = true,
  transportByEnemy    = false,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


	
--Abilities
    Builder = 0,
    CanAttack = 1,
    CanGuard = 1,
    CanMove = 1,
    CanPatrol = 1,
    CanStop = 1,
    leaveTracks =true,
	trackType ="jbeef",

	trackStrength=33,
    Reclaimable = 0,
    
--Hitbox

 	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:dirt",
	   "custom:leaves",
	   "custom:bloodspray",
	   "custom:jbeefheremightbedragons",
						  },
	
				},
--Weapons and related
   
    
}


return lowerkeys({ [unitName]  =  unitDef })
