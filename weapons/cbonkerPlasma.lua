---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cbonkerplasma"
local weaponDef = {

   name                    = "Channel",
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
	areaOfEffect       = 1,
	avoidFriendly      = true,
	soundtrigger = true,
	
	collideFriendly    = false,

	beamtime = 3,--0.01

	  FireSubmersed=0,

	  impulseFactor      = 0.1,
	  largeBeamLaser     = true,
	  lineOfSight        = false,
	  
	    --explosiongenerator = "custom:smallblueburn",
	targetMoveError=0.5,
	noSelfDamage       = true,
	range              = 350,
	reloadtime         = 2.0,
	renderType         = 0,

	  sweepfire=false,
	  
	turret      	   =true,
	--soundHit           = "null",
	----soundStart         = "null",
	startsmoke         = 0,
	coreThickness=0.3,
	thickness          = 2.5,
	--rgbColor  = [[1 0.4 0.25]],
	rgbColor  =[[0.6 1 1]],
	rgbColor2 =[[1 1 1]],
	HardStop=1,--test It
	Intensity=1.4,--test It
	ScrollSeed=0.3,

		  explosionGenerator="custom:vortflames",
	tolerance          = 1000,

    damage = {
				default = 5,
				HeavyArmor =5,
				},
  
		  
		}
return lowerkeys({[weaponName] = weaponDef})