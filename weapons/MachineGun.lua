--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "MachineGun"
local weaponDef = {
    name = "Machine Gun",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 10,
        HeavyArmor = 1,
    },
    areaOfEffect = 8,
    --physics
    weaponVelocity = 450,
    reloadtime = 0.25,
    range = 250,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    burst = 8,
    burstrate = 0.2,
	cegTag = "machinegunproj",
    --soundStart         = "maschinegun",
    explosionGenerator = "custom:Ricochet",
    soundtrigger = 1,
    SweepFire = 1,
    --apperance
    rgbColor = [[0.12 0.9 0.9]],
	alphaDecay = 0.35,
    size = 1.45,
    stages = 4,
    separation = 1,
}

return lowerkeys({ [weaponName] = weaponDef })