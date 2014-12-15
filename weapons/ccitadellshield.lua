local weaponName = "ccitadellshield"
local weaponDef = {

name = "citadellshield",
damage = {
default = 10,
},

exteriorShield = false,
weaponType="Shield",
shieldAlpha = 0.01,
ShieldEnergyUse=150,
ShieldForce=5.25,
 shieldBadColor = [[0 0.4 0.6]],--[[0.1 0.7 0.3]]
shieldGoodColor = [[0.6 1 1]],--[[0.8 1 0.1]]
ShieldInterceptType =65533,
ShieldMaxSpeed=400,
ShieldPower=9999,
ShieldPowerRegen =999,
shieldpowerregenenergy=1000,
SHIELDRADIUS=420,
ShieldRepulsor=false, --true for journeys
ShieldStartingPower =10000,
SmartShield = false,
VisibleShield = true,
VisibleShieldHitFrames =45,
VisibleShieldRepulse=true,
texture1 = [[shield3cent]],
weaponType = [[Shield]],


	}
return lowerkeys({[weaponName] = weaponDef})