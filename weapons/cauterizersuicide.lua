local weaponName = "cautsuicide"
local weaponDef = {
    name = "cautsuicide",
    weaponType = [[MissileLauncher]],
  

	highTrajectory =1,
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
    tracks = true,
    Turnrate = 16000,
    collideFriendly = true,

    --- -APPEARANCE
    model = "cauterizerproj.s3o",
    smokeTrail = true,
    --explosionGenerator="xamelimpact",
    --CegTag="smoketrail",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 90.0,
    avoidFeature = false,
    avoidFriendly = false,
    explosionGenerator = "custom:artillery_explosion",
    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 450,
        heavyarmor = 150,
    },
    areaOfEffect = 25,
    craterMult = 0,

    --?FIXME***
    lineOfSight = false,


    --sound
    soundHit = "cauterizer/impact.ogg",

 
}

return lowerkeys({ [weaponName] = weaponDef })