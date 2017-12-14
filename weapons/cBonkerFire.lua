--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "cbonkerfire" --this is the actually maschinegune of the inferno trooper
local weaponDef = {
    name = "Deadly Darkmatter",
    weaponType = [[Cannon]],
    --damage
    damage = {
        default = 35,
        HeavyArmor = 35,
    },
    areaOfEffect = 3,
    model = "bonkerplasmaproj.s3o",
    cegTag = "cplasmaproj",
    texture1 = "plasma",
    impulseBoost = 0.5,
    --physics
    weaponVelocity = 850,
    reloadtime = 1.35,
    range = 350,
    sprayAngle = 0,
    tolerance = 200,
    lineOfSight = true,
    turret = true,
    craterMult = 0,
    --burst=2,
    --burstrate=0.5,
    soundHit = "bonkers/impact.ogg",
    soundtrigger = 1,
    SweepFire = 0,
    --apperance
    rgbColor = [[0.5 0.95 0.85]],
    size = 1.2,
    explosionGenerator = "custom:flames",

    -- stages                  = 1,
    --separation              = 1.5,
}

return lowerkeys({ [weaponName] = weaponDef })