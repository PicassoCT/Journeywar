local weaponName = "jvaryspear"
local weaponDef = {
    name = "SpearUnit",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 800,
    reloadtime = 8,
    weaponVelocity = 1000,
    startVelocity = 750,
    weaponAcceleration = 250,
    flightTime = 2.5,
    BurnBlow = 1,
    FixedLauncher = false,
    dance = 5, --1
    wobble = 1, --4

    tolerance = 2000,
    tracks = false,
    Turnrate = 32000,
    collideFriendly = false,

    --- -APPEARANCE
    model = "jvaryspearproj.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",
    CegTag = "jbirdtrail",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 66,
    avoidFeature = true,
    avoidFriendly = true,

    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 150,
        heavyarmor = 150,
    },
    areaOfEffect = 100,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true
}

return lowerkeys({ [weaponName] = weaponDef })