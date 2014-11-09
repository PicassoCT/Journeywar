---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cchoppermines" --this is the actually maschinegune of the blackguard
local weaponDef = {
	      name                    = "Bombs",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 50,
				HeavyArmor = 26,
				},	      
	      areaOfEffect            = 28,
		--  explosionGenerator="custom:AR2Impact",
		--  cegTag="AR2Projectile",
		--  texture1="empty",
		  model="cChopperBomb.s3o",
		  --physics
	
		  weaponVelocity          = 850,
		  reloadtime              = 19.35,
			range = 480,
		  sprayAngle = 12000,
		  accuracy =0.2,
	      tolerance               = 5000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 3,	      
		  groundbounce=true,
		  WaterBounce=true,
		   BounceRebound=0.351,
		   bounceslip = 0.256,
		    NumBounce=5,
			flighttime =20,
		  collideFriendly = false,
		soundStart         = "cHunterChopper/bombdrop",
		soundHit="cHunterChopper/bombexplodes",
		  soundtrigger=1,
		  --apperance		  	      
          size                    = 0.1,
			
			areaOfEffect = 150,
			craterBoost = 3,
			cylinderTargeting = 17.0,
			edgeEffectiveness = 0.2,
			explosionGenerator="custom:330rlexplode",
			fireStarter = 100,
			impulseFactor = 3.1,

			--interceptedByShieldType = 16,
			myGravity = 0.2,
			targetBorder = 0,

		  }
		
return lowerkeys({[weaponName] = weaponDef})