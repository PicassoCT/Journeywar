local unitName  =  "operatrans"
local unitDef  =  {
--Internal settings
    BuildPic = "filename.bmp",
    ObjectName = "operatrans.s3o",
    name = "Operahovercraft",
    Side = "CentrAIl",
    TEDClass = "HOVER",
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
    BuildCostEnergy = 400,
    BuildCostMetal = 1000,

--Pathfinding and related
	holdSteady          = true,
    Acceleration = 0.05,
    BrakeRate = 0.1,
    FootprintX = 4,
    FootprintZ = 4,
    MaxSlope = 7,
    MaxVelocity = 2.0,
    MaxWaterDepth = 20,
    floater=true,
    MovementClass = "HOVER2x2",
    TurnRate = 50,
    mass                = 9750,
	
	
nanocolor=[[0 0.9 0.9]],
  smoothAnim          = true,
  transportByEnemy    = false,
  transportCapacity   = 5,
  transportSize       = 30000,
  
	
--Abilities
    Builder = 0,
    CanAttack = 1,
    CanGuard = 1,
    CanMove = 1,
    CanPatrol = 1,
    CanStop = 1,
    LeaveTracks = 0,
    Reclaimable = 0,
    category=[[LAND ]],
	
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
