local unitName = "cauterizer"

local unitDef = {
  name                = "Cauterizer",
  description         = [[Suicidal Area Defense Drone]],
  brakerate           = 0.4,
  buildCostMetal = 1500,
  buildCostEnergy = 800,
  builder             = false,
  buildPic            = [[cauterizer.png]],
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canSubmerge         = false,
  category            = [[AIR]],
  collide             = false,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[12 12 5]],
  collisionVolumeType    = [[box]],
  cruiseAlt           = 50,


  energyUse           = 1.5,
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maxAcc              = 0.5,
  maxDamage           = 1950,
  maxAileron          = 0.018,
  maxElevator         = 0.02,
  maxRudder           = 0.008,
  maxVelocity         = 22,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[NOTARGET]],
  objectName          = [[cauterizer.s3o]],
  radarDistance       = 300,
  radarDistanceJam    = 0,
  script              = [[cauterizerscript.lua]],
  selfDestructAs      = [[GUNSHIPEX]],
  sightDistance       = 600,
  sonarDistance       = 0,
  turnRadius          = 30,
  workerTime          = 0,
  
  	sfxtypes = {
		explosiongenerators = {
			"custom:supersonic",
		},
		
	},
	
	
	
	weapons = {
		[1]={name = "ccauterizermark",
			onlyTargetCategory = [[ LAND]],
			MainDir = [[0 0 1]],
			MaxAngleDif = 90,
			
		}
		}
}
return lowerkeys({ [unitName] = unitDef })