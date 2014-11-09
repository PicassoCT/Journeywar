local unitName = "jabyss"

local unitDef = {
name = "The Abbys",
Description = "releases Varyfoos, once the enemy riskes a Comender",
objectName = "jAbyss.s3o",
script = "jabyssscript.lua",
buildPic = "jabyss.png",
--cost
buildCostMetal = 950,
buildCostEnergy = 750,
buildTime = 35,
--Health
maxDamage = 3950,
mass=1024,
idleAutoHeal = 25,
idletime=3000,
--Movement
unitRestricted =1,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 10,	
sightDistance = 600,
nanocolor=[[0 0.9 0.9]],

CanAttack = false,
CanGuard = true,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



CanMove = false,
CanPatrol = false,
CanStop = true,

	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
						"custom:jbuildingexaust",
						  },
	
				},
				
		
	
	
Category = [[LAND BUILDING]],



}

return lowerkeys({ [unitName] = unitDef })