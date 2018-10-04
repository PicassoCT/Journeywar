local weaponName = "raiderarrow"
local weaponDef = {
    weaponType = [[MissileLauncher]],
    name = "raiderarrow",
    areaOfEffect = 128,
    avoidFeature = false,
    avoidGround = false,
    burst = 1,
    burstrate = 0.1,
    CegTag = "bluestripe",
    craterBoost = 1,
    craterMult = 2,
    dance = 20,
    edgeEffectiveness = 0.5,
    explosionGenerator = "custom:ccatapultexpl",
    fireStarter = 100,
    flightTime = 8,
    impulseBoost = 0,
    impulseFactor = 0.4,
    model = "ccatapultproj.s3o",
    noSelfDamage = true,
    projectiles = 2,
    range = 1450,
    reloadtime = 30,
    smokeTrail = false,

    --sound
    soundHit = "cgatefortress/CatapultImpact.ogg",
    soundStart = "cgatefortress/catapultFire.ogg",
    startVelocity = 100,
    tolerance = 512,
    trajectoryHeight = 1,
    turnRate = 2500,
    turret = true,
    weaponAcceleration = 100,
    weaponType = [[MissileLauncher]],
    weaponVelocity = 250,
    wobble = 7000,
    damage = {
        default = 15,
    },
}

return lowerkeys({ [weaponName] = weaponDef })