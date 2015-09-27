local unitName  =  "operatrans"
local unitDef  =  {
--Internal settings
    BuildPic = "filename.bmp",
    ObjectName = "operatrans.s3o",
    name = "Operahovercraft",
    Side = "CentrAIl",
TEDClass            = [[VTOL]],
steeringmode        = [[1]],
maneuverleashlength = 1380,
turnRadius		  	= 80,
dontLand		 	= true,

    script = "operatransscript.lua",
    
--Unit limitations and properties
    BuildTime = 82,
    Description = "citizens who enjoy the war, might donate more into your security-budget",
    MaxDamage = 1240,
    RadarDistance = 0,
    SightDistance = 500,
    Upright = 1,
	--floater             = true,    
--Energy and metal related
    buildCostMetal =  1200,
	buildCostEnergy = 900,


--Pathfinding and related
	holdSteady          = true,
    Acceleration = 0.05,
    BrakeRate = 0.1,
    FootprintX = 4,
    FootprintZ = 4,
    -- MaxSlope = 7,
    -- MaxVelocity = 2.0,
    -- MaxWaterDepth = 20,
    floater=true,
    MovementClass = "Default2x2",
    mass                = 9750,
	
	
nanocolor=[[0 0.9 0.9]],
  smoothAnim          = true,
  transportByEnemy    = false,
  transportCapacity   = 5,
  transportSize       = 30000,
--Ressources

	EnergyStorage = 800,
	EnergyUse = 0,
	MetalStorage = 0,
	EnergyMake = 150, 
	MetalUse = 3,
	MakesMetal = 0, 
	MetalMake = 0,	 
	
--Abilities
    Builder = 0,
    CanAttack = 1,
    CanGuard = 1,
    CanMove = 1,
    CanPatrol = 1,
    CanStop = 1,
    LeaveTracks = 0,
    Reclaimable = 0,
	Category = [[LAND]],
	
	explodeAs = [[NOWEAPON]],
	selfDestructAs= [[NOWEAPON]], 
  
--Hitbox
    collisionVolumeOffsets    =  "0 0 0",
    collisionVolumeScales     =  "35 60 90",
	collisionVolumeTest       =  1,
	collisionVolumeType       =  "box",
 	 customParams = {},
 sfxtypes = {
    explosiongenerators = {
	   "custom:factory_explosion",	  
						  },	
				},
--Weapons and related
   
    weapons = {
        [1]={name  = "cOperaCannon",
			 onlyTargetCategory = [[ LAND ]],
			},
		[2]={name  = "cOperaCannon",
		onlyTargetCategory = [[ LAND ]],
			},
		[3]={name  = "cwaterbombs",
			onlyTargetCategory = [[ WATER]],
			},	
		[4]={name  = "cwaterbombs",
			onlyTargetCategory = [[ WATER]],
			},	

    },
}
return lowerkeys({ [unitName]  =  unitDef })
