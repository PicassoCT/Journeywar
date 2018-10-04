--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cchoppermines" --this is the actually maschinegune of the inferno trooper
local weaponDef = {
    name = "Floatbomb",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 150,
        heavyarmor = 200,
    },
    areaOfEffect = 100,
    craterMult = 0,
    areaOfEffect = 28,
    --  explosionGenerator="custom:AR2Impact",
    --  cegTag="AR2Projectile",
    --  texture1="empty",
    model = "cChopperBomb.s3o",
    --physics

    weaponVelocity = 550,
    reloadtime = 0.42,
    range = 330,
    sprayAngle = 6000,
    accuracy = 0.2,
    tolerance = 5000,
    lineOfSight = true,
    turret = true,
    groundbounce = true,
    WaterBounce = true,
    BounceRebound = 0.251,
    bounceslip = 0.256,
    NumBounce = 3,
    flighttime = 20,
    collideFriendly = false,
    soundStart = "cHunterChopper/bombdrop",
    soundHit = "cHunterChopper/bombexplodes",
    soundtrigger = 1,
    --apperance
    size = 0.1,
    craterBoost = 3,
    cylinderTargeting = 17.0,
    edgeEffectiveness = 0.2,
    --	explosionGenerator="custom:missile_explosion",
    fireStarter = 100,
    impulseFactor = 3.1,

    --interceptedByShieldType = 16,
    myGravity = 0.2,
    targetBorder = 0,
}

return lowerkeys({ [weaponName] = weaponDef })