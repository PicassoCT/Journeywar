local unitName = "jHiveWulfMoma"
local unitDef = {
	objectName="jHiveHoundMoma.s3o",
	
	name               = "Wulfhive",
	Description 	   = "Ranged Ground-Assault Unit <Harass Carrier Unit>",
	
	script 			 = "jHiveMomaScript.lua",
	maxDamage = 2550, 
	buildPic = "jhivewulfmoma.png",
	
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
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	upright =false,
	pushResistant =true,
	maxVelocity =5.2,
	acceleration =0.1,
	brakeRate=3.2,
	turnRate =965,

	maneuverleashlength=640,
	shootme=true,
	smoothanim=true,
	steeringmode=true,
  
  	sightdistance=	450,
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
	[1]={name  = "jWulfJump",
		onlyTargetCategory = [[LAND]],
		},
					
		},		
	Category = [[LAND]],	
}
return lowerkeys({ [unitName] = unitDef })