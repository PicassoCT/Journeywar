local weaponName="cgaterailgun"
local weaponDef={
name="GateRailGun",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=12000,
reloadtime=30,
weaponVelocity=1000,
startVelocity=50,
weaponAcceleration=500,
flightTime=1.2,
BurnBlow=2,
FixedLauncher=true,
dance=1,
wobble=1,

tolerance=1000,
tracks=false,
Turnrate=16000,
collideFriendly=true,

----APPEARANCE
model="CGateProj.s3o",
smokeTrail=true,
--explosionGenerator=	"custom:bloodspray",	
--CegTag="smoketrail",

----TARGETING
turret=false,
CylinderTargeting=1.0,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=50,
heavyarmor=1,
},
areaOfEffect=10,
craterMult=0,

--?FIXME***
lineOfSight=false,


--sound
soundHit="headcrab/hc5.wav",
soundStart="cgatefortress/RailGunFire.ogg",
}

return lowerkeys ({[weaponName]=weaponDef})