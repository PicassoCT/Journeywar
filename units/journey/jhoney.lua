local unitName = "jhoneypot"
local unitDef = {
  objectName="jhoney.s3o",

  name               = "Honeypot",
  Description 		 ="Long Range Creeper with suicide tendencys",

  script 			 = "jhoneyscript.lua",
  maxDamage = 250, 

  MovementClass = "jcreeper",
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
     
  upright =false,
  pushResistant =true,
  maxVelocity =6.2,
  acceleration =3.2,
  turnRate =265,

  leaveTracks =true,
  trackType ="jBug",
  trackStrength=22,


	maneuverleashlength=640,
	shootme=true,
	smoothanim=true,
	steeringmode=true,
  
  
  
  	sightdistance=303,
	radardistance=50,
	radardistancejam=0,
  
  	mass=550,

	
corpse="honeypot",
  

  selfDestructCountdown =0,
  hideDamage =true,
  showNanoFrame =false,
  energyStorage = 750,
Category = [[LAND]],
  
  selfDestructAs ="jhoneypotW",
  explodeAs = "jhoneypotW",
  
	 customParams = {},
 sfxtypes = {
				explosiongenerators = {
				   "custom:bigbulletimpact",
				  
				},
				},
				
weapons = {
[1]={name  = "jhoneypotW",
	onlyTargetCategory = [[LAND]],
	},
				
	},		
		
}
return lowerkeys({ [unitName] = unitDef })