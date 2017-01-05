local weaponName="jvaryjump"
local weaponDef={
	name="Jump towards the Enemy",
	weaponType=[[MissileLauncher]],
	
	Accuracy=2000,
	
	--Physic/flight path
	range=720,
	reloadtime=22,
	weaponVelocity=150,
	startVelocity=50,
	weaponAcceleration=25,
	flightTime=4.5,
	BurnBlow=0,
	FixedLauncher=false,
	dance=0,
	wobble=0,
	
	tolerance=16000,
	tracks=true,
	Turnrate=1900,
	collideFriendly=false,
	
	----APPEARANCE
	model="emptyObjectIsEmpty.s3o",
	smokeTrail=false,
	explosionGenerator="custom:jvaryfootrail",
	CegTag="jvaryfootrail",
	
	----TARGETING
	turret=true,
	cylinderTargeting=100,
	avoidFeature=true,
	avoidFriendly=false,
	
	
	--commandfire=true,
	
	----DAMAGE
	damage={
		default=15,
		heavyarmor=5,
	},
	areaOfEffect=10,
	craterMult=0,
	
	--?FIXME***
	lineOfSight=true,
	
	
	--sound
	--soundHit="skinfantry/birdrockethit.wav",
	--soundStart="skinfantry/birdrocketstart.wav",
}

return lowerkeys ({[weaponName]=weaponDef})