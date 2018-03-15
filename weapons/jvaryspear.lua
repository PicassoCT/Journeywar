local weaponName = "jvaryspear"
local weaponDef = {
    name = "SpearUnit",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 800,
    reloadtime = 9000,
    weaponVelocity = 1200,
    startVelocity = 750,
    weaponAcceleration = 250,
    flightTime = 2.5,
    BurnBlow = 1,
    FixedLauncher = false,
    dance = 0, --1
    wobble = 0, --4

    tolerance = 2000,
    tracks = true,
    Turnrate = 0,
    collideFriendly = true,

    --- -APPEARANCE
    model = "jvaryspearproj.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",
    CegTag = "",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 66,
    avoidFeature = true,
    avoidFriendly = true,

    --- -DAMAGE
    damage = {
        default = 1,
        heavyarmor = 1,
    },
    areaOfEffect = 1,
    craterMult = 0,

    lineOfSight = true
}

return lowerkeys({ [weaponName] = weaponDef })