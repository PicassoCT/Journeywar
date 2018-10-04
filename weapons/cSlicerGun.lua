local weaponName = "slicergun"
local weaponDef = {
    name = "slicer",
    weaponType = [[Cannon]],
    Accuracy = 1000,

    --Physic/flight path
    range = 750,
    reloadtime = 5,
    weaponVelocity = 250,
    startVelocity = 250,
    weaponAcceleration = 50,
    flightTime = 3.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 0,
    wobble = 0,
    turnrate = 0,
    tolerance = 600,
    tracks = false,
    Turnrate = 0,
    collideFriendly = true,

    --- -APPEARANCE
    model = "emptyObjectIsEmpty.s3o",
    smokeTrail = false,
    explosionGenerator = "custom:slicegunhit",
    CegTag = "slicegunsfx",

    --- -TARGETING
    turret = true,

    avoidFeature = false,
    avoidFriendly = false,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 450,
        heavyarmor = 350,
    },
    areaOfEffect = 100,
    craterMult = 0,

	 soundStart="ccomender/slicergun.wav",
	 soundHit="ccomender/slicergun.wav",

    --?FIXME***
    lineOfSight = true,


    --sound
}

return lowerkeys({ [weaponName] = weaponDef })