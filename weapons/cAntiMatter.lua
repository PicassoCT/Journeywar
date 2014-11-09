---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cantimatter"
local weaponDef = {

   name                    = "Antimatter",
   

 weaponType              = [[Cannon]],

		-- soundHit           = "null",
		-- --soundStart         = "null",


   
	      areaOfEffect            = 5,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 4,
		  range                   = 66,
		  sprayAngle              = 0,
	      tolerance               = 100,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0.5,	      
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
				default = 600,
				HeavyArmor =600,
				},	   
		  
		} return lowerkeys({[weaponName] = weaponDef}) 
   
   
   
   
  