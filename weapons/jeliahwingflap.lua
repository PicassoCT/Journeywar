local weaponName = "jeliahwingflap"
local weaponDef = {
    name = "Wind Wings",
    accuracy = 512,
    areaOfEffect = 15,
    coreThickness = 0.25,
    craterBoost = 0,
    craterMult = 0,
    damage = {
        default = 10,
     
    },


    heightMod = 1,
    impactOnly = true,
    impulseBoost = 16,
    impulseFactor = 22,
    interceptedByShieldType = 1,
    lodDistance = 10000,
    proximityPriority = 4,
    range = 80,
    reloadtime = 10,
    targetMoveError = 0.25,
    tolerance = 5000,
    turret = true,
    weaponType = [[CANNON]],
    weaponVelocity = 500,
	 rgbColor = [[0.5 0.5 0.5 ]],
    size = 0.01,
}

return lowerkeys({ [weaponName] = weaponDef })