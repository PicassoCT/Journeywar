local weaponName = "cchainlightning"
local weaponDef = {
    name = "LightninBolt",
    weaponType = [[MissileLauncher]],
    Accuracy = 1000,

    --Physic/flight path
    range = 1200,
    reloadtime = 3,
    weaponVelocity = 250,
    startVelocity = 5,
    weaponAcceleration = 50,
    flightTime = 18.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 160,
    wobble = 225,
    turnrate = 25500,
    tolerance = 6000,
    tracks = true,
    collideFriendly = false,

    --- -APPEARANCE
    model = "emptyObjectIsEmpty.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",
    CegTag = "cchainlightning",

    --- -TARGETING
    turret = true,
    CylinderTargeting = 222.0,
    avoidFeature = true,
    avoidFriendly = true,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 450,
        heavyarmor = 350,
    },
    areaOfEffect = 20,
    craterMult = 0,
    --?FIXME***
    lineOfSight = false,
    noSelfDamage = true,

    --sound
    soundHit = "sounds/ccrabsynth/clightning1.ogg",
    soundStart = "sounds/ccrabsynth/clightning2.ogg",
}

return lowerkeys({ [weaponName] = weaponDef })