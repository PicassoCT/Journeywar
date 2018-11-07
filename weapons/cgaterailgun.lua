local weaponName = "cgaterailgun"
local weaponDef = {
    name = "GateRailGun",
    weaponType = [[StarburstLauncher]],
    vlaunch = 1,
    weaponTimer = 3.0,

    --Physic/flight path
    range = 3000,
    reloadtime = 3000,
    weaponVelocity = 1000,
    startVelocity = 250,
    weaponAcceleration = 200,
    flightTime = 5.5,
    cameraShake = 12;
    FixedLauncher = true,
    dance = 0,
    wobble = 0,
    trajectoryheight = 0.8,
    accuracy = 600,
    tolerance = 1000,
    tracks = false,
    Turnrate = 16000,


    --- -APPEARANCE
    model = "CGateProj.s3o",
    smokeTrail = true,
    explosionGenerator = [[custom:artillery_explosion]],
    --CegTag="smoketrail",
    cegtag = "cartdarkmat_STARFX",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 50.0,
    avoidFeature = false,
    avoidFriendly = false, --artillery doesent know friend or foe, only worthwile targets
	 avoidGround  = false,
	 collideFriendly = false,
	 collideFirebase  = false,
	 collideNeutral = false,
	 

    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 350,
        heavyarmor = 150,
    },
    areaOfEffect = 100,
    craterMult = 2,
    lineOfSight = false,


    --sound
    soundHit = "cart/darkmExplo",
}

return lowerkeys({ [weaponName] = weaponDef })