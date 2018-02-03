--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "bonkermaschinegun"
local weaponDef = {
    name = "Flak",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 10,
        plane = 50,
        HeavyArmor = 1,
    },
    areaOfEffect = 28,
    explosionGenerator = "custom:cflakimpact",
    cegTag = "cflaklongshot",
    texture1 = "empty",

    --physics
    weaponVelocity = 1050,
    reloadtime = 0.25,
    range = 1250,
    sprayAngle = 800,
    tolerance = 900,
	 targetMoveError = 0.015,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    burst = 7,
    burstrate = 0.2,
    soundStart = "sounds/bonkers/antiair.ogg",
    soundHit = "sounds/bonkers/flakhit.wav",
    soundtrigger = 1,
    SweepFire = 1,
    --apperance
    rgbColor = [[0.12 0.9 0.9]],
    size = 4.45,
    stages = 1,
    separation = 0,
}

return lowerkeys({ [weaponName] = weaponDef })