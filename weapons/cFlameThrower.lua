---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cflamethrower" --this is the actually maschinegune of the blackguard
local weaponDef = {

    accuracy           = 1500,
    AreaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    explosionGenerator = "custom:flames",
	SprayAngle=2200,
	Burst=5,
	BurstRate=0.1,
   -- coreThickness      = 0,
    duration           = 1,
 
    fallOffRate        = 1,
    fireStarter        = 50,
	cegTag                  = [[fireStarter]],
 --   soundstart         = "flamethrower.wav",
	FireSubmersed=false,
    lineOfSight        = true,
    minintensity       = 0.1,
    impulseFactor      = 0.1,
    name               = "Fires",
    range              = 120,
    reloadtime         = 0.5,
    WeaponType         = [[LaserCannon]],
    rgbColor           = "0 0 0",
    rgbColor2          = "0 0 0",
    thickness          = 0,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 400,
	sweepfire=true,--
    damage = {
      default           = 5,
    },
  }

return lowerkeys({[weaponName] = weaponDef})
