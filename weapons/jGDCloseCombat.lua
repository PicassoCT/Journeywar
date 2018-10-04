---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jGDCloseCombat"
local weaponDef = {
	      name                    = "Clawing and Biting",
	      weaponType              = [[Melee]],
	      --damage
		  damage = {
				default = 125,
				HeavyArmor = 45,
				},	      
	      areaOfEffect            = 3,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 2,
		  range                   = 35,
		  sprayAngle              = 300,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  =true,
		  craterMult              = 0,	      

		  soundStart         = "",
		  soundtrigger=1,
		
		  --apperance
		  rgbColor                = [[0 0 0]],		  	      
          size                    = 0.1,
	     
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})