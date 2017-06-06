--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "tigLilCloseCombat"
local weaponDef = {
    name = "tigLilCloseCombat",
    weaponType = [[Melee]],
    --damage
    damage = {
        default = 125,
        HeavyArmor = 90,
    },
    areaOfEffect = 3,
    --physics
    weaponVelocity = 450,
    reloadtime = 0,
    range = 25,
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