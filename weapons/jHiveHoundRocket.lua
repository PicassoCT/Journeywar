local weaponName = "jHiveHoundRocket"
local weaponDef = {
    name = "jump",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 80,
    reloadtime = 15,
    weaponVelocity = 500,
    startVelocity = 350,
    weaponAcceleration = 100,
    flightTime = 1,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 0,
    wobble = 0,
    tolerance = 16000,
    tracks = false,
    Turnrate = 16000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "jHiveHoundProj.s3o",
    smokeTrail = false,
    explosionGenerator = "custom:dirt",
    --CegTag="smoketrail",

    --- -TARGETING
    turret = true,
    avoidFeature = true,
    avoidFriendly = true,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 0,
        heavyarmor = 0,
    },
    areaOfEffect = 10,
    craterMult = 0,

    --?FIXME***
    lineOfSight = false,


    --sound
    soundHit = "",
    soundStart = "",
}

return lowerkeys({ [weaponName] = weaponDef })