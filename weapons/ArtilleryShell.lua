local weaponName = "crabshell"
local weaponDef = {
    name = "crabshell",
    weaponType = [[Cannon]],
    name = "HeadCrabShell",



    --

    --weapontimer=7,
    --
    --Physic/flight path
    range = 1800,
    reloadtime = 9,
    weaponVelocity = 1000,
    startVelocity = 250,
    weaponAcceleration = 200,
    flightTime = 2.5,
    BurnBlow = 0,
    FixedLauncher = true,
    dance = 0,
    wobble = 0,
    trajectoryheight = 0.8,
    accuracy = 4200,
    tolerance = 16000,
    tracks = false,
    Turnrate = 16000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "crabshell.s3o",
    smokeTrail = true,
    --explosionGenerator="xamelimpact",
    CegTag="smoketrail",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 90.0,
    avoidFeature = false,
    avoidFriendly = false,
    explosionGenerator = "custom:dirt",
    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 150,
        heavyarmor = 50,
    },
    areaOfEffect = 25,
    craterMult = 0,

    --?FIXME***
    lineOfSight = false,


    --sound
    soundHit = "cart/arthchit",
    soundStart = "cart/artfire",
}

return lowerkeys({ [weaponName] = weaponDef })