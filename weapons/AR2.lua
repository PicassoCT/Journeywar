---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "MachineGun"
local weaponDef = {
	      name                    = "Machine Gun",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 10,
				HeavyArmor = 10,
				},	      
	      areaOfEffect            = 8,
		  --physics
		  weaponVelocity          = 450,
		  reloadtime              = 0.25,
		  range                   = 250,
		  sprayAngle              = 300,
		  CollideFriendly = false,
		  avoidFeature=true,
			avoidFriendly=true,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  = true,
		  craterMult              = 0,	      
		  burst=2,
		  burstrate=0.2,
		  soundStart         = "maschinegun",
		  soundtrigger=1,
		  SweepFire=1,
		  --apperance
		  rgbColor                = [[0.12 0.9 0.9]],		  	      
          size                    = 0.45,
	      stages                  = 20,
		  separation              = 1,
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})