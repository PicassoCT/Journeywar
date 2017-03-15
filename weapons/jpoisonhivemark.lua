---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jpoisonhivemark"
local weaponDef = {
   name                    = "attackmarker",
   weaponType              = [[MELEE]],

   accuracy           = 0,
   --guidance=1,
   laserflaresize = 1,--0.3
	beamTtl=   0.05,--0.01
	movingaccuracy=5000,
	predictBoost=1.5,
	areaOfEffect       = 1,
	avoidFriendly      = false,
	soundtrigger = true,
	collideFriendly    = false,

	  FireSubmersed=true,

	noSelfDamage       = true,
	range              = 1900,
	reloadtime         = 7.0,
	turret      	   =true,
	--soundHit           = "null",
	soundStart         = "sounds/jPoisondart/jPoisonDartLaunch.ogg",
	tolerance          = 1000,

    damage = {
				default = 0,
				HeavyArmor =0,
				},
  		}
return lowerkeys({[weaponName] = weaponDef})