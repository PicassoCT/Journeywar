---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jResSubMG"
local weaponDef = {
	      name                    = "Sub Maschine Gun",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 5,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 0.25,
		  range                   = 250,
		  sprayAngle              = 300,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  burst=8,
		  burstrate=0.2,
		--  soundStart         = "jresistance/ressubmg3",
		--   soundHit                = [[jresistance/ressubmg2]],
		 -- explosionGenerator="custom:Ricochet",
		  soundtrigger=1,
		  SweepFire=1,
		  --apperance
		  rgbColor                = [[1 0.8 0.4]],		  	      
          size                    = 0.45,
	      stages                  = 20,
		  separation              = 1,
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})