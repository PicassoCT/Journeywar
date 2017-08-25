local weaponName="cnukegrenadelvl3"
local weaponDef={
	name="GrenadeLauncher Lvl3",
	weaponType=[[Cannon]],

	
	
	highTrajectory =1,
	--
	
	weapontimer=17,
	--
	--Physic/flight path
	range=1800,
	reloadtime=29,
	weaponVelocity=400,
	startVelocity=250,
	weaponAcceleration=200,
	flightTime=30.5,
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
	model="fatman.s3o",
	smokeTrail=true,
	--explosionGenerator="xamelimpact",
	--CegTag="smoketrail",
	
	----TARGETING
	turret=true,
	--CylinderTargetting=true,
	avoidFeature=false,
	avoidFriendly=false,
	
	explosionGenerator=	"custom:nukebigland",	
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
	soundHit="cart/arthchit",
	soundStart="cart/artfire",
}

return lowerkeys ({[weaponName]=weaponDef})