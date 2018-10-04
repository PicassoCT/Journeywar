--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jvarytaraompf"
local weaponDef = {
    name = "ompf",
    weaponType = [[Melee]],

    -- --soundHit = "null",
    -- --soundStart = "null",


    areaOfEffect = 1,
    --physics
    weaponVelocity = 450,
    reloadtime = 1,
    range = 300,
    sprayAngle = 300,
    tolerance = 800,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    PredictBoost = 0.6,
    soundtrigger = 1,

    --appearance
    rgbColor = [[0.01 0.01 0.01]],
    size = 1,



    ---------------------------------------------------------------

    ----------------------------------------------------------------
    ImpulseBoost = 0.08,
    impulseFactor = 0.025,
    damage = {
        default = 125,
        HeavyArmor = 100,
    },
}
return lowerkeys({ [weaponName] = weaponDef })