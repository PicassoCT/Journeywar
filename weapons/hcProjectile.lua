local weaponName="hcProjectile"
local weaponDef={
name="hcJump",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=80,
reloadtime=3,
weaponVelocity=1000,
startVelocity=50,
weaponAcceleration=50,
flightTime=1.2,
BurnBlow=0,
FixedLauncher=false,
dance=1,
wobble=4,

tolerance=16000,
tracks=true,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="hcProjectile.s3o",
smokeTrail=true,
explosionGenerator=	"custom:bloodspray",	
--CegTag="smoketrail",

----TARGETING
turret=true,
CylinderTargeting=1.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=500,
heavyarmor=1,
},
areaOfEffect=10,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
soundHit="headcrab/hc5.wav",
soundStart="",
}

return lowerkeys ({[weaponName]=weaponDef})