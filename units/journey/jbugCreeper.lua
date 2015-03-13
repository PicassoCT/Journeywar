local unitName = "jbugcreeper"
local unitDef = {
  objectName="jbug.s3o",

  name               = "Bug",
  Description 		 ="Short Range Creeper ",

  script 			 = "jgeobugscript.lua",
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
	
  moveState =2,
  noAutoFire =false,
  footprintX=1,
  footprintZ =1,
     
  upright =false,
  pushResistant =false,
  maxVelocity =3.2,
  acceleration =0.8,
  turnRate =565,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



 
	maneuverleashlength=640,
	shootme=true,
	smoothanim=true,
	steeringmode=true,
  
  
  
  	sightdistance=303,
	radardistance=50,
	radardistancejam=0,
  
  	mass=550,

	
  
  corpse="bug",

  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 750,

Category = [[LAND]],

	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				
				 
				},
				},
				
weapons = {
[1]={name  = "jBugCloseCombat",
	onlyTargetCategory = [[LAND]],
	},
				
	},		
		
}
return lowerkeys({ [unitName] = unitDef })