local weaponName="jplanktoneraa"
local weaponDef={
	name="anti air particles",
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
	collideFriendly=true,
	
	----APPEARANCE
	model="jplanktonerproj.s3o",
	smokeTrail=false,
	--explosionGenerator="custom:redsmoke",
	CegTag="jplankaatail",
	
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
	areaOfEffect=100,
	craterMult=0,
	
	--?FIXME***
	lineOfSight=true,
	
	
	--sound
	soundHit="sounds/jplanktoner/jplankimpact.ogg",
	soundStart="sounds/jplanktoner/jplankaachargeup.ogg",
	
}

return lowerkeys ({[weaponName]=weaponDef})