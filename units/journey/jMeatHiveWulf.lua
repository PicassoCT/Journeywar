local unitName = "jmeathivewulf"
local unitDef = {
  objectName="jMeatHiveHound.s3o",

  name               = "Hivewulf",
  Description 		 ="carrys Meat back to the hive <Harass Land Unit>",

  script 			 = "jmeathivewulf.lua",
  maxDamage = 2550, 

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
  footprintX=2,
  footprintZ =2,
     mass=1200,
  upright =false,
  pushResistant =true,
  maxVelocity =2.6,
  acceleration =0.1,
  turnRate =365,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



 
	maneuverleashlength=640,
	shootme=true,
	smoothanim=false,
	steeringmode=true,
  
  
  
  	sightdistance=	50,
	radardistance=50,
	radardistancejam=0,
  
  	mass=2550,

	
  
  

  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 750,



	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				    "custom:bloodspray",
				
				 
				},
				},
				
weapons = {
	
	Category = [[LAND]],	
}
}
return lowerkeys({ [unitName] = unitDef })