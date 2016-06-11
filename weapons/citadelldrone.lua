local weaponName="citadelldrone"
local weaponDef={
	name="citadelldrone",
	weaponType=[[MissileLauncher]],
	
	Accuracy=1000,
	
	--Physic/flight path
	range=1200,
	reloadtime=3,
	weaponVelocity=250,
	startVelocity=50,
	weaponAcceleration=50,
	flightTime=18.5,
	BurnBlow=0,
	FixedLauncher=false,
	dance=60,
	wobble=1,
	turnrate=12200,
	tolerance=16000,
	tracks=true,
	Turnrate=32000,
	
	
	----APPEARANCE
	model="cdDrone.s3o",
	smokeTrail=false,
	--explosionGenerator="custom:redsmoke",
	CegTag="ccitdronetail",
	
	----TARGETING
	turret=true,
	CylinderTargeting=1222.0,
	avoidFeature=true,
	avoidFriendly=true,
	collideFriendly=false,
	heightMod =0.5,
	
	--commandfire=true,
	
	----DAMAGE
	damage={
		default=450,
		heavyarmor=350,
	},
	areaOfEffect=100,
	craterMult=0,
	--?FIXME***
	
	noSelfDamage = true,
	
	--sound
	--soundHit="null",
	soundStart="citadell/dronelaunch",
}

return lowerkeys ({[weaponName]=weaponDef})