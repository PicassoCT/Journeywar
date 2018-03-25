local unitName = "jsungodcattle"
local unitDef = {
  objectName="jHeliosCattle.s3o",

  name               = "Sun God Cattle",
  Description 		 ="needs enemy fire for survival, spawns race Darts. <Tank>",
	buildPic = "jsungodcattle.png",
  script 			 = "jsungodcattlescript.lua",
  maxDamage = 6000, 

  MovementClass = "Default2x2",
  buildCostMetal =1000,
  buildCostEnergy =1000,
  buildTime=30,
 idleAutoHeal=0,
  autoheal=0,
  pushResistant =true,
  	canattack=true,
	canguard=true,
	canmove=true,
	canpatrol=true,
	canstop=true,
	
  moveState =2,
  noAutoFire =false,
  footprintX=3,
  footprintZ =3,
     
  upright =false,
  pushResistant =true,
  maxVelocity =0.42,
  acceleration =0.4,
  turnRate =365,
  selfDestructAs ="defaultweapon",
  explodeAs = "defaultweapon",



 
--	maneuverleashlength=640,
--	shootme=true,
--	smoothanim=true,
--	steeringmode=true,
  
  
  
  	sightdistance=303,
	radardistance=50,
	radardistancejam=0,
  
  	mass=5550,

	
  
  

  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 750,

Category = [[LAND]],

	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				"custom:dirt",
				"custom:sungodbuff"				 
				},
				},

				
weapons = {
		[1]={name = "jsungodegggun",
			onlyTargetCategory = [[BUILDING]],
		},		
	},		
		
}
return lowerkeys({ [unitName] = unitDef })