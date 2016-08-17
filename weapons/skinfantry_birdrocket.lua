local weaponName="birdrocket"
local weaponDef={
	name="birdrocket",
	weaponType=[[MissileLauncher]],
	
	Accuracy=2000,
	
	--Physic/flight path
	range=800,
	reloadtime=3,
	weaponVelocity=1000,
	startVelocity=150,
	weaponAcceleration=250,
	flightTime=2.5,
	BurnBlow=0,
	FixedLauncher=false,
	dance=1,
	wobble=4,
	
	tolerance=16000,
	tracks=true,
	Turnrate=16000,
	collideFriendly=false,
	
	----APPEARANCE
	model="birdrocket.s3o",
	smokeTrail=true,
	--explosionGenerator="custom:redsmoke",
	--CegTag="smoketrail",
	
	----TARGETING
	turret=true,
	cylinderTargeting=66,
	avoidFeature=true,
	avoidFriendly=false,
	
	
	--commandfire=true,
	
	----DAMAGE
	damage={
		default=150,
		heavyarmor=150,
	},
	areaOfEffect=100,
	craterMult=0,
	
	--?FIXME***
	lineOfSight=true,
	
	
	--sound
	soundHit="sounds/skinfantry/birdrockethit.ogg",
	soundStart="sounds/skinfantry/birdrocketstart.ogg",
	
}

return lowerkeys ({[weaponName]=weaponDef})