--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jbeefeatermarker"
local weaponDef = {
    name = "jbeefeatermarker",
    weaponType = [[Cannon]],

    areaOfEffect = 164,
    --physics
    weaponVelocity = 4950,
    reloadtime = 28,
    range = 800,
    sprayAngle = 0,
    tolerance = 0,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    PredictBoost = 0.6,
    soundtrigger = 0,

    --appearance
    rgbColor = [[0.05 0.05 0.05]],
    size = 0.002,

    ImpulseBoost = 2.8,
    impulseFactor = 10,
    damage = {
        default = 1,
        HeavyArmor = 1,
    },
} return lowerkeys({ [weaponName] = weaponDef })
   
   
   
   
  