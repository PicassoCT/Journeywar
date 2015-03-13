---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cchoppermg" --this is the actually maschinegune of the blackguard
local weaponDef = {
	      name                    = "cchoppermg",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 10,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 8,
		  explosionGenerator="custom:chelicopterimpact",
		  cegTag="AR2Projectile",
		  texture1="empty",
		
		  --physics
		  weaponVelocity          = 850,
		  reloadtime              = 0.35,
		  range                   = 450,
		  sprayAngle              = 400,
	      tolerance               = 2000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  burst=11,
		  burstrate=0.2,
			soundStart         = "sounds/cHunterChopper/firelooper.wav",
		--  soundHit="cHunterChopper/bulletimpact.wav",
		  soundtrigger=1,
		  SweepFire=1,
		  --apperance
		  rgbColor                = [[0.5 0.95 0.85]],		  	      
          size                    = 1.2,
			
		
		  
	      stages                  = 20,
		  separation              = 0.2,
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})