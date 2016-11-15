local weaponName = "ccitadellshield"
local weaponDef = {
weaponType="Shield",
name = "citadellshield",



exteriorShield = false,

shieldAlpha = 0.1,
ShieldEnergyUse=150,
ShieldForce=5.25,
 shieldBadColor = [[0 0.4 0.6]],--[[0.1 0.7 0.3]]
shieldGoodColor = [[0.6 1 1]],--[[0.8 1 0.1]]
ShieldInterceptType =65533,
ShieldMaxSpeed=400,
ShieldPower=9999,
ShieldPowerRegen =5,
shieldpowerregenenergy=50,
shieldradius = 850,
shieldrepulser  = 0, --true for journeys
visibleShieldRepulse = true,
ShieldStartingPower =10000,
SmartShield = false,
visibleShield = true,
visibleShieldHitFrames =45,
shieldRechargeDelay = 5,
texture1 = [[shield3cent]],
weaponType = [[Shield]],


	}
return lowerkeys({[weaponName] = weaponDef})