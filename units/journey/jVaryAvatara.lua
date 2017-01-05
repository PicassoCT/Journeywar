local unitName = "jvaryavatara"
local unitDef = {
  objectName="jvarytara.s3o",

  name               = "Antigenesis",
  Description 		 =" the end of this world ",

  script 			 = "jVaryTarascript.lua",
  maxDamage = 22550, 

  MovementClass = "jinfantry",
  buildCostMetal =30,
  buildCostEnergy =200,
  buildTime=3,
 
  	canattack=true,
	canguard=true,
	canmove=true,
	canpatrol=true,
	canstop=true,
	transportCapacity = 50,
	transportSize = 30000*50,
	
  moveState =2,
  noAutoFire =false,
  footprintX=8,
  footprintZ =8,
     
  upright =false,
  pushResistant =true,
  maxVelocity =1.2,
  acceleration =0.1,
  turnRate =125,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",
  maxwaterdepth=150,

	
 
	maneuverleashlength=640,
	shootme=true,
	smoothanim=false,
	steeringmode=true,
  
  
  
  	sightdistance=	50,
	radardistance=50,
	radardistancejam=0,
  
  	mass=25000,

	
  
  Category = [[LAND]],

  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 750,



	 customParams = {
	 varyfooneeded=[[50]]
	 },
	 
 sfxtypes = {
				explosiongenerators = {
				},
				},
				
	weapons = {		
		[1]={name = "jvaryspear",
			onlyTargetCategory = [[AIR]],
			},
		[2]={name = "jvarytaraompf",
			onlyTargetCategory = [[LAND]],
		},
	},

}
return lowerkeys({ [unitName] = unitDef })