--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jBugCloseCombat"
local weaponDef = {
    name = "Mean Bite",
    weaponType = [[Melee]],
    --damage
    damage = {
        default = 325,
        HeavyArmor = 90,
    },
    areaOfEffect = 3,
    --physics
    weaponVelocity = 450,
    reloadtime = 5,
    range = 18,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,

    --  soundStart         = "",
    --  soundtrigger=1,

    --apperance
    rgbColor = [[0 0 0]],
    size = 0.1,
}

return lowerkeys({ [weaponName] = weaponDef })