local weaponName="cwallbuildw"
local weaponDef={
name="Lazzorz",

        accuracy                = 512,
        areaOfEffect            = 20,
   
        coreThickness           = 0.5,
        craterBoost             = 0,
        craterMult              = 0,

       

        damage                  = {
                default = 35,
                planes  = 35,
                subs    = 1.75,
        },

        duration                = 0.3,
        dynDamageExp            = 1,
        dynDamageInverted       = false,
 
        fallOffRate             = 1,
        fireStarter             = 150,
        heightMod               = 1,
        impactOnly              = true,
        impulseBoost            = 0,
        impulseFactor           = 0.4,
        interceptedByShieldType = 1,
        lodDistance             = 10000,
        proximityPriority       = 4,
        range                   = 320,
        reloadtime              = 0.1,
        rgbColor                = [[0 1 0.9]],
        rgbColor2               = [[0.1 1 1]],
    
        targetMoveError         = 0.25,
        thickness               = 3,
        tolerance               = 5000,
        turret                  = true,
        weaponType              = [[LaserCannon]],
        weaponVelocity          = 500,
}

return lowerkeys ({[weaponName]=weaponDef})