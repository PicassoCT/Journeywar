local weaponName = "callygatormarker"
local weaponDef = {
    name = "Allygator Gate",
    weaponType = [[Melee]],
    Accuracy = 2000,

    --Physic/flight path
    range = 1200,
    reloadtime = 15,
    collideFriendly = false,



    --- -TARGETING
    turret = true,
    cylinderTargeting = 55.0,
    avoidFeature = true,
    avoidFriendly = false,


    --commandfire=true,

    --- -DAMAGE
    damage = {
        default = 1,
    },
    areaOfEffect = 1,
    craterMult = 0,

    --?FIXME***
    lineOfSight = true,


    --sound
    --soundHit="skinfantry/birdrockethit.ogg",
    --soundStart="skinfantry/birdrocketstart.ogg",
}

return lowerkeys({ [weaponName] = weaponDef })