local weaponName="ceater"
local weaponDef={
name="Eater Drone",
weaponType=[[MissileLauncher]],

Accuracy=2000,

--Physic/flight path
range=1800,
reloadtime=9000,
weaponVelocity=250,
startVelocity=150,
weaponAcceleration=250,
flightTime=12.5,
BurnBlow=0,
FixedLauncher=false,
dance=12,
wobble=42,

tolerance=16000,
tracks=true,
Turnrate=32000,
collideFriendly=true,

----APPEARANCE
model="cEaterProj.s3o",
smokeTrail=true,
explosionGenerator="custom:bloodslay",
--CegTag="smoketrail",
CegTag="razorstripe",
----TARGETING
turret=true,
cylinderTargeting=100,
avoidFeature=true,
avoidFriendly=true,


--commandfire=true,

----DAMAGE
damage={
default=325,
heavyarmor=150,
},
areaOfEffect=100,
craterMult=0,

--?FIXME***
lineOfSight=true,


--sound
--soundHit="skinfantry/birdrockethit.wav",
soundStart="cgatefortress/DroneSalvoFire.ogg",
}

return lowerkeys ({[weaponName]=weaponDef})