local weaponName = "jfiredancerproj"
local weaponDef = {
    name = "jfiredancerproj",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 800,
    reloadtime = 3,
    weaponVelocity = 1000,
    startVelocity = 150,
    weaponAcceleration = 250,
    flightTime = 2.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 1,
    wobble = 4,
    tolerance = 16000,
    tracks = true,
    Turnrate = 16000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "jfireProj.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",
    CegTag = "firedancerprojsfx", --firetwo

    --- -TARGETING
    turret = true,
    cylinderTargeting = 1.0,
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
    lineOfSight = true,


    --sound
    soundHit = "jfiredancer/impact.wav",
    soundStart = "jfiredancer/firedancerfire2.ogg",
}

return lowerkeys({ [weaponName] = weaponDef })