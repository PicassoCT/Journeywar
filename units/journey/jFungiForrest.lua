local unitName = "jfungiforrest"

local unitDef = {
name = "FungiForrest :",
Description = "sprays highly infectious spores",
objectName = "fungiforrest.s3o",
script = "jFungiForrest.lua",
buildPic = "jfungiforrest.png",
--cost
buildCostMetal = 950,
buildCostEnergy = 750,
buildTime = 35,
--Health
maxDamage = 1650,
mass=10024,
idleAutoHeal = 25,
idletime=3000,
--Movement
maxwaterdepth=5,
	FootprintX = 2,
	FootprintZ = 2,
	MaxSlope = 10,	
sightDistance = 600,
nanocolor=[[0 0.9 0.9]],
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",


CanAttack = true,
CanGuard = true,


CanMove = false,
CanPatrol = false,
CanStop = true,

	  customParams = {},
 sfxtypes = {
    explosiongenerators = {
	"custom:orangespores",
						  },
	
				},
				
		
	
	
  Category=[[LAND BUILDING]],	




}

return lowerkeys({ [unitName] = unitDef })