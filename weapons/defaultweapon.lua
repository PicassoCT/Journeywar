---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "defaultweapon"
local weaponDef = {
	      name                    = "default",
	      weaponType              = [[Melee]],
	      --damage
		  damage = {
				default = 23,
				HeavyArmor = 1,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 2,
		  range                   = 10,
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