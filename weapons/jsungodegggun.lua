--- http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "jsungodegggun" --this is the actually maschinegune of the inferno trooper
local weaponDef = {
	name = "egglauncher",
	 name = "SIprojectiles",
    weaponType = [[MissileLauncher]],
    Accuracy = 150,

    --Physic/flight path
    range = 420,
    reloadtime = 15,
    weaponVelocity = 1150,
    startVelocity = 550,
    weaponAcceleration = 350,
    sprayAngle = 100,
    tolerance = 200,
    flightTime = 0.5,
    BurnBlow = 0,
    FixedLauncher = false,
    dance = 0,
    wobble = 0,
    turnrate = 100,
    tracks = false,
    collideFriendly = true,

    --- -APPEARANCE
    model = "jsuneggnoggproj.s3o",
    smokeTrail = false,
    --explosionGenerator="custom:redsmoke",

    --- -TARGETING
    turret = true,
    avoidFeature = true,
    avoidFriendly = true,
    burstrate = 0.25,

    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 15,
        heavyarmor = 0,
    },
    areaOfEffect = 20,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


}

return lowerkeys({ [weaponName] = weaponDef })