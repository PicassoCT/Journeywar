--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cflamethrower"
local weaponDef = {
    accuracy = 1500,
    AreaOfEffect = 50,
    avoidFeature = false,
    avoidFriendly = true,
    collideFeature = false,
    collideFriendly = false,
    noSelfDamage = true,
    explosionGenerator = "custom:flames",
    SprayAngle = 8200,
    Burst = 5,
    BurstRate = 0.1,
    -- coreThickness = 0,
    duration = 1,
    sizeGrowth = 0.25,
    fallOffRate = 1,
    fireStarter = 100,
    Texture0 = "",
    --	cegTag = [[fireStarter]],
    -- soundstart = "flamethrower.wav",
    FireSubmersed = false,
    lineOfSight = true,
    minintensity = 0.1,
    impulseFactor = 0.1,
    name = "Fires",
    range = 160,
    reloadtime = 0.5,
    WeaponType = [[LaserCannon]],
    rgbColor = "0 0 0",
    rgbColor2 = "0 0 0",
    thickness = 0,
    tolerance = 1000,
    turret = true,
    weaponVelocity = 400,
    sweepfire = true, --
    damage = {
        default = 5,
    },
}

return lowerkeys({ [weaponName] = weaponDef })