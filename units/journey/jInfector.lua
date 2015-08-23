local unitName = "jinfector"

local unitDef = {
name = "Infector :",
Description = "makes the units from enemy factorys turn on a whim",
objectName = "jinfector.s3o",
script = "jInfectorScript.lua",
buildPic = "jinfector.png",
--cost
buildCostMetal = 950,
buildCostEnergy = 750,
buildTime = 35,
--Health
maxDamage = 1650,
mass=7024,
idleAutoHeal = 25,
idletime=3000,
--Movement

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

weapons = {
[1]={name  = "jfungiforrestmarker",
	onlyTargetCategory = [[ LAND AIR]],
	},
	
},


}

return lowerkeys({ [unitName] = unitDef })