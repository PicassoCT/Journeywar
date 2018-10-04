--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cantimatter"
local weaponDef = {
    weaponType = [[MissileLauncher]],
    name = "cantimatter",
    Accuracy = 1000,
    noSelfDamage = true,
    --Physic/flight path

    dance = 5,
    turnrate = 30,
    --cost
    energyPerShot = 15,
    tolerance = 6000,
    tracks = false,
    collideFriendly = true,
    collideEnemy = true,
    range = 420,
    reloadtime = 30,
    weaponVelocity = 25,
    weaponAcceleration = 3,
    startVelocity = 15,
    flightTime = 22.5,
    FixedLauncher = false,
    noexplode = true,
    lineOfSight = false,
    --- -APPEARANCE
    model = "emptyObjectIsEmpty.s3o",
    smokeTrail = false,
    CegTag = "antimatter",

    --- -TARGETING
    turret = true,
    --CylinderTargetting=true,
    avoidFeature = true,
    avoidFriendly = true,
    --- -DAMAGE
    ImpulseBoost = 2.8,
    impulseFactor = 10,
    damage = {
        default = 600,
        HeavyArmor = 600,
    },
    areaOfEffect = 3,
    craterMult = 0,
    energyPerShot = 250,
    --sound
    soundHit = "sounds/campro/antimatter.wav",
    soundStart = "sounds/campro/antimatter.wav",
} return lowerkeys({ [weaponName] = weaponDef })