local weaponName = "jglowproj"
local weaponDef = {
    name = "Glowworm",
    weaponType = [[MissileLauncher]],
    Accuracy = 1000,
    range = 700,
    reloadtime = 7,
    weaponVelocity = 350,
    startVelocity = 50,
    weaponAcceleration = 250,
    flightTime = 11.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 42,
    wobble = 12,
    turnrate = 12200,
	 burst = 3,
	burstrate = 0.5,
    tolerance = 16000,
    tracks = true,
    Turnrate = 32000,
    collideFriendly = false,

    --- -APPEARANCE
    model = "jGlowProj.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",
    CegTag = "jglowwormsfx",

    --- -TARGETING
    turret = true,
    CylinderTargeting = 1.0,
    avoidFeature = true,
    avoidFriendly = true,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 450,
        heavyarmor = 350,
    },
    areaOfEffect = 100,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    soundHit = "",
    soundStart = "",
}

return lowerkeys({ [weaponName] = weaponDef })