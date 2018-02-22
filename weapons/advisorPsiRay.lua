--- http:--springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "advisorPsiRay"
local weaponDef = {
    name = "advisorPsiRay",
    weaponType = [[LightningCannon]],
    areaOfEffect = 8,
    craterBoost = 0,
    craterMult = 0,
    damage = {
        default = 250,
        HeavyArmor = 70,
    },
	beamTTL = 10,
    duration = 10,
    fireStarter = 110,
    impactOnly = true,
    impulseBoost = 0,
    impulseFactor = 0.4,
    intensity = 12,
    interceptedByShieldType = 1,
    lineOfSight = true,
    paralyzer = true,
    paralyzeTime = 4,
    range = 280,
    reloadtime = 5,
    rgbColor = [[0.0 0.5 0.8]],
    soundHit = "cadvisor/psi.wav",
    explosionGenerator = "custom:advisorpsi",
    FireStarter = 75,
    targetMoveError = 0.3,
    texture1 = [[strips]],
    thickness = 10,
    turret = true,
    weaponVelocity = 400,
}

return lowerkeys({ [weaponName] = weaponDef })