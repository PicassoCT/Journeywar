local weaponName = "jethiefretweapon"
local weaponDef = {
    name = "returning Energy Orb",
    weaponType = [[MissileLauncher]],
    Accuracy = 500,

    --Physic/flight path
    range = 1800,
    reloadtime = 3,
    weaponVelocity = 900,
    startVelocity = 150,
    weaponAcceleration = 250,
    flightTime = 12.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 42,
    wobble = 12,
    tolerance = 16000,
    tracks = true,
    Turnrate = 64000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "jGlowProj.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:bloodslay",
    --CegTag="smoketrail",
    CegTag = "jglowstrip",
    --- -TARGETING
    turret = true,
    cylinderTargeting = 100,
    avoidFeature = true,
    avoidFriendly = true,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 0,
        heavyarmor = 0,
    },
    areaOfEffect = 1,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    --soundHit="cweapons/eaterImpact.ogg",
    --soundStart="cweapons/eaterlaunch.ogg",
}

return lowerkeys({ [weaponName] = weaponDef })