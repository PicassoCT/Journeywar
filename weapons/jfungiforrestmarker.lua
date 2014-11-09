---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jfungiforrestmarker"
local weaponDef = {
	      name                    = "jffm",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 1,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 28,
		  --physics
		  weaponVelocity          = 4500,
		 --  soundHit           = "null",
		-- --soundStart         = "null",


   

		  --physics

		  range                   = 250,
		  
		  reloadtime              =666,
	
		  sprayAngle              = 0,
	      tolerance               = 20,
		  lineOfSight             = false,	      
	      turret                  =true,
		  craterMult              = 0,	      
		
		  soundStart         = "",
		  soundtrigger=1,
		
		  --apperance
		  rgbColor                = [[0 0 0]],		  	      
          size                    = 0.1,
	     
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})