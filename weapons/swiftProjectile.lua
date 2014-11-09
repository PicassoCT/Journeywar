local weaponName="swiftProjectile"
local weaponDef={
name="jump",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=680,
reloadtime=66,
weaponVelocity=500,
startVelocity=350,
weaponAcceleration=100,
flightTime=1.2,
BurnBlow=0,
FixedLauncher=false,
dance=0,
wobble=0,

tolerance=16000,
tracks=false,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="swiftpro.s3o",
smokeTrail=false,
explosionGenerator=	"custom:dirt",	
--CegTag="smoketrail",

----TARGETING
turret=true,
cylinderTargeting=52.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=0,
heavyarmor=0,
},
areaOfEffect=10,
craterMult=0,

--?FIXME***
lineOfSight=false,


--sound
soundHit="",
soundStart="",
}

return lowerkeys ({[weaponName]=weaponDef})