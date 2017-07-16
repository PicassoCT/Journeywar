local weaponName = "jflowerfire"
local weaponDef = {
    name = "Fire",
    weaponType = [[Cannon]],
    Accuracy = 2000,

    --Physic/flight path
    range = 110,
    reloadtime = 1.2,
    weaponVelocity = 400,
    startVelocity = 50,
    weaponAcceleration = 50,
    flightTime = 0.8,
    BurnBlow = 0.1,
    dance = 1,
    wobble = 1,
    tolerance = 16000,
    tracks = true,
    Turnrate = 16000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "cHopper.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",
    --CegTag="smoketrail",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 1.0,
    avoidFeature = true,
    avoidFriendly = true,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 1,
        heavyarmor = 1,
    },
    areaOfEffect = 1,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    --soundHit="cHopper/detonation.wav",
    --soundStart="cHopper/Launch.wav",
}

return lowerkeys({ [weaponName] = weaponDef })