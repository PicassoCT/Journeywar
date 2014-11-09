local weaponName = "jmomtractor"
local weaponDef = {
	  name                    = "cuniversegun",
	      weaponType              = [[Cannon]],
		  
		  model="emptyObjectIsEmpty.s3o",
	      --damage
		  damage = {
				default = 150,
				HeavyArmor = 120,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 1900,
		  reloadtime              = 190,
		  range                   = 1850,
		  sprayAngle              = 300,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  --apperance
		  rgbColor                = [[0.1 0.1 0.1]],		  	      
          size                    = 4,
		  CegTag="jmomgeom",
		  soundHit                = "sounds/jMom/FieldGrab.ogg",
		  soundStart              = "sounds/jMom/FieldDeploy.ogg",


	explosionGenerator=	"custom:factory_explosion",	


	      }
		
return lowerkeys({[weaponName] = weaponDef})