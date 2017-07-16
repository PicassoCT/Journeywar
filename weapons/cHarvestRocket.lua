local weaponName = "charvest"
local weaponDef = {
    name = "Harvest Drone",
    weaponType = [[MissileLauncher]],
    Accuracy = 2000,

    --Physic/flight path
    range = 1800,
    reloadtime = 9000,
    weaponVelocity = 250,
    startVelocity = 150,
    weaponAcceleration = 250,
    flightTime = 12.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 0,
    wobble = 0,
    tolerance = 16000,
    tracks = true,
    Turnrate = 32000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "cHarvestProj.s3o",
    smokeTrail = false,
    explosionGenerator = "custom:bloodslay",
    --CegTag="smoketrail",
    CegTag = "eaterstrip",
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
    areaOfEffect = 100,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    soundStart = "cweapons/eaterlaunch.ogg",
    soundHit = "cweapons/eaterlaunch.ogg",
}

return lowerkeys({ [weaponName] = weaponDef })