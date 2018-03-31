local weaponName = "jeliahshield"
local weaponDef = {
    name = "shroudshield",
    damage = {
        default = 10,
    },
    exteriorShield = true,
    weaponType = "Shield",
    shieldAlpha = 0.2,
    ShieldEnergyUse = 0,
    ShieldForce = 5.25,
    shieldBadColor = [[0 0.4 0.6 1]], --[[0.1 0.7 0.3]]
    shieldGoodColor = [[0.2 1 1 1]], --[[0.8 1 0.1]]
    ShieldInterceptType = 65533,
    ShieldMaxSpeed = 400,
    ShieldPower = 3000,
    ShieldPowerRegen = 60,
    shieldpowerregenenergy = 25,
    shieldradius = 15,
    shieldrepulser = false, --true for journeys
    ShieldStartingPower = 3000,
    SmartShield = true,
    VisibleShield = true,
    VisibleShieldHitFrames = 145,
    VisibleShieldRepulse = true,
    texture1 = [[shieldmist]],
  
    weaponType = [[Shield]],
}
return lowerkeys({ [weaponName] = weaponDef })