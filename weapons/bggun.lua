--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "AR2" --this is the actually maschinegune of the blackguard
local weaponDef = {
    name = "AR2",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 10,
        HeavyArmor = 1,
    },
    areaOfEffect = 8,
    explosionGenerator = "custom:AR2Impact",
    cegTag = "AR2Projectile",
    texture1 = "empty",

    --physics
    weaponVelocity = 850,
    reloadtime = 0.35,
    range = 250,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    burst = 7,
    burstrate = 0.2,
    soundStart = "bgmtw/bgpulse2s",
    soundtrigger = 1,
    SweepFire = 1,
    --apperance
    rgbColor = [[0.5 0.95 0.85]],
    size = 1.2,
    stages = 20,
    separation = 0.2,
}

return lowerkeys({ [weaponName] = weaponDef })