local unitName = "ggluemine"
local unitDef = {
  objectName="ragtest.s3o",

  name               = "Gluemine",
  Description 		 =" stay a while and listen",

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
	
  footprintX=2,
  footprintZ =2,
     
  
  

	shootme=true,
	
  
  	sightdistance=120,
	radardistance=50,
	radardistancejam=0,
  
  	mass=550,

  

  selfDestructCountdown =1,
  hideDamage =true,
  showNanoFrame =false,

Category = [[BUILDING LAND]],
  
  selfDestructAs ="glueMineWeapon",
  explodeAs = "glueMineWeapon",
  
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:bigbulletimpact",
				  
				},
				},
				
weapons = {
[1]={name  = "glueMineWeapon",
	onlyTargetCategory = [[LAND]],
	},
				
	},		
		
}
return lowerkeys({ [unitName] = unitDef })