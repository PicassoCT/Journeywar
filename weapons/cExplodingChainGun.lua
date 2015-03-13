
local weaponName = "cexplochaingun" --this is the actually maschinegune of the blackguard
local weaponDef = {
	      name                    = "Explosive Ammo",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 10,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 8,
		-- explosionGenerator="custom:chelicopterimpact",
		--  cegTag="AR2Projectile",
		  texture1="empty",
		  model="cExploAmmo.s3o",
		  --physics
		  weaponVelocity          = 850,
		  reloadtime              = 5.35,
		  range                   = 450,
		  sprayAngle              = 400,
	      tolerance               = 2000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  burst=7,
		  burstrate=0.2,
		--	soundStart         = "sounds/cHunterChopper/firelooper.wav",
		--  soundHit="cHunterChopper/bulletimpact.wav",
		  soundtrigger=1,
		  SweepFire=1,
		  --apperance
		  rgbColor                = [[0.5 0.95 0.85]],		  	      
          size                    = 1.2,
			
		
		  
	      stages                  = 1,
		  separation              = 0.2,
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})