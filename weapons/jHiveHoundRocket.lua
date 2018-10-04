local weaponName = "jhivehoundrocket"
local weaponDef = {
    name = "Jump towards the Enemy",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 200,
    reloadtime = 35,
    weaponVelocity = 300,
    startVelocity = 140,
    weaponAcceleration = 50,
    flightTime = 4.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 0,
    wobble = 0,
    tolerance = 16000,
    tracks = true,
    Turnrate = 1900,
    collideFriendly = false,

    --- -APPEARANCE
    model = "jHiveHoundProj.s3o",
    smokeTrail = false,
  --  explosionGenerator = "custom:jvaryfootrail",
  --  CegTag = "jvaryfootrail",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 100,
    avoidFeature = true,
    avoidFriendly = false,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 15,
        heavyarmor = 5,
    },
    areaOfEffect = 10,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    --soundHit="skinfantry/birdrockethit.ogg",
    --soundStart="skinfantry/birdrocketstart.ogg",
}

return lowerkeys({ [weaponName] = weaponDef })