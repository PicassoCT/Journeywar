local weaponName="jdartgun"
local weaponDef={
	name="jdartgun",
	weaponType=[[MissileLauncher]],
	
	Accuracy=2000,
	
	--Physic/flight path
	range=800,
	reloadtime=8,
	weaponVelocity=1000,
	startVelocity=150,
	weaponAcceleration=250,
	flightTime=2.5,
	BurnBlow=1,
	FixedLauncher=false,
	dance=0,--1
	wobble=0,--4
	
	tolerance=16000,
	tracks=false,
	Turnrate=32000,
	collideFriendly=false,
	
	----APPEARANCE
	model="jhunterdart.s3o",
	smokeTrail=false,
	--explosionGenerator="custom:redsmoke",
	CegTag="jhuntertrail",
	
	----TARGETING
	turret=true,
	cylinderTargeting=66,
	avoidFeature=true,
	avoidFriendly=true,
	
	
	--commandfire=true,
	
	----DAMAGE
	damage={
		default=1,
		heavyarmor=1,
	},
	areaOfEffect=1,
	craterMult=0,
	
	--?FIXME***
	lineOfSight=true,
	
	
	--sound
--	soundHit="sounds/skinfantry/birdrockethit.ogg",
--	soundStart="sounds/skinfantry/birdrocketstart.ogg",
	
}

return lowerkeys ({[weaponName]=weaponDef})