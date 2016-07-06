local weaponName="jethiefweapon"
local weaponDef={
name="E-Thief Weapon",

        accuracy                = 512,
        areaOfEffect            = 20,
   
        coreThickness           = 0.5,
        craterBoost             = 0,
        craterMult              = 0,

       

        damage                  = {
                default = 0,
                planes  = 0,
                subs    = 0,
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
        range                   = 920,
        reloadtime              = 0.5,
        rgbColor                = [[0.7 1 0]],
        rgbColor2               = [[0.8 1 0.1]],
    
        targetMoveError         = 0.25,
        thickness               = 3,
        tolerance               = 5000,
        turret                  = true,
        weaponType              = [[LaserCannon]],
        weaponVelocity          = 500,
		
		
}
return lowerkeys ({[weaponName]=weaponDef})