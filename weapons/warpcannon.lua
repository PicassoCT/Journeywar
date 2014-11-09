---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "warpcannon"
local weaponDef = {

   name                    = "Singularity",
   weaponType              = [[BeamLaser]],

   beamweapon=1,
  -- beamlaser=1,
 -- WeaponAcceleration=0,
   accuracy           = 0,
   guidance=1,
   laserflaresize = 3,--0.3
	beamTtl=   0.15,--0.01
	movingaccuracy=5000,
	predictBoost=1.5,
	areaOfEffect       = 6,
	avoidFriendly      = true,
	soundtrigger = true,
	
	collideFriendly    = false,
	craterMult=1.2,--added
	cameraShake=15,
	beamtime = 1,--0.01

	  FireSubmersed=0,
	  sweepfire=false,
	  impulseFactor      = 0.1,
	  largeBeamLaser     = true,
	  lineOfSight        = false,
	  
	    --explosiongenerator = "custom:smallblueburn",
	targetMoveError=0.5,
	noSelfDamage       = true,
	range              = 450,
	reloadtime         = 19.0,
	renderType         = 0,

	
	  
	turret      	   =true,
	soundStart         = "strider/striderwarpfired",
	soundHit           = "strider/striderwarpexplo",
	soundtrigger=1,
	startsmoke         = 1,
	coreThickness=0.3,
	thickness          = 2.5,
	 rgbColor                = [[0.27 0.3 1]],		 
	 rgbColor                = [[0.27 0.27 0.9]],		
	HardStop=1,--test It
	Intensity=1.4,--test It
	ScrollSeed=0.3,
		customParams = {
				dgunwarped=1,
			},

		  explosionGenerator="custom:powerplant_explosion",
	tolerance          = 1000,

    damage = {
				default = 545,
				HeavyArmor =245,
				},
  
		  
		}
return lowerkeys({[weaponName] = weaponDef})