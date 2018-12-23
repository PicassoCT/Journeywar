--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "sniperweapon"
local weaponDef = {
    name = "sniperweapon",
    weaponType = [[Cannon]],

    areaOfEffect = 1,
    --physics
    weaponVelocity = 450,
    reloadtime = 8,
    range = 800,
    sprayAngle = 0,
    tolerance = 0,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    PredictBoost = 0.3,
    soundtrigger = 1,

    --appearance
    rgbColor = [[0.05 0.05 0.05]],
    size = 2,



    ---------------------------------------------------------------

    ----------------------------------------------------------------
    ImpulseBoost = 2.8,
    impulseFactor = 10,
    damage = {
        default = 780,
        HeavyArmor = 680,
    },
}
return lowerkeys({ [weaponName] = weaponDef })