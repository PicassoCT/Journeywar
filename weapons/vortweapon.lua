---http:--springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "vortweapon"
local weaponDef = {
	      name                    = "vortweapon",
		  weaponType              = [[LightningCannon]],
	areaOfEffect            = 8,
	craterBoost             = 0,
	craterMult              = 0,


 damage = {
				default = 250,
				HeavyArmor = 70,
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
	
	soundHit="vort/zap4.wav",
	explosionGenerator="custom:burnteal",
	FireStarter   = 75,
	targetMoveError         = 0.3,
	texture1                = [[vortw]],
	thickness               = 10,
	turret                  = true,
	
	weaponVelocity          = 400,
    
		 
	}	  
		
return lowerkeys({[weaponName] = weaponDef})