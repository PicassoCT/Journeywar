---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cbonkerfire" --this is the actually maschinegune of the blackguard
local weaponDef = {
	      name                    = "Deadly Darkmatter",
	      weaponType              = [[Cannon]],
	      --damage
		  damage = {
				default = 15,
				HeavyArmor = 15,
				},	      
	      areaOfEffect            = 3,
		  explosionGenerator="custom:electric_explosion",
		  cegTag="cbonkerplasma",
		  texture1="",
		
		  impulseBoost=0.5,
		  --physics
		  weaponVelocity          = 850,
		  reloadtime              = 3.35,
		  range                   = 350,
		  sprayAngle              = 25,
	      tolerance               = 8000,
		  lineOfSight             = true,	      
	      turret                  = false,
		  craterMult              = 0,	      
		  burst=2,
		  burstrate=0.5,
		--  soundStart         = "bonkers/plasma",
		  
		  soundtrigger=1,
		  SweepFire=0,
		  --apperance
		  rgbColor                = [[0.5 0.95 0.85]],		  	      
          size                    = 1.2,
			
		
		  
	      stages                  = 3,
		  separation              = 1.5,
		 
		  }
		
return lowerkeys({[weaponName] = weaponDef})