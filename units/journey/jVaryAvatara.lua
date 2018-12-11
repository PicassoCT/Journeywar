local unitName = "jvaryavatara"
local unitDef = {
  objectName="jvarytara.s3o",

  name               = "Antigenesis",
  Description 		 =" the end of this world. Combined from several Varyfoo. <Tank> ",

  script 			 = "jVaryTarascript.lua",
  maxDamage = 44550, 
buildPic = "jvarytara.png",
  MovementClass = "jinfantry",
  buildCostMetal =30,
  buildCostEnergy =200,
  buildTime=3,
 
  	canattack=true,
	canguard=true,
	canmove=true,
	canpatrol=true,
	canstop=true,
	transportCapacity = 150,
	transportSize = 3000000000,
	
  moveState =2,
  noAutoFire =false,
  footprintX=8,
  footprintZ =8,
     
  upright =false,
  pushResistant =true,
  maxVelocity =0.6,
  acceleration =0.1,
  turnRate =25,
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
					"custom:dirt",--1024
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