local weaponName = "jcrowbar"
local weaponDef = {
	      name                    = "Crowbar the Fucker",
	      weaponType              = [[Melee]],
	      --damage
		  damage = {
				default = 1250,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 12,
		  --physics
		  weaponVelocity          = 4500,
		--   soundHit           = "null",
		-- --soundStart         = "null",


   

		  --physics

		  range                   = 42,
		  
		  reloadtime              =16,
		  sprayAngle              = 0,
	      tolerance               = 20,
		  lineOfSight             = false,	      
	      turret                  =true,
		  craterMult              = 0,	      
		
		--  soundStart         = "",
		  soundtrigger=1,
		
		  --apperance
		  rgbColor                = [[0 0 0]],		  	      
          size                    = 0.1,
	     
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})