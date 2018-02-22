--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cadvisoraa"
local weaponDef = {
    name = [[Not banging rocks together]],
    areaOfEffect = 8,
    craterBoost = 0,
    craterMult = 0,
    cylinderTargeting = 100.0,
    damage = {
        default = 220,
        planes = 350,
        subs = 22.5
    },
	
    explosionGenerator = "custom:advisorpsi",
    fireStarter = 70,
    flightTime = 5,

    impactOnly = true,
    impulseBoost = 15,
    impulseFactor = 1.4,
    interceptedByShieldType = 2,
    lineOfSight = true,
    CegTag = "custom:advisorpsi",
    model = "stone.s3o",
    noSelfDamage = true,
    range = 850,
    reloadtime = 6,
    renderType = 0,
    smokeTrail = false,
    --soundHit = [[jresistance/rocketfire1]],
    --soundStart = [[jresistance/rockimpact]],
    FireStarter = 75,
    startVelocity = 250,
    tolerance = 10000,
    tracks = true,
    turnRate = 60000,
    turret = true,
    weaponAcceleration = 300,
    weaponTimer = 5,
    weaponType = [[MissileLauncher]],
    weaponVelocity = 450,
}



return lowerkeys({ [weaponName] = weaponDef })