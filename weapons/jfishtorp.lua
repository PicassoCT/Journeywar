local weaponName="jfishtorp"
local weaponDef={
name="Torpedous Deadlionis",

      areaOfEffect            = 16,
      avoidFriendly           = false,
      burnblow                = true,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 400,
      },

    --explosionGenerator      = [[custom:TORPEDO_HIT]],

      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      model                   = [[jFishWaterTorp.s3o]],
      noSelfDamage            = true,
      range                   = 500,
      reloadtime              = 3,
      renderType              = 1,

     -- soundHit                = [[OTAunit/XPLODEP1]],
     -- soundStart              = [[OTAunit/TORPEDO1]],
      startVelocity           = 140,
      tolerance               = 42767,
      tracks                  = true,
      turnRate                = 8000,
      turret                  = false,
      waterWeapon             = true,
      weaponAcceleration      = 15,
      weaponTimer             = 4,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 140,

}

return lowerkeys ({[weaponName]=weaponDef})