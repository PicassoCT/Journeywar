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
    areaOfEffect = 1,
    -- explosionGenerator="custom:chelicopterimpact",

    cegTag="explosiveproj",
    texture1 = "bulletzip",

    --physics
    weaponVelocity = 850,
    reloadtime = 5.35,
    range = 1250,
    sprayAngle = 400,
    tolerance = 2000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    burst = 7,
    burstrate = 0.2,
    --	soundStart         = "sounds/cHunterChopper/firelooper.wav",
    --  soundHit="cHunterChopper/bulletimpact.wav",
    soundtrigger = 1,
    SweepFire = 1,
    --apperance
    rgbColor = [[0.5 0.95 0.85]],
    size = 1.2,
    stages = 1,
    separation = 0.2
}
return lowerkeys({ [weaponName] = weaponDef })