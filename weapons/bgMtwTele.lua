---http:--springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "bgMtwTele"
local weaponDef = {
	      name                    = "bgMtwTele",
		  weaponType              = [[LightningCannon]],
	areaOfEffect            = 8,
	craterBoost             = 0,
	craterMult              = 0,


 damage = {
				default = 0,
				HeavyArmor = 0,
				},

	duration                = 10,

	fireStarter             = 110,
	impactOnly              = true,
	impulseBoost            = 0,
	impulseFactor           = 0.4,
	intensity               = 12,
	interceptedByShieldType = 1,
	lineOfSight             = true,
	paralyzer               = true,
	paralyzeTime            = 4,
	range                   = 280,
	reloadtime              = 2,
	rgbColor                = [[0.0 0.95 0.2]],
	

	startsmoke              = [[1]],
	targetMoveError         = 0.3,

	thickness               = 10,
	turret                  = true,
	
	weaponVelocity          = 400,
    
		 
	}	  
		
return lowerkeys({[weaponName] = weaponDef})