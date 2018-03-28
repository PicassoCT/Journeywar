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
    weaponVelocity = 99999,
    reloadtime = 20,
    range = 2000,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = false,
    turret = true,
    craterMult = 0,

}

return lowerkeys({ [weaponName] = weaponDef })