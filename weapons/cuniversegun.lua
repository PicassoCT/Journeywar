local weaponName = "cuniversegun"
local weaponDef = {
    name = "cuniversegun",
    weaponType = [[Cannon]],
    CegTag = "miniverrsetail",
    weaponVelocity = 300,
    model = "cMiniBigBang.s3o",
    --damage
    damage = {
        default = 150,
        HeavyArmor = 120,
    },
    areaOfEffect = 8,
    --physics
    weaponVelocity = 900,
    reloadtime = 19,
    range = 1350,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    --apperance
    rgbColor = [[0.1 0.1 0.1]],
    size = 4,
}

return lowerkeys({ [weaponName] = weaponDef })