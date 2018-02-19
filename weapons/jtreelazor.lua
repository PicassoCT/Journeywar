local weaponName = "jtreelazor"
local weaponDef = {
    name = "Green Sleaves",
    weaponType = [[BeamLaser]],
    beamweapon = 1,
    -- beamlaser=1,
    -- WeaponAcceleration=0,
    accuracy = 0,
    --guidance=1,
    laserflaresize = 3, --0.3
    beamTtl = 0.15, --0.01
    movingaccuracy = 1000,
    predictBoost = 1.5,
    avoidFriendly = true,
    soundtrigger = true,
    collideFriendly = false,
    beamtime = 1, --0.01

    FireSubmersed = 0,
    impulseFactor = 0.1,
    largeBeamLaser = true,
    lineOfSight = false,

    --explosiongenerator = "custom:smallblueburn",
    targetMoveError = 0.5,
    noSelfDamage = true,
    range = 700,
    reloadtime = 2.0,
    renderType = 0,
    sweepfire = true,
    turret = true,
    --soundHit           = "null",
    --soundStart         = "null",
    FireStarter = 0,
    coreThickness = 0.3,
    thickness = 3.14,
    --rgbColor  = [[1 0.4 0.25]],
    rgbColor = [[0.4 1 0]],
    rgbColor2 = [[0.3 0.7 0.1]],
    HardStop = 1, --test It
    Intensity = 1.4, --test It
    scrollspeed = 0.3,
    explosionGenerator = "custom:green_electric_explosion",
    tolerance = 1000,
    damage = {
        default = 25,
        HeavyArmor = 45,
    },
    areaOfEffect = 12,
}

return lowerkeys({ [weaponName] = weaponDef })