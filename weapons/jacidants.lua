local weaponName = "jacidants"
local weaponDef = {
    name = "Acidic Ant Wedding: Hive Sweet Hive",
    weaponType = [[Cannon]],
    --vlaunch=1,


    --Physic/flight path
    range = 8000,
    reloadtime = 9,
    weaponVelocity = 320,
    startVelocity = 50,
    weaponAcceleration = 50,
    flightTime = 25.5,
    cameraShake = 12;
    FixedLauncher = true,
    accuracy = 1200,
    tolerance = 3000,
    tracks = false,
    Turnrate = 16000,
    collideFriendly = true,
    WeaponTimer = 4,
    BurnBlow = 1,
    highTrajectory = 1,

    --- -APPEARANCE
    model = "jantbull.s3o",

    --explosionGenerator="xamelimpact",
    --CegTag="smoketrail",

    --- -TARGETING
    turret = true,
    --CylinderTargetting=true,
    avoidFeature = false,
    avoidFriendly = false,


    --commandfire=true,
    --explosionGenerator=[[custom:jantseverywhere]],
    CegTag = "jlessants",
    --- -DAMAGE
    damage = {
        default = 1,
        heavyarmor = 1,
    },
    areaOfEffect = 30,
    craterMult = 0,

    --?FIXME***
    lineOfSight = false,


    --sound
    soundHit = "jantart/jantimpactor",
    soundStart = "jantart/jantartlaunch",
}

return lowerkeys({ [weaponName] = weaponDef })