---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "csuborbitalstrike"
local weaponDef = {

   name                    = "cSubOrbitalStrike",
   

 weaponType              = [[Cannon]],

		 soundHit           = "null",
		 --soundStart         = "null",


   
	      areaOfEffect            = 1,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 8,
		  range                   = 9999900,
		  sprayAngle              = 0,
	      tolerance               = 0,
		  lineOfSight             = false,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  PredictBoost			  =0.6,
		  soundtrigger=1,
		
		  --appearance
		  rgbColor                = [[0.05 0.05 0.05]],		  	      
          size                    = 0.002,



---------------------------------------------------------------

----------------------------------------------------------------
	      ImpulseBoost=2.8,
          impulseFactor      = 10,
		  damage = {
				default = 1,
				HeavyArmor =1,
				},	   
		  
		} return lowerkeys({[weaponName] = weaponDef}) 
   
   
   
   
  