---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jfootstomp"
local weaponDef = {
	      name                    = "footStompinMusicNeverGetEnough",
	      weaponType              = [[Melee]],
	      --damage
		  damage = {
				default = 4000,
				HeavyArmor = 1200,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 2450,
		  reloadtime              = 0.1,
		  range                   = 35,
		  sprayAngle              = 0,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  =true,
		  craterMult              = 3.2,	      
		
		  soundStart         = "sounds/jBeherith/crunchy.ogg",
		  soundtrigger=1,
		
		  --apperance
		  rgbColor                = [[0 0 0]],		  	      
          size                    = 0.1,
	     
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})