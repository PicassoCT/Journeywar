--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jshroudtimerray"
local weaponDef = {
    name = "time bubble Ray",
   weaponType = [[Cannon]],
    --damage
    damage = {
        default = 10,
        HeavyArmor = 1,
    },
    areaOfEffect = 8,
   -- explosionGenerator = "custom:AR2Impact",
    --cegTag = "AR2Projectile",
    texture1 = "innerswirl.png",

    --physics
    weaponVelocity = 850,
    reloadtime = 60,
    range = 1024,
    sprayAngle = 300,
    tolerance = 8000,
    lineOfSight = true,
    turret = true,
    craterMult = 0,

	
    --apperance 
    rgbColor = [[0.1 0.8 0.8]],
    rgbColor2 = [[0.1 0.6 0.9]],
	
    size = 22.2,
    stages = 20,
    separation = 0.2,
}

return lowerkeys({ [weaponName] = weaponDef })