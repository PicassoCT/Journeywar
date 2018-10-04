local weaponName = "cartdarkmat"
local weaponDef = {
    name = "cartdarkmat",
    weaponType = [[StarburstLauncher]],
    vlaunch = 1,


    --Physic/flight path
    range = 2000,
    reloadtime = 9,
    weaponVelocity = 750,
    startVelocity = 500,
    weaponAcceleration = 200,
    flightTime = 15.5,
    cameraShake = 12;
    FixedLauncher = true,
    dance = 0,
    wobble = 0.5,
    trajectoryheight = 0.8,
    accuracy = 800,
    tolerance = 500,
    tracks = false,
    Turnrate = 16000,
    collideFriendly = true,
    WeaponTimer = 4,
    --- -APPEARANCE
    model = "emptyObjectIsEmpty.s3o",
    smokeTrail = false,
    explosionGenerator = [[custom:artillery_explosion]],
    --CegTag="smoketrail",
    cegtag = "cartdarkmat_STARFX",

    --- -TARGETING
    turret = true,
    cylinderTargeting = 50.0,
    avoidFeature = false,
    avoidFriendly = false, --artillery doesent know friend or foe, only worthwile targets


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