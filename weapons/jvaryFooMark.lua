---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jvaryfoomark"
local weaponDef = {
 name                    = "nomnomnom",
 weaponType              = [[Melee]],

		-- --soundHit           = "null",
		-- --soundStart         = "null",


   
	      areaOfEffect            = 1,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 800,
		  range                   = 90,
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
	      ImpulseBoost=7.8,
          impulseFactor      = 10,
		  damage = {
				default = 125,
				HeavyArmor =100,
				},	   
		  
		}
return lowerkeys({[weaponName] = weaponDef})