local weaponName="jGDJump"
local weaponDef={
	name="Jump towards the Enemy",
	weaponType=[[MissileLauncher]],
	
	Accuracy=2000,
	
	--Physic/flight path
	range=360,
	reloadtime=16,
	weaponVelocity= 1400,
	startVelocity= 800,
	weaponAcceleration=250,
	flightTime=0.5,
	BurnBlow=0,
	FixedLauncher=false,
	dance=1,
	wobble=4,
	
	tolerance=16000,
	tracks=true,
	Turnrate=500,
	collideFriendly=true,
	
	----APPEARANCE
	model="ghostdancerprojectile.s3o",
	smokeTrail=false,
	explosionGenerator="custom:jghostdancerswitch",
	--CegTag="smoketrail",
	
	----TARGETING
	turret=true,
	cylinderTargeting=100,
	avoidFeature=true,
	avoidFriendly=true,
	
	
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