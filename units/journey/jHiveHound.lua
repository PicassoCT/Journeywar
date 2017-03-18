local unitName = "jHiveHound"
local unitDef = {
  objectName="jHiveHound.s3o",

  name               = "Hivewulf",
  Description 		 = "Bites anything that comes close to the hive",
  script 			 = "jHiveHoundJunior.lua",
  maxDamage = 450, 

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
     mass=800,
  upright =false,
  pushResistant =true,
  maxVelocity =3.6,
  acceleration =1.2,
  turnRate =965,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



 
	maneuverleashlength=640,
	shootme=true,
	smoothanim=false,
	steeringmode=true,
  
  
  
  	sightdistance=	50,
	radardistance=50,
	radardistancejam=0,


	
  
  

  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 750,



	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				    
				    "custom:dirt",
					"custom:bloodspray",
				 
				},
				},
				
weapons = {
[1]={name  = "jHiveHoundRocket",
	onlyTargetCategory = [[LAND]],
	},
[2]={name  = "jHiveCloseCombat",
	onlyTargetCategory = [[LAND]],
	},				
	},		
		Category = [[LAND]],
}
return lowerkeys({ [unitName] = unitDef })