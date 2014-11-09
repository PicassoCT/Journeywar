---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cWEFence1"
local weaponDef = {
	  weaponType              = [[LightningCannon]],
	  name                    = [[Lightning Gun]],
	  areaOfEffect            = 30,
      beamWeapon              = true,
	  
      craterBoost             = 0,
      craterMult              = 0,
   --   cylinderTargetting      = false,
      
      damage                  = {
        default = 29,
             },

      duration                = 0.0025,
	  
	  
	 
	  Accuracy				  =	110, --1500: damit trifft er dudes kaum --1100: war ganz gut als die 5 blitze noch nicht in fire arcs aufgeteilt waren.
      duration                = 100,
      explosionGenerator      = [[custom:cEfenceSplash]],	--effect on impact
      fireStarter             = 1000,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0,
      --intensity               = 12,
      interceptedByShieldType = 1,
      lineOfSight             = false,
      noSelfDamage            = true,
      paralyzer               = true,
      paralyzeTime            = 7,
      range                   = 50,
      reloadtime              = 0.3,
      --renderType              = 7,
      rgbColor                = [[0.5 0.3 1]],
      startsmoke              = [[1]],
      targetMoveError         = 0.3,
      texture1                = [[efence]],
      thickness               = 5,
      turret                  = true,
   
      weaponVelocity          = 400,
    
		  }
		
return lowerkeys({[weaponName] = weaponDef})