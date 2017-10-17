--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cbggrenade" --this is the actually maschinegune of the blackguard
local weaponDef = {
    name = "grenade",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 50,
        heavyarmor = 75,
    },
    areaOfEffect = 25,
    craterMult = 1,

    --  explosionGenerator="custom:AR2Impact",
    --  cegTag="AR2Projectile",
    --  texture1="empty",
    model = "bgGrenade.s3o",
    --physics

    weaponVelocity = 550,
    reloadtime = 50.42,
    range = 150,
    sprayAngle = 6000,
    accuracy = 0.2,
    tolerance = 5000,
    lineOfSight = true,
    turret = true,
    groundbounce = true,
    WaterBounce = false,
    BounceRebound = 0.2,
    bounceslip = 0.05,
    NumBounce = 2,
    flighttime = 20,
    collideFriendly = true,
    -- soundStart = "cHunterChopper/bombdrop",
    -- soundHit = "cHunterChopper/bombexplodes",
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