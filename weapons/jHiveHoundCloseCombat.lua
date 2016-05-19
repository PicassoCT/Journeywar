---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jHiveCloseCombat"
local weaponDef = {
	      name                    = "Biting",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 175,
				HeavyArmor = 5,
				},	      
	      areaOfEffect            = 28,
		  --physics
		  weaponVelocity          = 4500,
		   soundHit           = "null",



   

		  --physics

		  range                   = 45,
		  
		  reloadtime              =12,
		  
		  sprayAngle              = 0,
	      tolerance               = 20,
		  lineOfSight             = false,	      
	      turret                  =true,
		  craterMult              = 0,	      
		
		  soundStart         = "sounds/jhivehound/aggressive.ogg",
		  soundtrigger=1,
		
		  --apperance
		  rgbColor                = [[0 0 0]],		  	      
          size                    = 0.1,
	     
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})