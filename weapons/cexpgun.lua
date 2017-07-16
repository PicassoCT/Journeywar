--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cexpgun" --this is the actually maschinegune of the blackguard
local weaponDef = {
    name = "Exponential Gun",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 10,
        HeavyArmor = 1,
    },
    areaOfEffect = 8,
    explosionGenerator = "custom:AR2Impact",
    cegTag = "cexpprojectile",
    texture1 = "empty",

    --physics
    weaponVelocity = 850,
    reloadtime = 0.00001,
    range = 650,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    soundStart = "bgmtw/bgpulse2s",
    soundtrigger = 1,
    SweepFire = 1,
    --apperance
    rgbColor = [[0.52 0.55 0.78]],
    size = 0.6,
    stages = 0,
    separation = 0,
}

return lowerkeys({ [weaponName] = weaponDef })