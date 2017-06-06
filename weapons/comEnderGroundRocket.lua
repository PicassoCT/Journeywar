local weaponName = "grocket"
local weaponDef = {
    name = "Long Range Ground Rocket",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 4095,
    reloadtime = 1,
    weaponVelocity = 1500,
    startVelocity = 100,
    weaponAcceleration = 250,
    flightTime = 10.5,
    BurnBlow = 2,
    FixedLauncher = false,
    dance = 5,
    wobble = 14,
    tolerance = 16000,
    tracks = false,
    Turnrate = 16000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "cComEunguidedRProj.s3o",
    smokeTrail = true,
    --explosionGenerator="custom:redsmoke",
    --CegTag="conairexaust",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 55.0,
    avoidFeature = true,
    avoidFriendly = true,
    burst = 3,
    burstrate = 0.02,
    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 10,
        heavyarmor = 15,
    },
    areaOfEffect = 100,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    soundHit = "skinfantry/birdrockethit.wav",
    soundStart = "skinfantry/birdrocketstart.wav",
}

return lowerkeys({ [weaponName] = weaponDef })