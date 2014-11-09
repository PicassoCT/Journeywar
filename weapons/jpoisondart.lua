---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jpoisondart"
local weaponDef = {
 name                    = "Poisoned Dart",
 weaponType              = [[Cannon]],

		-- --soundHit           = "null",
		-- --soundStart         = "null",


   
	      areaOfEffect            = 1,
		  --physics
		  weaponVelocity          = 1450,
		  reloadtime              = 32000,
		  range                   = 1200,
		  sprayAngle              = 0,
	      tolerance               = 0,
		  lineOfSight             = true,	      
	      turret                  = false,
		  craterMult              = 0,	      
		  PredictBoost			  =0.6,
		  soundtrigger=1,
		
		  --appearance
		  rgbColor                = [[0.01 0.01 0.01]],		  	      
          size                    = 1,



---------------------------------------------------------------

----------------------------------------------------------------

model="jpoisondart.s3o",

	      ImpulseBoost=2.8,
          impulseFactor      = 10,
		  damage = {
				default = 12,
				HeavyArmor =12,
				},	   
		  
		}
return lowerkeys({[weaponName] = weaponDef})