local unitName = "ggluemine"
local unitDef = {
  objectName="jgluemine.s3o",

  name               = "Glue",
  Description 		 =" inhale the solvents and stick to them",

  script 			 = "glueminescript.lua",
  maxDamage = 250, 

  MovementClass = "Default2x2",
  buildCostMetal =30,
  buildCostEnergy =200,
  buildTime=3,
 
  	canattack=true,
	canguard=true,
	canmove=true,
	canpatrol=true,
	canstop=true,
	canmove=false,
	cancloak=true,
	cloakCost=0.0,
	initCloaked=false,
	
  footprintX=2,
  footprintZ =2,
     
  
  

  	sightdistance=120,
	radardistance=50,
	radardistancejam=15,
  
  	mass=550,

  

  selfDestructCountdown =1,
  hideDamage =true,
  showNanoFrame =false,

Category = [[BUILDING LAND]],
  
  selfDestructAs ="gluemineweapon",
  explodeAs = "gluemineweapon",
  
	 customParams = {},
 sfxtypes = 	{
				explosiongenerators = {
				   "custom:bigbulletimpact",  
				},
				},
				
weapons = {
[1]={name  = "gluemineweapon",
	onlyTargetCategory = [[LAND]],
	},
				
	},		
		
}
return lowerkeys({ [unitName] = unitDef })