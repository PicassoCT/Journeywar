--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jfacehugger"
local weaponDef = {
    name = "sabotaging Units while not full Grown",
    weaponType = [[Melee]],
    areaOfEffect = 8,
    craterBoost = 0,
    craterMult = 0,	
	  damage = {
        default = 1,
        HeavyArmor = 1,
    },
 
    
    impactOnly = true,
    impulseBoost = 0.1,
    impulseFactor = 0.4,
    intensity = 12,

    lineOfSight = true,
 
    paralyzeTime = 1,
    range = 90,
    reloadtime = 0.1,
  --  rgbColor = [[0.0 0.95 0.2]],
  --  soundHit = "vort/zap4.wav",
    explosionGenerator = "",
    targetMoveError = 0.3,
    texture1 = [[vortw]],
    thickness = 25,
    turret = true,
    weaponVelocity = 400,
}

return lowerkeys({ [weaponName] = weaponDef })