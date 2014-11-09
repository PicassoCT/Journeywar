---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "sniper"
local weaponDef = {

   name                    = "sniper",
   weaponType              = [[BeamLaser]],
   beamweapon=1,
  -- beamlaser=1,
 -- WeaponAcceleration=0,
   accuracy           = 0,
   guidance=1,
   laserflaresize = 1,--0.3
	beamTtl=   0.05,--0.01
	movingaccuracy=5000,
	predictBoost=1.5,
	areaOfEffect       = 1,
	avoidFriendly      = true,
	soundtrigger = false,
	
	collideFriendly    = false,

	beamtime = 1,--0.01

	  FireSubmersed=0,

	  impulseFactor      = 0,
	  largeBeamLaser     = true,
	  lineOfSight        = false,
	  
	    --explosiongenerator = "custom:smallblueburn",
	targetMoveError=0.5,
	noSelfDamage       = true,
	range              = 900,
	reloadtime         = 0.01,
	renderType         = 0,

	  
	  
	turret      	   =false,
	soundHit           = "null",
	--soundStart         = "null",
	startsmoke         = 0,
	coreThickness=0.01,
	thickness          = 0.5,
	--rgbColor  = [[1 0.4 0.25]],
	rgbColor  =[[0.4 0.8 1]],
	rgbColor2 =[[0.4 1 1]],
	HardStop=1,--test It
	Intensity=1.4,--test It
	ScrollSeed=0.3,
	SweepFire=1,
		  explosionGenerator="custom:smallblueburn",
	tolerance          = 1000,

    damage = {
				default = 0,
				HeavyArmor =0,
				},
  
		  
		}
return lowerkeys({[weaponName] = weaponDef})