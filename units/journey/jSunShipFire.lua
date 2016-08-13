local unitName = "jsunshipfire"

local unitDef = {
	name = "Sun",
	Description = "let the sunshine in",
	objectName = "jSunShip.s3o",
	script = "jsunshipfireScript.lua",
	buildPic = "placeholderj.png",
	--floater = true,
	--cost
	buildCostMetal = 15,
	buildCostEnergy = 250,
	buildTime = 190,
	mass=150000,
	--Health
	maxDamage =3200,
	idleAutoHeal = 1500,
	--Movement
	airhoverfactor=0,
	bankingallowed=false,
	airstrafe=0,
	strafe=0,
	hoverattack=0,
	
	canCrash=0,
	canFly=1,
	dontLand=1,
	cruisealt=256,
	
	
	brakerate=0.95,
	
	
	canmove=1,
	maxvelocity=1,
	maxslope=3,
	
	canattack=0,
	cancapture=0,
	canstop=1,
	autoheal=0,
	activatewhenbuilt=1,
	radardistance=1024,
	
	sonardistance=0,
	-- explodeas=MYKO_SMALL,
	-- selfdestructas=MYKO_SMALL,
	selfdestructcountdown=0,
	canselfdestruct=false,
	
	maxwaterdepth=0,
	upright=1,
	hidedamage=true,
	immunetoparalyzer=true,
	norestrict=0,
	
	amphibious=1,
	reclaimable=0,
	maxAileron=0.00000000000001,
	maxElevator=0.0,
	maxRudder=0.02,
	maxBank=0,
	maxPitch=0,
	wingDrag=0.0001,
	wingAngle=0,
	frontToSpeed=0,
	speedToFront=0,
	myGravity=0,
	turnRadius=500,
	badTargetCategory="AIR NOTARGET",
	Acceleration = 0.0015,
	fireState=1,
	BrakeRate = 0.01,
	FootprintX =12,
	FootprintZ = 12,
	TEDClass = [[VTOL]],
	steeringmode = [["]],
	--maneuverleashlength = 1380,
	
	MaxVelocity = 0.025,
	MaxWaterDepth = 0,
	MovementClass = "Default2x2",
	TurnRate = 1024,
	nanocolor=[[0 0.9 0.9]],
	sightDistance = 1024,
	CanFly = true,
	alwaysupright=true,
	selfDestructAs ="defaultweapon",
	explodeAs = "defaultweapon",
	
	
	
	
	
	--canHover=true,
	CanAttack = true,
	CanGuard = true,
	CanMove = true,
	CanPatrol = true,
	Canstop = false,
	
	
	
	
	
	Category = [[AIR]],
	
	customParams = {},
	sfxtypes = {
		explosiongenerators = {	
			"custom:directionaldirt",	 
			"custom:waterdrop",
			"custom:jforcefieldgeom",
			"custom:jforcefieldgeomweak",
			"custom:factory_explosion",	
		},
		
	},
	
	weapons = {
		[1]={name = "jmountainmark",
			onlyTargetCategory = [[LAND]],
		},
	},
	
	
	
}

return lowerkeys({ [unitName] = unitDef })