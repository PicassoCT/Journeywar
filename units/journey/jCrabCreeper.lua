local unitName = "jCrabCreeper"
local unitDef = {
	objectName="jcrab.s3o",
	
	name = "Crustacian Creeper",
	Description 		 ="slow, steady, deadly Crab Creeper <Tank Creeper>",
	
	script 			 = "jCrabScript.lua",
	maxDamage = 2550, 
	
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
	maxVelocity =1.2,
	acceleration =0.1,
	turnRate =365,
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
	
	mass=2550,
	
	
	
	Category = [[LAND]],
	
	hideDamage =true,
	showNanoFrame =false,
	energyStorage = 750,
	
	 LeaveTracks = true, 
	trackType ="jBug",
	 trackStrength=2,
	trackWidth =32,
	trackOffset =0,
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {
			"custom:greenbloodspray",
				
		},
	},
	
	weapons = {
		[1]={name = "jcrabclosecombat",
			onlyTargetCategory = [[LAND]],
		},
		
	},		
	
}
return lowerkeys({ [unitName] = unitDef })