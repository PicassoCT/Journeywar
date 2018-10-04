--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "sentrygun"
local weaponDef = {
    name = "Sentrygun",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 10,
        HeavyArmor = 0.3,
    },
    areaOfEffect = 2,
    --physics
    weaponVelocity = 450,
    reloadtime = 0.10,
    range = 250,
    sprayAngle = 800,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    soundStart = "sentry/sentryshoot1",
    soundHit = "sentry/sentryshoot2",
    soundtrigger = 1,
    SweepFire = 1,
    --apperance
    rgbColor = [[0.4 0.8 0.8]],
    size = 1.15,
    stages = 45,
    separation = 0.4,
}

return lowerkeys({ [weaponName] = weaponDef })