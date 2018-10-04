local unitName  =  "jbeefeater"
local unitDef  =  {
--Internal settings
    BuildPic = "filename.bmp",
    ObjectName = "jbeefeater.s3o",
	buildPic = "jbeefeater.png",
    name = "Beefeater <Begin of Sniper Unit>",

    script = "jbeefeaterscript.lua",
    
--Unit limitations and properties
    BuildTime = 82,
    Description = "sniper Reptile, growing longer with experience.",
    MaxDamage = 1240,
    RadarDistance = 0,
    SightDistance = 500,
    Upright = false,
	turnInPlace=false,
	canCloak =true,
	
	cloakCost=0,
	cloakCostMoving = 10,
	minCloakDistance = 110,
	initCloaked =true,
	decloakOnFire = true,
	cloakTimeout = 30* 3,


	 
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
    MaxVelocity = 2.0,
    MaxWaterDepth = 40,
    MovementClass = "Default2x2",
    TurnRate = 350,
    mass                = 3750,
	  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


nanocolor=[[0.3 0.5 0.6]],
  smoothAnim          = true,
  transportByEnemy    = false,
  transportCapacity   = 5,
  transportSize       = 15,
	
--Abilities
    Builder = 0,
    CanAttack = 1,
    CanGuard = 1,
    CanMove = 1,
    CanPatrol = 1,
    CanStop = 1,
         leaveTracks =true,
  trackType ="jbeef",
  trackStrength=11,
    Reclaimable = 0,
    
--Hitbox

 	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:dirt",
	   "custom:leaves",
	   "custom:bloodspray",
	   "custom:jbeefheremightbedragons",--1027
	  
						  },
	
				},
--Weapons and related
   
    weapons = {
        [1]={name  = "jbeefeatermarker",
	onlyTargetCategory = [[ LAND ]],
	},
	
},

}


return lowerkeys({ [unitName]  =  unitDef })
