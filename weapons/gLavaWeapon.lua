---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "gLavaWeapon"
local weaponDef = {
	      name                    = "gLavaWeapon",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 230,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 1,
		  range                   = 60,
		  sprayAngle              = 300,
	      tolerance               = 8000,
		  FireStarter=100,
		  lineOfSight             = false,	      
	      turret                  =true,
		  craterMult              = 0,	      
		  smoketrail=1,
		  explosionGenerator="custom:flames",
		
		  soundtrigger=1,
		
		  --apperance
		  rgbColor                = [[0 0 0]],		  	      
          size                    = 0.1,
	   --  soundHit="sounds/impact.wav",

		  }
		
return lowerkeys({[weaponName] = weaponDef})