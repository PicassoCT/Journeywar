--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "ccauterizermark"
local weaponDef = {
    name = "targetreached",
    weaponType = [[MELEE]],

    areaOfEffect = 164,
    --physics
    weaponVelocity = 9999999,
    reloadtime = 28,
    range = 200,
    sprayAngle = 0,
    tolerance = 0,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    PredictBoost = 0.6,
    soundtrigger = 0,

    --appearance
    rgbColor = [[0.05 0.05 0.05]],
    size = 0.000000001,

    ImpulseBoost = 2.8,
    impulseFactor = 10,
    damage = {
        default = 1,
        HeavyArmor = 1,
    },
} return lowerkeys({ [weaponName] = weaponDef })
   
   
   
   
  