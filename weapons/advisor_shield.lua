local weaponName = "advisor_shield"
local weaponDef = {
	name                    = [[Personal Shield]],

	damage                  = {
		default = 10,
	},

	exteriorShield          = true,
	shieldAlpha             = 0.2,
	shieldBadColor          = [[1 0.1 0.1 0.5]],
	shieldGoodColor         = [[0.1 1 1 	0.5]],
	shieldInterceptType     = 0,
	shieldPower             = 800,
	shieldPowerRegen        = 16,
	shieldPowerRegenEnergy  = 0,
	shieldRadius            = 80,
	shieldRepulser          = true,
	shieldStartingPower     = 850,
	smartShield             = true,
	visibleShield           = false,
	visibleShieldRepulse    = true,
	texture1                = [[shield3cent.png]],
	weaponType              = [[Shield]],
}

return lowerkeys({ [weaponName] = weaponDef })