---http://springrts.com/wiki/Weapon_Variables#Cannon_.28Plasma.29_Visuals
local weaponName = "csuborbitalstrike"
local weaponDef = {
	
	name = "SubOrbitalStrike",
	
	weaponType=[[Cannon]],
	highTrajectory =0,
	
	
	--
	
	weapontimer=12,
	--
	--Physic/flight path
	range=900000,
	reloadtime=19,
	weaponVelocity=400,
	startVelocity=250,
	weaponAcceleration=200,
	flightTime=12.5,
	BurnBlow=0,
	FixedLauncher=true,
	dance=0,
	wobble=0,
	trajectoryheight=25.8,
	accuracy = 4200,
	tolerance=16000,
	tracks=false,
	Turnrate=16000,
	collideFriendly=true,
	
	----APPEARANCE
	rgbColor = [[0.05 0.05 0.05]],		 	 
	size = 0.002,
	smokeTrail=false,
	--explosionGenerator="xamelimpact",
	--CegTag="smoketrail",
	
	----TARGETING
	turret=true,
	--CylinderTargetting=true,
	avoidFeature=false,
	avoidFriendly=false,
	
	explosionGenerator=	"custom:csuborbimpact",	
	--commandfire=true,
	
	----DAMAGE
	damage={
		default=150,
		heavyarmor=50,
	},
	areaOfEffect=25,
	craterMult=0,
	
	--?FIXME***
	lineOfSight=false,
	
	
	--sound
	--soundHit="cart/arthchit",
	--soundStart="cart/artfire",
	
	
} return lowerkeys({[weaponName] = weaponDef})