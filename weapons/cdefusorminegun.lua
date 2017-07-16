--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cdefusorminegun"
local weaponDef = {
    name = "cdefusorminegun",
    weaponType = [[Melee]],
    --damage
    damage = {
        default = 1,
        HeavyArmor = 1,
    },
    areaOfEffect = 3,
    --physics
    weaponVelocity = 450,
    reloadtime = 20,
    range = 50,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    soundStart = "",
    soundtrigger = 1,

    --apperance
    rgbColor = [[0 0 0]],
    size = 0.1,
}

return lowerkeys({ [weaponName] = weaponDef })