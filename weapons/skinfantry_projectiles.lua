local weaponName="SIprojectiles"
local weaponDef={
	name="SIprojectiles",
	weaponType=[[MissileLauncher]],
	
	Accuracy=150,
	
	--Physic/flight path
	range=420,
	reloadtime=4,
	weaponVelocity=1150,
	startVelocity=550,
	weaponAcceleration=350,
	
	sprayAngle = 100,
	tolerance = 200,
	
	
	flightTime=0.5,
	BurnBlow=0,
	FixedLauncher=false,
	dance=0,
	wobble=0,
	turnrate=100,
	
	tracks=false,
	
	collideFriendly=false,
	
	----APPEARANCE
	model="SIprojectile.s3o",
	smokeTrail=false,
	--explosionGenerator="custom:redsmoke",
	CegTag="jskinfantrygun",
	
	----TARGETING
	turret=true,
	avoidFeature=true,
	avoidFriendly=true,
	burst=3,
	burstrate=0.25,
	
	--commandfire=true,
	
	----DAMAGE
	damage={
		default=25,
		heavyarmor=0,
	},
	areaOfEffect=20,
	craterMult=0,
	
	--?FIXME***
	lineOfSight=true,
	
	
	--sound
	soundHit="sounds/skinfantry/crystallbolter.ogg",
	soundStart="sounds/skinfantry/crystallfire.ogg",
	
}

return lowerkeys ({[weaponName]=weaponDef})